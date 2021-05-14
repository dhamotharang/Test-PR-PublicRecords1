//Constants

EXPORT Constants := module

Export In_GWL := '~prte::in::globalwatchlists::globalwatchkeylists';

EXPORT Base_GWL := '~prte::base::globalwatchlists::globalwatchkeylists';

EXPORT KeyName_gwl := 	'~prte::key::globalwatchlists::'; 

Export KeyName_patriot := '~prte::key::patriot::';

EXPORT Base_GWL_Tokens := '~prte::base::globalwatchlistsV2';

EXPORT KeyName_Patriot_File := '~prte::key::patriot_file_full_';

Export KeyName_Baddids := '~prte::key::baddids_';

EXPORT KeyName_bdid_File := '~prte::key::patriot_bdid_file_';

EXPORT KeyName_did_file := '~prte::key::patriot_did_file_';

Export KeyName_Annotated := '~prte::key::annotated_names_';

Export KeyName_Baddies:= '~prte::key::patriot::baddies_with_name_';

Export FileName_Scorenames:= '~prte::in::patriot::scorenames';

//Cloud Keys
EXPORT Keyname_Patriot_file_delta 						:= '~prte::key::patriot_file_full::delta_rid_';
EXPORT Keyname_Patriot_baddids_delta 					:= '~prte::key::baddids::delta_rid_';
EXPORT Keyname_Patriot_annotated_names_delta 	:= '~prte::key::annotated_names::delta_rid_';

EXPORT dataset_name_gwl			:= 'GlobalWatchListKeys';
EXPORT dataset_name_gwl2		:= 'GlobalWatchListV2Keys';
EXPORT dataset_name_patriot	:= 'PatriotKeys';

END;