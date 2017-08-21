import _Control, Orbit_report;
export Proc_Build_Calbus_all(STRING filedate,STRING thorName,STRING hostName,STRING srcDir = '/data/data_build_1/calbus/data/') := function

//Clean input file.
Mac_Calbus_Spray( hostName
								 ,srcDir+filedate+'/'
								 ,filedate
								 ,filedate
								 ,filedate+'.ACTIVE305.TXT'
								 ,thorName
								 ,DoClean );
 
//Start Build Process
DoBuild := Proc_build_Calbus(filedate);

//Do Orbit Report
Orbit_report.calbus_stats(DoReport);

retval := sequential(DoClean
										 ,DoBuild
										 ,DoReport
										 ,SampleRecs
										 ) : success(Send_Email(filedate).Build_Success), failure(Send_Email(filedate).Build_Failure);
return retval;
end;