// PRTE2_Phonesplus.Files

// WARNING - NEEDS RESEARCH AND WORK...
// in faa.Aircraft_In_Allsrc - I see THREE base files
// HOWEVER - unless it is IMPOSSIBLE, we want to join these into a single spreadsheet coming in.
	// EXPORT AlphaBase := UNKNOWN_LAYOUT;
// PRCT2_Watercraft had to do this as well.	
// If the boca build needs THREE files, we'll have to distribute the fields into three	files
// IF Boca does NOT need three files, we need to emulate what it has as a base file.
// check out faa.layouts and other code there.

IMPORT PRTE2_Common;

EXPORT Files := MODULE

	EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;		// a function
	
	EXPORT BASE_NAME							:= 'FAA';
	EXPORT Engine_NAME						:= 'Engine';	
	EXPORT Master_NAME						:= 'Master';
	EXPORT Acft_NAME							:= 'ACFT';
	
	SHARED ModuleName							:= 'faa';
	EXPORT IN_PREFIX_NAME					:= '~prct::IN::ct::'+ModuleName;
	EXPORT BASE_PREFIX_NAME				:= '~prct::BASE::ct::'+ModuleName;
	EXPORT SPRAYED_PREFIX_NAME    := '~prct::SPRAYED::ct::'+ModuleName;
	EXPORT KEY_PREFIX 						:= '~prte::key::'+ModuleName;
	
//Raw Sprayed File:
	EXPORT engine := 'engine';
	EXPORT master := 'master';
	EXPORT acft 	:= 'acft';
	
	EXPORT FILE_SPRAY(STRING FileName)			:= SPRAYED_PREFIX_NAME + '::'+ FileName + '_' + ThorLib.Wuid();
	EXPORT SPRAY_ENGINE_DS := DATASET(FILE_SPRAY(engine), Layouts.AlphaBase_Engine, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT SPRAY_MASTER_DS := DATASET(FILE_SPRAY(master), Layouts.AlphaBase_Master, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT SPRAY_ACFT_DS := DATASET(FILE_SPRAY(acft), Layouts.AlphaBase_ACFT, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	
	
	// EXPORT FILE_SPRAY_PATH				:= SPRAYED_PREFIX_NAME + '::';
	// EXPORT SPRAYED_DS							:= DATASET(FILE_SPRAY, Layouts.AlphaBase,
	                                   // CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

	// This is the full Base SF if we can at all join the three records into one spreadsheet.
	EXPORT FAA_Base_SF			:= BASE_PREFIX_NAME + '::qa::' + BASE_NAME;
	EXPORT FAA_Base_SF_DS	:= DATASET(FAA_Base_SF, Layouts.AlphaBase, THOR);
	
	// !!! This SF base DS is what the Boca build will need to read and append.
	EXPORT FAA_Master_Base_SF			:= BASE_PREFIX_NAME + '::qa::' + Master_NAME;
	EXPORT FAA_Master_Base_SF_DS	:= DATASET(FAA_Master_Base_SF, Layouts.AlphaBase_Master, THOR);
	
	EXPORT FAA_Engine_Base_SF			:= BASE_PREFIX_NAME + '::qa::' + Engine_NAME;
	EXPORT FAA_Engine_Base_SF_DS	:= DATASET(FAA_Engine_Base_SF, Layouts.AlphaBase_Engine, THOR);
	
	EXPORT FAA_ACFT_Base_SF			  := BASE_PREFIX_NAME + '::qa::' + Acft_NAME;
	EXPORT FAA_ACFT_Base_SF_DS	  := DATASET(FAA_ACFT_Base_SF, Layouts.AlphaBase_ACFT, THOR);

	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)
	EXPORT FAA_Base_SF_Prod			   	    := Add_Foreign_prod(FAA_Base_SF);
	EXPORT FAA_Base_SF_DS_Prod		      := DATASET(FAA_Base_SF_Prod, Layouts.AlphaBase, THOR);
	
	EXPORT FAA_Master_Base_SF_Prod			:= Add_Foreign_prod(FAA_Master_Base_SF);
	EXPORT FAA_Master_Base_SF_DS_Prod		:= DATASET(FAA_Master_Base_SF_Prod, Layouts.AlphaBase_Master, THOR);
	
	EXPORT FAA_Engine_Base_SF_Prod			:= Add_Foreign_prod(FAA_Engine_Base_SF);
	EXPORT FAA_Engine_Base_SF_DS_Prod		:= DATASET(FAA_Engine_Base_SF_Prod, Layouts.AlphaBase_Engine, THOR);
	
	EXPORT FAA_ACFT_Base_SF_Prod				:= Add_Foreign_prod(FAA_ACFT_Base_SF);
	EXPORT FAA_ACFT_Base_SF_DS_Prod		  := DATASET(FAA_ACFT_Base_SF_Prod, Layouts.AlphaBase_ACFT, THOR);
	
END;