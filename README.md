MATLAB Dependency Injection
===========================
A [dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) framework for MATLAB.

This is loosely based on  [Martin Fowler's dependency injection article](http://www.martinfowler.com/articles/injection.html) 
and [Spring](https://spring.io/).

Components are set up using constructor injection.  This requires each component to inherit from mdepin.Bean and have publicly settable properties for the injected services.  

The demo scripts demo_mdepin.m and demo_mdepin_GUI.m show examples of how dependency injection can be used to create modular applications reusing components.

Mirrored to [MATLAB Central File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/52394-matlab-dependency-injection).

MATLAB&reg; is a registered trademark of The MathWorks, Inc.
