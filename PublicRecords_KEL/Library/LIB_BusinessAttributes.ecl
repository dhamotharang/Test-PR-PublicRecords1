﻿/*--LIBRARY--*/

IMPORT PublicRecords_KEL;

EXPORT LIB_BusinessAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := MODULE
	#OPTION('expandSelectCreateRow', TRUE);

	// Nulling out stored variables to not propagate to Attributes.kel
	#CONSTANT('NetAcuityURL', '');
	#CONSTANT('OFACURL', '');
	#CONSTANT('TargusURL', '');
	#CONSTANT('IsFCRAValue', FALSE);
	#CONSTANT('GLBPurposeValue', 0);
	#CONSTANT('DPPAPurposeValue', 0);
	#CONSTANT('Watchlists_RequestedValue', '');
	#CONSTANT('IncludeOfacValue', FALSE);
	#CONSTANT('IncludeAdditionalWatchListsValue', FALSE);
	#CONSTANT('Global_Watchlist_ThresholdValue', 0);
	#CONSTANT('IsFCRA', FALSE);
	//if you add a build date to PublicRecords_KEL.ECL_Functions.get_mas_build_dates, you must add it to the below list as well
	#CONSTANT('cds_build_version', '');
	#CONSTANT('faa_build_version', '');
	#CONSTANT('asl_build_version', '');
	#CONSTANT('Bankruptcy_daily', '');
	#CONSTANT('doc_build_version', '');
	#CONSTANT('email_build_version', '');
	#CONSTANT('Gong_weekly', '');
	#CONSTANT('inquiry_build_version', '');
	#CONSTANT('liens_build_version', '');
	#CONSTANT('header_build_version', ''); 
	#CONSTANT('mari_build_version', '');
	#CONSTANT('proflic_build_version', '');
	#CONSTANT('Property_Build_Version', '');
	#CONSTANT('targus_build_version', '');
	#CONSTANT('thrive_build_version', '');
	#CONSTANT('watercraft_build_version', '');
	#CONSTANT('bip_build_version', '');
	#CONSTANT('corp_build_version', '');
	#CONSTANT('cortera_build_version', '');
	#CONSTANT('ecrash_build_version', '');
	#CONSTANT('fraudpoint3_build_version', '');
	#CONSTANT('risktable_build_version', ''); //attrs
	#CONSTANT('utility_build_version', '');
	#CONSTANT('vehicle_build_version', '');
	#CONSTANT('ucc_build_version', '');
	#CONSTANT('phonesplusv2_build_version', '');
	#CONSTANT('pphones_build_version', '');
	#CONSTANT('Foreclosure_Build_Version', '');
	#CONSTANT('Sam_build_version', '');
	#CONSTANT('fcra_optout_version', '');
	
	InputPIIBIIAttributes := PublicRecords_KEL.FnRoxie_GetInputBIIAttributes(InputData, RepInput, Options);

	BusinessSeleIDAttributes := PublicRecords_KEL.FnRoxie_GetBusinessSeleIDAttributes(InputData, RepInput, FDCDataset, Options);

	withBusinessSeleIDAttributes := JOIN(InputPIIBIIAttributes, BusinessSeleIDAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	

	BusinessProxIDAttributes := PublicRecords_KEL.FnRoxie_GetBusinessProxIDAttributes(InputData, RepInput, FDCDataset, Options);

	BusinessAttributes_Results := JOIN(withBusinessSeleIDAttributes, BusinessProxIDAttributes, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));		
	
	EXPORT Results := BusinessAttributes_Results;
END;
