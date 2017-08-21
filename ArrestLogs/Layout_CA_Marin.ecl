export Layout_CA_Marin:= module


export payload := 
record
string unparsedRec;
end;

export old_layout:= 
record 
string ID;
string Name;
string Book_Dt;
string Address;
string Arrest_Dt;
string Sex;
string Arrest_Agency;
string age;
string Charge_Num;
string Charge_Desc;
string Code;
string Bond;
string Court_Dt;
string Court_Time;
string Room;
string Case_Num;
string Case_Type;
end;



export new_layout := 
record 
string  ID;
string  Name;
string  Book_Dt;
string  Address;
string  Latest_Charge_Dt;
string  Sex;
string  Arrest_Dt;
string  DOB;
string  Arrest_Agency;
string  Occupation;
string  Arrest_Location;
string  Height;
string  Hair;
string  Weight;
string  Eyes;
string  Charge_Num;
string  Charge_Desc;
string  Code;
string  Bond;
string  Court_Dt;
string  Court_Time;
string  Room;
string  Case_Num;
string  Case_Type;


end;


export combined_layout := 
record 
string  ID;
string  Name;
string  Book_Dt;
string  Address;
string  Latest_Charge_Dt;
string  Sex;
string  Arrest_Dt;
string  DOB;
string  age;
string  Arrest_Agency;
string  Occupation;
string  Arrest_Location;
string  Height;
string  Hair;
string  Weight;
string  Eyes;
string  Charge_Num;
string  Charge_Desc;
string  Code;
string  Bond;
string  Court_Dt;
string  Court_Time;
string  Room;
string  Case_Num;
string	filler;
string  Case_Type;

end;

end;
