export Layout_OH_Adam := 
module

export crim := record
  string Case_Number;
  string Defendant;
  string Street;
  string City_State_Zip;
  string Birth_Date;
  string Section_Number;
  string Description;
  string Degree;
  string Filed_Date;
  string Sentencing_Date;
  string Sentencing_Info;
end;

export lexis := record
  string Case_Number;
  string Filed_Date;
  string Defendant;
  string DOB;
  string Section;
  string Description;
  string Dispo_Date;
  string Plea;
  string Found;
  string Fine_Amt;
  string Fine_Susp;
  string Costs;
  string Jail_Days;
  string Jail_Susp;
  string Jail_Credit;
  string OL_Susp_From;
  string OL_Susp_To;
  string Notes;
end;

end;