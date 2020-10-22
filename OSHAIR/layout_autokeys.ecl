IMPORT standard; 

// slimmed down version of OSHAIR.layout_OSHAIR_inspection_clean
EXPORT layout_autokeys := RECORD
  big_endian unsigned4 Activity_Number;
  big_endian unsigned4 Last_Activity_Date;

  big_endian unsigned4 Previous_Activity_Number;
  // string1              Previous_Activity_Type;
  // string31             Prev_Activity_Type_Desc := ''; // Derived

  // string30             Inspected_Site_Name; // Searchable
  // string30             Inspected_Site_Street;
  // string2              Inspected_Site_State;
  // decimal5             Inspected_Site_Zip;
  // big_endian unsigned2 Inspected_Site_City_Code;
  // string30             Inspected_Site_City_Name := ''; // Derived
  // decimal3             Inspected_Site_County_Code;
  // string20             Inspected_Site_County_Name := ''; // Derived

  // big_endian unsigned4 DUNS_Number;
  // string17             Host_Establishment_key;

  // string1              Owner_Type;
  // string18             Own_Type_Desc := ''; // Derived

  // big_endian unsigned2 SIC_Code;
  // big_endian unsigned2 SIC_Guide;
  // string6              NAICS_Code;
  // string6              NAICS_Secondary_Code;
  // string6              NAIC_Inspected;

  // cleaned and appended fields
  string30             cname;
  unsigned6	           bdid := 0;
  unsigned2            BDID_score := 0;
  string9              FEIN_append  := '';
  standard.L_Address.base addr;
	//Added for Cloud Project ~ DF-28288
	unsigned8 record_sid := 0;
  unsigned4 global_sid := 0;
  unsigned4 dt_effective_first := 0;
  unsigned4 dt_effective_last := 0;
  unsigned1 delta_ind := 0; // 0 - main record, 1 - incremental  
END;
