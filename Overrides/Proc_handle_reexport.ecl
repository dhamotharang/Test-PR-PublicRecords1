import ut,_control, STD;
export Proc_handle_reexport(string reexportflag = 'no'
												,string mode = ''
												,string dserver = if (_Control.ThisEnvironment.Name = 'Prod_Thor'
																						,_control.IPAddress.bctlpedata10
																						,_control.IPAddress.bctlpedata12)
												,string desprayprefix = '/data/data_lib_2_hus2/overrides/archive'
												,string versiontoremove = '' // use when the logicals have to removed from super manually
																							// example: 2 exports came in and first failed, second passed but you need to remove the first
																							//JIRA: DF-20859  
												) := function
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
															desprayprefix+'/transfer',
															desprayprefix+'/transfer/test');
	
	//JIRA: DF-20859  
	patterntosearch := if (versiontoremove <> '','*in*override*'+versiontoremove+'*','');
 
 
	rSuperNames := record
		string name;
	end;
 
 //JIRA: DF-20859  
	ds := if (patterntosearch <> ''
							,project(fileservices.logicalfilelist(patterntosearch),transform(rSuperNames,self := left))
							,project(fileservices.superfilecontents('~thor_data400::base::override::fcra::qa::lastprocessed'),transform(rSuperNames,self := left))
						);


	

	rFilesToRemove := record
		string thorname := '';
		string version := '';
		string filename := '';
		string supername := '';
		dataset(rSuperNames) snames;
	end;

	rFilesToRemove proj_recs(ds l) := transform
		integer totalwords := STD.Str.CountWords(l.name,':');
		self.thorname := l.name;
		self.version := STD.STr.SplitWords(l.name,':')[totalwords-1];
		self.filename := STD.STr.SplitWords(l.name,':')[totalwords];
		self.snames := FileServices.LogicalFileSuperOwners('~'+l.name);
		self := l;
	end;

	dGetSupers := project(ds,proj_recs(left));

	rFilesToRemove norm_recs(dGetSupers l, rSuperNames r) := transform
		self.supername := r.name;
		self := l;
	end;
	
	dPopulateSupername := normalize(dGetSupers, left.snames, norm_recs(left,right))(supername <> 'thor_data400::base::override::fcra::qa::lastprocessed');
	

	// ds := fileservices.SuperFileContents('~thor_data400::base::override::fcra::qa::lastprocessed');
	
	
	return sequential(
					if ( ~fileservices.superfileexists('~thor_data400::base::override::fcra::qa::lastprocessed'),
							fileservices.createsuperfile('~thor_data400::base::override::fcra::qa::lastprocessed')),
					if (reexportflag = 'yes' or versiontoremove <> '', //JIRA: DF-20859  
						nothor(apply(global(dPopulateSupername,few)
							,sequential(fileservices.removesuperfile('~'+supername,'~'+thorname)
								
							,output('~'+thorname + ' removed'))
							)),
						nothor(
							apply(global(dPopulateSupername,few),
										if (mode = 'test',
										fileservices.despray('~'+thorname,dserver,despraylocation + '/'+filename +'_processed_'+version+'.txt',,,,TRUE),
										fileservices.despray('~'+thorname,dserver,despraylocation + '/'+filename +'_processed_'+version+'.txt',,,,TRUE))
									)
							)
						),
					if (versiontoremove = '' //JIRA: DF-20859  
						,fileservices.clearsuperfile('~thor_data400::base::override::fcra::qa::lastprocessed'))
					);
end;