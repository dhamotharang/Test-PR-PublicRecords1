IMPORT MDR, PublicRecords_KEL, Risk_Indicators, UT, STD;

EXPORT Fn_KEL_DPMBitmap := MODULE
	/* Sets the DPMBitmapValue for a record of data */
	EXPORT SetValue(STRING Source = '', BOOLEAN FCRA_Restricted = FALSE, BOOLEAN GLBA_Restricted = FALSE, BOOLEAN DPPA_Restricted = FALSE, BOOLEAN Generic_Restriction = FALSE, BOOLEAN Not_Restricted = FALSE, BOOLEAN Insurance_Product_Restricted = FALSE, PublicRecords_KEL.CFG_Compile KELPermissions = PublicRecords_KEL.CFG_Compile) := FUNCTION
		Permissions := 
			IF(FCRA_Restricted, IF(NOT Not_Restricted, KELPermissions.Permit_FCRA, 0), IF(NOT Not_Restricted, KELPermissions.Permit_NonFCRA, 0)) + // IF FCRA_Restricted is TRUE this record/file is FCRA Restricted, if FALSE it is assumed to be a NonFCRA record/file.  Not_Restricted is utilized for files that allowed for usage in both FCRA and NonFCRA
			IF(GLBA_Restricted, KELPermissions.Permit_GLBA, 0) + // This record/file is GLBA Restricted, you must have proper GLBA Permissions to use the data
			IF(DPPA_Restricted, KELPermissions.Permit_DPPA, 0) + // This record/file is DPPA Restricted, you must have proper DPPA Permissions to use the data
			IF(Source IN PublicRecords_KEL.ECL_Functions.Constants.ALLOWED_MARKETING_SOURCES, 0, KELPermissions.Permit_Marketing) + // This record/file is Marketing Approved, when running a Marketing Product you can use the data
			IF(Insurance_Product_Restricted, KELPermissions.Permit_InsuranceProduct, 0) + // This record/file is only permitted for use within an Insurance Product.  Business Services is NOT allowed to utilize these records
			
			/* ******** Data Restriction Mask controlled sources ******** */
			IF(Source IN [MDR.sourceTools.src_Fares_Deeds_from_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Deeds], KELPermissions.Permit_Fares, 0) + // Fares is a DRM restricted source
			IF(Source = MDR.sourceTools.src_Experian_Credit_Header, IF(FCRA_Restricted, KELPermissions.Permit_ExperianFCRA, KELPermissions.Permit_Experian), 0) + // Experian is a DRM restricted source - depending on if it is an FCRA or NonFCRA source it has different DRM bits
			IF(Source = MDR.sourceTools.src_Certegy, KELPermissions.Permit_Certegy, 0) + // Certegy is a DRM restricted source
			IF(Source = MDR.sourceTools.src_Equifax, KELPermissions.Permit_Equifax, 0) + // Equifax is a DRM restricted source
			IF(Source = MDR.sourceTools.src_TU_CreditHeader, KELPermissions.Permit_TransUnion, 0) + // TransUnion Credit is a DRM restricted source
			IF(Source = MDR.sourceTools.src_Experian_Credit_Header + ',' + MDR.sourceTools.src_TU_CreditHeader + ',' + MDR.sourceTools.src_Equifax, 
				IF(FCRA_Restricted, KELPermissions.Permit_ExperianFCRA, KELPermissions.Permit_Experian) + 
				KELPermissions.Permit_TransUnion + 
				KELPermissions.Permit_Equifax, 0) + // This is a special permission used for selecting the Combo child dataset in certain pre-built Roxie Indexes which have Combo/EN/TN/EQ child datasets, it requires all 3 permissions
			IF(Source = MDR.sourceTools.src_advo_valassis, KELPermissions.Permit_ADVO, 0) + // ADVO is a DRM restricted source
			
			IF(Source = MDR.sourceTools.src_InquiryAcclogs, KELPermissions.Permit_Inquiries, 0) + // Inquiries are a DRM restricted source
			
			
			IF(Source IN [MDR.sourceTools.Src_Cortera, MDR.sourceTools.Src_Cortera_Tradeline], KELPermissions.Permit_Cortera, 0) + // Cortera is a DRM restricted source
			
			/* ******** Data Permission Mask controlled sources ******** */
			IF(Source = MDR.sourceTools.src_Death_Restricted, KELPermissions.Permit_SSNDeathMaster, 0) + // SSN Death Master data is a DPM restricted source
			IF(Source = MDR.sourceTools.src_InquiryAcclogs AND Generic_Restriction, KELPermissions.Permit_FDN, 0) + // For Inquiries, there are certain records which are only allowed if the DPM restriction for FDN allows usage.  Here Generic_Restriction is checking to see if the "method" column in our Inquiries data is IN ['BATCH','MONITORING']
			// KELPermissions.Permit_InsuranceDL -- We don't currently have Insurance DL Data coded, unable to implement this permission until we know how to bring in other gateway type data.  Data comes from InsuranceHeader_BestOfBest.search_Insurance_DL_by_Did(...)
			
			/* ******** Generic Restrictions ******** */
			IF(Source IN [MDR.sourceTools.src_Mixed_DPPA, MDR.sourceTools.src_Mixed_Non_DPPA], KELPermissions.Permit_Restricted, 0) + // These sources are permanently restricted, there is no way to enable permissions for them in the Generate(...) function below, we just don't ever want to use this data
			
			KELPermissions.Permit_NoRestriction; // Every Record will be tagged as having NoRestriction - any records which have additional restrictions are handled above
			/* TODO: KS-1968 - Define the set of ALLOWED_SOURCES.  At the time that ticket is worked on, replace the previous line of code with the following commented-out lines:
			IF(Source IN PublicRecords_KEL.ECL_Functions.Constants.ALLOWED_SOURCES, KELPermissions.Permit_NoRestriction, KELPermissions.Permit_Restricted); // Every Record which is in the set of Allowed Sources will be tagged as having NoRestriction - any records which have additional restrictions are handled above */

		RETURN Permissions;
	END;
	
	/* Generates the KEL PERMITS Bitmask to pass to a KEL QUERY */
	EXPORT Generate(STRING DataRestrictionMask, STRING DataPermissionMask, UNSIGNED1 GLBA, UNSIGNED1 DPPA, BOOLEAN isFCRA, BOOLEAN isMarketing = FALSE, BOOLEAN AllowDNBDMI = FALSE, PublicRecords_KEL.CFG_Compile KELPermissions = PublicRecords_KEL.CFG_Compile, BOOLEAN IsInsuranceProduct = FALSE) := FUNCTION
		Permissions := 
			IF(isFCRA, KELPermissions.Permit_FCRA, KELPermissions.Permit_NonFCRA) + // If isFCRA is TRUE allow FCRA Restricted data, else allow NonFCRA Restricted data in KEL
			IF(Risk_Indicators.iid_constants.glb_ok(GLBA, isFCRA), KELPermissions.Permit_GLBA, 0) + // Check to see if we have appropriate GLBA permissions before allowing use of GLBA Restricted data in KEL
			IF(Risk_Indicators.iid_constants.dppa_ok(DPPA, isFCRA), KELPermissions.Permit_DPPA, 0) + // Check to see if we have appropriate DPPA permissions before allowing use of DPPA Restricted data in KEL
			IF(isMarketing, 0, KELPermissions.Permit_Marketing) + // Running a Marketing product, only allow Marketing approved sources in KEL
			IF(AllowDNBDMI, KELPermissions.Permit_DNBDMI, 0) + // If AllowDNBDMI is TRUE allow use of DNBDMI data in KEL
			IF(IsInsuranceProduct, KELPermissions.Permit_InsuranceProduct, 0) + // If IsInsuranceProduct is TRUE allow use of Insurance only data in KEL
			// DataRestrictionMask DRM Sources
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posFaresRestriction] != '1', KELPermissions.Permit_Fares, 0) + // If Fares Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posExperianRestriction] != '1', KELPermissions.Permit_Experian, 0) + // If Experian Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posCertegyRestriction] != '1', KELPermissions.Permit_Certegy, 0) + // If Certegy Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posEquifaxRestriction] != '1', KELPermissions.Permit_Equifax, 0) + // If Equifax Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posTransUnionRestriction] != '1', KELPermissions.Permit_TransUnion, 0) + // If TransUnion Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posADVORestriction] != '1', KELPermissions.Permit_Advo, 0) + // If ADVO Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posExperianFCRARestriction] != '1', KELPermissions.Permit_ExperianFCRA, 0) + // If ExperianFCRA Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posExperianPhonesRestriction] != '1', KELPermissions.Permit_ExperianPhones, 0) + // If  Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posInquiriesRestriction] != '1', KELPermissions.Permit_Inquiries, 0) + // If  Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posRestrictPreGLB] != '1', KELPermissions.Permit_PreGLB, 0) + // If PreGLB Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posLiensJudgRestriction] != '1', KELPermissions.Permit_LiensJudgments, 0) + // If Liens and Judgments Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			IF(DataRestrictionMask[Risk_Indicators.iid_constants.posCortera] != '1', KELPermissions.Permit_Cortera, 0) + // If Cortera Source is NOT restricted in the DataRestrictionMask, allow its usage in KEL
			// DataPermissionMask DPM Sources
			IF(DataPermissionMask[Risk_Indicators.iid_constants.posSSADeathMasterPermission] = '1', KELPermissions.Permit_SSNDeathMaster, 0) + // If SSN Death Master Source is permitted in the DataPermissionMask, allow its usage in KEL
			IF(DataPermissionMask[Risk_Indicators.iid_constants.posFDNcftfPermission] = '1', KELPermissions.Permit_FDN, 0) + // If Fraud Defense Network Source is permitted in the DataPermissionMask, allow its usage in KEL
			IF(DataPermissionMask[Risk_Indicators.iid_constants.InsuranceDLPermission] = '1', KELPermissions.Permit_InsuranceDL, 0) + // If Insurance Drivers License Source is permitted in the DataPermissionMask, allow its usage in KEL
			// Every Transaction should have the NoRestriction permission - this will allow viewing of data that has no restrictions at all
			KELPermissions.Permit_NoRestriction;

		RETURN(Permissions);
	END;
	
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
			{'Permit_ExperianBus', (BOOLEAN)(convertedString[16] = '1')},
			{'Permit_SSNDeathMaster', (BOOLEAN)(convertedString[17] = '1')},
			{'Permit_FDN', (BOOLEAN)(convertedString[18] = '1')},
			{'Permit_InsuranceDL', (BOOLEAN)(convertedString[19] = '1')},
			{'Permit_SBFE', (BOOLEAN)(convertedString[20] = '1')},
			{'Permit_DNBDMI', (BOOLEAN)(convertedString[21] = '1')},
			{'Permit_Targus', (BOOLEAN)(convertedString[22] = '1')},
			{'Permit_Certegy', (BOOLEAN)(convertedString[23] = '1')},
			{'Permit_PreGLB', (BOOLEAN)(convertedString[24] = '1')},
			{'Permit_LiensJudgments', (BOOLEAN)(convertedString[25] = '1')},
			{'Permit_ExperianPhones', (BOOLEAN)(convertedString[26] = '1')},
			{'Permit_Inquiries', (BOOLEAN)(convertedString[27] = '1')},
			{'Permit_Unassigned37', (BOOLEAN)(convertedString[28] = '1')},
			{'Permit_Unassigned36', (BOOLEAN)(convertedString[29] = '1')},
			{'Permit_Unassigned35', (BOOLEAN)(convertedString[30] = '1')},
			{'Permit_Unassigned34', (BOOLEAN)(convertedString[31] = '1')},
			{'Permit_Unassigned33', (BOOLEAN)(convertedString[32] = '1')},
			{'Permit_Unassigned32', (BOOLEAN)(convertedString[33] = '1')},
			{'Permit_Unassigned31', (BOOLEAN)(convertedString[34] = '1')},
			{'Permit_Unassigned30', (BOOLEAN)(convertedString[35] = '1')},
			{'Permit_Unassigned29', (BOOLEAN)(convertedString[36] = '1')},
			{'Permit_Unassigned28', (BOOLEAN)(convertedString[37] = '1')},
			{'Permit_Unassigned27', (BOOLEAN)(convertedString[38] = '1')},
			{'Permit_Unassigned26', (BOOLEAN)(convertedString[39] = '1')},
			{'Permit_Unassigned25', (BOOLEAN)(convertedString[40] = '1')},
			{'Permit_Unassigned24', (BOOLEAN)(convertedString[41] = '1')},
			{'Permit_Unassigned23', (BOOLEAN)(convertedString[42] = '1')},
			{'Permit_Unassigned22', (BOOLEAN)(convertedString[43] = '1')},
			{'Permit_Unassigned21', (BOOLEAN)(convertedString[44] = '1')},
			{'Permit_Unassigned20', (BOOLEAN)(convertedString[45] = '1')},
			{'Permit_Unassigned19', (BOOLEAN)(convertedString[46] = '1')},
			{'Permit_Unassigned18', (BOOLEAN)(convertedString[47] = '1')},
			{'Permit_Unassigned17', (BOOLEAN)(convertedString[48] = '1')},
			{'Permit_Unassigned16', (BOOLEAN)(convertedString[49] = '1')},
			{'Permit_Unassigned15', (BOOLEAN)(convertedString[50] = '1')},
			{'Permit_Unassigned14', (BOOLEAN)(convertedString[51] = '1')},
			{'Permit_Unassigned13', (BOOLEAN)(convertedString[52] = '1')},
			{'Permit_Unassigned12', (BOOLEAN)(convertedString[53] = '1')},
			{'Permit_Unassigned11', (BOOLEAN)(convertedString[54] = '1')},
			{'Permit_Unassigned10', (BOOLEAN)(convertedString[55] = '1')},
			{'Permit_Unassigned9', (BOOLEAN)(convertedString[56] = '1')},
			{'Permit_Unassigned8', (BOOLEAN)(convertedString[57] = '1')},
			{'Permit_Unassigned7', (BOOLEAN)(convertedString[58] = '1')},
			{'Permit_Unassigned6', (BOOLEAN)(convertedString[59] = '1')},
			{'Permit_Unassigned5', (BOOLEAN)(convertedString[60] = '1')},
			{'Permit_Unassigned4', (BOOLEAN)(convertedString[61] = '1')},
			{'Permit_Unassigned3', (BOOLEAN)(convertedString[62] = '1')},
			{'Permit_Unassigned2', (BOOLEAN)(convertedString[63] = '1')},
			{'Permit_Unassigned1', (BOOLEAN)(convertedString[64] = '1')}
			], {STRING40 Permits_Name, BOOLEAN Permits_Set}) (Permits_Name[1..17] != 'Permit_Unassigned');
	
		RETURN result;
	END;
END;