EXPORT Layouts_Citrus := module

export master := module

export raw := record
  string Type_Class_Update_action;
  string County_Number;
  string Instrument_Number;
  string Document_Type;
  string Document_Desc;
  string Legal_Desc;
  string Book_Type;
  string Book;
  string Page;
  string filler;
  string Number_Pages;
  string File_Date;
  string File_Time;
  string lf;
end;

export fixed := record
   string8 process_date;
   string5 Type_Class_Update_action;
   string5 County_Number;
   string20 Instrument_Number;
   string20 Document_Type;
   string150 Document_Desc;
   string185 Legal_Desc;
   string40 Book_Type;
   string8 Book;
   string8 Page;
   string3 Page_Suffix;
   string8 Number_Pages;
   string12 File_Date;
   string10 File_Time;
   string256 County_Info;
   string2 lf;
end;

end;

export party := module

export raw := record
  string Type_Class_Update_Action;
  string County_Number;
  string Instrument_Number;
  string Party_ID;
  string Party_Type;
  string Name;
  string lf;
end;

export fixed :=  record
   string8 process_date;
   string5 Type_Class_Update_Action;
   string5 County_Number;
   string20 Instrument_Number;
   string20 Party_ID;
   string5 Party_Type;
   string150 Name;
   string1 lf;
end;

end;

export Layout_all := record
  string5 Type_Class_Update_action;
  string5 County_Number;
  string20 Instrument_Number;
  string20 Document_Type;
  string150 Document_Desc;
  string185 Legal_Desc;
  string40 Book_Type;
  string8 Book;
  string8 Page;
  string3 Page_Suffix;
  string8 Number_Pages;
  string12 File_Date;
  string10 File_Time;
  string256 County_Info;
  string20 Party_ID;
  string5 Party_Type;
  string150 Name;
end;

end;