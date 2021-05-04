IMPORT STD, EBR;


EXPORT Mac_Spray_RawData(
	source_IP,
	source_path,
	filedate,
	file_name,
	group_name 
) := MACRO

	#UNIQUENAME(recSize);
	#UNIQUENAME(Create_Superfiles);
	#UNIQUENAME(CreateSuperFiles);
	#UNIQUENAME(spray_main);
	#UNIQUENAME(super_main);
	#UNIQUENAME(splitRecs);
	#UNIQUENAME(do_spray_raw_data);

	#WORKUNIT('name','EBR Spray');

	%recSize% := 503;

	%Create_Superfiles% := STD.File.CreateSuperFile('~thor_data400::in::ebr::RawData');
	%CreateSuperFiles%  := IF (~STD.File.SuperFileExists('~thor_data400::in::ebr::RawData'),%Create_Superfiles%);
 
	%spray_main% := STD.File.SprayFixed(
		source_IP,
		source_path + file_name,
		%recSize%,
		group_name,
		'~thor_data400::in::ebr::RawData_'+ filedate,,,,
		TRUE,
		TRUE,
		TRUE
	);

	%super_main% := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		//STD.File.ClearSuperFile('~thor_data400::in::ebr::RawData'),
		STD.File.AddSuperFile('~thor_data400::in::ebr::RawData','~thor_data400::in::ebr::RawData_'+ filedate),
		STD.File.FinishSuperFileTransaction()
	);

	%do_spray_raw_data% := SEQUENTIAL(
		OUTPUT('spray data...'),
		%CreateSuperFiles%,
		%spray_main%,
		%super_main%
	);

	%do_spray_raw_data%;

ENDMACRO
;
