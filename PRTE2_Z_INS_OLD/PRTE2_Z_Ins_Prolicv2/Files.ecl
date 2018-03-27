IMPORT PRTE2_Common, PRTE2_Prolicv2;
Constants := PRTE2_Prolicv2.Constants;
Layouts   := PRTE2_Prolicv2.Layouts;

EXPORT Files := MODULE
	EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;	
	
	EXPORT ALPHA_BASE_NAME				:= 'Alpha_Prolicv2';
	
	SHARED ModuleName							:= 'Prolicv2';
	EXPORT IN_PREFIX_NAME					:= '~prct::IN::ct::'+ModuleName;
	EXPORT BASE_PREFIX_NAME				:= '~prct::BASE::ct::'+ModuleName;
	EXPORT SPRAYED_PREFIX_NAME    := '~prct::SPRAYED::ct::'+ModuleName;
	EXPORT KEY_PREFIX 						:= '~prte::key::'+ModuleName+'::';
	// EXPORT KEY_PREFIX_FCRA 				:= KEY_PREFIX+'fcra::';
	
  // Raw Sprayed File:	
	EXPORT FILE_SPRAY							:= SPRAYED_PREFIX_NAME + '::'+ALPHA_BASE_NAME+ '_' + ThorLib.Wuid();
	EXPORT SPRAYED_DS							:= DATASET(FILE_SPRAY, Layouts.AlphaBaseOUT,  
	                                   // CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"'), MAXLENGTH(Constants.CSVMaxCount)));
  // Despray File:
	EXPORT FILE_DESPRAY_CSV				:= IN_PREFIX_NAME + '::CSV::' + ALPHA_BASE_NAME;

	// This is the full Base SF
	EXPORT Prolicv2_Alpha_SF			:= BASE_PREFIX_NAME + '::qa::' + ALPHA_BASE_NAME;
	EXPORT Prolicv2_Alpha_SF_DS	  := DATASET(Prolicv2_Alpha_SF, Layouts.AlphaBaseOUT, THOR);  
	// !!! This SF base DS is what the Boca build will need to read and append.

	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)	
	EXPORT Prolicv2_Alpha_SF_Prod		  := Add_Foreign_prod(Prolicv2_Alpha_SF);
	EXPORT Prolicv2_Alpha_SF_DS_Prod	:= DATASET(Prolicv2_Alpha_SF_Prod, Layouts.AlphaBaseOUT, THOR);

  // Temp Boca PRTE Dataset will be added
	
END;