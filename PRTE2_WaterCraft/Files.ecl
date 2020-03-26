/********************************************************************************************************** 
	Name: 			_Files
	Created On: 07/20/2013
	By: 				ssivasubramanian
	Desc: 			Source for all file names for the sprayed, input files and the keys and the corresponding Supers
***********************************************************************************************************/


IMPORT _Control, PRTE2_Common, ut, STD, PRTE2_Watercraft;

EXPORT Files := MODULE

	process_date	:= (string8)STD.Date.Today();
	
// Insurance input file for the main build process put in same format as Boca file for ease of merging data for keybuild	
	EXPORT Alpha_Base			:= DATASET(PRTE2_Watercraft.Constants.BASE_PREFIX + '::qa::alldata_alpha', PRTE2_Watercraft.Layouts.Base_new - [bug_num, cust_name, link_inc_date, link_fein, link_dob, link_ssn, global_sid,record_sid], THOR);

// Boca Input file
	EXPORT Boca_in				:= DATASET(PRTE2_Watercraft.Constants.IN_PREFIX + '::boca', PRTE2_Watercraft.Layouts.Incoming_Boca, CSV(HEADING(2), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));										
	
// These are the final master files that will hold all the data in a unified format. 
		EXPORT Boca_Base		:= DATASET(PRTE2_Watercraft.Constants.BASE_PREFIX + '::qa::boca', PRTE2_Watercraft.Layouts.Base_new, THOR);
		EXPORT Main					:= DATASET(PRTE2_Watercraft.Constants.BASE_PREFIX + '::qa::main', PRTE2_Watercraft.Layouts.Main, THOR);
		EXPORT Search				:= DATASET(PRTE2_Watercraft.Constants.BASE_PREFIX + '::qa::search', PRTE2_Watercraft.Layouts.Search, THOR);
		EXPORT CoastGuard		:= DATASET(PRTE2_Watercraft.Constants.BASE_PREFIX + '::qa::coastguard', PRTE2_Watercraft.Layouts.CoastGuard, THOR);

	
	/***************************************************
	The following are intermediate datasets that are created for building keys
	****************************************************/

	EXPORT Search_Ph_Supressed_bdid 	:= PROJECT(Search,
																					TRANSFORM(Layouts.Search_Slim,
																						SELF.bdid := LEFT.bdid,
																						SELF := LEFT));
//Used for hull number key	
	EXPORT Search_ded 			:= DEDUP(SORT(Search,state_origin,watercraft_key,sequence_key),state_origin,watercraft_key,sequence_key);
	
	//BDID
	EXPORT df_main_slim		:= PROJECT(Search((UNSIGNED6)bdid<>0),TRANSFORM(PRTE2_Watercraft.Layouts.Search_Slim, SELF.bdid := LEFT.bdid, SELF := LEFT));

END;