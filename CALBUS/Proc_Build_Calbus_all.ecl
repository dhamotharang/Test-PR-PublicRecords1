IMPORT _Control, Orbit_report;
EXPORT Proc_Build_Calbus_all(
	STRING filedate,
	STRING thorName,
	STRING hostname,
	STRING source = '/data/data_build_1/calbus/data/',
	STRING filename
) := FUNCTION

	//Clean input file.
	Mac_Calbus_Spray( 
		hostname,
		source+'/',
		filedate,
		filedate,
		filename,
		thorName,
		DoClean 
	);
 
	//Start Build Process
	DoBuild := Proc_build_Calbus(filedate);

	//Do Orbit Report
	Orbit_report.calbus_stats(DoReport);

	retval := SEQUENTIAL(
		DoClean,
		DoBuild,
		DoReport,
		SampleRecs
	) : SUCCESS(Send_Email(filedate).Build_Success), FAILURE(Send_Email(filedate).Build_Failure);

	RETURN retval;
END;
