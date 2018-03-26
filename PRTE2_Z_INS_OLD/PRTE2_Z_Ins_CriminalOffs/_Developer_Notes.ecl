/*
Looks like we need to import records to populate base files for:

PRTE.Proc_Build_SexOffender_Keys
PRTE.Proc_Build_Corrections_Keys

Jennifer points us to the following files we can research:
--------------------------------------------------------------------------------------------
		IMPORT Hygenics_Crim, Hygenics_Search, Hygenics_SOff, Images, Hygenics_Images, ut;

		//NonFCRA Crim Files
		export CrimOffender		:= Hygenics_crim.File_Moxie_Crim_Offender2_Dev;
		export CourtOffenses	:= Hygenics_crim.File_Moxie_Court_Offenses_Dev;
		export DOCOffenses		:= Hygenics_crim.File_Moxie_DOC_Offenses_Dev;
		export DOCPunishment	:= Hygenics_crim.File_Moxie_DOC_Punishment_Dev;
		export CrimImages			:= Hygenics_images.File_Images;

		//FCRA Crim Files
		export FCRA_CrimOffendder	:= Hygenics_Search.File_Moxie_Offender_Dev;
		export FCRA_CourtOffenses	:= Hygenics_Search.File_Moxie_CourtOffenses_Dev;
		export FCRA_DOCOffenses		:= Hygenics_Search.File_Moxie_Offenses_Dev;
		export FCRA_DOCPunishment	:= Hygenics_Search.File_Moxie_Punishment_Dev;

		//NonFCRA SexOffender Files
		export SOFF_Offender			:= Hygenics_SOff.File_Main;
		export SOFF_Offense				:= Hygenics_SOff.File_Offense; 
		export SOFF_Images				:= Images.File_Images; //(rtype=’SO’);

		//FCRA SexOffender Files
		export FCRA_SOFF_Offender	:= Hygenics_SOff.File_Main(seisint_primary_key[1..4] not in hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key);
		export FCRA_SOFF_Offenses	:= Hygenics_SOff.File_Offense(seisint_primary_key[1..4] not in hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key);  
--------------------------------------------------------------------------------------------


*/