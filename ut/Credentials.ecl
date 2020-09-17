import STD;
// get/set encoded credentials 
EXPORT Credentials(string appuser = STD.System.Job.User()) := module
	// this function can be used for storing hpcc username/pass
	export fSetEncodedValues(string username, string password) := function
		DATA vCreds := (DATA)(username+':'+password);
		string vencodedCreds := STD.Str.EncodeBase64(vCreds);
		return if (username <> '' and password <> ''
							,sequential
							(
								if (STD.File.FileExists('~hpccinternal::'+appuser+'::credentials')
									,STD.File.ProtectLogicalFile('~hpccinternal::'+appuser+'::credentials',false))
								,output(dataset([{vencodedCreds}],{string encodedcreds})
											,,'~hpccinternal::'+appuser+'::credentials',overwrite)
								,STD.File.ProtectLogicalFile('~hpccinternal::'+appuser+'::credentials')
								)
							,fail('username, password cannot be empty')
						);
	end;
	// get hpcc creds (encoded)
	export fGetEncodedValues() := function
		return dataset('~hpccinternal::'+appuser+'::credentials',{string encodedcreds},thor,opt)[1].encodedcreds;
									
	end;
	
	// this function can be used for any app that requires username/password (not encoded)
	export fSetAppUserInfo(string username
													,string password
													,string appname = 'hpcc') := function
		dAppInfo := dataset([{username, password}],{string username, string password});
		return if (username <> '' and password <> ''
							,sequential
							(
								if (STD.File.FileExists('~hpccinternal::'+appname+'_'+appuser+'::userinfo')
									,STD.File.ProtectLogicalFile('~hpccinternal::'+appname+'_'+appuser+'::userinfo',false))
								,output(dAppInfo
											,,'~hpccinternal::'+appname+'_'+appuser+'::userinfo',overwrite)
								,STD.File.ProtectLogicalFile('~hpccinternal::'+appname+'_'+appuser+'::userinfo')
								)
							,fail('username, password cannot be empty')
						);
	end;
	// credentials not encoded
	export fGetAppUserInfo(string appname = 'hpcc') := function
		return dataset('~hpccinternal::'+appname+'_'+appuser+'::userinfo'
									,{string username, string password},thor,opt);
									
	end;

  export mac_add2Soapcall() := 
  functionmacro

    return ',HTTPHEADER(\'Authorization\', \'Basic \' + ut.Credentials().fGetEncodedValues())';

  endmacro;
	
	
end;