import _control;

export _Flags :=
module

	export IsDataland := if(regexfind('Dataland', _Control.ThisEnvironment.Name, nocase)
													,true		
													,false	
											);


end;