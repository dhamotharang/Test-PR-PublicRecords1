	#WORKUNIT('name','Avenger Daily Build');
	#OPTION('multiplePersistInstances',FALSE);

IMPORT ut;
EXPORT Proc_Build_All(string filedate = ut.GetDate):= function

//spray inputfiles
spray_files := Avenger.fn_sprayfiles(): success(avenger.Email_Notification_Lists(filedate).SprayCompletion);
//output new records sample
New_records_sample := Avenger.New_Records_Sample_IDM;
//Scrub input files
	Scrub_IDM				:= Avenger.Proc_IDM_Raw_Stats(filedate)					  : success(output('Scrub IDM input file completed.'));
//build base file 	
  build_base := Avenger.proc_buildbase_old(filedate)  : success(avenger.Email_Notification_Lists(filedate).BuildSuccess),failure(avenger.Email_Notification_Lists(filedate).BuildFailure);
//build strata 
build_strata := Avenger.proc_build_strata(filedate) : success(output('Build strata report completed.'));

return sequential(
spray_files, New_records_sample, Scrub_IDM, build_base,build_strata);

end;
