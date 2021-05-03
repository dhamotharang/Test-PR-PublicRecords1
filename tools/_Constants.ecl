import _control;
export _Constants :=
module
	export IsDataland := if(regexfind('Dataland', _Control.ThisEnvironment.Name, nocase)
													,true		
													,false	
											);
	export IsBocaProd := if(regexfind('Prod_Thor', _Control.ThisEnvironment.Name, nocase)
													,true		
													,false	
											);
	export IsBocaQaRoxie := if(regexfind('QA_Roxie', _Control.ThisEnvironment.Name, nocase)
													,true		
													,false	
											);
	export IsAlpha_dev := if(regexfind('Alpha_Dev', _Control.ThisEnvironment.Name, nocase)
													,true		
													,false	
											);
end;
