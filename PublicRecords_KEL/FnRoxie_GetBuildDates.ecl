IMPORT PublicRecords_KEL, Risk_Indicators;

EXPORT FnRoxie_GetBuildDates (DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster) InputData,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION 
			
//if the build date is nonFCRA only please blank it out accordinly so it is not seen on the dev roxie			
//there are additional build dates that can be referenced in get_mas_build_dates for future attributes
			
	IsFCRA := FALSE : STORED('isFCRA');	
			
			
	SetBuildDates := PROJECT(InputData, TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
		SELF.G_BuildBusHdrDt := IF(~options.ISFCRA, PublicRecords_KEL.ECL_Functions.get_mas_build_dates('bip_build_version'), '');
		SELF.G_BuildB2BDt := IF(~options.ISFCRA,  PublicRecords_KEL.ECL_Functions.get_mas_build_dates('cortera_build_version'), '');
		SELF.G_BuildSOSDt :=  IF(~options.ISFCRA, PublicRecords_KEL.ECL_Functions.get_mas_build_dates('Corp_build_version'), '');
		SELF.G_BuildDrgLnJDt := PublicRecords_KEL.ECL_Functions.get_mas_build_dates('liens_build_version');
		SELF.G_BuildUCCDt := IF(~options.ISFCRA, PublicRecords_KEL.ECL_Functions.get_mas_build_dates('ucc_build_version'), '');
		SELF.G_BuildDrgCrimDt :=PublicRecords_KEL.ECL_Functions.get_mas_build_dates('doc_build_version');
		SELF.G_BuildAstVehAutoDt := IF(~options.ISFCRA, PublicRecords_KEL.ECL_Functions.get_mas_build_dates('vehicle_build_version'), '');
		SELF.G_BuildAstVehAirDt := PublicRecords_KEL.ECL_Functions.get_mas_build_dates('faa_build_version');
		SELF.G_BuildAstVehWtrDt := PublicRecords_KEL.ECL_Functions.get_mas_build_dates('watercraft_build_version');	
		SELF.G_BuildAstPropDt := PublicRecords_KEL.ECL_Functions.get_mas_build_dates('Property_Build_Version');
		SELF.G_BuildEduDt := PublicRecords_KEL.ECL_Functions.get_mas_build_dates('asl_build_version');
		SELF.G_BuildPIICorrDt  := IF(~options.ISFCRA, PublicRecords_KEL.ECL_Functions.get_mas_build_dates('RiskTable_build_version'), '');
		SELF.G_BuildEmailDt := PublicRecords_KEL.ECL_Functions.get_mas_build_dates('email_build_version');
		SELF.G_BuildDrgBkDt :=  PublicRecords_KEL.ECL_Functions.get_mas_build_dates('Bankruptcy_daily'); 
		SELF.G_BuildProfLicDt := MAX(PublicRecords_KEL.ECL_Functions.get_mas_build_dates('mari_build_version'), PublicRecords_KEL.ECL_Functions.get_mas_build_dates('proflic_build_version'));
		SELF.G_BuildSrchDt :=  IF(~options.ISFCRA, PublicRecords_KEL.ECL_Functions.get_mas_build_dates('inquiry_build_version'), '');//nonFCRA name
		SELF.G_BuildInqDt := PublicRecords_KEL.ECL_Functions.get_mas_build_dates('inquiry_build_version');		
		SELF.G_BuildHdrDt := PublicRecords_KEL.ECL_Functions.get_mas_build_dates('header_build_version');
		SELF := LEFT));

		RETURN SetBuildDates;
	END;	