IMPORT PRTE2_DEA, ut,PRTE_CSV,VersionControl, _Control;
EXPORT Files := 	MODULE

	EXPORT DEA_IN 	:= DATASET('~prte::in::dea',layouts.layout_DEA_In, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));

	Export File_DEA_Base 		:= DATASET(constants.dea_base,layouts.Layout_DEA_OUT_baseV2,flat);

	EXPORT File_DEAv2 			:= project(file_DEA_Base, {file_DEA_BASE} - Layouts.working_layout);
																								
	EXPORT File_DEA_Modified 	:= 	Project(File_DEAv2 ,Transform(PRTE2_DEA.layouts.Layout_DEA_OUT_base_2, 
																Self.name_score := ''; 
																Self.score := ''; 
																Self := Left;)	
																);
											
											
	EXPORT File_DEA 		:= 	PROJECT(File_DEAv2,	TRANSFORM(PRTE2_DEA.layouts.layout_DEA_Out,
													SELF := LEFT;));
	
	EXPORT Base_Full		:= 	PROJECT(File_DEAv2,	TRANSFORM(layouts.full_layout, 
													SELF.name_score := ''; 
													SELF.score := ''; 
													SELF := LEFT;));
													
	EXPORT DEAid_base    := dedup(sort(project(File_DEAv2,layouts.slim_layout),lnpid,DEA_REGISTRATION_NUMBER,local),
													lnpid,
													DEA_REGISTRATION_NUMBER,
													local);
END;