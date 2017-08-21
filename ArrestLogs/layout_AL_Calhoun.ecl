export layout_AL_Calhoun := module

export payload := 
record
string unparsedRec;
end;


export parsed_LFM_name := 
record
string ID;
string Last_Name;
string First_Name;
string Middle_Name;
string Booking_Dt;
string Charge_Descr;
end;

export unparsed_LFM_name := 
record
string ID;
string Name;
string Booking_Dt;
string Charge_Descr;
end;

end;