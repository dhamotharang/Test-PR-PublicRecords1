IMPORT Civ_Court, ut;

EXPORT Files_In_NY_Downstate := MODULE

	//Noticed extensive duplication in input files so deduping prior to processing
	EXPORT Case_in	:= dedup(dataset('~thor_data400::in::civil::ny_downstate_cas',Civ_Court.Layouts_In_NY_Downstate.CAS,flat));
	EXPORT Atty_In	:= dedup(dataset('~thor_data400::in::civil::ny_downstate_aty',Civ_Court.Layouts_In_NY_Downstate.ATY,flat));
	EXPORT Apr_in		:= dedup(dataset('~thor_data400::in::civil::ny_downstate_apr',Civ_Court.Layouts_In_NY_Downstate.APR,flat));
	EXPORT Mtn_in		:= dedup(dataset('~thor_data400::in::civil::ny_downstate_mtn',Civ_Court.Layouts_In_NY_Downstate.MTN,flat));
	EXPORT Cnty_Codes_lkp	:= dataset('~thor_data400::in::civil::ny_downstate_cnty_codes_lkp ',Civ_Court.Layouts_In_NY_Downstate.code_lkp,flat);
	
END;