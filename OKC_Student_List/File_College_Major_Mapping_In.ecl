EXPORT File_College_Major_Mapping_In := DATASET(OKC_Student_List.thor_cluster + 'IN::OKC_Student_List::College_Major_Mapping',
																								OKC_Student_List.Layout_College_Major_Mapping_In,
																								CSV(HEADING(1), 
																								SEPARATOR(','),
																								QUOTE('"'),
																								TERMINATOR(['\r\n','\r','\n'])));