IMPORT PublicRecords_KEL, Risk_Indicators;

EXPORT FnRoxie_GetBuildDates (DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster) InputData,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION 
			
	SetBuildDates := PROJECT(InputData, TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
		SELF.G_BuildBusHdrDt := Risk_Indicators.get_build_date('bip_build_version');
		SELF.G_BuildB2BDt := Risk_Indicators.get_Build_date('cortera_build_version');
		SELF.G_BuildSOSDt := Risk_Indicators.get_build_date('Corp_build_version');
		SELF.G_BuildDrgLnJDt := Risk_Indicators.get_build_date('liens_build_version');
		SELF.G_BuildUCCDt := Risk_Indicators.get_build_date('ucc_build_version');
		SELF.G_BuildDrgCrimDt := Risk_Indicators.get_Build_date('doc_build_version');
		SELF.G_BuildAstVehAutoDt := Risk_Indicators.get_Build_date('vehicle_build_version');	
		SELF.G_BuildAstVehAirDt := Risk_Indicators.get_Build_date('faa_build_version');
		SELF.G_BuildAstVehWtrDt := Risk_Indicators.get_Build_date('watercraft_build_version');
		SELF.G_BuildAstPropDt := Risk_Indicators.get_Build_date('Property_Build_Version');
		SELF.G_BuildEduDt := Risk_Indicators.get_Build_date('asl_build_version');
		SELF.G_BuildPIICorrDt  := Risk_Indicators.get_build_date('pii_corr_build_version');
		SELF.G_BuildEmailDt := IF(Options.IsFCRA, Risk_Indicators.get_Build_date('FCRA_email_build_version'), Risk_Indicators.get_Build_date('email_build_version'));
		SELF.G_BuildDrgBkDt := Risk_Indicators.get_Build_date('bankruptcy_daily'); 		
		SELF.G_BuildProfLicDt := Risk_Indicators.get_Build_date('proflic_build_version');
		SELF.G_BuildSrchDt :=Risk_Indicators.get_Build_date('inquiry_update_build_version');
		SELF.G_BuildInqDt :=IF(Options.IsFCRA, Risk_Indicators.get_Build_date('inquiry_build_version'), Risk_Indicators.get_Build_date('inquiry_update_build_version'));
		SELF := LEFT));
		
		RETURN SetBuildDates;
	END;	