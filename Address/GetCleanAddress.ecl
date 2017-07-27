IMPORT doxie;


EXPORT GetCleanAddress (string addr_first_line, string addr_second_line, unsigned1 region, boolean useGlobal = false) := MODULE
	
//************ For fixing issue with st Vs Saint and Address line1 suffix Bug 40030 

  // E216 - when the address cleaner cannot uniquely identify the ZIP associated with city name provided 
  // it doesn't standardize the City name. For example ST is not standardized to SAINT.
  // E423 = "suffix needed, input is wrong or missing". In some cases AddressCleaner can
  // mistaken part of the street name for the suffix (#40030). We are going to implement this in autokey fetch. 

	// shared US_Clean_1:=Address.CleanAddress182 (addr_first_line, addr_second_line);
	// shared Error_Code:=US_Clean_1[179..182];
	
	// Checking to see if error code is E216, only in this case we want to standardize the city name from ST to SAINT.
	// For any other error code we do not want to touch the city name.

	// shared Standard_addr_second_line:=if(Error_Code='E216',
							// Address.SpecialCaseHandler.StandardizeCityName(addr_second_line),
							// addr_second_line);
	// shared US_Clean_2:=doxie.cleanaddress182(addr_first_line,Standard_addr_second_line);
	// shared US:=if(Error_Code='E216' , US_Clean_2,US_Clean_1);
	shared US := Address.CleanAddress182 (addr_first_line, addr_second_line);
	shared CA := Address.CleanCanadaAddress109 (addr_first_line, addr_second_line);
  
	shared cleaned := 
		MAP(
			region = address.Components.Country.US => US,
      region = address.Components.Country.CA => CA,
      ''
		);
	
  export str_addr := 
		if(
			useGlobal,
			GLOBAL (cleaned, OPT),
			cleaned
		);

  clean_addr := MODULE (Address.ICleanAddress)
    export string prim_range 	:= str_addr [1..10];
    export string predir     	:= str_addr [11..12];
    export string prim_name  	:= str_addr [13..40];
    export string suffix     	:= str_addr [41..44];
    export string postdir   	:= CASE (region, 0=> str_addr [45..46],		'');
    export string unit_desig 	:= CASE (region, 0=> str_addr [47..56],   1=> str_addr [45..54], '');
    export string sec_range  	:= CASE (region, 0=> str_addr [57..64],   1=> str_addr [55..62], '');
    export string p_city     	:= CASE (region, 0=> str_addr [65..89],   1=> str_addr [63..92], '');
    export string v_city     	:= CASE (region, 0=> str_addr [90..114],  1=> p_city, '');
    export string state      	:= CASE (region, 0=> str_addr [115..116], 1=> str_addr [93..94], '');
    export string province   	:= state;
    export string zip   			:= CASE (region, 0=> str_addr [117..121], 1=> str_addr [95..100], '');  
    export string postal_code := zip;
    export string zip4 				:= CASE (region, 0=> str_addr [122..125], '');
    export string address_type:= CASE (region, 0=> str_addr [139], '');
    export string county 			:= CASE (region, 0=> str_addr [141..145], '');
    export string latitude		:= CASE (region, 0=> str_addr [146..155], '');
    export string longitude		:= CASE (region, 0=> str_addr [156..166], '');
  	export string geo_blk     := CASE (region, 0=> str_addr [171..177], '');
    export string geo_match		:= CASE (region, 0=> str_addr [178], '');
    export string error_msg  	:= CASE (region, 0=> str_addr [179..182], str_addr [104..109]);
  END;
	
  export results := clean_addr;
END;