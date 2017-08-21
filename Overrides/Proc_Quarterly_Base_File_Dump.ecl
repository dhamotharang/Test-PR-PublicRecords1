import ut,_Control, wk_ut, STD;
// Function to despray the full dump of all fcra override base files every quarter.
export Proc_Quarterly_Base_File_Dump(string filedate
																	,string wuid
																	,string dserver = _control.IPAddress.bctlpedata10
																	,string desprayprefix = '/data/data_lib_2_hus2/overrides/archive/fulldump') := function

// integer GetWords(string s,string1 c=' ') := BEGINC++
  // #option pure
	// unsigned score = 0;
	// while ( lenS > 0 && s[lenS-1] == *c ) lenS--;
	// for ( int i = 1; i < lenS; i++ )
	// {
		// if ( s[i] == *c )
		// {
			// score++;
		// }
	// }
	// return score+1;
 // ENDC++;
	
 
	despraylocation := if (_Control.ThisEnvironment.Name = 'Prod_Thor',
															desprayprefix,
															desprayprefix+'/test');
	fulldistlist := if (_Control.ThisEnvironment.Name = 'Prod_Thor',
														'Anantha.Venkatachalam@lexisnexis.com,Darren.Knowles@lexisnexis.com,Melanie.Jackson@lexisnexis.com,Charlene.Ros@lexisnexis.com',
														'Anantha.Venkatachalam@lexisnexis.com'
														
														);

ds := wk_ut.get_WUInfo(wuid,wk_ut._constants.LocalEsp).FilesRead(issuper);

	send_email_with_eid := fileservices.sendemail(
													fulldistlist,
													'Override Dump Succeeded ' + filedate,
													'WUID used: '+ wuid);
							
	email_fail := fileservices.sendemail(
													
													fulldistlist,
													'Override Dump FAILED ' + filedate,
													'WUID used: '+ wuid + '. ' + failmessage);


string_rec := record
	string thorname;
	string unixname;
end;

string_rec proj_recs(ds l) := transform
	integer totalwords := STD.Str.CountWords(l.name,':');
	self.thorname := '~'+l.name;
	self.unixname := STD.STr.SplitWords(l.name,':')[totalwords];
end;

proj_out := project(ds(name <> ''),proj_recs(left));

return sequential(
			Overrides.reDID(filedate).getnew(),
			output(wuid,named('Workunit_Used_To_Get_Filelist')),
			output(proj_out), // outputs the list of files to despray
			//desprays the file
			nothor(apply(global(proj_out,few),
			//	if (fileservices.getsuperfilesubcount(thorname) > 0,
					fileservices.despray(thorname,dserver,despraylocation + '/'+filedate+'/'+trim(unixname,left,right)+'_fulldump_'+filedate+'.txt',,,,TRUE)
					))
				
			);/* : success(send_email_with_eid),
					// failure(email_fail);*/

end;