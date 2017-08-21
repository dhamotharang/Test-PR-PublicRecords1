import _Control;
export Proc_Spray(string filedate,string sourcefile) := function
	string SourceIP := '10.121.146.106';
	string group_name := 'thor10_11';
	string thorfilename := '~thor_data400::logs::'+filedate+'::roxie';
	string basefile := '~thor_data400::base::logs::roxie';
	
	spraycsv := FileServices.SprayVariable(sourceIP,sourcefile,1000000,'\\t','|||','\'',group_name,
						thorfilename ,-1,,,true,true);
						
	addsuper := fileservices.addsuperfile(basefile,thorfilename);
	return sequential(
								if(not fileservices.superfileexists(basefile),
										fileservices.createsuperfile(basefile))
										,spraycsv
										,addsuper);
	
end;