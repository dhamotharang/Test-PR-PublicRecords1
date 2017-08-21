//The file type of this dataset is changed to THOR
EXPORT file_college_metadata_lkp := DATASET(American_student_list.Thor_Cluster + 'lookup::american_student_list::college_metadata', 
                                            American_student_list.layout_college_metadata_lkp, 
																						THOR);

//EXPORT file_college_metadata_lkp := DATASET('~thor_data400::lookup::american_student_list::college_metadata', layout_college_metadata_lkp, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')));
