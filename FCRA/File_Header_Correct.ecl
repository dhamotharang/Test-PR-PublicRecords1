string_rec := record
		fcra.Layout_Override_Header;
		string14 date_created;
end;

base := dataset('~thor_data400::base::override::fcra::qa::header',string_rec,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);					
					
					
export File_Header_Correct := dedup(base, record);