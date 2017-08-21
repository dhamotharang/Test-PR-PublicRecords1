export Layout_CA_Fresno := module

export payload := 
record
string unparsedRec;
end;

export lfield_bail_out := 
record
string ID;
string Book_Num;
string Name;
string DOB;
string Sex;
string Race;
string Hair;
string Eyes;
string Height;
string Weight;
string Age;
string Arrest_Dt;
string Arrest_Time;
string Arrest_Agency;
string Book_Dt;
string Book_Time;
string Housing_Facility;
string Floor;
string Cell;
string Charges;
string Description;
string Bail_Amount;
string Holding_Agency;
string Case_Num;
string Level;
string Court;
string Bail_Out;

end;

export lfield_release_date := 
record
lfield_bail_out;
string Sentence_Date; 
string Sentence_Days; 
string Release_Date; 
end;

export lfield_remove_date := 
record
string ID;
string Book_Num;
string Name;
string DOB;
string Sex;
string Race;
string Age;
string Hair;
string Eyes;
string Height;
string Weight;
string Arrest_Dt;
string Arrest_Time;
string Arrest_Agency;
string Book_Dt;
string Book_Time;
string Housing_Facility;
string Floor;
string Cell;
string Charges;
string Description;
string Bail_Amount;
string Holding_Agency;
string Case_Num;
string Level;
string Court;
string Bail_Out;
string Sentence_Date; 
string Sentence_Days; 
string Release_Date; 
string Hold_Type; 
string Start_Date; 
string Remove_Date;
end;

end;
