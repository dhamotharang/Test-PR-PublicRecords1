

import crim_common;
import crim_cp_ln;

Layout_criminal_supplimental_Offender_key := Layout_criminal_supplimental_cp;

Layout_criminal_supplimental_Offender_key   tr_PrimOffenderToCrimSupp(Distribute_File_Primary_Offender_ECL_Cade_id L) := TRANSFORM,
                                              SKIP(L.police_agency = '')
  SELF.ECL_CADE_ID := L.ECL_CADE_ID;
  SELF.OFFENDER_KEY := L.Seisint_Primary_Key; 
  SELF.CRSU_ID := L.ECL_CADE_ID;
	SELF.ASSIGNED_JUDGE := '';
	SELF.REFERRED_JUDGE := '';
	SELF.TERM_DT := '';
	SELF.ORIGINAL_COURT_ID := '';
	SELF.ARREST_DT_C := '';
	SELF.ARRAIGN_DT_F := '';
	SELF.FIRST_COURT_DT_F := '';
	SELF.JAIL_RELEASE_DT_C := '';
	SELF.TICKET_NUMBER := '';
	SELF.ARRESTING_AGENCY_CD := '';
	SELF.ARRESTING_AGENCY_PLACE_C := L.police_agency;
	SELF.SEIZED_PROPERTY_NUMBER := ''; 
	SELF.COSTS_ORDERED := '';
	SELF.COSTS_IMPOSED := '';
	SELF.IMPRISONED_SWITCH_FLG := '';
	SELF.COMMENCED_BY_CD := '';
	SELF.CADE_CADE_ID := '';
	SELF.CREATED_BY := 'HPCCLOAD';
	SELF.CREATION_DT := StringLib.GetDateYYYYMMDD();
	SELF.LAST_UPDATED_BY := '';
	SELF.LAST_UPDATE_DT := '';
	SELF.RECORD_SUPPLIER_CD := L.RECORD_SUPPLIER_CD_C;
	SELF.BATCH_NUMBER := '';
	SELF.AGENCY_CASE_NUMBER_F := '';
	SELF.CUSTODIAL_AGENCY_ID := '';
	SELF.CUSTODIAL_AGENCY := '';
	SELF.COUNTY_OF_COMMITMENT_F := '';
	SELF.CUSTODY_STATUS := '';
	SELF.CHARGING_DOCUMENT := '';
	SELF.JUDGE_DOC_ENTERED_BY := '';
	SELF.JUDGE_DOC_ENTERED_DT := '';
	SELF.OFFENDER_LEGAL_REPRESENTER := '';
	SELF.WITNESS_NAME := '';
	SELF.TRIAL_DT_C := '';
	SELF.CASE_SERVED_DT := '';
	SELF.OLD_RECORD_SUPPLIER_CD := L.OLD_RECORD_SUPPLIER_CD_C;
	SELF.TRIAL_TYPE := '';
	SELF.WARRANT_INFO_F := '';
	SELF.MTR_INFO := '';
	SELF.CUSTODY_INFO_CASE := '';
	SELF.PROBATION_INFO := '';
	SELF.CUSTODY_LOCATION := '';
	SELF := [];
END;	


	ds_CaseDetailsPrimary := PROJECT(Distribute_File_Primary_Offender_ECL_Cade_id,tr_PrimOffenderToCrimSupp(LEFT));
  

export MapOffenderToCriminalSupplimental := SORT(ds_CaseDetailsPrimary,ecl_cade_id)
                             : persist ('~thor_data400::persist::out::crim::cross_soff::MapOffenderToCriminalSupplimental');   
                                            


