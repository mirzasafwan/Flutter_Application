<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use App\Models\User;

class AuthController extends Controller
{
/** login*/
    public function login(Request $request){
        $validator=Validator::make($request->all(),[
            'email'=>['required'],
            'password'=>['required','min:8'],
           ]);
           if($validator->fails()){
            return response()->json(['error'=>$validator->errors()],401);
           }
           $userData=User::where('email',$request->email)->first();

           if($userData!=null){
            if($userData->email==request('email') && Hash::check(request('password'),$userData->password)){
                $token=$userData->createToken('MyApp')->accessToken;
                return $token;
            }else{
                return response()->json(['error','invalid Creds'],401);
            }
           }else{
            return response()->json(['error','No user Found'],404);
           }
    }
/** signup*/
    public function signUp(Request $request){
        $validator=Validator::make($request->all(),[
            'email'=>['required','unique:users'],
            'name'=>['required','min:3'],
            'password'=>['required','min:8'],
           ]);
           if($validator->fails()){
            return response()->json(['error'=>$validator->errors()],401);
           }
          $user=new User;
          $user->name=$request->name;
          $user->email=$request->email;
          $user->password=bcrypt($request->password);
          $user->created_at=\Carbon\Carbon::now();
          $user->updated_at=\Carbon\Carbon::now();
          if($user->save()){
            return response()->json(['success','Successfully Inserted Data'],200);
           }

    }

}
