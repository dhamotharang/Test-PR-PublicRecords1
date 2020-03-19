IMPORT ProfileBooster, ProfileBooster.ProfileBoosterV2_KEL, BIPV2, MDR, Risk_Indicators, RiskVIew, dx_BestRecords, UT, STD;

EXPORT Fn_KEL_DPMBitmap := MODULE

	EXPORT Watchdog_NonEN := 'Watchdog NonEN';
	EXPORT Watchdog_NonEQ := 'Watchdog NonEQ';

	/* Sets the DPMBitmapValue for a record of data */
	// Marketing: Sources that are NOT marketing allowed have their marketing permission bit set to 1, so that in marketing mode, they are NOT allowed.
	// Sources that ARE marketing allowed have marketing permission bit set to 0, since they do not need to be turned off when marketing mode is set.
	// The watchdog person data permissions have a marketing bit that is ignored. After talking to the engineer in Boca who worked on those bits, we may change the code here.
	EXPORT SetValue(STRING Source = '', BOOLEAN FCRA_Restricted = FALSE, BOOLEAN GLBA_Restricted = FALSE, BOOLEAN Pre_GLB_Restricted = FALSE, BOOLEAN DPPA_Restricted = FALSE, STRING DPPA_State = '', BOOLEAN Generic_Restriction = FALSE, BOOLEAN Not_Restricted = FALSE, BOOLEAN Insurance_Product_Restricted = FALSE, UNSIGNED watchdogPermissionsColumn = 0, ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile KELPermissions = ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile, UNSIGNED BIPBitMask = 0) := FUNCTION
		Permissions := 
			IF(FCRA_Restricted, IF(NOT Not_Restricted, KELPermissions.Permit_FCRA, 0), IF(NOT Not_Restricted, KELPermissions.Permit_NonFCRA, 0)) | // IF FCRA_Restricted is TRUE this record/file is FCRA Restricted, if FALSE it is assumed to be a NonFCRA record/file.  Not_Restricted is utilized for files that allowed for usage in both FCRA and NonFCRA
			IF(GLBA_Restricted, KELPermissions.Permit_GLBA, 0) | // This record/file is GLBA Restricted, you must have proper GLBA Permissions to use the data
			IF(DPPA_Restricted, KELPermissions.Permit_DPPA, 0) | // This record/file is DPPA Restricted, you must have proper DPPA Permissions to use the data
			
			IF(Source IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.ALLOWED_MARKETING_SOURCES OR BIPBitMask > 0, 0, KELPermissions.Permit_Marketing) | // This record/file is Marketing Approved, when running a Marketing Product you can use the data. Skip this check for BIP Best data (BIPBitMask > 0) since source codes are not populated, and marketing restriction has already been applied in BIPBitMask.
			// BIP Best checks against MDR.sourceTools.set_Marketing_Restricted for marketing restrictions instead of ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.ALLOWED_MARKETING_SOURCES. Using this code so we can match what the interface does.
			IF(Source IN MDR.sourceTools.set_Marketing_Restricted AND BIPBitMask > 0, KELPermissions.Permit_Marketing, 0) | 
			
			IF(Insurance_Product_Restricted, KELPermissions.Permit_InsuranceProduct, 0) | // This record/file is only permitted for use within an Insurance Product.  Business Services is NOT allowed to utilize these records
			
			/* ******** Data Restriction Mask controlled sources ******** */
			IF(Source IN [MDR.sourceTools.src_Fares_Deeds_from_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Deeds], KELPermissions.Permit_Fares, 0) | // Fares is a DRM restricted source
			IF(Source = MDR.sourceTools.src_Experian_Credit_Header, IF(FCRA_Restricted, KELPermissions.Permit_ExperianFCRA, KELPermissions.Permit_Experian), 0) | // Experian is a DRM restricted source - depending on if it is an FCRA or NonFCRA source it has different DRM bits
			IF(Source = MDR.sourceTools.src_Certegy, KELPermissions.Permit_Certegy, 0) | // Certegy is a DRM restricted source
			IF(Source = MDR.sourceTools.src_Equifax, KELPermissions.Permit_Equifax, 0) | // Equifax is a DRM restricted source
			IF(Source = MDR.sourceTools.src_TU_CreditHeader, KELPermissions.Permit_TransUnion, 0) | // TransUnion Credit is a DRM restricted source
			IF(Source = MDR.sourceTools.src_Experian_Credit_Header + ',' + MDR.sourceTools.src_TU_CreditHeader + ',' + MDR.sourceTools.src_Equifax, 
				IF(FCRA_Restricted, KELPermissions.Permit_ExperianFCRA, KELPermissions.Permit_Experian) | 
				KELPermissions.Permit_TransUnion | 
				KELPermissions.Permit_Equifax, 0) | // This is a special permission used for selecting the Combo child dataset in certain pre-built Roxie Indexes which have Combo/EN/TN/EQ child datasets, it requires all 3 permissions
			IF(Source = MDR.sourceTools.src_advo_valassis, KELPermissions.Permit_ADVO, 0) | // ADVO is a DRM restricted source
			IF(Source = MDR.sourceTools.src_EBR, KELPermissions.Permit_ExperianEBR, 0) | // Experian EBR is a restricted sources
			IF(Source = MDR.SourceTools.src_Experian_CRDB, KELPermissions.Permit_ExperianCRDB, 0) | // Experian CRDB is a restricted sources
			IF(Source = MDR.sourceTools.src_Experian_Phones, KELPermissions.Permit_ExperianPhones, 0) | // This only applies to a single file: Experian_Phones.Key_Did_Digits and it applies to every record in that file
			IF(Source = MDR.sourceTools.src_InquiryAcclogs, KELPermissions.Permit_Inquiries, 0) | // Inquiries are a DRM restricted source
			IF(Pre_GLB_Restricted, KELPermissions.Permit_PreGLB, 0) | //  Records from GLB sources that are older than GLBA laws are DRM restricted 
			IF(Source IN (MDR.sourceTools.set_Liens + [MDR.sourceTools.src_Liens_and_Judgments]), KELPermissions.Permit_LiensJudgments, 0) | // Liens and Judgements are restricted sources
			IF(Source IN [MDR.sourceTools.Src_Cortera, MDR.sourceTools.Src_Cortera_Tradeline], KELPermissions.Permit_Cortera, 0) | // Cortera is a DRM restricted source
						
			/* ******** Data Permission Mask controlled sources ******** */
			IF(Source = MDR.sourceTools.src_Targus_Gateway, KELPermissions.Permit_Targus, 0) | // The Targus Gateway is a DPM restricted source
			IF(Source = MDR.sourceTools.src_Death_Restricted, KELPermissions.Permit_SSNDeathMaster, 0) | // SSN Death Master data is a DPM restricted source
			IF(Source = MDR.sourceTools.src_InquiryAcclogs AND Generic_Restriction, KELPermissions.Permit_FDN, 0) | // For Inquiries, there are certain records which are only allowed if the DPM restriction for FDN allows usage.  Here Generic_Restriction is checking to see if the "method" column in our Inquiries data is IN ['BATCH','MONITORING']
			IF(Source = ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.FraudPoint3Source, KELPermissions.Permit_FDN, 0) | 			//FDN data is DPM restricted		
			// KELPermissions.Permit_InsuranceDL -- We don't currently have Insurance DL Data coded, unable to implement this permission until we know how to bring in other gateway type data.  Data comes from InsuranceHeader_BestOfBest.search_Insurance_DL_by_Did(...)
			IF(Source = MDR.sourceTools.src_Business_Credit, KELPermissions.Permit_SBFE, 0) | // SBFE Data is a restricted source

			/* ******** GLBA restrictions ******** */
			// Data from GLB sources that is not older than the GLBA laws requires a valid GLBA Purpose to access.
			IF(MDR.SourceTools.SourceIsGLB(Source) AND NOT Pre_GLB_Restricted, KELPermissions.Permit_GLBA, 0) |
			
			/* ******** DPPA restrictions ******** */
			// There are two types of DPPA restrictions.
			// Certain sources/files require any valid DPPA (1-7) to return data.
			// Other sources are further restricted based of the state the data is from and can only be returned with a specific subset of valid DPPA values.
			// Each of these subsets that we utilize is controlled by a different DPPAGroup in the KEL DPM.
			IF(MDR.SourceTools.SourceIsDPPA(Source) OR DPPA_Restricted, 
				(KELPermissions.Permit_DPPA | 
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[1].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup1, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[2].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup2, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[3].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup3, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[4].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup4, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[5].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup5, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[6].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup6, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[7].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup7, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[8].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup8, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[9].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup9, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[10].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup10, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[11].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup11, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[12].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup12, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[13].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup13, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[14].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup14, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[15].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup15, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[16].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup16, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[17].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup17, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[18].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup18, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[19].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup19, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[20].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup20, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[21].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup21, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[22].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup22, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[23].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup23, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[24].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup24, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[25].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup25, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[26].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup26, 0) |
				IF(EXISTS(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[27].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup27, 0)),
				0) |

			/* ******** Best Business Restrictions using BIP Bitmask ******** */
			BIPBitMask | // BIPBitMask is precalculated in Fn_KEL_FPMBitmap.ConvertAndNoralizeBIPPermits. Any Permits bits that are turned on in the BIPBitMask we also turn on in our KEL Permits value. ConvertAndNoralizeBIPPermits has already translated BIP Permits values to KEL permits values.
			
			/* ******** Generic Restrictions ******** */
			IF(Source = MDR.sourceTools.src_Dunn_Bradstreet, KELPermissions.Permit_DNBDMI, 0) | // DNB DMI is not allowed unless the Allowed Sources option is set specifically to turn it on.
			IF(Source = MDR.sourceTools.src_Utilities, KELPermissions.Permit_Utility, 0) | // Utility data is typically controlled by the IndustryClass value sent into the query at runtime, this data could be toggled by that IndustryClass value
			IF(Source = MDR.sourceTools.src_Professional_License AND Generic_Restriction, KELPermissions.Permit_DirectToConsumer, 0) | // FCRA Professional License records where vendor = 'ASC APPRAISAL SUBCOMMITTEE' are not allowed if the Permissible Purpose is Direct To Consumer
			
			IF(Source IN [MDR.sourceTools.src_Mixed_DPPA, MDR.sourceTools.src_Mixed_Non_DPPA], KELPermissions.Permit_Restricted, 0) | // These sources are permanently restricted, there is no way to enable permissions for them in the Generate(...) function below, we just don't ever want to use this data
			IF(Source = MDR.sourceTools.src_Mari_Prof_Lic AND Generic_Restriction, KELPermissions.Permit_Restricted, 0) | // MARI records where std_source_upd IN ['S0822','S0843','S0900','S0868'] are never allowed since we can't use New Mexico and Pennsylvania real estate
			IF(Source = MDR.sourceTools.src_UCCV2 AND ~Generic_Restriction, KELPermissions.Permit_Marketing, 0) | //UCC Marking restricted 
			IF(Source = Watchdog_NonEN, KELPermissions.Permit_Equifax, 0) |
			IF(Source = Watchdog_NonEQ, KELPermissions.Permit_NonEquifax, 0) |
			MAP(watchdogPermissionsColumn & dx_BestRecords.Functions.get_perm_type(glb_flag:=false, pre_glb_flag:=false, filter_exp_flag:=false) > 0 => KELPermissions.Permit_WatchdogNonRestricted, // This watchdog best record isn't restricted for usage
			    watchdogPermissionsColumn & dx_BestRecords.Functions.get_perm_type(glb_flag:=true, pre_glb_flag:=false, filter_exp_flag:=false) > 0 => KELPermissions.Permit_GLBA, // This watchdog best record only requires GLBA Permissions to use
			    watchdogPermissionsColumn & dx_BestRecords.Functions.get_perm_type(glb_flag:=true, pre_glb_flag:=false, filter_exp_flag:=true) > 0 => KELPermissions.Permit_GLBA | KELPermissions.Permit_WatchdogExperianRestricted, // This watchdog best record requires GLBA Permission and Experian must be restricted
			    watchdogPermissionsColumn & dx_BestRecords.Functions.get_perm_type(glb_flag:=false, pre_glb_flag:=true, filter_exp_flag:=false) > 0 => KELPermissions.Permit_WatchdogPreGLBA, // This watchdog best record requires that we NOT be filtering PreGLB data
			    watchdogPermissionsColumn > 0 => KELPermissions.Permit_Restricted, // Any other watchdog best records that didn't fit into the above conditions should be blocked from usage
			                     0) | // Default to allowing the record - should only trigger when watchdogPermissionsColumn == 0, which would be true for any files that aren't the Watchdog Key

			KELPermissions.Permit_NoRestriction; // Every Record will be tagged as having NoRestriction - any records which have additional restrictions are handled above
			/* TODO: KS-1968 - Define the set of ALLOWED_SOURCES.  At the time that ticket is worked on, replace the previous line of code with the following commented-out lines:
			IF(Source IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.ALLOWED_SOURCES, KELPermissions.Permit_NoRestriction, KELPermissions.Permit_Restricted); // Every Record which is in the set of Allowed Sources will be tagged as having NoRestriction - any records which have additional restrictions are handled above */

		RETURN Permissions;
	END;
	
	/* Generates the KEL PERMITS Bitmask to pass to a KEL QUERY */
	EXPORT Generate(STRING DataRestrictionMask, STRING DataPermissionMask, UNSIGNED1 GLBA, UNSIGNED1 DPPA, BOOLEAN isFCRA, BOOLEAN isMarketing = FALSE, BOOLEAN AllowDNBDMI = FALSE, BOOLEAN OverrideExperianRestriction = FALSE, STRING PermissiblePurpose, STRING IndustryClass = '', ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile KELPermissions = ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile, BOOLEAN IsInsuranceProduct = FALSE) := FUNCTION
		Permissions := 
			IF(isFCRA, KELPermissions.Permit_FCRA, KELPermissions.Permit_NonFCRA) | // If isFCRA is TRUE allow FCRA Restricted data, else allow NonFCRA Restricted data in KEL
			IF(Risk_Indicators.iid_constants.glb_ok(GLBA, isFCRA), KELPermissions.Permit_GLBA, 0) | // Check to see if we have appropriate GLBA permissions before allowing use of GLBA Restricted data in KEL
			IF(Risk_Indicators.iid_constants.dppa_ok(DPPA, isFCRA), KELPermissions.Permit_DPPA, 0) | // Check to see if we have appropriate DPPA permissions before allowing use of DPPA Restricted data in KEL
			IF(isMarketing, 0, KELPermissions.Permit_Marketing) | // Running a Marketing product, only allow Marketing approved sources in KEL
			IF(AllowDNBDMI, KELPermissions.Permit_DNBDMI, 0) | // If AllowDNBDMI is TRUE allow use of DNBDMI data in KEL
			IF(IsInsuranceProduct, KELPermissions.Permit_InsuranceProduct, 0) | // If IsInsuranceProduct is TRUE allow use of Insurance only data in KEL
			IF(PermissiblePurpose = RiskView.Constants.directToConsumer, 0 , KELPermissions.Permit_DirectToConsumer) | // If running with a Direct To Consumer Permissible Purpose, certain Direct to Consumer sources are not allowed
			IF(~(IndustryClass = 'UTILI' OR IndustryClass = 'DRMKT'), KELPermissions.Permit_Utility, 0) | // If Utility data is NOT restricted based on the IndustryClass value, allow its usage in KEL
			// DataRestrictionMask DRM Sources
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posFaresRestriction] != '1', KELPermissions.Permit_Fares, 0) | // If Fares Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posExperianEBR] != '1' AND OverrideExperianRestriction, KELPermissions.Permit_ExperianEBR, 0) | // If Experian EBR Source is NOT restricted in the DataRestrictionMask and OverrideExperianRestriction is set, allow its usage in KEL
			IF(OverrideExperianRestriction, KELPermissions.Permit_ExperianCRDB, 0) | // OverrideExperianRestriction is set, allow CRDB usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posFidelityRestriction] != '1', KELPermissions.Permit_Fidelity, 0) | // If Fidelity is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posExperianRestriction] != '1', KELPermissions.Permit_Experian, 0) | // If Experian Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posCertegyRestriction] != '1', KELPermissions.Permit_Certegy, 0) | // If Certegy Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posEquifaxRestriction] != '1', KELPermissions.Permit_Equifax, KELPermissions.Permit_NonEquifax) | // If Equifax Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posTransUnionRestriction] != '1', KELPermissions.Permit_TransUnion, 0) | // If TransUnion Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posADVORestriction] != '1', KELPermissions.Permit_Advo, 0) | // If ADVO Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posExperianFCRARestriction] != '1', KELPermissions.Permit_ExperianFCRA, 0) | // If ExperianFCRA Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posExperianPhonesRestriction] != '1', KELPermissions.Permit_ExperianPhones, 0) | // If  Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posInquiriesRestriction] != '1', KELPermissions.Permit_Inquiries, 0) | // If  Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posRestrictPreGLB] != '1' OR Risk_Indicators.iid_constants.glb_ok(GLBA, isFCRA), KELPermissions.Permit_PreGLB, 0) | // If PreGLB Source is NOT restricted in the DataRestrictionMask or GLB data is permitted, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posLiensJudgRestriction] != '1', KELPermissions.Permit_LiensJudgments, 0) | // If Liens and Judgments Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posCortera] != '1', KELPermissions.Permit_Cortera, 0) | // If Cortera Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			// DataPermissionMask DPM Sources
			IF(DataPermissionMask[Risk_Indicators.iid_constants.posTargusPermission] = '1', KELPermissions.Permit_Targus, 0) | // If Targus is permitted in the DataPermissionMask, allow its usage in KEL
			IF(DataPermissionMask[Risk_Indicators.iid_constants.posSSADeathMasterPermission] = '1', KELPermissions.Permit_SSNDeathMaster, 0) | // If SSN Death Master Source is permitted in the DataPermissionMask, allow its usage in KEL
			IF(DataPermissionMask[Risk_Indicators.iid_constants.posFDNcftfPermission] = '1', KELPermissions.Permit_FDN, 0) | // If Fraud Defense Network Source is permitted in the DataPermissionMask, allow its usage in KEL
			IF(DataPermissionMask[Risk_Indicators.iid_constants.InsuranceDLPermission] = '1', KELPermissions.Permit_InsuranceDL, 0) | // If Insurance Drivers License Source is permitted in the DataPermissionMask, allow its usage in KEL
			IF(DataPermissionMask[Risk_Indicators.iid_constants.posSBFEPermission] = '1', KELPermissions.Permit_SBFE, 0) | // If SBFE data is permitted in the DataPermissionMask, allow its usage in KEL
			// DPPA Restrictions:
				// DPPA records are restricted for NonFCRA if DPPA is not between 1 and 7.
				// Additional source/state DPPA restrictions also apply that are based on specific DPPA value.
			IF(Risk_Indicators.iid_constants.dppa_ok(DPPA, isFCRA), KELPermissions.Permit_DPPA, 0) |
			CASE(DPPA,
				1 => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA1, isFCRA),
				2 => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA2, isFCRA),
				3 => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA3, isFCRA),
				4 => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA4, isFCRA),
				5 => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA5, isFCRA),
				6 => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA6, isFCRA),
				7 => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA7, isFCRA),
						 0) |
			MAP(DataRestrictionMask[Risk_Indicators.iid_constants.posExperianRestriction] = '1' => KELPermissions.Permit_WatchdogExperianRestricted, // Allow Watchdog Best experian restricted records (Note: this is the inverse of the check for Permit_Experian)
			    DataRestrictionMask[Risk_Indicators.iid_constants.posRestrictPreGLB] != '1' OR Risk_Indicators.iid_constants.glb_ok(GLBA, isFCRA) => KELPermissions.Permit_WatchdogPreGLBA, // Allow Watchdog Best PreGLBA restricted records if the Data Restriction Mask isn't restricting, or if GLBA data is allowed
			    Risk_Indicators.iid_constants.glb_ok(GLBA, isFCRA) => KELPermissions.Permit_GLBA, // Allow Watchdog Best GLBA restricted records
			    KELPermissions.Permit_WatchdogNonRestricted) | // Default to the version of Watchdog Best which isn't restricted

			// Every Transaction should have the NoRestriction permission - this will allow viewing of data that has no restrictions at all
			KELPermissions.Permit_NoRestriction;

		RETURN(Permissions);
	END;

	/* This FUNCTIONMACRO is used for converting the linking team's data permisions bitmask into data permissions that are usable by our KEL system. 
		 First, we translate the BIP Best data permits value into a dataset of KEL Data Permits values in ConvertPermitsToDS PROJECT.
		 Then, we normalize that dataset into one record per permission, since the BIP Permits bits are ORed together, but the KEL Data Permits bits are ANDed together
		 For example, if we have a best company name that comes from EBR and DNBDMI, we only need permissions to view EBR OR DNBDMI to view the record in the Best key.
		 Instead of turning on both Permit_ExperianEBR and Permit_DNBDMI, we split this into two records, one with Permit_ExperianEBR set, and the other with Permit_DNBDMI set
			so we will still return the best company name if either EBR OR DNBDMI is allowed. */
	EXPORT ConvertAndNormalizeBIPPermits(InFile, InPermitsFieldName, KELPermissions = ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile) := FUNCTIONMACRO
			DPMLayout := RECORD
				UNSIGNED8 DPMFromBIPBitMask;
			END;
			
			DPMDatasetLayout := RECORD
				DATASET(DPMLayout) PermitsDataset;
			END;
			
			ConvertPermitsToDS := PROJECT(InFile, TRANSFORM({RECORDOF(LEFT), DPMDatasetLayout},
				MarketingPermission := IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.MARKETING_UNRESTRICTED) > 0, KELPermissions.Permit_NonFCRA, KELPermissions.Permit_Marketing); // Need to check marketing separately from other permissions

				SELF.PermitsDataset := IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.UNRESTRICTED) > 0, DATASET([{MarketingPermission}], DPMLayout), // If it's Unrestricted, bypass all other permission checks since we know we won't need to suppress the record.
															 IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.DNB) > 0, DATASET([{KELPermissions.Permit_DNBDMI | MarketingPermission}], DPMLayout), DATASET([], DPMLayout)) +
															 IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.EBR) > 0, DATASET([{KELPermissions.Permit_ExperianEBR | MarketingPermission}], DPMLayout), DATASET([], DPMLayout)) +
															 IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.PROP_FARES) > 0, DATASET([{KELPermissions.Permit_Fares | MarketingPermission}], DPMLayout), DATASET([], DPMLayout)) +
															 IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.DPPA) > 0, DATASET([{KELPermissions.Permit_DPPA | MarketingPermission}], DPMLayout), DATASET([], DPMLayout)) +
															 IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.PROP_FIDELITY) > 0, DATASET([{KELPermissions.Permit_Fidelity | MarketingPermission}], DPMLayout), DATASET([], DPMLayout)) +
															 IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.PROP_DAYTON) > 0, DATASET([{KELPermissions.Permit_Fidelity | MarketingPermission}], DPMLayout), DATASET([], DPMLayout)));
				SELF := LEFT));

			NormalizePermits := NORMALIZE(ConvertPermitsToDS, LEFT.PermitsDataset,
				TRANSFORM({RECORDOF(LEFT) - PermitsDataset, UNSIGNED8 DPMFromBIPBitMask},
					SELF := RIGHT,
					SELF := LEFT));
				
			RETURN NormalizePermits;	
		ENDMACRO;
		
	/* For debugging purposes converts a KEL PERMITS Bitmask into a string of 1/0 flags for if a PERMITS option is set/enabled */
	EXPORT ConvertToBinaryString(UNSIGNED8 KELDPM, BOOLEAN Reverse = FALSE) := FUNCTION
		converted := UT.IntegerToBinaryString(KELDPM);
		reversed := IF(Reverse, STD.Str.Reverse(converted), converted);
	
		RETURN(reversed);
	END;
	
	/* For debugging purposes converts a KEL PERMITS Bitmask into a dataset of TRUE/FALSE flags for if a PERMITS option is set/enabled */
	EXPORT ConvertToDataset(UNSIGNED8 KELDPM) := FUNCTION
		convertedString := ConvertToBinaryString(KELDPM, TRUE);
	
		result := DATASET([
			{'Permit_Restricted', (BOOLEAN)(convertedString[1] = '1')},
			{'Permit_NoRestriction', (BOOLEAN)(convertedString[2] = '1')},
			{'Permit_FCRA', (BOOLEAN)(convertedString[3] = '1')},
			{'Permit_NonFCRA', (BOOLEAN)(convertedString[4] = '1')},
			{'Permit_GLBA', (BOOLEAN)(convertedString[5] = '1')},
			{'Permit_DPPA', (BOOLEAN)(convertedString[6] = '1')},
			{'Permit_Marketing', (BOOLEAN)(convertedString[7] = '1')},
			{'Permit_InsuranceProduct', (BOOLEAN)(convertedString[8] = '1')},
			{'Permit_Fares', (BOOLEAN)(convertedString[9] = '1')},
			{'Permit_Experian', (BOOLEAN)(convertedString[10] = '1')},
			{'Permit_ExperianFCRA', (BOOLEAN)(convertedString[11] = '1')},
			{'Permit_TransUnion', (BOOLEAN)(convertedString[12] = '1')},
			{'Permit_Equifax', (BOOLEAN)(convertedString[13] = '1')},
			{'Permit_Advo', (BOOLEAN)(convertedString[14] = '1')},
			{'Permit_Cortera', (BOOLEAN)(convertedString[15] = '1')},
			{'Permit_ExperianEBR', (BOOLEAN)(convertedString[16] = '1')},
			{'Permit_ExperianCRDB', (BOOLEAN)(convertedString[17] = '1')},
			{'Permit_SSNDeathMaster', (BOOLEAN)(convertedString[18] = '1')},
			{'Permit_FDN', (BOOLEAN)(convertedString[19] = '1')},
			{'Permit_InsuranceDL', (BOOLEAN)(convertedString[20] = '1')},
			{'Permit_SBFE', (BOOLEAN)(convertedString[21] = '1')},
			{'Permit_DNBDMI', (BOOLEAN)(convertedString[22] = '1')},
			{'Permit_Targus', (BOOLEAN)(convertedString[23] = '1')},
			{'Permit_Certegy', (BOOLEAN)(convertedString[24] = '1')},
			{'Permit_PreGLB', (BOOLEAN)(convertedString[25] = '1')},
			{'Permit_LiensJudgments', (BOOLEAN)(convertedString[26] = '1')},
			{'Permit_ExperianPhones', (BOOLEAN)(convertedString[27] = '1')},
			{'Permit_Inquiries', (BOOLEAN)(convertedString[28] = '1')},
			{'Permit_DPPAGroup1', (BOOLEAN)(convertedString[29] = '1')},
			{'Permit_DPPAGroup2', (BOOLEAN)(convertedString[30] = '1')},
			{'Permit_DPPAGroup3', (BOOLEAN)(convertedString[31] = '1')},
			{'Permit_DPPAGroup4', (BOOLEAN)(convertedString[32] = '1')},
			{'Permit_DPPAGroup5', (BOOLEAN)(convertedString[33] = '1')},
			{'Permit_DPPAGroup6', (BOOLEAN)(convertedString[34] = '1')},
			{'Permit_DPPAGroup7', (BOOLEAN)(convertedString[35] = '1')},
			{'Permit_DPPAGroup8', (BOOLEAN)(convertedString[36] = '1')},
			{'Permit_DPPAGroup9', (BOOLEAN)(convertedString[37] = '1')},
			{'Permit_DPPAGroup10', (BOOLEAN)(convertedString[38] = '1')},
			{'Permit_DPPAGroup11', (BOOLEAN)(convertedString[39] = '1')},
			{'Permit_DPPAGroup12', (BOOLEAN)(convertedString[40] = '1')},
			{'Permit_DPPAGroup13', (BOOLEAN)(convertedString[41] = '1')},
			{'Permit_DPPAGroup14', (BOOLEAN)(convertedString[42] = '1')},
			{'Permit_DPPAGroup15', (BOOLEAN)(convertedString[43] = '1')},
			{'Permit_DPPAGroup16', (BOOLEAN)(convertedString[44] = '1')},
			{'Permit_DPPAGroup17', (BOOLEAN)(convertedString[45] = '1')},
			{'Permit_DPPAGroup18', (BOOLEAN)(convertedString[46] = '1')},
			{'Permit_DPPAGroup19', (BOOLEAN)(convertedString[47] = '1')},
			{'Permit_DPPAGroup20', (BOOLEAN)(convertedString[48] = '1')},
			{'Permit_DPPAGroup21', (BOOLEAN)(convertedString[49] = '1')},
			{'Permit_DPPAGroup22', (BOOLEAN)(convertedString[50] = '1')},
			{'Permit_DPPAGroup23', (BOOLEAN)(convertedString[51] = '1')},
			{'Permit_DPPAGroup24', (BOOLEAN)(convertedString[52] = '1')},
			{'Permit_DPPAGroup25', (BOOLEAN)(convertedString[53] = '1')},
			{'Permit_DPPAGroup26', (BOOLEAN)(convertedString[54] = '1')},
			{'Permit_DPPAGroup27', (BOOLEAN)(convertedString[55] = '1')},
			{'Permit_DirectToConsumer', (BOOLEAN)(convertedString[56] = '1')},
			{'Permit_Utility', (BOOLEAN)(convertedString[57] = '1')},
			{'Permit_Fidelity', (BOOLEAN)(convertedString[58] = '1')},
			{'Permit_NonEquifax', (BOOLEAN)(convertedString[59] = '1')},
			{'Permit_WatchdogExperianRestricted', (BOOLEAN)(convertedString[60] = '1')},
			{'Permit_WatchdogNonRestricted', (BOOLEAN)(convertedString[61] = '1')},
			{'Permit_WatchdogPreGLBA', (BOOLEAN)(convertedString[62] = '1')},
			{'Permit_Unassigned2', (BOOLEAN)(convertedString[63] = '1')},
			{'Permit_Unassigned1', (BOOLEAN)(convertedString[64] = '1')}
			], {STRING40 Permits_Name, BOOLEAN Permits_Set}) (Permits_Name[1..17] != 'Permit_Unassigned');
	
		RETURN result;
	END;
END;