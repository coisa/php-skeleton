<?php

namespace App\Web\Middleware;

use App\Web\Application;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

/**
 * Class ContentNegociationMiddleware
 *
 * @package App\Web\Middleware
 */
class ContentNegociationMiddleware implements MiddlewareInterface
{
    /**
     * @param ServerRequestInterface $request
     * @param RequestHandlerInterface $handler
     *
     * @return ResponseInterface
     */
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        if ($handler instanceof Application) {

        }

        // app/html -> platesresponder -> request attributes
        // app/json

        //if (!$handler instanceof ResponderAwareInterface) {
        //    $handler->setResponder($responder);
        //}

        return $handler->handle($request);
    }
}
