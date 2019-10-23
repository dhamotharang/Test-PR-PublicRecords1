/*2013-11-27T02:42:43Z (Ananth Vankatachalam)

*/
import roxiekeybuild, Scrubs_ConsumerStatement,dops,Orbit3;
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
	
	shared prepbase(filetype, retval) := macro
		#uniquename(readData)
		%readData% := consumerstatement.ReadData.filetype;
		#uniquename(rawFile)
		%rawFile% := dataset(consumerstatement.filenames(indexenvstring).rawfile,consumerstatement.layout.filetype.consumer,csv(separator('\t')),opt);
		#uniquename(baseLogicalFile)
		%baseLogicalFile% := regexreplace('::qa::',filenames(indexenvstring).datafile,'::'+infiledate+'::');
		#uniquename(promotefile)
		%promotefile% := regexreplace('::qa::',filenames(indexenvstring).datafile,'::@version@::');
		#uniquename(filepromoted)
		RoxieKeyBuild.Mac_SK_Move_V3(%promotefile%,'D',%filepromoted%,infiledate,'2');
		
		retval := sequential(
										fileservices.removesuperfile(filenames(indexenvstring).datafile,%baseLogicalFile%),
										if (indexenvstring = 'fcra',
											output(%rawFile%,,%baseLogicalFile%,csv(separator('\t')),overwrite),
												output(%readData% + %rawFile%,,%baseLogicalFile%,csv(separator('\t')),overwrite)),
										%filepromoted%
																
									);
		
	endmacro;
	
	export addtobase := function
		prepbase(nonfcra, nonfcraretval);
		prepbase(fcra, fcraretval);
		return map(
									indexenvstring = 'nonfcra' => nonfcraretval,
									indexenvstring = 'fcra' => fcraretval
								);
	
	end;
	
	export update_dops := function
		return map(
	             indexenvstring = 'nonfcra' => 
							 dops.updateversion ( 'ConsumerStatementKeys',infiledate,'skasavajjala@seisint.com',,'N'),
							 indexenvstring = 'fcra' => 
							 dops.updateversion ( 'FCRA_ConsmrStmtKeys',infiledate,'skasavajjala@seisint.com',,'F') 
							);
							
	end;
	
	export update_orbit := function
	return map(
	             indexenvstring = 'nonfcra' => 
							 Orbit3.proc_Orbit3_CreateBuild ( 'Consumer Statement',infiledate),
							 indexenvstring = 'fcra' => 
		           Orbit3.proc_Orbit3_CreateBuild ( 'FCRA Consumer Statement',infiledate,'F')

							);
							
	end;
	
	export runbuild := function
		return sequential
										(
											addtobase
											,build_keys
											,promote_keys
											,update_dops
											,update_orbit
											,Scrubs_ConsumerStatement.fn_RunScrubs(infiledate[1..8],'')
										
										);
	end;
	
	export spray(string sourceip,string unixfilename,string groupname) :=  function
		logicalname := regexreplace('::qa::',filenames(indexenvstring).rawfile,'::'+infiledate+'::');
		promotefile := regexreplace('::qa::',filenames(indexenvstring).rawfile,'::@version@::');
		sprayfile := FileServices.SprayVariable(sourceip,unixfilename,,'\\t','\\r\\n','\"',groupname,logicalname,-1,,,true);
		RoxieKeyBuild.Mac_SK_Move_V3(promotefile,'D',filepromoted,infiledate,'2');
		
		return sequential(
											sprayfile,
											filepromoted
											);
		
	end;
	
end;