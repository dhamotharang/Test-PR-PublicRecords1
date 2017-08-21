export Layout_TX_Denton := module

export old_format := record

string ID;
string Name;
string Alias;
string Arrest_Agency;
string Dt_Confined;
string Dt_Released;
string Address;
string City;
string State;
string Zipcode;
string Race;
string Sex;
string Height;
string Weight;
string DOB;
string Hair;
string Eyes;
string DL_Num;
string SO_Num;
string Cause;
string Charge;
string Issuing_Authority;
string Disposition;
string Bond;
string Bond_Type;
string Fine;

end;

export new_format := record

string ID;
string Name;
string Alias;
string Arrest_Agency;
string Dt_Confined;
string Dt_Released;
string Address;
string City;
string State;
string Zipcode;
string Race;
string Sex;
string Height;
string Weight;
string DOB;
string Hair;
string Eyes;
string DL_Num;
string SO_Num;
string Cause;
string Charge;
string Issuing_Authority;
string Disposition;
string Bond;
string Bond_Type;
string Fine;
string Photo;

end;

end;