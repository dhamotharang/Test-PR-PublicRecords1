IMPORT _control, TXBUS, orbit_report, Orbit3;

#OPTION('multiplePersistInstances',FALSE);

EXPORT Proc_Build_Txbus_all(STRING filedate,STRING thorName,STRING hostname,STRING srcDir = '/data/data_build_1/txbus/build/') := FUNCTION

//Clean input file.
Mac_Txbus_Spray(
	hostname,
	srcDir+filedate+'/',
	filedate,
	filedate,
	'TX_'+filedate+'_STACT.txt',
	thorName,
	DoClean
);

//Start Build Process
DoBuild := Proc_build_Txbus(filedate);

//Do Orbit Report
orbit_report.txbus_stats(doReport);

orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('TXBUS',(filedate),'N');
					
retval := sequential(
	DoClean,
	DoBuild,
	doReport,
	SampleRecs,
	orbit_update
) : success(Send_Email(filedate).Build_Success), failure(Send_Email(filedate).Build_Failure);

RETURN retval;
END;