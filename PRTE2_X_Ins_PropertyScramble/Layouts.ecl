IMPORT PRTE2_Common;

EXPORT Layouts := MODULE
// Max size study.
// St: 35 and city: 20 and fname: 16 and mname: 13 and lname: 20
/* **************** NOTES: *********************
is_custom=Y - custom test cases where the data is found in production (Mark Marsupial)
is_property=Y - this equals Not a POBox address
is_condo - probably should have named this is_condoOrApt
    =Y - this appears to be a condo or apt type address
    ='' - this is assumed to be a house type address
********************************************** */

	SHARED Layout_Name := RECORD
			STRING20	fname;			// Max was 16
			STRING20	mname;			// Max was 13
			STRING30	lname;			// Max was 20
	END;
	SHARED Layout_Address := RECORD
			STRING40	street;			// Max was 35
			STRING10	apt;
			STRING30	city;				// Max was 20
			STRING2		state;
			STRING10	zip;
	END;
	SHARED Layout_SisterAddress := RECORD
			STRING40	mapped_street;
			STRING10	mapped_apt;
			STRING30	mapped_city;
			STRING2		mapped_state;
			STRING10	mapped_zip;
	END;
	
	EXPORT Layout_XRef_Left_v1 := RECORD
			Layout_Name;
			Layout_Address;
	END;

	EXPORT Layout_XRef_Left_v2 := RECORD
			Layout_Name;
			Layout_Address;
			STRING1	is_custom_prod;			// Custom records that are expected to pull production property data (Marsupials)
			STRING1 is_property;
	END;
	EXPORT Layout_XRef_Left := RECORD
			Layout_Name;
			Layout_Address;
			STRING1	is_custom_prod;			// Custom records that are expected to pull production property data (Marsupials)
			STRING1 is_property;
			STRING1 is_condo;
	END;
	
	EXPORT Layout_Clean_Addr := RECORD
				STRING  prim_range;
				STRING  predir;
				STRING  prim_name;
				STRING  addr_suffix;
				STRING  postdir;
				STRING  unit_desig;
				STRING  sec_range;
				STRING  p_city_name;
				STRING	v_city_name;
				STRING  st;
				STRING	zip5;
				STRING	zip4;
				STRING  Clean_streetaddr1;
				STRING	Clean_CityStZip;
	END;
	EXPORT Mapped_Clean_Addr := RECORD
				STRING  map_prim_range;
				STRING  map_predir;
				STRING  map_prim_name;
				STRING  map_addr_suffix;
				STRING  map_postdir;
				STRING  map_unit_desig;
				STRING  map_sec_range;
				STRING  map_p_city_name;
				STRING	map_v_city_name;
				STRING  map_st;
				STRING	map_zip5;
				STRING	map_zip4;
				STRING  map_Clean_streetaddr1;
				STRING	map_Clean_CityStZip;
  END;
	EXPORT Temp_Clean_Addr := RECORD
				STRING  tmp_prim_range;
				STRING  tmp_predir;
				STRING  tmp_prim_name;
				STRING  tmp_addr_suffix;
				STRING  tmp_postdir;
				STRING  tmp_unit_desig;
				STRING  tmp_sec_range;
				STRING  tmp_p_city_name;
				STRING	tmp_v_city_name;
				STRING  tmp_st;
				STRING	tmp_zip5;
				STRING	tmp_zip4;
				STRING  tmp_Clean_streetaddr1;
				STRING	tmp_Clean_CityStZip;
	END;
	
	EXPORT Layout_XRef_Enhanced_LeftV1 := RECORD
			UNSIGNED4	RECNUM;
			Layout_XRef_Left;
			STRING9	SSN :='';
			STRING8	DOB :='';
			Layout_Clean_Addr;
	END;
	EXPORT Layout_XRef_Enhanced_Left := RECORD
			UNSIGNED4	RECNUM;
			unsigned6 LexID;
			Layout_XRef_Left;
			STRING9	SSN :='';
			STRING8	DOB :='';
			Layout_Clean_Addr;
	END;
	EXPORT Layout_XRef_Enhanced_Left_CNTRS := RECORD
			UNSIGNED4	RECNUM;
			UNSIGNED4 XRecnum;
			unsigned6 LexID;
			Layout_XRef_Left;
			STRING9	SSN :='';
			STRING8	DOB :='';
			Layout_Clean_Addr;
	END;

	EXPORT Layout_Base_XRef := RECORD
			Layout_XRef_Left;
			Layout_SisterAddress;
	END;

	EXPORT Layout_Base_XRef_EnhancedV1 := RECORD
			Layout_XRef_Enhanced_LeftV1;
			Layout_SisterAddress;
	END;
	EXPORT Layout_Base_XRef_Enhanced := RECORD
			Layout_XRef_Enhanced_Left;
			Layout_SisterAddress;
	END;

	EXPORT Layout_Enhanced_with_Counters := RECORD
			Layout_XRef_Enhanced_Left_CNTRS;
			Layout_SisterAddress;
			Mapped_Clean_Addr;
	END;

	EXPORT Layout_BatchGateway := RECORD
			Layout_Name;
			STRING9		SSN :='';
			STRING8		DOB :='';
			Layout_Address;
	END;

	EXPORT Layout_NameAddr_XRef := RECORD
			UNSIGNED4	RECNUM;
			Layout_XRef_Left;
			Layout_SisterAddress;
	END;

	EXPORT Layout_AddrAddr_XRef := RECORD
			UNSIGNED4	RECNUM;
			Layout_Address;
			STRING1 is_property;
			STRING1 is_condo;
			Layout_SisterAddress;
	END;
	
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