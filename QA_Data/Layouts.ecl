IMPORT Address, AID, BIPV2;

EXPORT Layouts := MODULE

	////////////////////////////////////////////////////////////////////////
	// -- Input Layouts (Transactions and Address Files)
	////////////////////////////////////////////////////////////////////////
  EXPORT Input := MODULE
  
    EXPORT Sprayed_Transactions := RECORD
      STRING MasterAddressId;
      STRING Date;
      STRING Category;
      STRING Subcategory;
      STRING Name;
      STRING Company;
      STRING AddressOne;
      STRING AddressTwo;
      STRING City;
      STRING State;
      STRING PostalCode;
    END;  //End Sprayed_Transactions

    EXPORT Sprayed_Addresses := RECORD
      STRING FirstName;
      STRING MiddleInitial;
      STRING LastName;
      STRING Company;
      STRING Other;
      STRING Phone;
      STRING DatabaseMatchCode;
      STRING HomeBusinessFlag;
      STRING AddressOne;
      STRING AddressTwo;
      STRING StreetNumber;
      STRING PreDirection;
      STRING StreetName;
      STRING StreetType;
      STRING PostDirection;
      STRING Extension;
      STRING ExtensionNumber;
      STRING Village;
      STRING City;
      STRING State;
      STRING ZipPlus4;
      STRING ZipCode;
      STRING ZipAddOn;
      STRING CarrierRoute;
      STRING PMB;
      STRING PMBDesignator;
      STRING DeliveryPoint;
      STRING DeliveryPointCheckDigit;
      STRING CMRA;
      STRING DPV;
      STRING DPVFootnote;
      STRING CongressDistrict;
      STRING County;
      STRING CountyNumber;
      STRING StateNumber;
      STRING Latitude;
      STRING Longitude;
      STRING CensusTract;
      STRING BlockNumber;
      STRING BlockGroup;
      STRING MasterAddressId;
    END;  //End Sprayed_Addresses

  END;  //End Input
	
	
	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	EXPORT Base := RECORD	
	  BIPV2.IDlayouts.l_xlink_ids;
	  UNSIGNED6												did													      := 0;
	  UNSIGNED1												did_score										      := 0;
	  UNSIGNED4 											dt_first_seen								      := 0;
	  UNSIGNED4 											dt_last_seen								      := 0;
	  UNSIGNED4 											dt_vendor_first_reported		      := 0;
	  UNSIGNED4 											dt_vendor_last_reported			      := 0;
	  STRING1													record_type									      :='';			

	  Input.Sprayed_Transactions			rawTrans  											      ;
	  Input.Sprayed_Addresses					rawAddr											          ;

		AID.Common.xAID	                Trans_RawAID		                  := 0;
		AID.Common.xAID	                Trans_ACEAID		                  := 0;
		AID.Common.xAID	                Addr_RawAID		                    := 0;
		AID.Common.xAID	                Addr_ACEAID		                    := 0;

	  STRING100												prep_trans_line1					 	      :='';
	  STRING50												prep_trans_line_last				      :='';
	  STRING100												prep_addr_line1						 	      :='';
	  STRING50												prep_addr_line_last				 	      :='';
		
	  Address.Layout_Clean182_fips    Trans_address								   ;
		string5													Trans_address_fips_state_county; //concat trans_address.fips_state & trans_address.fips_county
	  Address.Layout_Clean182_fips    Addr_address								   ; 
		string5													Addr_address_fips_state_county ; //concat addr_address.fips_state & addr_address.fips_county
		
		// Clean_person_type values:  
		//	 	AP - person name came from Address File "FirstName/MiddleInitial/LastName"
		//	 	AC - person name came from Address File "Company"
		//  	TP - person name came from Transaction File "Name" 
		//		TC - person name came from Transaction File "Company"
    STRING2                         clean_person_type                 :='';
		Address.Layout_Clean_Name				clean_person_name							    ;
		
		STRING10                        clean_phone                       :='';
		STRING80                        clean_company                     :='';
		
		// if '' then clean_company came from rawAddr.Company or rawTrans.Company, 
		// but if 'B' then clean_company came from a concatenation of 
		// rawaddr.FirstName, rawaddr.MiddleInitial, rawaddr.LastName and  
		// the NID name cleaner determined that first/middle/last was a company name
		STRING1                         nameType                          :=''; 
		
	  UNSIGNED8												source_rec_id								      := 0;
  END; //End Base
	
  // Flattened Base Layout used for Scrubs Plus	
	EXPORT Base_Flat := RECORD 
		UNSIGNED6 dotid;
		UNSIGNED2 dotscore;
		UNSIGNED2 dotweight;
		UNSIGNED6 empid;
		UNSIGNED2 empscore;
		UNSIGNED2 empweight;
		UNSIGNED6 powid;
		UNSIGNED2 powscore;
		UNSIGNED2 powweight;
		UNSIGNED6 proxid;
		UNSIGNED2 proxscore;
		UNSIGNED2 proxweight;
		UNSIGNED6 seleid;
		UNSIGNED2 selescore;
		UNSIGNED2 seleweight;
		UNSIGNED6 orgid;
		UNSIGNED2 orgscore;
		UNSIGNED2 orgweight;
		UNSIGNED6 ultid;
		UNSIGNED2 ultscore;
		UNSIGNED2 ultweight;
		UNSIGNED6	did													      := 0;
	  UNSIGNED1	did_score										      := 0;
	  UNSIGNED4	dt_first_seen								      := 0;
	  UNSIGNED4	dt_last_seen								      := 0;
	  UNSIGNED4	dt_vendor_first_reported		      := 0;
	  UNSIGNED4	dt_vendor_last_reported			      := 0;
	  STRING1		record_type									      :='';			
		STRING 		rawTrans_MasterAddressId;
		STRING 		rawTrans_Date;
		STRING 		rawTrans_Category;
		STRING 		rawTrans_Subcategory;
		STRING 		rawTrans_Name;
		STRING 		rawTrans_Company;
		STRING 		rawTrans_AddressOne;
		STRING 		rawTrans_AddressTwo;
		STRING 		rawTrans_City;
		STRING 		rawTrans_State;
		STRING 		rawTrans_PostalCode;
		STRING 		rawAddr_FirstName;
		STRING 		rawAddr_MiddleInitial;
		STRING 		rawAddr_LastName;
		STRING 		rawAddr_Company;
		STRING 		rawAddr_Other;
		STRING 		rawAddr_Phone;
		STRING 		rawAddr_DatabaseMatchCode;
		STRING 		rawAddr_HomeBusinessFlag;
		STRING 		rawAddr_AddressOne;
		STRING 		rawAddr_AddressTwo;
		STRING 		rawAddr_StreetNumber;
		STRING 		rawAddr_PreDirection;
		STRING 		rawAddr_StreetName;
		STRING 		rawAddr_StreetType;
		STRING 		rawAddr_PostDirection;
		STRING 		rawAddr_Extension;
		STRING 		rawAddr_ExtensionNumber;
		STRING 		rawAddr_Village;
		STRING 		rawAddr_City;
		STRING 		rawAddr_State;
		STRING 		rawAddr_ZipPlus4;
		STRING 		rawAddr_ZipCode;
		STRING 		rawAddr_ZipAddOn;
		STRING 		rawAddr_CarrierRoute;
		STRING 		rawAddr_PMB;
		STRING 		rawAddr_PMBDesignator;
		STRING 		rawAddr_DeliveryPoint;
		STRING 		rawAddr_DeliveryPointCheckDigit;
		STRING 		rawAddr_CMRA;
		STRING 		rawAddr_DPV;
		STRING 		rawAddr_DPVFootnote;
		STRING 		rawAddr_CongressDistrict;
		STRING 		rawAddr_County;
		STRING 		rawAddr_CountyNumber;
		STRING 		rawAddr_StateNumber;
		STRING 		rawAddr_Latitude;
		STRING 		rawAddr_Longitude;
		STRING 		rawAddr_CensusTract;
		STRING 		rawAddr_BlockNumber;
		STRING 		rawAddr_BlockGroup;
		STRING 		rawAddr_MasterAddressId;
		UNSIGNED8 trans_rawaid;
		UNSIGNED8 trans_aceaid;
		UNSIGNED8 addr_rawaid;
		UNSIGNED8 addr_aceaid;
		STRING100 prep_trans_line1					 	    :='';
	  STRING50 	prep_trans_line_last				    :='';
	  STRING100 prep_addr_line1						 	    :='';
	  STRING50 	prep_addr_line_last				 	    :='';
		STRING10 	trans_address_prim_range;
		STRING2 	trans_address_predir;
		STRING28 	trans_address_prim_name;
		STRING4 	trans_address_addr_suffix;
		STRING2 	trans_address_postdir;
		STRING10 	trans_address_unit_desig;
		STRING8 	trans_address_sec_range;
		STRING25 	trans_address_p_city_name;
		STRING25 	trans_address_v_city_name;
		STRING2 	trans_address_st;
		STRING5 	trans_address_zip;
		STRING4 	trans_address_zip4;
		STRING4 	trans_address_cart;
		STRING1 	trans_address_cr_sort_sz;
		STRING4 	trans_address_lot;
		STRING1 	trans_address_lot_order;
		STRING2 	trans_address_dbpc ;
		STRING1 	trans_address_chk_digit ;
		STRING2 	trans_address_rec_type ;
		STRING2 	trans_address_fips_state ;
		STRING3 	trans_address_fips_county ;
		STRING10 	trans_address_geo_lat ;
		STRING11 	trans_address_geo_long ;
		STRING4 	trans_address_msa ;
		STRING7 	trans_address_geo_blk ;
		STRING1 	trans_address_geo_match ;
		STRING4 	trans_address_err_stat ;
		STRING5		trans_address_fips_state_county; 
		STRING10 	addr_address_prim_range ;
		STRING2 	addr_address_predir ;
		STRING28 	addr_address_prim_name ;
		STRING4 	addr_address_addr_suffix ;
		STRING2 	addr_address_postdir ;
		STRING10 	addr_address_unit_desig ;
		STRING8 	addr_address_sec_range ;
		STRING25 	addr_address_p_city_name ;
		STRING25 	addr_address_v_city_name;
		STRING2 	addr_address_st ;
		STRING5 	addr_address_zip ;
		STRING4 	addr_address_zip4 ;
		STRING4 	addr_address_cart ;
	  STRING1 	addr_address_cr_sort_sz ;
	  STRING4 	addr_address_lot ;
	  STRING1 	addr_address_lot_order ;
	  STRING2 	addr_address_dbpc ;
	  STRING1 	addr_address_chk_digit;
	  STRING2 	addr_address_rec_type ;
	  STRING2 	addr_address_fips_state ;
	  STRING3 	addr_address_fips_county ;
	  STRING10 	addr_address_geo_lat ;
	  STRING11 	addr_address_geo_long ;
	  STRING4  	addr_address_msa ;
	  STRING7  	addr_address_geo_blk ;
	  STRING1  	addr_address_geo_match ;
	  STRING4  	addr_address_err_stat ;
		STRING5		addr_address_fips_state_county ; 
		STRING2 	clean_person_type                 :='';
		STRING5  	clean_person_name_title;
		STRING20 	clean_person_name_fname;
		STRING20 	clean_person_name_mname;
		STRING20 	clean_person_name_lname;
		STRING5 	clean_person_name_name_suffix;
		STRING3 	clean_person_name_name_score;
		STRING10 	clean_phone                       :='';
		STRING80 	clean_company                     :='';
		STRING1 	nameType                          :=''; 
	  UNSIGNED8 source_rec_id								      := 0;
  END;
 
		
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	EXPORT Temporary := MODULE
	
		EXPORT AID_prep := RECORD
			UNSIGNED8		                   unique_id;
			STRING1			                   record_type			:='';
			STRING2			                   state            :='';
		  STRING100		                   prep_line1				:='';
		  STRING50		                   prep_line_last		:='';
		  AID.Common.xAID	               RawAID	          := 0;
		  AID.Common.xAID	               ACEAID	          := 0;
	    Address.Layout_Clean182_fips;
	  END;
		
	  EXPORT DidSlim := RECORD
			UNSIGNED8		unique_id   := 0;
			STRING20 		fname;
			STRING20 		mname;
			STRING20 		lname;
			STRING5  		name_suffix;
			STRING10  	prim_range;
			STRING28		prim_name;
			STRING8			sec_range;
			STRING5			zip5;
			STRING2			state;
			STRING10		phone;
			UNSIGNED6		did         := 0;
			UNSIGNED1		did_score		:= 0;
	  END;

	  EXPORT BIPSlim := RECORD
			UNSIGNED8		unique_id;
			STRING80  	company;
			STRING10  	prim_range;
			STRING28		prim_name;
			STRING8			sec_range;
			STRING25 		city;   		      // p_city
			STRING2			state;
			STRING5			zip5;
			STRING20 		fname;
			STRING20 		mname;
			STRING20 		lname;
			STRING10		phone;
			BIPV2.IDlayouts.l_xlink_ids;
	  END;
		
	  EXPORT UniqueId := RECORD
 		  UNSIGNED8		unique_id;
		  Base;
		END;
    
	END;  //End Temporary
	
END;  //End Layouts