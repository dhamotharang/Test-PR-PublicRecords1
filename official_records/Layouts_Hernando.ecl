EXPORT Layouts_Hernando := module

export raw := record
  string Direct_Name_or_Grantor_FromParty;
  string Reverse_Name_or_Grantee_ToParty;
  string Instrument_File;
  string Book_Number;
  string Page_Number;
  string Document_Type;
  string Legal_Description;
  string Document_Date;
end;

export fixed := record
   string80 Direct_Name_or_Grantor_FromParty;
   string80 Reverse_Name_or_Grantee_ToParty;
   string10 Instrument_File;
   string4 Book_Number;
   string4 Page_Number;
   string60 Document_Type;
   string290 Legal_Description;
   string30 Document_Date;
   string1 lf;
end;

end;