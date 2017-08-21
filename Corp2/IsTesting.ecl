import _control;
export IsTesting := if(_Control.ThisEnvironment.Name = 'Dataland'
												,true		// If running on dataland, assume you are testing
												,false	// If not running on dataland, assume production
										);