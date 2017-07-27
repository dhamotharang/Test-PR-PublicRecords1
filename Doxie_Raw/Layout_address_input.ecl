//===========================================================
//Layout of address input for Doxie.HeaderSource_Service.
//===========================================================

export Layout_address_input := RECORD
    string10  prim_range := '';
    string2   predir := '';
    string28  prim_name := '';
    string4   suffix := ''; 
    string2   postdir := '';
    string8   sec_range := '';
    string25  city_name := '';
    string2   st := '';
    string5   zip := '';
    string4   zip4 := '';
		string50  streetAddr1 := '';
		string50  streetAddr2 := '';
END;