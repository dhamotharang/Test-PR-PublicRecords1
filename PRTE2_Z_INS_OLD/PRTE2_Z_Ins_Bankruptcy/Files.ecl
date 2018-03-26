//--------------------------------------------------------------------
// PRTE2_Bankruptcy.Files
// Project on hold.
// CT Bankruptcy are done as part of Alpharetta based simulator CompReport
//--------------------------------------------------------------------

IMPORT PRTE2_Bankruptcy, PRTE2_Common;

EXPORT Files := MODULE
	EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;
	
	EXPORT BASE_NAME							:= 'Bankruptcy';
	SHARED MODULE_SUFFIX					:= '::bankruptcy';
	EXPORT IN_PREFIX_NAME					:= PRTE2_Common.Cross_Module_Files.MASTER_IN_PREFIX+MODULE_SUFFIX;
	EXPORT BASE_PREFIX_NAME				:= PRTE2_Common.Cross_Module_Files.MASTER_BASE_PREFIX+MODULE_SUFFIX;
	EXPORT SPRAYED_PREFIX_NAME		:= PRTE2_Common.Cross_Module_Files.MASTER_SPRAY_PREFIX+MODULE_SUFFIX;
	EXPORT KEY_PREFIX							:= PRTE2_Common.Cross_Module_Files.MASTER_KEY_PREFIX+MODULE_SUFFIX;

	//----------------------------------------------------
	EXPORT FILE_SPRAY_status			:= SPRAYED_PREFIX_NAME + '::' + 'status'   + '_' + ThorLib.Wuid();
	EXPORT FILE_SPRAY_search			:= SPRAYED_PREFIX_NAME + '::' + 'search'   + '_' + ThorLib.Wuid();
	EXPORT FILE_SPRAY_main				:= SPRAYED_PREFIX_NAME + '::' + 'main'     + '_' + ThorLib.Wuid();
	EXPORT FILE_SPRAY_comments		:= SPRAYED_PREFIX_NAME + '::' + 'comments' + '_' + ThorLib.Wuid();	
	
	EXPORT status_DS							:= DATASET(FILE_SPRAY_status, 	Layouts.status, 	CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT comments_DS						:= DATASET(FILE_SPRAY_comments, Layouts.comments, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT main_DS								:= DATASET(FILE_SPRAY_main, 		Layouts.main, 		CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT search_DS							:= DATASET(FILE_SPRAY_search, 	Layouts.search,		CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));

	EXPORT FILE_DESPRAY_status		:= IN_PREFIX_NAME + '::CSV::' + 'status';
	EXPORT FILE_DESPRAY_comments	:= IN_PREFIX_NAME + '::CSV::' + 'comments';
	EXPORT FILE_DESPRAY_main			:= IN_PREFIX_NAME + '::CSV::' + 'main';
	EXPORT FILE_DESPRAY_search		:= IN_PREFIX_NAME + '::CSV::' + 'search';
	//----------------------------------------------------

	EXPORT status_SF							:= BASE_PREFIX_NAME + '::qa::' + 'status';
	EXPORT comments_SF						:= BASE_PREFIX_NAME + '::qa::' + 'comments';
	EXPORT main_SF								:= BASE_PREFIX_NAME + '::qa::' + 'main';
	EXPORT search_SF							:= BASE_PREFIX_NAME + '::qa::' + 'search';

	EXPORT status_SF_DS						:= DATASET(status_SF, 	Layouts.status, 	THOR);
	EXPORT comments_SF_DS					:= DATASET(comments_SF, Layouts.comments, THOR);
	EXPORT main_SF_DS							:= DATASET(main_SF, 		Layouts.main, 		THOR);
	EXPORT search_SF_DS						:= DATASET(search_SF, 	Layouts.search, 	THOR);
	// !!! This SF DS is what the Boca build will need to read and append.

END;