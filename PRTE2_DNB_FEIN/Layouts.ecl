IMPORT PRTE2_DNB_FEIN, DNB_FEINV2, Experian_FEIN, Standard, address;

EXPORT Layouts := MODULE

	//Layout is a combo of Experian_FEIN and DNB_FEIN fields
	EXPORT Main_in := RECORD //Combination of DNB_FEIN layout and Experian_FEIN layout
		STRING50  tmsid ;
		STRING9 	Business_Identification_Number;
		STRING1		Norm_Type;           /* '1' through '5' for the 5 normalized FEINs */
		STRING1   Norm_Confidence_Level;       
		STRING1		Norm_Display_Configuration;
		STRING8   date_first_seen := '';
		STRING8   date_last_seen := '';	
		STRING8   date_vendor_first_reported := '';  
		STRING8   date_vendor_last_reported := ''; 
		STRING50  orig_company_name;  //legal business name
		STRING30  orig_address1;
		STRING30  orig_address2 ;   //Contains CSZ
		STRING20  orig_CITY;
		STRING2   orig_STATE;
		STRING5   orig_ZIP5;
		STRING4   orig_zip4 := '';       //for future reference 
		STRING20  orig_county := '' ;    //for future reference 
		STRING9   FEIN   ;            //Tax ID Number
		STRING9   SOURCE_DUNS_NUMBER;
		STRING9   CASE_DUNS_NUMBER;
		STRING50  duns_orig_source;
		STRING2   CONFIDENCE_CODE;
		STRING1   INDIRECT_DIRECT_SOURCE_IND;
		STRING1   BEST_FEIN_Indicator;
		STRING120 company_name;      //Note, this is not the Legal Business Name
		STRING120 trade_style;
		STRING8   sic_code;
		STRING16  Telephone_Number;
		STRING60  Top_Contact_Name;
		STRING60  Top_Contact_Title;
		STRING9   Hdqtr_Parent_Duns_Number;
		STRING3		SOURCE;
		STRING		bug_num;
		STRING		cust_name;
	END;
	
	//Temporary layout to add clean fields used both both datasets so only one base cleaning needed for name/address
	EXPORT tempComboLayout := RECORD
		Main_in;
		address.Layout_Clean_Name;
		address.Layout_Clean182;
		UNSIGNED8	raw_aid								:=  0;
		UNSIGNED8	ace_aid								:=  0;
		STRING100 prep_addr_line1				:= '';
		STRING50	prep_addr_line_last		:= '';
		UNSIGNED8	source_rec_id 		    :=  0;
	END;
	
	//Base file + Data Insight reference fields
	//DNB Main
	EXPORT DNB_Main_di_ref	:= RECORD 
		DNB_FEINv2.layout_DNB_fein_base_main_new;
		STRING	bug_num;
		STRING	cust_name;
	END;
	
	//Experian Main
	EXPORT Experian_Main_di_ref	:= RECORD
		Experian_FEIN.Layouts.base;
		STRING	bug_num;
		STRING	cust_name;
	END;
	
	//Autokey file layout
	EXPORT ak_rec := RECORD
		DNB_Main_di_ref.clean_cname;
		DNB_Main_di_ref.tmsid;
		DNB_Main_di_ref.fein;
		unsigned6 intbdid;
		standard.Addr company_addr;
		unsigned1 zero := 0;
		STRING1 blank := '' ; 
	END;
	
END;