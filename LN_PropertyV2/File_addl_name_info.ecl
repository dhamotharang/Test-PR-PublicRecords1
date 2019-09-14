IMPORT LN_PropertyV2_Fast;
EXPORT File_addl_name_info := dataset(
																	 LN_PropertyV2_Fast.filenames.baseFull.addl_name_info
																	,LN_PropertyV2.layout_addl_name_info
																	,flat);