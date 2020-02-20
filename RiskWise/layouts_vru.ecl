import Risk_Indicators, dx_header;

EXPORT layouts_vru := MODULE

  //numerical input
  EXPORT layout_VRU := RECORD
    string9  socs;
    string2  yob;
    string5  housenum;
    string10 hphone;
    string5  zip5;
  END;


  //main person layout; generally, did + appropriate address
  EXPORT layout_person := RECORD
    unsigned6 did := 0;
    unsigned6 hhid := 0;
    string9   ssn;
    integer4  dob;
	  string10  phone;

    unsigned3 dt_first_seen;
    unsigned3 dt_last_seen;
    qstring20 fname;
    qstring20 mname;
    qstring20 lname;
  
    string2   predir;
    qstring28 prim_name;
    string5   prim_range;
    qstring4  suffix;
    string2   postdir;
    qstring10 unit_desig;
    qstring8  sec_range;
    qstring25 city_name;
    string2   st;
    string5   zip;
    qstring4  zip4;
  END;

	//all input parameters; dataset with this layout always has exactly one record
  EXPORT layout_input := RECORD
    layout_VRU;

    string15 first;
		string20 middle;
    string20 last;
		string5  suffix;
    string50 addr;
    string30 city;
    string2  state;
    string9  zip;
		string8  dob;

    boolean AlphaNumericInput;
		string60 neutralIP;
  END;

  EXPORT layout_verified := RECORD  //formal definition
    layout_VRU;
  END;

  EXPORT layout_output := RECORD
    unsigned1 VRU_code := 0;
    string64  VRU_message:= '';
    DATASET (layout_verified) verified {MAXCOUNT(1)};
    DATASET (layout_person)   id       := DATASET ([], layout_person);// {MAXCOUNT(1)};
    DATASET (layout_input)    input    := DATASET ([], layout_input);// {MAXCOUNT(1)};
    STRING13 CID := ''; //correction record id
		integer seq := 0;
  END;
	
	EXPORT layout_data_service_output := RECORD
		layout_output;
		Risk_Indicators.Layout_ConsumerFlags cflags;
	END;
	

// if you add fields to this layout, also add the same fields to FCRA.Layout_Override_Header
	EXPORT Layout_Header_Data := RECORD
		dx_header.layout_key_header;
		Risk_Indicators.Layouts.Layout_Addr_Flags2 Addr_Flags;
		string2 high_risk_address_source;
		string50 high_risk_address_description; 
	END;

END;
