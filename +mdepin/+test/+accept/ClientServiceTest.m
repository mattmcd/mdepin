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
            testCase.createClient();
            assertEqual( testCase.getClientValue(), testCase.ServiceValue);
        end
    end    
    
end

