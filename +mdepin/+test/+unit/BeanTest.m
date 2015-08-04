classdef BeanTest < matlab.unittest.TestCase
    %BEANTEST 
    %   Unit test for mdepin.Bean class
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
    end
    
    methods (Test)
        function testSetProperties(testCase)
            testNum = 1;
            testChar = 'Hello world';
            testArray = [1,2,3,4];            
            config = mdepin.StructConfig(struct('NumProp', testNum, ...
                'CharProp', testChar, 'ArrayProp', testArray ));
            testObj = mdepin.test.mock.MockData( config );
            testCase.assertEqual( testObj.NumProp, testNum );
            testCase.assertEqual( testObj.CharProp, testChar);
            testCase.assertEqual( testObj.ArrayProp, testArray );
        end
        
    end
    
end

