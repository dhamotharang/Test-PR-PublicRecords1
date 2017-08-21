EXPORT Layouts_Martin := module

export raw := record
  string Party_Name;
  string Cross_Party_Name;
  string File_Number;
  string Book;
  string Page;
  string Document_Type;
  string Legal_1;
  string Party_Code;
  string Page_Count;
  string Filler;
  string Recorded_Date;
  string Name;
  string filler1;
  string filler2;
  string Correction_Flag;
end;

export fixed :=  record
  string65 Party_Name;
  string65 Cross_Party_Name;
  string7 File_Number;
  string4 Book;
  string4 Page;
  string4 Document_Type;
  string60 Legal_1;
  string1 Party_Code;
  string4 Page_Count;
  string25 Legal_2;
  string19 Recorded_Date;
  string60 Name;
  string1 Correction_Flag;
end;

end;