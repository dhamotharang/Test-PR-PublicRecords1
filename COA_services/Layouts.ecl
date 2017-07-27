import iesp, header_quick, coa_services;
	
export Layouts := MODULE

   export Rawrec := record
					  recordof(header_quick.layout_records); 
						boolean isDeepDive := false;
						unsigned2 penalt := 0;
						unsigned3 firstSeenDate := 0;
						unsigned3 lastSeenDate :=0;
						unsigned3 latestDate:=0;
						unsigned3 inputFirstSeenDate := 0;
						unsigned3 inputLastSeenDate := 0;
	 end;
	
	 export t_ChangeOfAddressRecord := record
			iesp.share.t_Name InputName {xpath('InputName')};
			iesp.changeofAddress.t_COAAddress InputAddress {xpath('InputAddress')};	
			dataset(iesp.changeofAddress.t_AddressChange) AddressChanges {xpath('AddressChanges/AddressChange'), MAXCOUNT(iesp.constants.COA_MAX_COUNT_SEARCH_RESPONSE_RECORDS)};
  end;	
	
	export coaInputAddrLayout := record
	
	  string20 prim_name := '';
				 string20 prim_range := '';
				 string10	predir := '';
				 string10 postdir := '';
					string10 suffix := '';
					string10 unit_desig := '';
			      string10 sec_range := '';
					 string40 v_city := '';
					 // string a;
					 // string b;
					 string10		state :='';
					 string10		zip := '';
						string5	zip4 := '';
		end;
	
	export inputAddrFromForm := record
	string40 county; //42085   
  string40 p_city; //GROVE CITY   
  string40 postal_code; //16127   
  string40 postdir;    
  string40 predir;   
  string40 prim_name; //CENTER CHURCH   
  string40 prim_range; //339   
  string40 province; //PA   
  string40 sec_range;    
  string2 state; //PA   
  string20 suffix; //RD   
  string20 unit_desig;    
  string20 v_city; //GROVE CITY   
  string6 zip; //16127   
  string4 zip4; 
 end;

END;	