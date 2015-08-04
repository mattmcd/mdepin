classdef ClientServiceTest < matlab.unittest.TestCase
    %CLIENTSERVICETEST Create Client that makes use of Service component
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        ServiceValue = 1 % Value returned by service
        BeanFactory
        Client
    end
    
    methods (Test)
        function testCreateClientService(testCase)
            % Create client with dependency on service
            testCase.readConfiguration();
            assertClass(testCase, testCase.BeanFactory, ?mdepin.BeanFactory)
            testCase.createClient();
            testCase.assertClass( testCase.Client, ?mdepin.test.mock.Client );
            testCase.assertEqual( testCase.getClientValue(), testCase.ServiceValue);
        end
    end    
    
    methods 
        % Helper methods to set up the test case
        function readConfiguration(testCase)
            ctx.Client.class = 'mdepin.test.mock.Client';
            ctx.Client.Service = 'MyService';
            ctx.MyService.class = 'mdepin.test.mock.Service';
            ctx.MyService.Value = testCase.ServiceValue;
            ctx =  mdepin.StructContext( ctx );
            testCase.BeanFactory = mdepin.BeanFactory( ctx );
        end
        
        function createClient(testCase)
            testCase.Client = testCase.BeanFactory.getBean('Client');
        end
        
        function val = getClientValue(testCase)
            val = testCase.Client.getValue();
        end
    end
    
end

