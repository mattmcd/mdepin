classdef BeanFactoryTest < matlab.unittest.TestCase
    %BEANFACTORYTEST Test creation of bean factory from context object
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    properties
    end
    
    methods (Test)
        function testCreateFactory(testCase)
            context.Data.class = 'mdepin.test.mock.MockData';
            context.Data.NumProp = 1;
            context.Data.CharProp = 'Hello world';
            context = mdepin.StructContext( context );
            beanFactory = mdepin.BeanFactory(context);
            beanFactory.init();
            data = beanFactory.getBean( 'Data' );
            testCase.assertClass( data, ?mdepin.test.mock.MockData);
            testCase.assertEqual( data.NumProp, 1);
        end
        
        function testCreateFailForCycle(testCase)
            % Test that creating bean factory fails if cyclic dependency
            ctx.Client1.class = 'mdepin.test.mock.Client';
            ctx.Client1.Service = 'Client2';
            ctx.Client2.class = 'mdepin.test.mock.Client';
            ctx.Client2.Service = 'Client1';
            ctx = mdepin.StructContext( ctx );
            beanFactory = mdepin.BeanFactory(ctx);
            try
                beanFactory.init();
            catch ME
                testCase.assertEqual(ME.identifier, 'dep:cycle');
                return
            end
            error('expected:fail', 'Expected test to fail');
        end
    end
    
end

