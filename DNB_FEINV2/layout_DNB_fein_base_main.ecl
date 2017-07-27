import address, dnb_feinv2, dnb;


export layout_DNB_fein_base_main :=
			record
				string50   tmsid ;
				string12   BDID := '';
				string8    date_first_seen := '';      //Date_Input_Data
				string8    date_last_seen := '';	   //Date_Input_Data	
				string8    date_vendor_first_reported := '';  
				string8    date_vendor_last_reported := ''; 
				string50   orig_company_name;  //legal business name
				string50   clean_cname ;       //legal business name
				string30   orig_address1;
				string30   orig_address2 ;   //not being used now
				string20   orig_CITY;
				string2    orig_STATE;
				string5    orig_ZIP5;
				string4    orig_zip4 := '';       //for future reference 
				string20   orig_county := '' ;    //for future reference 
				string9    FEIN   ;            //Tax ID Number
				string9    SOURCE_DUNS_NUMBER;
				string9    CASE_DUNS_NUMBER;
				string50   duns_orig_source;
				string2    CONFIDENCE_CODE;
				string1    INDIRECT_DIRECT_SOURCE_IND;
				string1    BEST_FEIN_Indicator;
				string120   company_name;      //Note, this is not the Legal Business Name
				string120   trade_style;
				string8     sic_code;
				string16  Telephone_Number;
				string60  Top_Contact_Name;
				string60  Top_Contact_Title;
				string9   Hdqtr_Parent_Duns_Number;
				address.Layout_Clean_Name;
				address.Layout_Clean182;
			end;

