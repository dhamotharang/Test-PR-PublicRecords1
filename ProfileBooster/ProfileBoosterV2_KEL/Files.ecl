/* KEL expects that any necessary permission mapping happens prior to the KEL implementation.  
   The purpose of this MODULE is to gather all of that permission functionality into one location for ease of maintanence.
   KEL can then USE these results for Attribute computation and appropriately filter out data at runtime that is not explicitly allowed. 
   For organizational purposes, we are maintaining this list in alphabettical order. */
IMPORT 
 // ADVO,
 // AlloyMedia_student_list,
 // American_Student_List,
 // BIPV2,
 // DMA,
 // Doxie,
 // DriversV2,
 // DX_Email,
 // Email_Data,
 Header,
 // Header_Quick,
 // MDR,
 // PAW,
 // PhonesPlus_v2,
 ProfileBooster,
 ProfileBooster.ProfileBoosterV2_KEL,
 Relationship,
 // Risk_Indicators,
 // RiskView,
 // USPIS_HotList,
 VehicleV2,
 // Watercraft,
 // YellowPages,
 STD;

EXPORT Files := MODULE
	// EXPORT (inputDataset) := FUNCTIONMACRO
		// filteredSet := inputDataset; // 'Unchanged', 'Updated', 'New'
		
		// RETURN(filteredSet);
	// ENDMACRO;
	
	SHARED CFG_File := ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile;
/* ******************************************************************************
                            SHARED PERMISSIONS LOGIC
 ****************************************************************************** */
	// This record IS regulated by DPPA if it is one of the DPPA Regulated Sources (Determined by Source_Column)
	SHARED DPPARegulatedRecord(STRING Source_Column) := 'MDR.SourceTools.SourceIsDPPA(' + Source_Column + ')';
	
	// Additionally records from certain states are not allowed to be used unless we have a DPPA in a specific set of values
	SHARED GetDPPAState(STRING Source_Column) := 'MDR.SourceTools.DPPAOriginState(' + Source_Column + ')';
	
	// Treat QH and WH are Equifax records in our source filtering.
	SHARED SetQuickHeaderSource(STRING Source_Column) := 'IF(' + Source_Column + ' IN [\'QH\', \'WH\'], MDR.sourceTools.src_Equifax, ' + Source_Column + ')';
	
	// Phones Plus Scoring Keys are GLB regulated dppa_glb_flag is 'G' or 'B'
	SHARED GLBARegulatedPhonesPlusRecord(STRING dppa_glb_flag) := dppa_glb_flag + ' IN [\'G\', \'B\']';
	
	// Death Master records are GLB regualted if glb_flag = 'Y'
	SHARED GLBARegulatedDeathMasterRecord(STRING glb_flag) := glb_flag + ' = \'Y\'';

	// Watercraft records are DPPA regualted if dppa_flag = 'Y'
	SHARED DPPARegulatedWaterCraftRecord(STRING dppa_flag) := dppa_flag + ' = \'Y\'';	
	
	// Records from GLB sources might NOT be GLBA Regulated depending on if they are older than GLBA Laws
	SHARED PreGLBRegulatedRecord(STRING Source_Column, STRING Date_Last_Seen_Column, STRING Date_First_Seen_Column) := 
				Source_Column + ' IN MDR.SourceTools.set_GLB AND Header.isPreGLB_LIB(' + Date_Last_Seen_Column + ', ' + Date_First_Seen_Column + ', ' + Source_Column + ', \'00000000000000000000000000000000000000000000000000\')';
	
	// Indicates if a dataset/file is NOT regulated by DPPA/GLBA and has no other Generic_Restrictions to apply inside of ProfileBooster.ProfileBoosterV2_KEL/ECL_Functions/Fn_KEL_DPMBitmap.SetValue(...)
	SHARED NotRegulated := 'FALSE';
	// Indicates a dataset regalted by a certain restriction
	SHARED Regulated := 'TRUE';
	SHARED BlankString := '\'\'';

	SHARED Watchdog_NonEN_String := '\'' + ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Watchdog_NonEN + '\'';
	SHARED Watchdog_NonEQ_String := '\'' + ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Watchdog_NonEQ + '\'';











/* ******************************************************************************
                            FCRA FILE PERMISSIONS
 ****************************************************************************** */		
	// EXPORT FCRA := MODULE
		// SHARED isFCRA := TRUE;
		
		// EXPORT AlloyMedia_Student_List__Key_DID_FCRA := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((AlloyMedia_Student_List.Key_DID_FCRA), 'LEFT.Source', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT American_Student_List__Key_DID_FCRA := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((American_Student_List.Key_DID_FCRA), 'LEFT.Source', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT ADVO__Key_Addr1_FCRA := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ADVO.Key_Addr1_FCRA), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT ADVO__Key_Addr1_FCRA_History := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.ADVO__Key_Addr1_FCRA_History, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT AVM_V2__Key_AVM_Address_FCRA := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.AVM_V2__Key_AVM_Address_FCRA), BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT AVM_V2__Key_AVM_Medians_FCRA := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.AVM_V2__Key_AVM_Medians_FCRA), BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT BankruptcyV3__Key_BankruptcyV3_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.BankruptcyV3__Key_BankruptcyV3_DID), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT BankruptcyV3__Key_BankruptcyV3_Main_Full := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.BankruptcyV3__Key_BankruptcyV3_Main_Full), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT BankruptcyV3__Key_BankruptcyV3_Search_Full_BIP := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.BankruptcyV3__Key_BankruptcyV3_Search_Full_BIP), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT BankruptcyV3__Key_BankruptcyV3_Search_Full := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.BankruptcyV3__Key_BankruptcyV3_Search_Full), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Death_Master__Key_ssn_ssa := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Death_Master__Key_ssn_ssa), 'LEFT.Src', isFCRA, GLBARegulatedDeathMasterRecord('LEFT.glb_flag') /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Doxie_Files__Key_BocaShell_Crim_FCRA := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Doxie_Files__Key_BocaShell_Crim_FCRA, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT doxie_files__Key_Court_Offenses := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.doxie_files__Key_Court_Offenses), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Doxie_Files__Key_Offenders_FCRA := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Doxie_Files__Key_Offenders_FCRA), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Doxie_Files__Key_Offenders := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Doxie_Files__Key_Offenders), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT doxie_files__Key_Offenses := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.doxie_files__Key_Offenses), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Doxie_Files__Key_Punishment := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Doxie_Files__Key_Punishment, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT Doxie__Key_FCRA_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(doxie.Key_FCRA_Header_Address, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, PreGLBRegulatedRecord('LEFT.Src', 'LEFT.dt_last_seen', 'LEFT.dt_first_seen') /*PreGLB*/, NotRegulated /*DPPA*/, GetDPPAState('LEFT.src') /*DPPA State*/,  CFG_File);
		
		// EXPORT Doxie__Key_FCRA_Header := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((doxie.Key_FCRA_Header), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, PreGLBRegulatedRecord('LEFT.Src', 'LEFT.dt_nonglb_last_seen', 'LEFT.dt_first_seen') /*PreGLB*/, NotRegulated /*DPPA*/, GetDPPAState('LEFT.src') /*DPPA State*/,  CFG_File);
		
		// EXPORT Doxie__Key_FCRA_legacy_ssn := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(doxie.Key_FCRA_legacy_ssn, BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT DX_Email__Key_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(DX_Email.Key_DID(isFCRA), '', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT DX_Email__Key_Email_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(DX_Email.Key_Email_Address, '', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT DX_Email__Key_Email_Payload := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((DX_Email.Key_Email_Payload(isFCRA)), 'LEFT.Email_Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT Email_Data__Key_DID_FCRA := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((Email_Data.Key_DID_FCRA), 'LEFT.Email_Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT FAA__Key_Aircraft_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.FAA__Key_Aircraft_DID), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT FAA__Key_Aircraft_Id := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.FAA__Key_Aircraft_Id), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT Gong__Key_History_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Gong__Key_History_Address), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);		
		
		// EXPORT Gong__Key_History_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Gong__Key_History_DID), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
						
		// EXPORT Gong__Key_History_Phone := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Gong__Key_History_Phone), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
	
		// EXPORT Header__Key_Addr_Hist := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Header__Key_Addr_Hist, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Header_Quick__Key_Did_FCRA := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((Header_Quick.Key_Did_FCRA), SetQuickHeaderSource('LEFT.src'), isFCRA, NotRegulated /*GLBA*/, PreGLBRegulatedRecord('LEFT.Src', 'LEFT.dt_nonglb_last_seen', 'LEFT.dt_first_seen') /*PreGLB*/, NotRegulated /*DPPA*/, GetDPPAState(SetQuickHeaderSource('LEFT.src')) /*DPPA State*/, CFG_File);
		
		// EXPORT InfutorCID__Key_Infutor_Phone :=  ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.InfutorCID__Key_Infutor_Phone), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);		
	
		// EXPORT Inquiry_AccLogs__Key_FCRA_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Inquiry_AccLogs__Key_FCRA_DID), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT LN_PropertyV2__Key_Assessor_FID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.LN_PropertyV2__Key_Assessor_FID), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT LN_PropertyV2__Key_Deed_FID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.LN_PropertyV2__Key_Deed_FID, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
								
		// EXPORT LN_PropertyV2__Key_Search_FID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.LN_PropertyV2__Key_Search_FID, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Prof_LicenseV2__Key_Proflic_Did := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Prof_LicenseV2__Key_Proflic_Did), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, 'LEFT.vendor = RiskView.Constants.directToConsumerPL_sources' /*Generic_Restriction*/);
		
		// EXPORT Prof_License_Mari__Key_did := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Prof_License_Mari__Key_did), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, 'LEFT.std_source_upd IN Risk_Indicators.iid_constants.restricted_Mari_vendor_set');
		
		// EXPORT Risk_Indicators__Key_SSN_Table_v4_filtered_FCRA_Combo := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Risk_Indicators__Key_SSN_Table_v4_filtered_FCRA_Combo), 'LEFT.Src', isFCRA, Regulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Risk_Indicators__Key_SSN_Table_v4_filtered_FCRA_Experian := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Risk_Indicators__Key_SSN_Table_v4_filtered_FCRA_Experian), 'LEFT.Src', isFCRA, Regulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Risk_Indicators__Key_SSN_Table_v4_filtered_FCRA_Equifax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Risk_Indicators__Key_SSN_Table_v4_filtered_FCRA_Equifax), 'LEFT.Src', isFCRA, Regulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Risk_Indicators__Key_ADL_Risk_Table_v4_Filtered_Combo := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Risk_Indicators__Key_ADL_Risk_Table_v4_Filtered_Combo), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Risk_Indicators__Key_ADL_Risk_Table_v4_Filtered_Experian := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Risk_Indicators__Key_ADL_Risk_Table_v4_Filtered_Experian), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
				
		// EXPORT Risk_Indicators__Key_ADL_Risk_Table_v4_Filtered_Equifax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Risk_Indicators__Key_ADL_Risk_Table_v4_Filtered_Equifax), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
	
		// EXPORT Targus__Key_Targus_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Targus__Key_Targus_Address), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Targus__Key_Targus_Phone := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Targus__Key_Targus_Phone), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT Watchdog__Key_Watchdog_FCRA_nonEN := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN), Watchdog_NonEN_String, isFCRA, GLBA_Restriction_Rules := NotRegulated, Pre_GLB_Restriction_Rules := NotRegulated, DPPA_Restriction_Rules := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);

		// EXPORT Watchdog__Key_Watchdog_FCRA_nonEQ := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ), Watchdog_NonEQ_String, isFCRA, GLBA_Restriction_Rules := NotRegulated, Pre_GLB_Restriction_Rules := NotRegulated, DPPA_Restriction_Rules := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File);

		// EXPORT Watercraft__Key_Watercraft_did := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Watercraft__Key_Watercraft_did), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT Watercraft__Key_Watercraft_Sid := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.FCRA.Watercraft__Key_Watercraft_Sid), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
	// END;











/* ******************************************************************************
                            NON FCRA FILE PERMISSIONS
 ****************************************************************************** */
	EXPORT NonFCRA := MODULE
		SHARED isFCRA := FALSE;
		
		// EXPORT AddrFraud__Key_AddrFraud_GeoLink := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.AddrFraud__Key_AddrFraud_GeoLink), BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT ADVO__Key_Addr1 := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ADVO.Key_Addr1), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT ADVO__Key_Addr1_History := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.ADVO__Key_Addr1_History, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT AlloyMedia_Student_List__Key_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((AlloyMedia_Student_List.Key_DID), 'LEFT.Source', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT American_Student_List__Key_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((American_Student_List.Key_DID), 'LEFT.Source', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT AVM_V2__Key_AVM_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.AVM_V2__Key_AVM_Address), BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT AVM_V2__Key_AVM_Medians := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.AVM_V2__Key_AVM_Medians), BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT BankruptcyV3__Key_BankruptcyV3_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BankruptcyV3__Key_BankruptcyV3_DID), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT BankruptcyV3__Key_BankruptcyV3_Main_Full := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BankruptcyV3__Key_BankruptcyV3_Main_Full), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT BankruptcyV3__Key_BankruptcyV3_Search_Full_BIP := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BankruptcyV3__Key_BankruptcyV3_Search_Full_BIP), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT BankruptcyV3__Key_BankruptcyV3_Search_Full := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BankruptcyV3__Key_BankruptcyV3_Search_Full), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT BankruptcyV3__Key_BankruptcyV3_linkids := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BankruptcyV3__Key_BankruptcyV3_linkids, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT BBB2__Key_BBB_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BBB2__Key_BBB_LinkIds), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT BBB2__Key_BBB_Non_Member_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BBB2__Key_BBB_Non_Member_LinkIds), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT BIPV2__Key_BH_Linking_Ids__Key := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(BIPV2.Key_BH_Linking_Ids.Key, 'LEFT.Source', isFCRA, NotRegulated /*GLBA*/, PreGLBRegulatedRecord('LEFT.Source', '0', 'LEFT.dt_first_seen') /*PreGLB*/, NotRegulated /*DPPA*/, GetDPPAState('LEFT.source') /*DPPA State*/, CFG_File);

		// EXPORT BIPV2_Best__Key_LinkIds__Company_Name := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BIPV2_Best__Key_LinkIds__Company_Name_Translated, 'LEFT.Source' /*Source*/, IsFCRA, NotRegulated /*GLBA*/, PreGLBRegulatedRecord('LEFT.Source', '0', 'LEFT.dt_first_seen') /*PreGLB*/, NotRegulated /*DPPA*/, GetDPPAState('LEFT.Source') /*DPPA State*/, CFG_File, BIP_Bit_Mask := 'LEFT.DPMFromBIPBitMask' /*BIPBitMask*/);
		
		// EXPORT BIPV2_Best__Key_LinkIds__Company_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BIPV2_Best__Key_LinkIds__Company_Address_Translated, BlankString /*Source*/, IsFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, BIP_Bit_Mask := 'LEFT.DPMFromBIPBitMask' /*BIPBitMask*/);

		// EXPORT BIPV2_Best__Key_LinkIds__Company_Phone := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BIPV2_Best__Key_LinkIds__Company_Phone_Translated, BlankString /*Source*/, IsFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, BIP_Bit_Mask := 'LEFT.DPMFromBIPBitMask' /*BIPBitMask*/);

		// EXPORT BIPV2_Best__Key_LinkIds__Company_FEIN := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BIPV2_Best__Key_LinkIds__Company_FEIN_Translated, 'LEFT.Source' /*Source*/, IsFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, GetDPPAState('LEFT.Source') /*DPPA State*/, CFG_File, BIP_Bit_Mask := 'LEFT.DPMFromBIPBitMask' /*BIPBitMask*/);

		// EXPORT BIPV2_Best__Key_LinkIds__SIC_Code := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BIPV2_Best__Key_LinkIds__Company_SIC_Code_Translated, BlankString /*Source*/, IsFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, BIP_Bit_Mask := 'LEFT.DPMFromBIPBitMask' /*BIPBitMask*/);

		// EXPORT BIPV2_Best__Key_LinkIds__NAICS_Code := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BIPV2_Best__Key_LinkIds__Company_NAICS_Code_Translated, BlankString /*Source*/, IsFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, BIP_Bit_Mask := 'LEFT.DPMFromBIPBitMask' /*BIPBitMask*/);
			
		// EXPORT BusReg__Key_BusReg_Company_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BusReg__Key_BusReg_Company_LinkIds), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT BIPV2_Build__key_contact_linkids := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.BIPV2_Build__key_contact_linkids), 'LEFT.Source', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT CalBus__Key_CalBus_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.CalBus__Key_CalBus_LinkIds, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// Certegy.Key_Certegy_DID
			// Note: This data requires a valid DPPA to access (DPPA is Regulated, if we bring this key into the Analytic Library.)
			// See Risk_Indicators.iid_DL_verification: requires dppa_ok to access

		// EXPORT CellPhone__Key_Nustar_Phone := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.CellPhone__Key_Nustar_Phone, 'LEFT.Src', isFCRA, NotRegulated/*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);		
		
		// EXPORT Corp2__Key_LinkIDs := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Corp2__Key_LinkIDs), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Cortera__Key_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Cortera__Key_LinkIds), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Cortera_Tradeline__Key_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Cortera_Tradeline__Key_LinkIds), 'LEFT.Source', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT DCAV2__Key_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.DCAV2__Key_LinkIds), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Death_Master__Key_ssn_ssa := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Death_Master__Key_ssn_ssa), 'LEFT.Src', isFCRA, GLBARegulatedDeathMasterRecord('LEFT.glb_flag') /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT DMA__key_DNM_Name_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(DMA.Key_DNM_Name_Address,  BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);	

		// EXPORT Doxie__Key_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(Doxie.Key_Header_Address, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, PreGLBRegulatedRecord('LEFT.Src', 'LEFT.dt_last_seen', 'LEFT.dt_first_seen') /*PreGLB*/, NotRegulated /*DPPA*/, GetDPPAState('LEFT.src') /*DPPA State*/, CFG_File);
		
		// EXPORT Doxie__Key_Death_MasterV2_SSA_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((Doxie.Key_Death_MasterV2_SSA_DID), 'LEFT.Src', isFCRA, GLBARegulatedDeathMasterRecord('LEFT.glb_flag') /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Doxie__Key_Header := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((Doxie.Key_Header), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, PreGLBRegulatedRecord('LEFT.Src', 'LEFT.dt_nonglb_last_seen', 'LEFT.dt_first_seen') /*PreGLB*/, NotRegulated /*DPPA*/, GetDPPAState('LEFT.src') /*DPPA State*/, CFG_File);
		
		// EXPORT Doxie__Key_HHID_Did := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((Doxie.Key_HHID_Did), BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Doxie_Files__Key_Court_Offenses := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Doxie_Files__Key_Court_Offenses), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Doxie_Files__Key_Offenders_Risk := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Doxie_Files__Key_Offenders_Risk), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Doxie_Files__Key_Offenders := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Doxie_Files__Key_Offenders), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Doxie_Files__Key_Punishment := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Doxie_Files__Key_Punishment, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT DriversV2__Key_DL_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.DriversV2__Key_DL_DID, 'LEFT.Source_Code', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, 'LEFT.st' /*DPPA State*/, CFG_File);
		
		// EXPORT DriversV2__Key_DL_Number := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.DriversV2__Key_DL_Number, 'LEFT.Source_Code', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, 'LEFT.st' /*DPPA State*/, CFG_File);
		
    EXPORT DunnData_Consumer__Key_Did := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.DunnData_Consumer__Key_Did, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, 'LEFT.st' /*DPPA State*/, CFG_File);
	
		// EXPORT DX_Email__Key_Did := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(DX_Email.Key_Did(isFCRA), '', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT DX_Email__Key_Email_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(DX_Email.Key_Email_Address(), '', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT DX_Email__Key_Email_Payload := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(DX_Email.Key_Email_Payload(isFCRA), 'LEFT.Email_Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT EBR__Key_5600_Demographic_Data_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.EBR__Key_5600_Demographic_Data_LinkIds, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Email_Data__Key_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((Email_Data.Key_DID), 'LEFT.Email_Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
	
		// EXPORT Email_Data__Key_Email_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((Email_Data.Key_Email_Address), 'LEFT.Email_Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Equifax_Business_Data__Key_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Equifax_Business_Data__Key_LinkIds), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT FAA__Key_Aircraft_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.FAA__Key_Aircraft_DID), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT FAA__Key_Aircraft_Id := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.FAA__Key_Aircraft_Id), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
	
		// EXPORT FAA__key_aircraft_linkids := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.FAA__key_aircraft_linkids), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
	
		// EXPORT FBNv2__Key_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.FBNv2__Key_LinkIds, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT FLAccidents_Ecrash__Key_ECrash4 := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.FLAccidents_Ecrash__Key_ECrash4, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT FLAccidents_Ecrash__Key_ECrashV2_AccNBR := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.FLAccidents_Ecrash__Key_ECrashV2_AccNBR, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT Fraudpoint3__Key_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Fraudpoint3__Key_Address, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Gong__Key_History_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Gong__Key_History_Address), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);		
		
		// EXPORT Gong__Key_History_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Gong__Key_History_DID), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT Gong__Key_History_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Gong__Key_History_LinkIds), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
				
		// EXPORT Gong__Key_History_Phone := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Gong__Key_History_Phone), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT GovData__Key_IRS_NonProfit_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.GovData__Key_IRS_NonProfit_LinkIds), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Header__Key_Addr_Hist := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Header__Key_Addr_Hist, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Header_Quick__Key_Did := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((Header_Quick.Key_Did), SetQuickHeaderSource('LEFT.src'), isFCRA, NotRegulated /*GLBA*/, PreGLBRegulatedRecord('LEFT.Src', 'LEFT.dt_nonglb_last_seen', 'LEFT.dt_first_seen') /*PreGLB*/, NotRegulated /*DPPA*/, GetDPPAState(SetQuickHeaderSource('LEFT.src')) /*DPPA State*/, CFG_File);
		
		// InsuranceHeader_PostProcess.AncillaryKeys().did.qa
		// InsuranceHeader_PostProcess.AncillaryKeys().dln.qa
			// Note: if either of these Insurance header keys are brought into the Anaytic Library, see 
			// InsuranceHeader_BestOfBest.search_Insurance_DL_by_DID and InsuranceHeader_BestOfBest.search_Insurance_DL_by_DL for which records are allowed:
				// ((StringLib.StringToUpperCase(right.src[1..3]) in ['IVS','ICA'] or StringLib.StringToUpperCase(right.src) = 'MVRINQ') or drivers.state_dppa_ok(left.dl_st,dppa)) and Risk_Indicators.iid_constants.InsuranceDL_ok(DataPermission)
		// EXPORT InfoUSA__Key_DEADCO_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.InfoUSA__Key_DEADCO_LinkIds), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);	
		
		// EXPORT InfutorCID__Key_Infutor_Phone :=  ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.InfutorCID__Key_Infutor_Phone), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);	
		
		// EXPORT Infutor_NARB__Key_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Infutor_NARB__Key_LinkIds), 'LEFT.Source', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT IRS5500__Key_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.IRS5500__Key_LinkIds), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT LN_PropertyV2__Key_Addl_Fares_Deed_FID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.LN_PropertyV2__Key_Addl_Fares_Deed_FID), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT LN_PropertyV2__Key_Assessor_FID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.LN_PropertyV2__Key_Assessor_FID), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT LN_PropertyV2__Key_Deed_FID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.LN_PropertyV2__Key_Deed_FID, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
				
		// EXPORT LN_PropertyV2__Key_Search_FID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.LN_PropertyV2__Key_Search_FID, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT OSHAIR__Key_OSHAIR_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.OSHAIR__Key_OSHAIR_LinkIds, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT PAW__Key_ContactID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(PAW.Key_ContactID, 'LEFT.Source', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT PhonesPlus_v2__Keys_Iverification__Phone__QA := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.PhonesPlus_v2__Keys_Iverification__Phone__QA), 'LEFT.Src', isFCRA, NotRegulated/*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT PhonesPlus_v2__Keys_Iverification__Did_Phone__QA := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.PhonesPlus_v2__Keys_Iverification__Did_Phone__QA), 'LEFT.Src', isFCRA, NotRegulated/*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);		
		
		// EXPORT PhonesPlus_v2__key_phonesplus_fdid := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.PhonesPlus_v2__key_phonesplus_fdid), 'LEFT.Src', isFCRA, GLBARegulatedPhonesPlusRecord('LEFT.glb_dppa_flag') /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, 'LEFT.origstate'  /*DPPA State*/, CFG_File);		
		
		// EXPORT PhonesPlus_v2__Keys_Scoring__Phone__QA := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.PhonesPlus_v2__Keys_Scoring__Phone__QA, 'LEFT.Src', isFCRA, GLBARegulatedPhonesPlusRecord('LEFT.glb_dppa_flag') /*GLBA*/, NotRegulated /*PreGLB*/, Regulated /*DPPA*/, 'LEFT.state' /*DPPA State*/, CFG_File);
		
		// EXPORT PhonesPlus_v2__Keys_Scoring__Address__QA := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.PhonesPlus_v2__Keys_Scoring__Address__QA, 'LEFT.Src', isFCRA, GLBARegulatedPhonesPlusRecord('LEFT.glb_dppa_flag') /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, 'LEFT.state' /*DPPA State*/, CFG_File);		
		
		// Phonesplus_v2.key_phonesplus_fdid
			// Note: If this key is brought into the Analytic Library, see Phones.Functions.IsPhoneRestricted for what restrictions to apply: GLBA, DPPA, and DRM rules should all be applied.
			
		// EXPORT Prof_LicenseV2__Key_Proflic_Did := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Prof_LicenseV2__Key_Proflic_Did), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Prof_License_Mari__Key_did := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Prof_License_Mari__Key_did), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, 'LEFT.std_source_upd IN Risk_Indicators.iid_constants.restricted_Mari_vendor_set' /*Generic_Restriction*/);
		
		// Risk_Indicators.Key_ADL_Risk_Table_V4
			// Note: If this key is brought in for NonFCRA, DPPA restrictions apply to the reported_dob field in addition to source restrictions that help us determine which section of the key to pull data from.
				// See Risk_Indicators.Boca_Shell_HHID_Summary:
					// reported_dob := if(dppa_ok, header_version.reported_dob, header_version.reported_dob_no_dppa) 

		// EXPORT Risk_Indicators__Key_ADL_Risk_Table_v4_Combo := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Risk_Indicators__Key_ADL_Risk_Table_v4_Combo), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Risk_Indicators__Key_ADL_Risk_Table_v4_Experian := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Risk_Indicators__Key_ADL_Risk_Table_v4_Experian), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
				
		// EXPORT Risk_Indicators__Key_ADL_Risk_Table_v4_Equifax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Risk_Indicators__Key_ADL_Risk_Table_v4_Equifax), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
					
		// EXPORT Risk_Indicators__Key_ADL_Risk_Table_v4_TransUnion := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Risk_Indicators__Key_ADL_Risk_Table_v4_TransUnion), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT Risk_Indicators__key_fi_fips := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Risk_Indicators__key_fi_fips), BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Risk_Indicators__Key_FI_Module__key_fi_geo12 := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Risk_Indicators__Key_FI_Module__key_fi_geo12), BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Risk_Indicators__Key_Neighborhood_Stats_geolink := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Risk_Indicators__Key_Neighborhood_Stats_geolink), BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT Risk_Indicators__Key_SSN_Table_v4_Filtered_TransUnion := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Risk_Indicators__Key_SSN_Table_v4_Filtered_TransUnion), 'LEFT.Src', isFCRA, Regulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT RiskWise__Key_CityStZip := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.RiskWise__Key_CityStZip), BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT SAM__Key_LinkId := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.SAM__Key_LinkId, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Targus__Key_Targus_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Targus__Key_Targus_Address), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT Targus__Key_Targus_Phone := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Targus__Key_Targus_Phone, 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
	
		// EXPORT UCCV2__Key_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.UCCV2__Key_LinkIds), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, 'LEFT.Marketing' /*Generic_Restriction*/);
			
		// EXPORT UCCV2__Key_rmsid_main := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.UCCV2__Key_rmsid_main), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, 'LEFT.Marketing' /*Generic_Restriction*/);
	
		// EXPORT UCCV2__Key_rmsid_party := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.UCCV2__Key_rmsid_party), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, 'LEFT.Marketing' /*Generic_Restriction*/);
	
		// EXPORT UtilFile__Key_DID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.UtilFile__Key_DID, 'LEFT.Src', isFCRA, Regulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT UtilFile__Key_Address := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.UtilFile__Key_Address, 'LEFT.Src', isFCRA, Regulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
		
		// EXPORT UtilFile__Key_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.UtilFile__Key_LinkIds, 'LEFT.Src', isFCRA, Regulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT USPIS_HotList__Key_ADDR_Search_Zip := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(USPIS_HotList.key_addr_search_zip,  BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);	
			
		EXPORT VehicleV2__Key_Vehicle_Main_Key := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.VehicleV2__Key_Vehicle_Main_Key, 'LEFT.Source_Code', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, Regulated /*DPPA*/, 'LEFT.state_origin' /*DPPA State*/, CFG_File);
		
		EXPORT VehicleV2__Key_Vehicle_Party_Key := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(VehicleV2.Key_Vehicle_Party_Key, 'LEFT.Source_Code', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, Regulated /*DPPA*/, 'LEFT.orig_state' /*DPPA State*/, CFG_File);
		
		// NEEDS TO BE SANDBOXED TO _QA INSTEAD OF _PB. FILE is 1.24TB
		EXPORT VehicleV2__Key_Vehicle_linkids := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(VehicleV2.Key_Vehicle_linkids.Key, 'LEFT.Source_Code', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, Regulated /*DPPA*/, 'LEFT.orig_state' /*DPPA State*/, CFG_File);

		EXPORT Watchdog__Key_Watchdog := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Watchdog__Key_Watchdog), BlankString, isFCRA, watchdogPermissionsColumn := 'LEFT.permissions', KELPermissions := CFG_File);

		// EXPORT Watercraft__Key_Watercraft_did := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Watercraft__Key_Watercraft_did), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);

		// EXPORT Watercraft__Key_Watercraft_Sid := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Watercraft__Key_Watercraft_Sid), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, 'LEFT.state_origin' /*DPPA State*/, CFG_File);
	
		// EXPORT Watercraft__Key_LinkIds := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((ProfileBooster.ProfileBoosterV2_KEL.FileCleaning.NonFCRA.Watercraft__Key_LinkIds), 'LEFT.Src', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, DPPARegulatedWaterCraftRecord('LEFT.dppa_flag') /*DPPA*/, 'LEFT.state_origin' /*DPPA State*/, CFG_File);	
		
		// EXPORT YellowPages__key_yellowpages_linkids := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((YellowPages.key_yellowpages_linkids.key), 'LEFT.source', isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File);
	END;











/* ******************************************************************************
                      SHARED FCRA/NON FCRA FILE PERMISSIONS
 ****************************************************************************** */
	EXPORT FCRAAndNonFCRA := MODULE
		SHARED isFCRA := FALSE; // The Not_Restricted parameter in Fn_Append_DPMBitmap controls this, doesn't matter if this parameter is TRUE or FALSE
		EXPORT Header__Key_ADL_Segmentation := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(Header.Key_ADL_Segmentation, BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, NotRegulated /*GenericRestriction*/, 'TRUE' /*Not FCRA or NonFCRA Restricted*/);
		EXPORT Header__Key_ADL_Segmentation_Valut := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap(Header.Key_ADL_Segmentation, BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, NotRegulated /*GenericRestriction*/, 'TRUE' /*Not FCRA or NonFCRA Restricted*/);
		
		EXPORT Relationship__Key_Relatives_V3 := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((Relationship.Key_Relatives_V3), BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, NotRegulated /*GenericRestriction*/, 'TRUE' /*Not FCRA or NonFCRA Restricted*/);
		EXPORT Relationship__Key_Relatives_V3_Vault := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Append_DPMBitmap((Relationship.Key_Relatives_V3), BlankString /*File Has No Source*/, isFCRA, NotRegulated /*GLBA*/, NotRegulated /*PreGLB*/, NotRegulated /*DPPA*/, BlankString /*DPPA State*/, CFG_File, NotRegulated /*GenericRestriction*/, 'TRUE' /*Not FCRA or NonFCRA Restricted*/);
	END;
END;
