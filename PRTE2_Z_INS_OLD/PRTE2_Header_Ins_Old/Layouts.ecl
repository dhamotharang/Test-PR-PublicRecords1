/* ************************************************************************************
PRTE2_Header_Ins.Files

To imitate what we did in PhonesPlus we should:
a. Files should reference all naming via PRTE2_Common.Cross_Module_Files
b. Layouts should reference all layouts via PRTE_CSV 

NOTE: We only need file info here for 
a) Spray/DeSpray and 
b) Our Base file and 
c) any research/maintenance
************************************************************************************ */

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