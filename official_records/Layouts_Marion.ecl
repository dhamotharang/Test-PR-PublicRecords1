EXPORT Layouts_Marion := module

export name := module

export raw := record
  string Party_Name;
  string Direct_Reverse;
  string Cross_Party_Name;
  string Record_Date;
  string Document_Type;
  string Book_Number;
  string Page_Number;
  string Legal_1;
  string Clerk_File_Number;
  string Consideration_Amt;
  string Case_Number_or_Parcel_ID;
end;

export fixed := record
  string25 Clerk_File_Number;
  string60 Party_Name;
  string1 Direct_Reverse;
  string60 Cross_Party_Name;
  string26 Record_Date;
  string10 Document_Type;
  string8 Book_Number;
  string6 Page_Number;
  string60 Legal_1;
  string35 Consideration_Amt;
  string25 Case_Number_or_Parcel_ID;
  string1 lf;
end;

end;

export cfn := module
 
 export raw := record
  string Clerk_File_Number;
  string Party_Name;
  string Direct_Reverse;
  string Cross_Party_Name;
  string Record_Date;
  string Document_Type;
  string Book_Number;
  string Page_Number;
  string Legal_1;
  string Consideration_Amt;
  string Case_Number_or_Parcel_ID;
end;

export fixed := record
  string25 Clerk_File_Number;
  string60 Party_Name;
  string1 Direct_Reverse;
  string60 Cross_Party_Name;
  string26 Record_Date;
  string10 Document_Type;
  string8 Book_Number;
  string6 Page_Number;
  string60 Legal_1;
  string35 Consideration_Amt;
  string25 Case_Number_or_Parcel_ID;
  string1 lf;
end;
end;

export Layout_common :=  record
  string25 Clerk_File_Number;
  string60 Party_Name;
  string1 Direct_Reverse;
  string60 Cross_Party_Name;
  string26 Record_Date;
  string10 Document_Type;
  string8 Book_Number;
  string6 Page_Number;
  string60 Legal_1;
  string35 Consideration_Amt;
  string25 Case_Number_or_Parcel_ID;
  string1 lf;
end;

end;

