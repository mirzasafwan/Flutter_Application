<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use App\Models\User;
class TodoController extends Controller
{
/**adding User */
    public function addUserData(Request $request){
        $validator=Validator::make($request->all(),[
            'email'=>['required',],
            'title'=>['required','min:3'],
            'description'=>['required','min:8'],
            'datetime'=>['required'],
        ]);
           if($validator->fails()){
            return response()->json(['error'=>$validator->errors()],401);
           }
           $addUserData=DB::table('todo_list')->insert([
            'user_email'=>$request->email,
            'title'=>$request->title,
            'description'=>$request->description,
            'datetime'=>$request->datetime,
            'status'=>2,
            'created_at'=>\Carbon\Carbon::now(),
            'updated_at'=>\Carbon\Carbon::now(),
           ]);
           if($addUserData){
            return response()->json(['success'=>'Successfully data inserted'],200);
           }else{
            return response()->json(['error'=>'Data not inserted'],400);
           }

    }
/** get User data  */
    public function getUserData(Request $request){
        $validator=Validator::make($request->all(),[
            'email'=>['required'],

        ]);
        if($validator->fails()){
            return response()->json(['error'=>$validator->errors()],400);
        }
        $getUserData=DB::table('todo_list')->where('user_email',$request->email)->get();
        if(count($getUserData)>0){
            return response()->json(['success'=>$getUserData],200);
        }else{
            return response()->json(['error'=>'Data not found'],401);
        }
    }
/** update User data  */
    public function updateUserData(Request $request){
        $validator=Validator::make($request->all(),[
            'email'=>['required'],
            'todoId'=>['required']
        ]);
        if($validator->fails()){
            return response()->json(['error'=>$validator->errors()],401);
        }
        $update=DB::table('todo_list')->where('user_email',$request->email)->where('id',$request->todoId)->update([
            'title'=>$request->title,
            'description'=>$request->description,
            'datetime'=>$request->datetime,
            'status'=>$request->status,
            'updated_at'=>\Carbon\Carbon::now(),
           ]);
        if($update){
            return response()->json(['sucess','Data Updated Successfully'],200);
        }
        else{
            return response()->json(['error','Cannot Update Data'],400);
        }
    }
/** delete User data  */
    public function deleteUserData(Request $request){
        $validator=Validator::make($request->all(),[
            'email'=>['required'],
            'todoId'=>['required'],
        ]);
        if($validator->fails()){
            return response()->json(['error'=>$validator->errors()],401);
        }
        $deleteUserData=DB::table('todo_list')->where('user_email',$request->email)->where('id',$request->todoId)->delete();
        if($deleteUserData){
            return response()->json(['success','deleted successfully'],200);
        }
        else{
            return response()->json(['error','Data cannot delete'],401);
        }
    }
}
