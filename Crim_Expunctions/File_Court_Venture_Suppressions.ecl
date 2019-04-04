import data_services;
export File_Court_Venture_Suppressions := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::court_ventures::expunctions'
													,Crim_Expunctions.Layout_Court_Venture_Suppressions.clean,csv(terminator('\r\n'), separator('\t'), quote('')));
													
													
