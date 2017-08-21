IMPORT prte_csv, PRTE2_LNProperty;

EXPORT Layouts := MODULE

	// EXPORT newBaseLayout := prte_csv.ge_header_base.layout_payload;

	EXPORT Expanded_Main_Header_Layout := prte_csv.ge_header_base.layout_payload;

	
	EXPORT Original_50k_Layout := RECORD
			STRING SSN;
			STRING Fname;
			STRING Mname;
			STRING Lname;
			STRING Lname2;
			STRING Gen;
			STRING HouseNumber;
			STRING Street_Name;
			STRING Str_Suffix;
			STRING Unit;
			STRING UnitNum;
			STRING City;
			STRING State;
			STRING Zip;
	END;
	
END;