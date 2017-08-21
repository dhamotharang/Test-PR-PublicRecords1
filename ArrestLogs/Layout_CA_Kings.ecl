export Layout_CA_Kings := module


export payload := 
record
string unparsedRec;
end;

export old_layout:= 
record 
string ID;
string Book_Dt;
string Book_Time;
string Inmate_ID;
string Arrest_Dt;
string Arrest_Time;
string Arrest_Location;
string Release_Dt;
string Release_Time;
string Jail_Facility;
string Arresting_Agency;
string StateID;
string Name;
string DOB;
string Sex;
string Resident_City;
string Resident_State;
string Race;
string Height;
string Weight;
string Hair;
string Eyes;
string Occupation;
string Book_Num;
string Code_Book_ID;
string Code_Num;
string Alpha_Charge_Desc;
string Crime_Type;
string Bail_Amount;

end;


export old_layout_1 := 
record 
string ID;	
string Book_Dt;	
string Book_Time;	
string Inmate_ID;	
string Arrest_Dt;	
string Arrest_Time;	
string Arrest_Location;	
string Release_Dt;	
string Release_Time;	
string Jail_Facility;	
string Arresting_Agency;	
string Name;	
string DOB;	
string Sex;
string Resident_City;
string Resident_State;
string Race;
string Height;
string Weight;
string Hair;
string Eyes;
string Occupation;
string Book_Num;
string Code_Book_ID;
string Code_Num;
string Alpha_Charge_Desc;
string Crime_Type;
string Bail_Amount;
end;

export combined_layout := 
record 
string ID;
string Book_Dt;
string Book_Time;
string Inmate_ID;
string Arrest_Dt;
string Arrest_Time;
string Arrest_Location;
string Release_Dt;
string Release_Time;
string Jail_Facility;
string Arresting_Agency;
string StateID;
string Name;
string DOB;
string Sex;
string Birth_City;
string Birth_State;
string Resident_City;
string Resident_State;
string Race;
string Height;
string Weight;
string Hair;
string Eyes;
string Occupation;
string Book_Num;
string Code_Book_ID;
string Code_Num;
string Alpha_Charge_Desc;
string Crime_Type;
string Bail_Amount;

end;
end;

