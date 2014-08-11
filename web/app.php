<?php

use Symfony\Component\ClassLoader\ApcClassLoader;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Debug\Debug;

require_once __DIR__.'/../app/environment.php';
if (in_array($ENV['APP_ENVIRONMENT'], array('prod', 'staging'))) {
    $loader = require_once __DIR__.'/../app/bootstrap.php.cache';

    // Use APC for autoloading to improve performance.
    // Change 'sf2' to a unique prefix in order to prevent cache key conflicts
    // with other applications also using APC.
    /*
    $loader = new ApcClassLoader('sf2', $loader);
    $loader->register(true);
     */

    require_once __DIR__.'/../app/AppKernel.php';
    //require_once __DIR__.'/../app/AppCache.php';

    $kernel = new AppKernel($ENV['APP_ENVIRONMENT'], false);
    $kernel->loadClassCache();
    //$kernel = new AppCache($kernel);
} else if (in_array($ENV['APP_ENVIRONMENT'], array('dev'))) {
    // If you don't want to setup permissions the proper way, just uncomment the following PHP line
    // read http://symfony.com/doc/current/book/installation.html#configuration-and-setup for more information
    //umask(0000);

    // This check prevents access to debug front controllers that are deployed by accident to production servers.
    // Feel free to remove this, extend it, or make something more sophisticated.
    if (isset($_SERVER['HTTP_CLIENT_IP'])
        || isset($_SERVER['HTTP_X_FORWARDED_FOR'])
        || !in_array(@$_SERVER['REMOTE_ADDR'], array('192.168.59.3', '127.0.0.1', 'fe80::1', '::1'))
    ) {
        header('HTTP/1.0 403 Forbidden');
        exit('You are not allowed to access this file. Check '.basename(__FILE__).' for more information.');
    }

    $loader = require_once __DIR__.'/../app/bootstrap.php.cache';
    Debug::enable();

    require_once __DIR__.'/../app/AppKernel.php';

    $kernel = new AppKernel('dev', true);
    $kernel->loadClassCache();
} else {
    header('HTTP/1.0 403 Forbidden');
    exit('You are not allowed to access this file. Check '.basename(__FILE__).'/app/environment.php for more information.');
}
$request = Request::createFromGlobals();
$response = $kernel->handle($request);
$response->send();
$kernel->terminate($request, $response);
