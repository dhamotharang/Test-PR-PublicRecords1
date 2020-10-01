

base := dataset('~thor_data400::in::override::fcra::20201001020006::header',FCRA.Layout_Override_Header_In,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);					
					
rHeaderKeyLayout := record
	FCRA.Layout_Override_Header;
	string14 date_created;
end;

rHeaderKeyLayout xConvertToHeaderLayout(base l) := transform
	self.head.global_sid := 0;
	self.head.record_sid := 0;
	self := l;
end;

dConvertToHeaderLayout := project(base, xConvertToHeaderLayout(left));
					
export File_Header_Correct := dedup(dConvertToHeaderLayout, record);