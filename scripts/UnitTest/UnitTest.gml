/// @function				UnitTest()
/// @argument				{string} name?
///	@description			Constructs a UnitTest Class, used for testing invidual pieces of code to
///							ensure they keep their intended behavior and stability.
/// @author					Mtax (github.com/Git-Mtax)
function UnitTest() constructor
{
	#region [Static Properties]
		
		/// @member {bool}			A property set and kept true only if any of the test had failures.
		static failuresExist = false;
		
	#endregion
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function(_name)
			{
				name = _name;
				
				testID = 0;
				testStatus = [];
				testNames = [];
			}
			
		#endregion
		#region <Getters>
			
			// @description			Create a formatted string listing the saved results of the tests.
			static getResults = function()
			{
				var _string_results = "";
				
				var _failures_exist = false;
				
				var _testStatus_number = array_length(testStatus);
				
				var _i = 0;
				repeat (_testStatus_number)
				{
					var _failures = [];
					
					var _j = 0;
					repeat (array_length(testStatus[_i]))
					{
						if (!testStatus[_i][_j].success)
						{
							array_push(_failures, (_j + 1));
						}
						
						++_j;
					}
					
					var _string_testName = "";
					
					if (testNames[_i] != undefined)
					{
						_string_testName = (" " + string(testNames[_i]));
					}
					
					_string_results += ("Test #" + string(_i + 1) + ": ");
					
					if (string_length(_string_testName) > 0)
					{
						_string_results += (_string_testName + ": ");
					}
					
					var _failures_length = array_length(_failures);
					
					var _mark_equal = "=";
					
					if (_failures_length > 0)
					{
						_failures_exist = true;
						
						_string_results += "FAILURE" + ((_failures_length > 1) ? "S" : "") + " (";
						
						if (_failures_length == 1)
						{
							var _failure = testStatus[_i][(_failures[0] - 1)];
							_string_results += (string(_failure.functionReturn) + " ≠ " 
									   + string(_failure.expectedResult));
						}
						else
						{
							var _j = 0;
							repeat (_failures_length)
							{
								if (_j != 0)
								{
									_string_results += ", ";
								}
							
								_string_results += string(_failures[_j]);
							
								++_j;
							}
						}
						
						_string_results += ")";
					}
					else
					{
						_string_results += "SUCCESS";
					}
					
					_string_results += "\n";
					
					++_i;
				}
				
				var _string_title = ((name != undefined) ? string(name) + " - " : "");
				
				_string_title += ("Test Results" + " - ");
				
				if (_testStatus_number > 0)
				{
					_string_title += ((_failures_exist) ? "FAILURES PRESENT" : "ALL CLEAR");
				
					var _string_separation = ":\n\n";
				
					return (_string_title + _string_separation + _string_results);
				}
				else
				{
					_string_title += "NO TESTS DONE";
					
					return _string_title;
				}
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{string|undefined} name
			// @argument			{any} functionReturn
			// @argument			{any} expectedResult
			// @argument			... (Repeated arguments: argument[1] and argument[2])
			// @description			Check if the value returned by the function is the same as the
			//						specified expected one.
			//						A name of this test can be specified in the first argument of this
			//						function. Then the next arguments will accept any number of the 
			//						argument pairs for function return and their expected results.
			static assert_equal = function()
			{
				testNames[testID] = argument[0];
				
				var _i = 1;
				repeat ((argument_count - 1) div 2)
				{
					var _pair = ((_i - 1) div 2);
					
					var _functionReturn = argument[_i];
					var _expectedResult = argument[_i + 1];
					
					testStatus[testID][_pair] =
					{
						success: (_functionReturn == _expectedResult),
						functionReturn: _functionReturn,
						expectedResult: _expectedResult
					}
					
					if (!testStatus[testID][_pair].success)
					{
						failuresExist = true;
					}
					
					_i += 2;
				}
				
				++testID;
			}
			
			// @argument			{string|undefined} name
			// @argument			{any} functionReturn
			// @argument			{any} expectedResult
			// @argument			...
			// @description			Check if the value returned by the function is different from the
			//						specified expected one.
			//						A name of this test can be specified in the first argument of this
			//						function. Then the next arguments will accept any number of the 
			//						argument pairs for function return and their expected results.
			static assert_notEqual = function()
			{
				testNames[testID] = argument[0];
				
				var _i = 1;
				repeat ((argument_count - 1) div 2)
				{
					var _pair = ((_i - 1) div 2);
					
					var _functionReturn = argument[_i];
					var _expectedResult = argument[_i + 1];
					
					testStatus[testID][_pair] =
					{
						success: (_functionReturn == _expectedResult),
						functionReturn: _functionReturn,
						expectedResult: _expectedResult
					}
					
					if (!testStatus[testID][_pair].success)
					{
						failuresExist = true;
					}
					
					_i += 2;
				}
				
				++testID;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		argument_original = array_create(argument_count, undefined);
		
		var _i = 0;
		repeat (argument_count)
		{
			argument_original[_i] = argument[_i];
			
			++_i;
		}
		
		script_execute_ext(method_get_index(self.construct), argument_original);
		
	#endregion
}
