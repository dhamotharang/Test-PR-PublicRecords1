

base := dataset('~thor_data400::base::override::fcra::qa::header',FCRA.Layout_Override_Header_In,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);					
					

					
export File_Header_Correct := dedup(base, record);