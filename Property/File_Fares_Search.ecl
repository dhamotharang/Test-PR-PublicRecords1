//Fares search file concated with Direct Search file
export File_Fares_Search := dataset('~thor_data400::in::fares_search',layout_Fares_Search,flat);

/*export File_Fares_Search := dataset('~thor_data400::base::fares_search_20040608_vendor',layout_Fares_Search,flat) +
							dataset('~thor_data400::in::fares_search_20040715',layout_Fares_Search,flat) +
							dataset('~thor_data400::in::fares_search_20040802',layout_Fares_Search,flat) +
							dataset('~thor_data400::in::fares_search_20040826',layout_Fares_Search,flat) +
							dataset('~thor_data400::in::fares_search_20040927',layout_Fares_Search,flat) +
							dataset('~thor_data400::in::fares_search_20041011',layout_Fares_Search,flat) +
							dataset('~thor_data400::in::fares_search_20041027',layout_Fares_Search,flat) +
							dataset('~thor_data400::in::fares_search_20041129',layout_Fares_Search,flat);*/