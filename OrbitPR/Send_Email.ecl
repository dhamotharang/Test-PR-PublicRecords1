import _Control;
export Send_Email(string filedate='',string email='',string buildname , string buildvs ):= module

	shared myemail:='Sudhir.Kasavajjala@lexisnexisrisk.com';
	
	
	
	
	
					
   export emaillist := if ( email = '', myemail , email + ',' + myemail );
				

	export build_success
						:= fileservices.sendemail(
								emaillist
								,'OrbitPR Spawn WU Succeeded ' + filedate + ', Build Name : '+buildname + ', Build Version : ' + buildvs
								,'WUID:' + workunit
							
								);

	export build_failure
						:= fileservices.sendemail(
								emaillist
								,'OrbitPR Spawn WU failed ' + filedate + ', Build Name : '+buildname + ', Build Version : ' + buildvs
								,'WUID:' + workunit+ ' ' + FAILMESSAGE
								);
end;