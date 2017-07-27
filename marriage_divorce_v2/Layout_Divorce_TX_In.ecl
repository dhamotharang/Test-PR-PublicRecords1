export Layout_Divorce_TX_In := 
	
record
  string8 	File_Number;
  string32  Husbands_Name;
  string8 	Husbands_Age;
  string32 	Wifes_Name;
  string8 	Wifes_Age;
  string8 	Number_of_Children_Under_18;
  string16	Marriage_Date;
  string16 	Divorce_Date;
  string8 	County_Code_Where_Divorce_Occurred;
  string16 	County_Name_Where_Divorce_Occurred;
  string2 	lf;
end;

