import lib_stringlib;

trimheader := Files_raw.Martin.File_in_raw(trim(Book) <> 'book');

Layouts_Martin.fixed Convert2fixed(trimheader l) := transform
	self.Legal_2            := '';
  self.Correction_Flag    := '';
  self.Legal_1            := trim(lib_stringlib.StringLib.StringFilterOut(l.Legal_1[1..60],'\''));
  self.Document_Type      := lib_stringlib.StringLib.StringFilterOut(trim(l.Document_Type),'V1');
	self.Party_Name         := trim(l.Party_Name) [ 1..80];
	self.Cross_Party_Name   := trim(l.Cross_Party_Name) [ 1..80];
  self                    := l;
  end;
  
export File_In_FL_Martin := project(trimheader,Convert2fixed(LEFT));
  

