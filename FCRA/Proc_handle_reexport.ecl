import ut,_control;
export Proc_handle_reexport(string reexportflag = 'no',string mode = '') := function
	integer GetWords(string s,string1 c=' ') := BEGINC++
  #option pure
	unsigned score = 0;
	while ( lenS > 0 && s[lenS-1] == *c ) lenS--;
	for ( int i = 1; i < lenS; i++ )
	{
		if ( s[i] == *c )
		{
			score++;
		}
	}
	return score+1;
 ENDC++;
 
	ds := fileservices.superfilecontents('~thor_data400::base::override::fcra::qa::lastprocessed');

	string_rec := record
		string thorname := '';
		string version := '';
		string filename := '';
	
	end;

	string_rec proj_recs(ds l) := transform
		integer totalwords := GetWords(l.name,':');
		self.thorname := l.name;
		self.version := ut.Word(l.name,totalwords-2,':');
		self.filename := ut.Word(l.name,totalwords,':');
	end;

	proj_out := project(ds,proj_recs(left));

	// ds := fileservices.SuperFileContents('~thor_data400::base::override::fcra::qa::lastprocessed');
	
	
	return sequential(
					if (reexportflag = 'yes',
						nothor(apply(proj_out,
							sequential(
							// remove from daily file and base file
								fileservices.removesuperfile('~'+FileServices.LogicalFileSuperOwners('~'+regexreplace('::daily::qa::',thorname,'::qa::'))(name <> 'thor_data400::base::override::fcra::qa::lastprocessed')[1].name,'~'+thorname),
								fileservices.removesuperfile('~'+FileServices.LogicalFileSuperOwners('~'+regexreplace('::qa::',thorname,'::daily::qa::'))(name <> 'thor_data400::base::override::fcra::qa::lastprocessed')[1].name,'~'+thorname),
							output('~'+thorname + ' removed'))
							)),
						nothor(
							apply(proj_out,
										if (mode = 'test',
										fileservices.despray('~'+thorname,_control.IPAddress.bctlpedata10,'/data/data_lib_2_hus2/overrides/archive/transfer/test/'+filename +'_processed_'+version+'.txt',,,,TRUE),
										fileservices.despray('~'+thorname,_control.IPAddress.bctlpedata10,'/data/data_lib_2_hus2/overrides/archive/transfer/'+filename +'_processed_'+version+'.txt',,,,TRUE))
									)
							)
						),
					fileservices.clearsuperfile('~thor_data400::base::override::fcra::qa::lastprocessed')
					);
end;