// PRTE2_Hunting_Fishing.Files

IMPORT PRTE2_Common;

EXPORT Files := MODULE
	EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;	// a function

	EXPORT BOCA_BASE_NAME					:= 'Boca_HuntFish';
	EXPORT ALPHA_BASE_NAME							:= 'Alpha_HuntFish';
	
	SHARED ModuleName							:= 'hunting_fishing';
	EXPORT IN_PREFIX_NAME					:= '~prct::IN::ct::'+ModuleName;
	EXPORT BASE_PREFIX_NAME				:= '~prct::BASE::ct::'+ModuleName;
	EXPORT SPRAYED_PREFIX_NAME    := '~prct::SPRAYED::ct::'+ModuleName;
	EXPORT KEY_PREFIX 						:= '~prte::key::'+ModuleName+'::';
	EXPORT KEY_PREFIX_FCRA  			:= KEY_PREFIX+'fcra::';
	
	EXPORT FILE_SPRAY							:= SPRAYED_PREFIX_NAME + '::'+ALPHA_BASE_NAME+ '_' + ThorLib.Wuid();
	EXPORT SPRAYED_DS							:= DATASET(FILE_SPRAY, Layouts.AlphaBaseOUT,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

	EXPORT FILE_DESPRAY_CSV				:= IN_PREFIX_NAME + '::CSV::' + ALPHA_BASE_NAME;
	EXPORT HuntFish_Boca_IN(STRING date)	:= IN_PREFIX_NAME + '::'+date+'::' + BOCA_BASE_NAME;

	// This is the full Base SF
	EXPORT HuntFish_Boca_SF			:= BASE_PREFIX_NAME + '::qa::' + BOCA_BASE_NAME;
	EXPORT HuntFish_Boca_SF_DS	:= DATASET(HuntFish_Boca_SF, Layouts.AlphaBaseOUT, THOR);
	EXPORT HuntFish_Alpha_SF			:= BASE_PREFIX_NAME + '::qa::' + ALPHA_BASE_NAME;
	EXPORT HuntFish_Alpha_SF_DS	:= DATASET(HuntFish_Alpha_SF, Layouts.AlphaBaseOUT, THOR);
	// !!! This SF base DS is what the Boca build will need to read and append.

	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)
	EXPORT HuntFish_Alpha_SF_Prod				:= Add_Foreign_prod(HuntFish_Alpha_SF);
	EXPORT HuntFish_Alpha_SF_DS_Prod		:= DATASET(HuntFish_Alpha_SF_Prod, Layouts.AlphaBaseOUT, THOR);
	EXPORT HuntFish_Boca_SF_Prod			:= BASE_PREFIX_NAME + '::qa::' + BOCA_BASE_NAME;
	EXPORT HuntFish_Boca_SF_DS_Prod	:= DATASET(HuntFish_Boca_SF_Prod, Layouts.AlphaBaseOUT, THOR);
	
END;