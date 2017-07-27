export WorldCheckKeys := macro
	output(choosen(WorldCheck.Key_WorldCheck_In,10));
	output(choosen(WorldCheck.Key_WorldCheck_key,10));
	output(choosen(DATASET('~thor_data400::base::WorldCheck::QA::Tokens',GlobalWatchLists.Layout_SearchFile,flat),10));
	output(choosen(WorldCheck.Key_WorldCheck_Version,10));
	output(choosen(WorldCheck.Key_WorldCheck_ext_sources,10));
	output(choosen(WorldCheck.Key_WorldCheck_main,10));
endmacro;