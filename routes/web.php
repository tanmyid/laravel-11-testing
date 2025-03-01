<?php

use Illuminate\Support\Facades\Route;
use App\Models\User;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/getUsers', function () {
    $users = User::all();

    return response()->json([
        'status' => 'success',
        'data' => $users
    ], 200);
});
