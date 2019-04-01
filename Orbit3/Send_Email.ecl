import _Control;
export Send_Email(string filedate='',string email=''):= module

	shared myemail:='Sudhir.Kasavajjala@lexisnexisrisk.com';
	
	
	
	
	
					
   export emaillist := if ( email = '', _Control.MyInfo.EmailAddressNotify+','+myemail , email + ',' + myemail );
				

	export build_success
						:= fileservices.sendemail(
								emaillist
								,'Orbit3 Spawn WU Succeeded ' + filedate
								,'WUID:' + workunit
							
								);

	export build_failure
						:= fileservices.sendemail(
								emaillist
								,'Orbit3 Spawn WU failed ' + filedate
								,'WUID:' + workunit+ ' ' + FAILMESSAGE
								);
end;