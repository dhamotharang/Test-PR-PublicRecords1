EXPORT Layouts_Hillsborough := module

export document := record
string Identifier  ;
string County_Number ;
string Instrument_Number ;
string Document_Type ;
string Document_Description ;
string Legal_Description_1 ;
string Book_Type ;
string Book_Number ;
string Page_Number ;
string Page; 
string Document_Page_Count ;
string Record_Date ;
string Record_Time ;
string Consideration_Amt ;
end;

export party := record
string Identifier;
string County_Number;
string Instrument_Number;
string Party_Code;
string Party_Type;
string Party_Name;
string eor;
end;

export layout_common := record
  string60 Party_Name;
  string10 Record_Date;
  string11 Instrument_Number;
  string5 Entity_Sequence;
  string1 Book_Type;
  string10 Book_Number;
  string4 Page_Number;
  string4 Document_Page_Count;
  string60 Document_Description;
  string60 Legal_Description_1;
  string25 Legal_Description_2;
  string5 Party_Code;
  string60 Cross_Reference_Name;
  string1 Correction_Flag;
end;

end;
