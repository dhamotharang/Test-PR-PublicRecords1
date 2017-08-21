import lib_stringlib;

Layouts_Marion.name.fixed Convert2fixed(Files_raw.Marion.File_raw_name l) := transform
	self.Case_Number_or_Parcel_ID := l.Case_Number_or_Parcel_ID[1..25];
	self.Legal_1                  := l.Legal_1[1..60];
	self.lf                       := '';
	self                          := l;
end;

dWithFixedname := project(Files_raw.Marion.File_raw_name,Convert2fixed(LEFT));



Layouts_Marion.cfn.fixed Convert2fixedcfn(Files_raw.Marion.File_raw_cfn l) := transform
self.Case_Number_or_Parcel_ID := l.Case_Number_or_Parcel_ID[1..25];
self.Legal_1                  := l.Legal_1[1..60];
self.Clerk_File_Number        := trim(intformat((integer)l.Clerk_File_Number,10,0));
self.lf                       := '';
self                          := l;
end;

dWithFixedcfn := project(Files_raw.Marion.File_raw_cfn,Convert2fixedcfn(LEFT));


combined := dWithFixedname + dWithFixedcfn;

dWith_FileNumber := combined(Clerk_File_Number <> '');

dWithout_FileNumber := combined(Clerk_File_Number = '');



Layouts_Marion.Layout_common blankcfn(dWithout_FileNumber l) := transform
	self.Clerk_File_Number := trim(lib_stringlib.StringLib.StringFilter(lib_stringlib.StringLib.StringtoUpperCase(l.Record_Date + l.Document_Type + l.Book_Number + l.Page_Number + l.Legal_1 + l.Consideration_Amt + l.Case_Number_or_Parcel_ID),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))[1..58];
	self := l;
end;

PrepCFN := project(dWithout_FileNumber,blankcfn(LEFT));
combined_final := PrepCFN + dWith_FileNumber;

export File_In_FL_Marion := combined_final((Party_Name <> '' or Cross_Party_Name <> '') and Clerk_File_Number <> '');



