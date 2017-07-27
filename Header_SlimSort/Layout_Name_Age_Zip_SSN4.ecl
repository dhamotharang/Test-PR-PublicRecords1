IMPORT header, ut;

h := header.file_headers;

// Overflow indicator is 65535;
// No count exists indicator is 65534, this will
// be present in the age radius counts when they
// do not need to be calculated due to the matching
// age count already being at least 10.
UNSIGNED2 Void := 65534;

export Layout_Name_Age_Zip_SSN4 := RECORD
	h.did;
	h.fname;
	h.mname;
	h.lname;
	h.zip;
	UNSIGNED1 age := 0;
	UNSIGNED2 ssn4 := 0;
	UNSIGNED2 Count_A_Z_S_F_M_L := Void;
	//UNSIGNED2 Count_Ar_Z_S_F_M_L := Void;
	UNSIGNED2 Count_A_Z_S_F_Mi_L := Void;
	//UNSIGNED2 Count_Ar_Z_S_F_Mi_L := Void;
	UNSIGNED2 Count_A_Z_S_Fi_Mi_L := Void;
	//UNSIGNED2 Count_Ar_Z_S_Fi_Mi_L := Void;
	UNSIGNED2 Count_A_Z_S_F_L := Void;
	//UNSIGNED2 Count_Ar_Z_S_F_L := Void;
	UNSIGNED2 Count_A_Z_F_M_L := Void;
	//UNSIGNED2 Count_Ar_Z_F_M_L := Void;
	UNSIGNED2 Count_A_Z_F_Mi_L := Void;
	//UNSIGNED2 Count_Ar_Z_F_Mi_L := Void;
	UNSIGNED2 Count_A_Z_Fi_Mi_L := Void;
	//UNSIGNED2 Count_Ar_Z_Fi_Mi_L := Void;
	UNSIGNED2 Count_A_Z_F_L := Void;
	//UNSIGNED2 Count_Ar_Z_F_L := Void;
	UNSIGNED2 Count_A_S_F_M_L := Void;
	//UNSIGNED2 Count_Ar_S_F_M_L := Void;
	UNSIGNED2 Count_A_S_F_Mi_L := Void;
	//UNSIGNED2 Count_Ar_S_F_Mi_L := Void;
	UNSIGNED2 Count_A_S_Fi_Mi_L := Void;
	//UNSIGNED2 Count_Ar_S_Fi_Mi_L := Void;
	UNSIGNED2 Count_A_S_F_L := Void;
	//UNSIGNED2 Count_Ar_S_F_L := Void;
	UNSIGNED2 Count_Z_S_F_M_L := Void;
	UNSIGNED2 Count_Z_S_F_Mi_L := Void;
	UNSIGNED2 Count_Z_S_Fi_Mi_L := Void;
	UNSIGNED2 Count_Z_S_F_L := Void;
	UNSIGNED2 Count_A_F_M_L := Void;
	//UNSIGNED2 Count_Ar_F_M_L := Void;
	UNSIGNED2 Count_A_F_Mi_L := Void;
	//UNSIGNED2 Count_Ar_F_Mi_L := Void;
	UNSIGNED2 Count_A_F_L := Void;
	//UNSIGNED2 Count_Ar_F_L := Void;
	UNSIGNED2 Count_Z_F_M_L := Void;
	UNSIGNED2 Count_Z_F_Mi_L := Void;
	UNSIGNED2 Count_Z_Fi_Mi_L := Void;
	UNSIGNED2 Count_Z_F_L := Void;
	UNSIGNED2 Count_S_F_M_L := Void;
	UNSIGNED2 Count_S_F_Mi_L := Void;
	UNSIGNED2 Count_S_Fi_Mi_L := Void;
	UNSIGNED2 Count_S_F_L := Void;
END;