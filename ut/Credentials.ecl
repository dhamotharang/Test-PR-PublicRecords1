import STD;
// get/set encoded credentials 
EXPORT Credentials() := module
	export fSetEncodedValues(string username, string password) := function
		DATA vCreds := (DATA)(username+':'+password);
		string vencodedCreds := STD.Str.EncodeBase64(vCreds);
		return if (username <> '' and password <> ''
							,sequential
							(
								if (STD.File.FileExists('~hpccinternal::'+STD.System.Job.User()+'::credentials')
									,STD.File.ProtectLogicalFile('~hpccinternal::'+STD.System.Job.User()+'::credentials',false))
								,output(dataset([{vencodedCreds}],{string encodedcreds})
											,,'~hpccinternal::'+STD.System.Job.User()+'::credentials',overwrite)
								,STD.File.ProtectLogicalFile('~hpccinternal::'+STD.System.Job.User()+'::credentials')
								)
							,fail('username, password cannot be empty')
						);
	end;
	
	export fGetEncodedValues() := function
		return dataset('~hpccinternal::'+STD.System.Job.User()+'::credentials',{string encodedcreds},thor,opt)[1].encodedcreds;
									
	end;

  export mac_add2Soapcall() := 
  functionmacro

    return ',HTTPHEADER(\'Authorization\', \'Basic \' + ut.Credentials().fGetEncodedValues())';

  endmacro;
	
	
end;