import _Control, Autokey, MDR, Std, ut;

//populate only updating source for keys
canadianWP := file_CanadianWhitePagesBase(vendor IN ['I7','AX']);

slim_canadianWP := RECORD
  string8 Date_first_reported;
	string8 Date_last_reported;
  string6  date_first_published;			//new in V2
	string6  date_last_published;				//new in V2
	string2  vendor;
  string20 Source_file;   						// growing field. overtime this might need to be updated
	string1	 history_flag;							//new in V2. ['C','H','U'] where C is current, H historical, and U unknown.
	string20 lastname;
  string15 firstname;
  string15 middlename;
  string50 Name;
	string15 nickname;
  string3  generational;
  string4  title;
  string4  professionalsuffix;
  string10 housenumber;
  string3  directional;
  string35 streetname;
  string7  streetsuffix;
  string9  suitenumber;
  string30 suburbancity;
  string30 postalcity;
  string2  province;
  string6  postalcode;
  string2  provincecode;
  string3  County_Code;
  string10 phonenumber;
  string4  phonetypeflag;
  string4  nosolicitation;
  string4  cmacode;
  string10 prim_range;
  string2  predir;
  string28 prim_name;
  string4  addr_suffix;
  string10 unit_desig;
  string8  sec_range;
  string25 p_city_name;
  string2  state;
  string6  zip;
  string2  rec_type;
  string1  language;
  string6  errstat;
	string60 company_name; //instead of business name
  string10 Record_ID;
	string1  Record_Use_Indicator;
	string25 city;
  string6  Pub_Date;
  string10 Latitude;
	string10 Longitude;
	string1  Lat_Long_Level_Applied;
	string6  Book_Number;
	string30 Secondary_Name;
	string4  Room_Number;
	string3  Room_Code;
	string1  Record_Type;
	string6  YPHC_1;
	string6  YPHC_2;	
	string6  YPHC_3;
	string6  YPHC_4;
	string6  YPHC_5;
	string6  YPHC_6;
	string8  SIC_1;
	string8  SIC_2;
	string8  SIC_3;
	string8  SIC_4;
	string1  Bus_Govt_Indicator;
	string1  status_indicator;
	string6  Selected_SIC;
	string6  Franchise_Codes;
	string1  Ad_Size;
	string1  French_Flag;
	string1  Population_Code;
	string1  Individual_Firm_Code;
	string4  Year_of_1st_Appearance_CCYY;
	string6  Date_Added_to_DB_CCYYMM;
	string1  Title_Code;
	string1  Contact_Gender_Code;
	string1  Employee_Size_Code;
	string1  Sales_Volume_Code;
	string1  Industry_Specific_Code;
	string1  Business_Status_Code;
	string10 Key_Code;
	string10 Fax_Phone;
	string1  Office_Size_Code;
	string8  Production_Date_MMDDCCYY;
	string9  ABI_Number;
	string9  Subsidiary_Parent_Number;
	string9  Ultimate_Parent_Number;
	string6  Primary_Sic;
	string6  Secondary_SIC_Code_1;
	string6  Secondary_SIC_Code_2;
	string6  Secondary_SIC_Code_3;
	string6  Secondary_SIC_Code_4;
	string1  Total_Employee_Size_Code;
	string1  Total_Output_Sales_Code;
	string6  Number_of_Employees_Actual;
	string6  Total_No_Employees_Actual;	
	string9  Postal_Mode;
	string9  Postal_Bag_Bundle;	
	string1  Transaction_Code;
    string1  listing_type;
	unsigned6 fdid;
	//Added for CCPA-90
	UNSIGNED4 global_sid;
	UNSIGNED8 record_sid;
	//Added for CCPA-1030
  UNSIGNED6 did := 0;
  INTEGER3  DID_Score := 0;
END;

slim_canadianWP xpand_canadianWP(canadianWP le,integer cntr) :=  TRANSFORM 
	SELF.fdid := cntr + autokey.did_adder(''); 
	self.firstname	 	:= le.fname;
	self.middlename		:= le.mname;
	self.lastname		:= le.lname;
	SELF.record_sid   := 0;
	SELF := le; 
END;

cProject := PROJECT(canadianWP,xpand_canadianWP(LEFT,COUNTER));

//Add Global_SID
addGlobalSID	:= MDR.macGetGlobalSID(cProject, 'CanadianPhones', 'source_file', 'global_sid'); //DF-25404

ut.mac_suppress_by_phonetype(addGlobalSID,phonenumber,state,ph_out1,false);

export file_cwp_with_fdid :=  ph_out1 : PERSIST('per_file_cwp_with_fdid_v2');