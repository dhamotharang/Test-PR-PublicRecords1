IMPORT Civ_Court, ut;

EXPORT Files_In_NY_Upstate := MODULE

	EXPORT Case_in	:= dataset('~thor_data400::in::civil::ny_upstate_cas',Civ_Court.Layouts_In_NY_Upstate.CAS,flat);
	EXPORT Atty_In	:= dataset('~thor_data400::in::civil::ny_upstate_aty',Civ_Court.Layouts_In_NY_Upstate.ATY,flat);
	EXPORT Apr_in		:= dataset('~thor_data400::in::civil::ny_upstate_apr',Civ_Court.Layouts_In_NY_Upstate.APR,flat);
	EXPORT Mtn_in		:= dataset('~thor_data400::in::civil::ny_upstate_mtn',Civ_Court.Layouts_In_NY_Upstate.MTN,flat);
	EXPORT Action_type_lkp	:= dataset('~thor_data400::in::civil::ny_upstate_action_type',Civ_Court.Layouts_In_NY_Upstate.Action_type_lkp,flat);
	EXPORT Justice_lkp	:= dataset('~thor_data400::in::civil::ny_upstate_justice_type',Civ_Court.Layouts_In_NY_Upstate.Justice_lkp,flat);
	EXPORT County_lkp	:= dataset('~thor_data400::in::civil::ny_upst_cnty_codes.lkp',Civ_Court.Layouts_In_NY_Upstate.County_lkp,flat);
	EXPORT Case_status_lkp	:= dataset('~thor_data400::in::civil::ny_upst_case_status.lkp',Civ_Court.Layouts_In_NY_Upstate.Case_status_lkp,flat);
	EXPORT Apr_type_lkp	:= dataset('~thor_data400::in::civil::ny_upst_apr_types.lkp',Civ_Court.Layouts_In_NY_Upstate.Apr_type_lkp,flat);
	
END;