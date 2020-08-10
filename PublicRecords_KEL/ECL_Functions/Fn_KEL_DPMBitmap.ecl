IMPORT $.^.^.BIPV2, $.^.^.MDR, $.^.^.PublicRecords_KEL, $.^.^.Risk_Indicators, $.^.^.RiskVIew, $.^.^.dx_BestRecords, $.^.^.UT, STD;
IMPORT KEL13 AS KEL;

EXPORT Fn_KEL_DPMBitmap := MODULE

	EXPORT BitOr(DATA100 a, DATA100 b) := KEL.Permits.BitOr(a, b);
	EXPORT BitAnd(DATA100 a, DATA100 b) := KEL.Permits.BitAnd(a, b);
	/* Sets the DPMBitmapValue for a record of data */
	// Marketing: Sources that are NOT marketing allowed have their marketing permission bit set to 1, so that in marketing mode, they are NOT allowed.
	// Sources that ARE marketing allowed have marketing permission bit set to 0, since they do not need to be turned off when marketing mode is set.
	// The watchdog person data permissions have a marketing bit that is ignored. After talking to the engineer in Boca who worked on those bits, we may change the code here.
	EXPORT SetValue(STRING Source = '', BOOLEAN FCRA_Restricted = FALSE, BOOLEAN GLBA_Restricted = FALSE, BOOLEAN Pre_GLB_Restricted = FALSE, BOOLEAN DPPA_Restricted = FALSE, STRING DPPA_State = '', BOOLEAN Generic_Restriction = FALSE, BOOLEAN Is_Business_Header = FALSE, STRING Marketing_State = '', BOOLEAN Not_Restricted = FALSE, BOOLEAN Insurance_Product_Restricted = FALSE, UNSIGNED watchdogPermissionsColumn = 0, PublicRecords_KEL.CFG_Compile KELPermissions = PublicRecords_KEL.CFG_Compile, DATA100 BIPBitMask = PublicRecords_KEL.CFG_Compile.Permit__NONE, BOOLEAN Is_Consumer_Header = FALSE) := FUNCTION
		Permissions := 
			BitOr(IF(FCRA_Restricted, IF(NOT Not_Restricted, KELPermissions.Permit_FCRA, KELPermissions.Permit__NONE), IF(NOT Not_Restricted, KELPermissions.Permit_NonFCRA, KELPermissions.Permit__NONE)) , // IF FCRA_Restricted is TRUE this record/file is FCRA Restricted, if FALSE it is assumed to be a NonFCRA record/file.  Not_Restricted is utilized for files that allowed for usage in both FCRA and NonFCRA
			BitOr(IF(GLBA_Restricted, KELPermissions.Permit_GLBA, KELPermissions.Permit__NONE) , // This record/file is GLBA Restricted, you must have proper GLBA Permissions to use the data
			BitOr(IF(DPPA_Restricted, KELPermissions.Permit_DPPA, KELPermissions.Permit__NONE) , // This record/file is DPPA Restricted, you must have proper DPPA Permissions to use the data
			
			BitOr(IF(Source IN PublicRecords_KEL.ECL_Functions.Constants.ALLOWED_MARKETING_SOURCES OR PublicRecords_KEL.ECL_Functions.Common_Functions.IsMarketingAllowedKey(Source, Marketing_State) OR (Source = MDR.sourceTools.src_Best_Business AND BIPBitMask <> KELPermissions.Permit__NONE), KELPermissions.Permit__NONE, KELPermissions.Permit_Marketing) , // This record/file is Marketing Approved, when running a Marketing Product you can use the data. Skip this check for BIP Best data (BIPBitMask > 0) since source codes are not populated, and marketing restriction has already been applied in BIPBitMask.			// BIP Best checks against MDR.sourceTools.set_Marketing_Restricted for marketing restrictions instead of PublicRecords_KEL.ECL_Functions.Constants.ALLOWED_MARKETING_SOURCES. Using this code so we can match what the interface does.
			BitOr(IF(Source IN MDR.sourceTools.set_Marketing_Restricted AND BIPBitMask <> KELPermissions.Permit__NONE, KELPermissions.Permit_Marketing, KELPermissions.Permit__NONE) , 
			
			BitOr(IF(Insurance_Product_Restricted, KELPermissions.Permit_InsuranceProduct, KELPermissions.Permit__NONE) , // This record/file is only permitted for use within an Insurance Product.  Business Services is NOT allowed to utilize these records
			
			/* ******** Data Restriction Mask controlled sources ******** */
			BitOr(IF(Source IN [MDR.sourceTools.src_Fares_Deeds_from_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Deeds], KELPermissions.Permit_Fares, KELPermissions.Permit__NONE) , // Fares is a DRM restricted source
			BitOr(IF(Source = MDR.sourceTools.src_Experian_Credit_Header, IF(FCRA_Restricted, KELPermissions.Permit_ExperianFCRA, KELPermissions.Permit_Experian), KELPermissions.Permit__NONE) , // Experian is a DRM restricted source - depending on if it is an FCRA or NonFCRA source it has different DRM bits
			BitOr(IF(Source = MDR.sourceTools.src_Certegy, KELPermissions.Permit_Certegy, KELPermissions.Permit__NONE) , // Certegy is a DRM restricted source
			BitOr(IF(Source = MDR.sourceTools.src_Equifax, KELPermissions.Permit_Equifax, KELPermissions.Permit__NONE) , // Equifax is a DRM restricted source
			BitOr(IF(Source = MDR.sourceTools.src_TU_CreditHeader, KELPermissions.Permit_TransUnion, KELPermissions.Permit__NONE) , // TransUnion Credit is a DRM restricted source
			BitOr(IF(Source = MDR.sourceTools.src_Experian_Credit_Header + ',' + MDR.sourceTools.src_TU_CreditHeader + ',' + MDR.sourceTools.src_Equifax, 
				BitOr(IF(FCRA_Restricted, 
					KELPermissions.Permit_ExperianFCRA, 
					KELPermissions.Permit_Experian) , BitOr(KELPermissions.Permit_TransUnion , KELPermissions.Permit_Equifax)), 
					KELPermissions.Permit__NONE) , // This is a special permission used for selecting the Combo child dataset in certain pre-built Roxie Indexes which have Combo/EN/TN/EQ child datasets, it requires all 3 permissions
			BitOr(IF(Source = MDR.sourceTools.src_advo_valassis, KELPermissions.Permit_ADVO, KELPermissions.Permit__NONE) , // ADVO is a DRM restricted source
			BitOr(IF(Source = MDR.sourceTools.src_EBR, KELPermissions.Permit_ExperianEBR, KELPermissions.Permit__NONE) , // Experian EBR is a restricted sources
			BitOr(IF(Source = MDR.SourceTools.src_Experian_CRDB, KELPermissions.Permit_ExperianCRDB, KELPermissions.Permit__NONE) , // Experian CRDB is a restricted sources
			BitOr(IF(Source = MDR.sourceTools.src_Experian_Phones, KELPermissions.Permit_ExperianPhones, KELPermissions.Permit__NONE) , // This only applies to a single file: Experian_Phones.Key_Did_Digits and it applies to every record in that file
			BitOr(IF(Source = MDR.sourceTools.src_InquiryAcclogs, KELPermissions.Permit_Inquiries, KELPermissions.Permit__NONE) , // Inquiries are a DRM restricted source
			BitOr(IF(Pre_GLB_Restricted, KELPermissions.Permit_PreGLB, KELPermissions.Permit__NONE) , //  Records from GLB sources that are older than GLBA laws are DRM restricted 
			BitOr(IF(Source IN (MDR.sourceTools.set_Liens + [MDR.sourceTools.src_Liens_and_Judgments]), KELPermissions.Permit_LiensJudgments, KELPermissions.Permit__NONE) , // Liens and Judgements are restricted sources
			BitOr(IF(Source IN [MDR.sourceTools.Src_Cortera, MDR.sourceTools.Src_Cortera_Tradeline], KELPermissions.Permit_Cortera, KELPermissions.Permit__NONE) , // Cortera is a DRM restricted source
						
			/* ******** Data Permission Mask controlled sources ******** */
			BitOr(IF(Source = MDR.sourceTools.src_Targus_Gateway, KELPermissions.Permit_Targus, KELPermissions.Permit__NONE) , // The Targus Gateway is a DPM restricted source
			BitOr(IF(Source = MDR.sourceTools.src_Death_Restricted, KELPermissions.Permit_SSNDeathMaster, KELPermissions.Permit__NONE) , // SSN Death Master data is a DPM restricted source
			BitOr(IF(Source = MDR.sourceTools.src_InquiryAcclogs AND Generic_Restriction, KELPermissions.Permit_FDN, KELPermissions.Permit__NONE) , // For Inquiries, there are certain records which are only allowed if the DPM restriction for FDN allows usage.  Here Generic_Restriction is checking to see if the "method" column in our Inquiries data is IN ['BATCH','MONITORING']
			BitOr(IF(Source = PublicRecords_KEL.ECL_Functions.Constants.FraudPoint3Source, KELPermissions.Permit_FDN, KELPermissions.Permit__NONE) , 			//FDN data is DPM restricted		
			// KELPermissions.Permit_InsuranceDL -- We don't currently have Insurance DL Data coded, unable to implement this permission until we know how to bring in other gateway type data.  Data comes from InsuranceHeader_BestOfBest.search_Insurance_DL_by_Did(...)
			BitOr(IF(Source = MDR.sourceTools.src_Business_Credit, KELPermissions.Permit_SBFE, KELPermissions.Permit__NONE) , // SBFE Data is a restricted source

			/* ******** GLBA restrictions ******** */
			// Data from GLB sources that is not older than the GLBA laws requires a valid GLBA Purpose to access.
			BitOr(IF(MDR.SourceTools.SourceIsGLB(Source) AND NOT Pre_GLB_Restricted, KELPermissions.Permit_GLBA, KELPermissions.Permit__NONE) ,
			
			/* ******** DPPA restrictions ******** */
			// There are two types of DPPA restrictions.
			// Certain sources/files require any valid DPPA (1-7) to return data.
			// Other sources are further restricted based of the state the data is from and can only be returned with a specific subset of valid DPPA values.
			// Each of these subsets that we utilize is controlled by a different DPPAGroup in the KEL DPM.
			BitOr(IF(MDR.SourceTools.SourceIsDPPA(Source) OR DPPA_Restricted, 
				BitOr(KELPermissions.Permit_DPPA , 
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[1].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup1, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[2].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup2, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[3].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup3, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[4].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup4, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[5].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup5, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[6].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup6, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[7].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup7, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[8].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup8, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[9].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup9, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[10].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup10, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[11].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup11, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[12].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup12, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[13].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup13, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[14].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup14, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[15].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup15, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[16].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup16, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[17].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup17, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[18].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup18, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[19].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup19, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[20].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup20, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[21].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup21, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[22].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup22, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[23].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup23, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[24].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup24, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[25].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup25, KELPermissions.Permit__NONE) ,
				BitOr(IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[26].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup26, KELPermissions.Permit__NONE) ,
							IF(EXISTS(PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[27].States(State = DPPA_State AND IsExperian = MDR.sourceTools.SourceIsExperianVehicle(Source))), KELPermissions.Permit_DPPAGroup27, KELPermissions.Permit__NONE)
				))))))))))))))))))))))))))),
				KELPermissions.Permit__NONE),
			/* ******** Best Business Restrictions using BIP Bitmask ******** */
			BitOr(BIPBitMask , // BIPBitMask is precalculated in Fn_KEL_FPMBitmap.ConvertAndNoralizeBIPPermits. Any Permits bits that are turned on in the BIPBitMask we also turn on in our KEL Permits value. ConvertAndNoralizeBIPPermits has already translated BIP Permits values to KEL permits values.
			
			/* ******** Generic Restrictions ******** */
			BitOr(IF(Source = MDR.sourceTools.src_Dunn_Bradstreet, KELPermissions.Permit_DNBDMI, KELPermissions.Permit__NONE) , // DNB DMI is not allowed unless the Allowed Sources option is set specifically to turn it on.
			BitOr(IF(Source = MDR.sourceTools.src_Utilities, KELPermissions.Permit_Utility, KELPermissions.Permit__NONE) , // Utility data is typically controlled by the IndustryClass value sent into the query at runtime, this data could be toggled by that IndustryClass value
			BitOr(IF(Source = MDR.sourceTools.src_Professional_License AND Generic_Restriction, KELPermissions.Permit_DirectToConsumer, KELPermissions.Permit__NONE) , // FCRA Professional License records where vendor = 'ASC APPRAISAL SUBCOMMITTEE' are not allowed if the Permissible Purpose is Direct To Consumer
			
			BitOr(IF(Source IN [MDR.sourceTools.src_Mixed_DPPA, MDR.sourceTools.src_Mixed_Non_DPPA], KELPermissions.Permit_Restricted, KELPermissions.Permit__NONE) , // These sources are permanently restricted, there is no way to enable permissions for them in the Generate(...) function below, we just don't ever want to use this data
			BitOr(IF(Source = MDR.sourceTools.src_Mari_Prof_Lic AND Generic_Restriction, KELPermissions.Permit_Restricted, KELPermissions.Permit__NONE) , // MARI records where std_source_upd IN ['S0822','S0843','S0900','S0868'] are never allowed since we can't use New Mexico and Pennsylvania real estate
			BitOr(IF(Source = MDR.sourceTools.src_UCCV2 AND ~Generic_Restriction, KELPermissions.Permit_Marketing, KELPermissions.Permit__NONE) , //UCC Marking restricted IF UCC and in List then allowed
			BitOr(IF(Source = MDR.sourceTools.src_Marketing_Relatives_Data, KELPermissions.Permit_MarketingRelatives, KELPermissions.Permit__NONE) , //Relatives marketing 
			BitOr(IF(Source = MDR.sourceTools.src_Relatives_Data, KELPermissions.Permit_NonMarketingRelatives, KELPermissions.Permit__NONE) , //Relatives non marketing
			
			BitOr(IF(Source = PublicRecords_KEL.ECL_Functions.Constants.Watchdog_NonEN_FCRA, KELPermissions.Permit_Equifax, KELPermissions.Permit__NONE) ,
			BitOr(IF(Source = PublicRecords_KEL.ECL_Functions.Constants.Watchdog_NonEQ_FCRA, KELPermissions.Permit_NonEquifax, KELPermissions.Permit__NONE) ,
			BitOr(MAP(watchdogPermissionsColumn & dx_BestRecords.Functions.get_perm_type(glb_flag:=false, pre_glb_flag:=false, filter_exp_flag:=false) > 0 => KELPermissions.Permit_WatchdogNonRestricted, // This watchdog best record isn't restricted for usage
			    watchdogPermissionsColumn & dx_BestRecords.Functions.get_perm_type(glb_flag:=true, pre_glb_flag:=false, filter_exp_flag:=false) > 0 => KELPermissions.Permit_GLBA, // This watchdog best record only requires GLBA Permissions to use
			    watchdogPermissionsColumn & dx_BestRecords.Functions.get_perm_type(glb_flag:=true, pre_glb_flag:=false, filter_exp_flag:=true) > 0 => BitOr(KELPermissions.Permit_GLBA , KELPermissions.Permit_WatchdogExperianRestricted), // This watchdog best record requires GLBA Permission and Experian must be restricted
			    watchdogPermissionsColumn & dx_BestRecords.Functions.get_perm_type(glb_flag:=false, pre_glb_flag:=true, filter_exp_flag:=false) > 0 => KELPermissions.Permit_WatchdogPreGLBA, // This watchdog best record requires that we NOT be filtering PreGLB data
			    watchdogPermissionsColumn > 0 => KELPermissions.Permit_Restricted, // Any other watchdog best records that didn't fit into the above conditions should be blocked from usage
			                     KELPermissions.Permit__NONE) , // Default to allowing the record - should only trigger when watchdogPermissionsColumn == 0, which would be true for any files that aren't the Watchdog Key

			BitOr(IF(PublicRecords_KEL.ECL_Functions.Common_Functions.SourceGroup(Source) NOT IN PublicRecords_KEL.ECL_Functions.Constants.Allowed_Business_Header_SRC AND Is_Business_Header, KELPermissions.Permit_Restricted, KELPermissions.Permit__NONE) ,		//analytics only wants specific sources returned from BH
			BitOr(IF(FCRA_Restricted AND Source NOT IN SET(PublicRecords_KEL.ECL_Functions.Constants.Allowed_Consumer_Header_SRC(IsFCRA), Src) AND Is_Consumer_Header, KELPermissions.Permit_Restricted, KELPermissions.Permit__NONE) , 	//analytics only wants specific sources returned from consumer header
			BitOr(IF(NOT FCRA_Restricted AND Source NOT IN SET(PublicRecords_KEL.ECL_Functions.Constants.Allowed_Consumer_Header_SRC, Src) AND Is_Consumer_Header, KELPermissions.Permit_Restricted, KELPermissions.Permit__NONE) ,		//analytics only wants specific sources returned from consumer header

			KELPermissions.Permit_NoRestriction // Every Record will be tagged as having NoRestriction - any records which have additional restrictions are handled above
			))))))))))))))))))))))))))))))))))))))))));
			/* TODO: KS-1968 - Define the set of ALLOWED_SOURCES.  At the time that ticket is worked on, replace the previous line of code with the following commented-out lines:
			IF(Source IN PublicRecords_KEL.ECL_Functions.Constants.ALLOWED_SOURCES, KELPermissions.Permit_NoRestriction, KELPermissions.Permit_Restricted); // Every Record which is in the set of Allowed Sources will be tagged as having NoRestriction - any records which have additional restrictions are handled above */

		RETURN Permissions;
	END;
	
	/* Generates the KEL PERMITS Bitmask to pass to a KEL QUERY */
	EXPORT Generate(STRING DataRestrictionMask, STRING DataPermissionMask, UNSIGNED1 GLBA, UNSIGNED1 DPPA, BOOLEAN isFCRA, BOOLEAN isMarketing = FALSE, BOOLEAN AllowDNBDMI = FALSE, BOOLEAN OverrideExperianRestriction = FALSE, STRING PermissiblePurpose, STRING IndustryClass = '', PublicRecords_KEL.CFG_Compile KELPermissions = PublicRecords_KEL.CFG_Compile, BOOLEAN IsInsuranceProduct = FALSE) := FUNCTION
		Permissions := 
			BitOr(IF(isFCRA, KELPermissions.Permit_FCRA, KELPermissions.Permit_NonFCRA) , // If isFCRA is TRUE allow FCRA Restricted data, else allow NonFCRA Restricted data in KEL
			BitOr(IF(Risk_Indicators.iid_constants.glb_ok(GLBA, isFCRA), KELPermissions.Permit_GLBA, KELPermissions.Permit__NONE) , // Check to see if we have appropriate GLBA permissions before allowing use of GLBA Restricted data in KEL
			BitOr(IF(Risk_Indicators.iid_constants.dppa_ok(DPPA, isFCRA), KELPermissions.Permit_DPPA, KELPermissions.Permit__NONE) , // Check to see if we have appropriate DPPA permissions before allowing use of DPPA Restricted data in KEL
			BitOr(IF(isMarketing, KELPermissions.Permit__NONE, KELPermissions.Permit_Marketing) , // Running a Marketing product, only allow Marketing approved sources in KEL
			BitOr(IF(isMarketing,  KELPermissions.Permit_MarketingRelatives, KELPermissions.Permit_NonMarketingRelatives) , // if marketing use marketing relatives, else use 'normal' relatves
			BitOr(IF(AllowDNBDMI, KELPermissions.Permit_DNBDMI, KELPermissions.Permit__NONE) , // If AllowDNBDMI is TRUE allow use of DNBDMI data in KEL
			BitOr(IF(IsInsuranceProduct, KELPermissions.Permit_InsuranceProduct, KELPermissions.Permit__NONE) , // If IsInsuranceProduct is TRUE allow use of Insurance only data in KEL
			BitOr(IF(PermissiblePurpose = RiskView.Constants.directToConsumer, KELPermissions.Permit__NONE , KELPermissions.Permit_DirectToConsumer) , // If running with a Direct To Consumer Permissible Purpose, certain Direct to Consumer sources are not allowed
			BitOr(IF(~(IndustryClass = 'UTILI' OR IndustryClass = 'DRMKT'), KELPermissions.Permit_Utility, KELPermissions.Permit__NONE) , // If Utility data is NOT restricted based on the IndustryClass value, allow its usage in KEL
			// DataRestrictionMask DRM Sources
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posFaresRestriction] != '1', KELPermissions.Permit_Fares, KELPermissions.Permit__NONE) , // If Fares Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posExperianEBR] != '1' AND OverrideExperianRestriction, KELPermissions.Permit_ExperianEBR, KELPermissions.Permit__NONE) , // If Experian EBR Source is NOT restricted in the DataRestrictionMask and OverrideExperianRestriction is set, allow its usage in KEL
			BitOr(IF(OverrideExperianRestriction, KELPermissions.Permit_ExperianCRDB, KELPermissions.Permit__NONE) , // OverrideExperianRestriction is set, allow CRDB usage in KEL
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posFidelityRestriction] != '1', KELPermissions.Permit_Fidelity, KELPermissions.Permit__NONE) , // If Fidelity is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posExperianRestriction] != '1', KELPermissions.Permit_Experian, KELPermissions.Permit__NONE) , // If Experian Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posCertegyRestriction] != '1', KELPermissions.Permit_Certegy, KELPermissions.Permit__NONE) , // If Certegy Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posEquifaxRestriction] != '1', KELPermissions.Permit_Equifax, KELPermissions.Permit_NonEquifax) , // If Equifax Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posTransUnionRestriction] != '1', KELPermissions.Permit_TransUnion, KELPermissions.Permit__NONE) , // If TransUnion Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posADVORestriction] != '1', KELPermissions.Permit_Advo, KELPermissions.Permit__NONE) , // If ADVO Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posExperianFCRARestriction] != '1', KELPermissions.Permit_ExperianFCRA, KELPermissions.Permit__NONE) , // If ExperianFCRA Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posExperianPhonesRestriction] != '1', KELPermissions.Permit_ExperianPhones, KELPermissions.Permit__NONE) , // If  Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posInquiriesRestriction] != '1', KELPermissions.Permit_Inquiries, KELPermissions.Permit__NONE) , // If  Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posRestrictPreGLB] != '1' OR Risk_Indicators.iid_constants.glb_ok(GLBA, isFCRA), KELPermissions.Permit_PreGLB, KELPermissions.Permit__NONE) , // If PreGLB Source is NOT restricted in the DataRestrictionMask or GLB data is permitted, allow its usage in KEL
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posLiensJudgRestriction] != '1', KELPermissions.Permit_LiensJudgments, KELPermissions.Permit__NONE) , // If Liens and Judgments Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			BitOr(IF(DataRestrictionMask[Risk_Indicators.iid_constants.posCortera] != '1', KELPermissions.Permit_Cortera, KELPermissions.Permit__NONE) , // If Cortera Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			// DataPermissionMask DPM Sources
			BitOr(IF(DataPermissionMask[Risk_Indicators.iid_constants.posTargusPermission] = '1', KELPermissions.Permit_Targus, KELPermissions.Permit__NONE) , // If Targus is permitted in the DataPermissionMask, allow its usage in KEL
			BitOr(IF(DataPermissionMask[Risk_Indicators.iid_constants.posSSADeathMasterPermission] = '1', KELPermissions.Permit_SSNDeathMaster, KELPermissions.Permit__NONE) , // If SSN Death Master Source is permitted in the DataPermissionMask, allow its usage in KEL
			BitOr(IF(DataPermissionMask[Risk_Indicators.iid_constants.posFDNcftfPermission] = '1', KELPermissions.Permit_FDN, KELPermissions.Permit__NONE) , // If Fraud Defense Network Source is permitted in the DataPermissionMask, allow its usage in KEL
			BitOr(IF(DataPermissionMask[Risk_Indicators.iid_constants.InsuranceDLPermission] = '1', KELPermissions.Permit_InsuranceDL, KELPermissions.Permit__NONE) , // If Insurance Drivers License Source is permitted in the DataPermissionMask, allow its usage in KEL
			BitOr(IF(DataPermissionMask[Risk_Indicators.iid_constants.posSBFEPermission] = '1', KELPermissions.Permit_SBFE, KELPermissions.Permit__NONE) , // If SBFE data is permitted in the DataPermissionMask, allow its usage in KEL
			// DPPA Restrictions:
				// DPPA records are restricted for NonFCRA if DPPA is not between 1 and 7.
				// Additional source/state DPPA restrictions also apply that are based on specific DPPA value.
			BitOr(IF(Risk_Indicators.iid_constants.dppa_ok(DPPA, isFCRA), KELPermissions.Permit_DPPA, KELPermissions.Permit__NONE) ,
			BitOr(CASE(DPPA,
				1 => PublicRecords_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA1, isFCRA, KELPermissions),
				2 => PublicRecords_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA2, isFCRA, KELPermissions),
				3 => PublicRecords_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA3, isFCRA, KELPermissions),
				4 => PublicRecords_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA4, isFCRA, KELPermissions),
				5 => PublicRecords_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA5, isFCRA, KELPermissions),
				6 => PublicRecords_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA6, isFCRA, KELPermissions),
				7 => PublicRecords_KEL.ECL_Functions.DPPA_Permits.CheckDPPAPermits(RestrictDPPA7, isFCRA, KELPermissions),
						KELPermissions.Permit__NONE) ,
			BitOr(MAP(DataRestrictionMask[Risk_Indicators.iid_constants.posExperianRestriction] = '1' => KELPermissions.Permit_WatchdogExperianRestricted, // Allow Watchdog Best experian restricted records (Note: this is the inverse of the check for Permit_Experian)
			    DataRestrictionMask[Risk_Indicators.iid_constants.posRestrictPreGLB] != '1' OR Risk_Indicators.iid_constants.glb_ok(GLBA, isFCRA) => KELPermissions.Permit_WatchdogPreGLBA, // Allow Watchdog Best PreGLBA restricted records if the Data Restriction Mask isn't restricting, or if GLBA data is allowed
			    Risk_Indicators.iid_constants.glb_ok(GLBA, isFCRA) => KELPermissions.Permit_GLBA, // Allow Watchdog Best GLBA restricted records
			    KELPermissions.Permit_WatchdogNonRestricted) , // Default to the version of Watchdog Best which isn't restricted

			// Every Transaction should have the NoRestriction permission - this will allow viewing of data that has no restrictions at all
			KELPermissions.Permit_NoRestriction
			))))))))))))))))))))))))))))))));

		RETURN(Permissions);
	END;

	/* This FUNCTIONMACRO is used for converting the linking team's data permisions bitmask into data permissions that are usable by our KEL system. 
		 First, we translate the BIP Best data permits value into a dataset of KEL Data Permits values in ConvertPermitsToDS PROJECT.
		 Then, we normalize that dataset into one record per permission, since the BIP Permits bits are ORed together, but the KEL Data Permits bits are ANDed together
		 For example, if we have a best company name that comes from EBR and DNBDMI, we only need permissions to view EBR OR DNBDMI to view the record in the Best key.
		 Instead of turning on both Permit_ExperianEBR and Permit_DNBDMI, we split this into two records, one with Permit_ExperianEBR set, and the other with Permit_DNBDMI set
			so we will still return the best company name if either EBR OR DNBDMI is allowed. */
	EXPORT ConvertAndNormalizeBIPPermits(InFile, InPermitsFieldName, KELPermissions = PublicRecords_KEL.CFG_Compile) := FUNCTIONMACRO
			IMPORT KEL13 AS KEL;
			BitOr(DATA a, DATA b) := KEL.Permits.BitOr(a, b);
			BitAnd(DATA a, DATA b) := KEL.Permits.BitAnd(a, b);
	
			DPMLayout := RECORD
				DATA100 DPMFromBIPBitMask;
			END;
			
			DPMDatasetLayout := RECORD
				DATASET(DPMLayout) PermitsDataset;
			END;
			
			ConvertPermitsToDS := PROJECT(InFile, TRANSFORM({RECORDOF(LEFT), DPMDatasetLayout},
				MarketingPermission := IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.MARKETING_UNRESTRICTED) > 0, KELPermissions.Permit_NonFCRA, KELPermissions.Permit_Marketing); // Need to check marketing separately from other permissions

				SELF.PermitsDataset := IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.UNRESTRICTED) > 0, DATASET([{MarketingPermission}], DPMLayout), // If it's Unrestricted, bypass all other permission checks since we know we won't need to suppress the record.
															 IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.DNB) > 0, DATASET([{BitOr(KELPermissions.Permit_DNBDMI , MarketingPermission)}], DPMLayout), DATASET([], DPMLayout)) +
															 IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.EBR) > 0, DATASET([{BitOr(KELPermissions.Permit_ExperianEBR , MarketingPermission)}], DPMLayout), DATASET([], DPMLayout)) +
															 IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.PROP_FARES) > 0, DATASET([{BitOr(KELPermissions.Permit_Fares , MarketingPermission)}], DPMLayout), DATASET([], DPMLayout)) +
															 IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.DPPA) > 0, DATASET([{BitOr(KELPermissions.Permit_DPPA , MarketingPermission)}], DPMLayout), DATASET([], DPMLayout)) +
															 IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.PROP_FIDELITY) > 0, DATASET([{BitOr(KELPermissions.Permit_Fidelity , MarketingPermission)}], DPMLayout), DATASET([], DPMLayout)) +
															 IF(LEFT.#EXPAND(InPermitsFieldName) & BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.PROP_DAYTON) > 0, DATASET([{BitOr(KELPermissions.Permit_Fidelity , MarketingPermission)}], DPMLayout), DATASET([], DPMLayout)));
				SELF := LEFT));

			NormalizePermits := NORMALIZE(ConvertPermitsToDS, LEFT.PermitsDataset,
				TRANSFORM({RECORDOF(LEFT) - PermitsDataset, DATA100 DPMFromBIPBitMask},
					SELF := RIGHT,
					SELF := LEFT));
				
			RETURN NormalizePermits;	
		ENDMACRO;
	
	/* For debugging purposes converts a KEL PERMITS Bitmask into a dataset of TRUE/FALSE flags for if a PERMITS option is set/enabled */
	EXPORT ConvertToDataset(DATA100 KELDPM, PublicRecords_KEL.CFG_Compile KELPermissions = PublicRecords_KEL.CFG_Compile) := FUNCTION
	
		result := DATASET([
			{'Permit_Restricted', BitAnd(KELDPM, KELPermissions.Permit_Restricted) <> KELPermissions.Permit__NONE},
			{'Permit_NoRestriction', BitAnd(KELDPM, KELPermissions.Permit_NoRestriction) <> KELPermissions.Permit__NONE},
			{'Permit_FCRA', BitAnd(KELDPM, KELPermissions.Permit_FCRA) <> KELPermissions.Permit__NONE},
			{'Permit_NonFCRA', BitAnd(KELDPM, KELPermissions.Permit_NonFCRA) <> KELPermissions.Permit__NONE},
			{'Permit_GLBA', BitAnd(KELDPM, KELPermissions.Permit_GLBA) <> KELPermissions.Permit__NONE},
			{'Permit_DPPA', BitAnd(KELDPM, KELPermissions.Permit_DPPA) <> KELPermissions.Permit__NONE},
			{'Permit_Marketing', BitAnd(KELDPM, KELPermissions.Permit_Marketing) <> KELPermissions.Permit__NONE},
			{'Permit_InsuranceProduct', BitAnd(KELDPM, KELPermissions.Permit_InsuranceProduct) <> KELPermissions.Permit__NONE},
			{'Permit_Fares', BitAnd(KELDPM, KELPermissions.Permit_Fares) <> KELPermissions.Permit__NONE},
			{'Permit_Experian', BitAnd(KELDPM, KELPermissions.Permit_Experian) <> KELPermissions.Permit__NONE},
			{'Permit_ExperianFCRA', BitAnd(KELDPM, KELPermissions.Permit_ExperianFCRA) <> KELPermissions.Permit__NONE},
			{'Permit_TransUnion', BitAnd(KELDPM, KELPermissions.Permit_TransUnion) <> KELPermissions.Permit__NONE},
			{'Permit_Equifax', BitAnd(KELDPM, KELPermissions.Permit_Equifax) <> KELPermissions.Permit__NONE},
			{'Permit_Advo', BitAnd(KELDPM, KELPermissions.Permit_Advo) <> KELPermissions.Permit__NONE},
			{'Permit_Cortera', BitAnd(KELDPM, KELPermissions.Permit_Cortera) <> KELPermissions.Permit__NONE},
			{'Permit_ExperianEBR', BitAnd(KELDPM, KELPermissions.Permit_ExperianEBR) <> KELPermissions.Permit__NONE},
			{'Permit_ExperianCRDB', BitAnd(KELDPM, KELPermissions.Permit_ExperianCRDB) <> KELPermissions.Permit__NONE},
			{'Permit_SSNDeathMaster', BitAnd(KELDPM, KELPermissions.Permit_SSNDeathMaster) <> KELPermissions.Permit__NONE},
			{'Permit_FDN', BitAnd(KELDPM, KELPermissions.Permit_FDN) <> KELPermissions.Permit__NONE},
			{'Permit_InsuranceDL', BitAnd(KELDPM, KELPermissions.Permit_InsuranceDL) <> KELPermissions.Permit__NONE},
			{'Permit_SBFE', BitAnd(KELDPM, KELPermissions.Permit_SBFE) <> KELPermissions.Permit__NONE},
			{'Permit_DNBDMI', BitAnd(KELDPM, KELPermissions.Permit_DNBDMI) <> KELPermissions.Permit__NONE},
			{'Permit_Targus', BitAnd(KELDPM, KELPermissions.Permit_Targus) <> KELPermissions.Permit__NONE},
			{'Permit_Certegy', BitAnd(KELDPM, KELPermissions.Permit_Certegy) <> KELPermissions.Permit__NONE},
			{'Permit_PreGLB', BitAnd(KELDPM, KELPermissions.Permit_PreGLB) <> KELPermissions.Permit__NONE},
			{'Permit_LiensJudgments', BitAnd(KELDPM, KELPermissions.Permit_LiensJudgments) <> KELPermissions.Permit__NONE},
			{'Permit_ExperianPhones', BitAnd(KELDPM, KELPermissions.Permit_ExperianPhones) <> KELPermissions.Permit__NONE},
			{'Permit_Inquiries', BitAnd(KELDPM, KELPermissions.Permit_Inquiries) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup1', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup1) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup2', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup2) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup3', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup3) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup4', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup4) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup5', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup5) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup6', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup6) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup7', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup7) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup8', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup8) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup9', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup9) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup10', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup10) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup11', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup11) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup12', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup12) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup13', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup13) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup14', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup14) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup15', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup15) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup16', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup16) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup17', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup17) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup18', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup18) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup19', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup19) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup20', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup20) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup21', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup21) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup22', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup22) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup23', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup23) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup24', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup24) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup25', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup25) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup26', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup26) <> KELPermissions.Permit__NONE},
			{'Permit_DPPAGroup27', BitAnd(KELDPM, KELPermissions.Permit_DPPAGroup27) <> KELPermissions.Permit__NONE},
			{'Permit_DirectToConsumer', BitAnd(KELDPM, KELPermissions.Permit_DirectToConsumer) <> KELPermissions.Permit__NONE},
			{'Permit_Utility', BitAnd(KELDPM, KELPermissions.Permit_Utility) <> KELPermissions.Permit__NONE},
			{'Permit_Fidelity', BitAnd(KELDPM, KELPermissions.Permit_Fidelity) <> KELPermissions.Permit__NONE},
			{'Permit_NonEquifax', BitAnd(KELDPM, KELPermissions.Permit_NonEquifax) <> KELPermissions.Permit__NONE},
			{'Permit_WatchdogExperianRestricted', BitAnd(KELDPM, KELPermissions.Permit_WatchdogExperianRestricted) <> KELPermissions.Permit__NONE},
			{'Permit_WatchdogNonRestricted', BitAnd(KELDPM, KELPermissions.Permit_WatchdogNonRestricted) <> KELPermissions.Permit__NONE},
			{'Permit_WatchdogPreGLBA', BitAnd(KELDPM, KELPermissions.Permit_WatchdogPreGLBA) <> KELPermissions.Permit__NONE},
			{'Permit_MarketingRelatives', BitAnd(KELDPM, KELPermissions.Permit_MarketingRelatives) <> KELPermissions.Permit__NONE},
			{'Permit_NonMarketingRelatives', BitAnd(KELDPM, KELPermissions.Permit_NonMarketingRelatives) <> KELPermissions.Permit__NONE}
			], {STRING40 Permits_Name, BOOLEAN Permits_Set}) (Permits_Name[1..17] != 'Permit_Unassigned');
	
		RETURN result;
	END;
END;