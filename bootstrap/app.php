<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    // Eddie Note: Laravel 11 requires explicit web middleware registration
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->web();
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        //
    })->create();
