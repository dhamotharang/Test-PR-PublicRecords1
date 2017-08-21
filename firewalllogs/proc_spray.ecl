import _Control,ut;
export proc_spray(string filedate,string filename) := function
	string superfilestring := ut.Word(filename,1,'-')+ut.Word(filename,2,'-');
	landingzone := '/data/infosec/process/spray/*'+filename+'*.log';
	thorfilename := '~thor_data400::in::firewalllogs::'+filedate+'::'+filename+WORKUNIT;
	superfilename := '~thor_data400::in::firewalllogs::'+superfilestring;

	string SourceIP := '10.194.72.226';
	string group_name := _Control.TargetGroup.All_400[1];
	
	spraycsv := FileServices.SprayVariable(sourceIP,landingzone, 10000,'|',,,group_name,thorfilename,-1,,,true,true,true);
						
	addsuper := fileservices.addsuperfile(superfilename,thorfilename);
	return sequential(
								if(not fileservices.superfileexists(superfilename),
										fileservices.createsuperfile(superfilename)),
										if (FileServices.FindSuperFileSubName(superfilename,thorfilename) > 0,
										output(thorfilename + ' already sprayed'),
										sequential(spraycsv
										,addsuper)));
	
end;

