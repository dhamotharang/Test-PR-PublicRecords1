import ut,lib_stringlib;






Layouts_Hernando.fixed raw2fixed(Files_raw.Hernando.File_In_raw l) := transform

	
	self.Direct_Name_or_Grantor_FromParty   := trim(l.Direct_Name_or_Grantor_FromParty);
	self.Reverse_Name_or_Grantee_ToParty    := trim(l.Reverse_Name_or_Grantee_ToParty);
	self.Instrument_File                    := trim(l.Instrument_File);
	self.Book_Number                        := trim(l.Book_Number);
	self.Page_Number                        := trim(l.Page_Number);
	self.Document_Type                      := trim(l.Document_Type);
	self.Legal_Description                  := trim(l.Legal_Description);
	self.Document_Date                      := trim(l.Document_Date)[1..StringLib.Stringfind(trim(l.Document_Date), '/',2 ) ] + '20'+ trim(l.Document_Date)[StringLib.Stringfind(trim(l.Document_Date), '/',2)+1..];
	self.lf                                 := '';
end;

export File_In_FL_Hernando := project(Files_raw.Hernando.File_In_raw,raw2fixed(LEFT));


