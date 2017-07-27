// Name - Proc_Spray
// Parameters - filedate (date of spray), sourcefile (file name with full path)
// Function - Sprays a csv file and moves the sprayed file to a superfile

import ut,_Control;
export Proc_spray(string filedate,string sourcefile,string source) := function
	
	sourceIP := _control.IPAddress.edata12;
	group_name := _control.TargetGroup.Thor400_92;
	// group_name := 'thor400_88';
	filesuffix := regexreplace('.txt',ut.word(sourcefile,ut.NoWords(sourcefile,'/')+1,'/'),'');
	tempfilename := '~thor_data400::temp::webclick::' + filedate + '::' + filesuffix;
	infilename := '~thor_data400::in::webclick::' + filedate + '::' + filesuffix;
	superfile := '~thor_data400::base::webclick::access_log';
	
	// Spray CSV file
	spraycsv := FileServices.SprayVariable(sourceIP,sourcefile,,,,,group_name,
						tempfilename ,-1,,,true,true);
	
	// Add source flag
	ds := dataset(tempfilename,WebClick_Tracker.Layout_WC_FileIn_Pre_Flag,csv(quote('\"')));
 	
	addflag_rec := record
		string source := source;
		ds;
	end;
	
	tab_recs := table(ds,addflag_rec);
	
	// Add csv file to superfile
	superfileT := sequential
						(
							if (fileservices.superfileexists(superfile),
								output(superfile + ' exists'),
								fileservices.createsuperfile(superfile)),
							output(tab_recs,,infilename,csv(quote('\"'))),
							fileservices.addsuperfile(superfile,infilename),
							fileservices.deletelogicalfile(tempfilename)
						);
	
	actions := sequential(spraycsv,superfileT);
	
	return 	actions;
					
end;