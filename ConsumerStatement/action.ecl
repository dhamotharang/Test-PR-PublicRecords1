import roxiekeybuild;
EXPORT action(string infiledate,string indexenvstring) := module
	
	shared createindex(indexdataset,infiledate,suffix,indexenv, retval) := macro
		#uniquename(lfilename)
		%lfilename% := regexreplace('@version@',filenames(indexenvstring).buildkeys.keyname(suffix),infiledate);
		retval := if (~fileservices.fileexists(%lfilename%),
								buildindex(key.indexenv.indexdataset,%lfilename%,update),
								output(%lfilename% + ' exists - skipping')
								);
		
		
	endmacro;

	shared movekey(indexname,infiledate,retval) := macro
		RoxieKeyBuild.Mac_SK_Move_V3(filenames(indexenvstring).buildkeys.keyname(indexname),'D',retval,infiledate,'1');
	endmacro;

	export build_keys := function
		
		createindex(address,infiledate,'address',nonfcra,addressretval);
		createindex(phone,infiledate,'phone',nonfcra, phoneretval);
		createindex(statement_id,infiledate,'statement_id',nonfcra, sidretval);
		createindex(lexid,infiledate,'lexid',fcra,lexidretval);
		createindex(ssn,infiledate,'ssn',fcra, ssnretval);
		return map(
								indexenvstring = 'nonfcra' => 
											parallel(
														addressretval
														,phoneretval
														,sidretval
														),
								indexenvstring = 'fcra' => 
											parallel(
														lexidretval
														,ssnretval
														)
							);
	end;
	
	
	export promote_keys := function
	
		movekey('address',infiledate,addressretval);
		movekey('phone',infiledate,phoneretval);
		movekey('statement_id',infiledate,sidretval);
		movekey('lexid',infiledate,lexidretval);
		movekey('ssn',infiledate,ssnretval);
		return map(
								indexenvstring = 'nonfcra' => 
											parallel(
														addressretval
														,phoneretval
														,sidretval
														),
								indexenvstring = 'fcra' => 
											parallel(
														lexidretval
														,ssnretval
														)
							);
				
	end;
	
	export runbuild := function
		return sequential
										(
											build_keys
											,promote_keys
										
										);
	end;
	
	export spray(string sourceip,string unixfilename,string groupname) :=  function
		logicalname := regexreplace('::qa::',filenames(indexenvstring).datafile,'::'+infiledate+'::');
		promotefile := regexreplace('::qa::',filenames(indexenvstring).datafile,'::@version@::');
		sprayfile := FileServices.SprayVariable(sourceip,unixfilename,,'\\t','\\r\\n','\"',groupname,logicalname,-1,,,true);
		RoxieKeyBuild.Mac_SK_Move_V3(promotefile,'D',filepromoted,infiledate,'2');
		
		return sequential(
											sprayfile,
											filepromoted
											);
		
	end;
	
end;