IMPORT standard, aid,BIPV2;
EXPORT Layout_Common:=
  module
   EXPORT Bus:=RECORD
       
		STRING35 		FILING_NUMBER				:='';
		unsigned4		Filing_date     		:=0;      	
		STRING 			FILING_TYPE   			:='';      	
		unsigned4 	EXPIRATION_DATE			:=0;
		Unsigned4 	CANCELLATION_DATE		:=0;
		STRING12 		ORIG_FILING_NUMBER	:='';
		Unsigned4 	ORIG_FILING_DATE  	:=0; 
		STRING192 	BUS_NAME						:='';
		STRING      LONG_BUS_NAME    		:='';
		unsigned4   bus_comm_dATE 			:=0;
		STRING10    bus_statUS					:='';
		unsigned4 	orig_FEIN  					:=0; 	
		string10 		BUS_PHONE_NUM				:='';
		STRING9 		SIC_CODE						:='';
		STRING100 	BUS_TYPE_DESC				:='';
		STRING40 		BUS_ADDRESS1				:='';
		STRING40 		BUS_ADDRESS2				:='';
		STRING28 		BUS_CITY     				:='';           	
		STRING12 		BUS_COUNTY					:='';
		STRING2 		BUS_STATE  					:='';             	
		Unsigned3 	BUS_ZIP							:=0;
		Unsigned2 	BUS_ZIP4						:=0;
		STRING12 		BUS_COUNTRY					:='';
		STRING80 		MAIL_STREET					:='';
		STRING28 		MAIL_CITY						:='';
		STRING2 		MAIL_STATE					:='';
		STRING10 		MAIL_ZIP						:='';
		Unsigned3 	SEQ_NO							:=0;
	 END; 
	 EXPORT vendor_dates := RECORD
	 	 unsigned4 	dt_vendor_first_reported:=0;
		 unsigned4 	dt_vendor_last_reported	:=0;
	 END;
	 EXPORT addr_fip_geo := RECORD
	 	string2  	addr_rec_type 			:='';
		string2  	fips_state					:='';
		string3  	fips_county					:='';
		string10 	geo_lat							:='';
		string11 	geo_long						:='';
		string4  	cbsa 								:='';
		string7  	geo_blk 						:='';
		string1  	geo_match 					:='';
		string4  	err_stat						:='';
	 END;
	 
	 EXPORT mailing_adr_fip_geo := RECORD
	 	string2  	mail_addr_rec_type 		:='';
		string2  	mail_fips_state				:='';
		string3  	mail_fips_county			:='';
		string10 	mail_geo_lat					:='';
		string11 	mail_geo_long					:='';
		string4  	mail_cbsa 						:='';
		string7  	mail_geo_blk 					:='';
		string1  	mail_geo_match 				:='';
		string4  	mail_err_stat					:='';
	 END;
	 
	 EXPORT Bus_Addr_AID := RECORD
		AID.Common.xAID	RawAID 									 := 0;
		AID.Common.xAID	ACEAID 									 := 0;
		AID.Common.xAID	Mail_RawAID 						 := 0;
		AID.Common.xAID	Mail_ACEAID 						 := 0;
		string100				Prep_Addr_Line1					 :='';
		string50				Prep_Addr_Line_Last			 :='';
		string100				Prep_Mail_Addr_Line1		 :='';
		string50				Prep_Mail_Addr_Line_Last :='';	
		unsigned8   		source_rec_id 					 :=0 ;
		BIPV2.IDlayouts.l_xlink_ids ;
	 END;
	 
		// Jira# CCPA-102, The below layout with 2 new fields are added for CCPA (California Consumer Protection Act) project.
		// The Orbit infrastructure is not available yet, so leaving unpopulated for now.
		export CCPA_fields := 
		record
			unsigned4 				global_sid 		:= 0;
			unsigned8 				record_sid 		:= 0;
		end;

	 EXPORT Business := RECORD
			STRING38 		Tmsid								:='';
			STRING35 		Rmsid								:='';
			unsigned4 	dt_first_seen				:=0;    
			unsigned4 	dt_last_seen				:=0;  
			vendor_dates;
			STRING3 		Filing_Jurisdiction	:='';
			Bus;
			string10 		prim_range 					:='';
			string2  		predir 							:='';
			string28 		prim_name 					:='';
			string4  		addr_suffix 				:='';
			string2  		postdir 						:='';
			string10 		unit_desig					:='';
			string8  		sec_range						:='';
			string25 		v_city_name 				:='';
			string2  		st 									:='';
			string5  		zip5 								:='';
			string4  		zip4 								:='';
			addr_fip_geo;
			string10 		mail_prim_range 		:='';
			string2  		mail_predir 				:='';
			string28 		mail_prim_name 			:='';
			string4  		mail_addr_suffix 		:='';
			string2  		mail_postdir 				:='';
			string10 		mail_unit_desig			:='';
			string8  		mail_sec_range			:='';
			string25 		mail_v_city_name 		:='';
			string2  		mail_st 						:='';
			string5  		mail_zip5 					:='';
			string4  		mail_zip4 					:='';
			mailing_adr_fip_geo;
			unsigned6		bdid 								:=0 ;
			unsigned6   bdid_score 					:=0 ;
			CCPA_fields;
	 END;

   EXPORT Business_AID := RECORD
	   Business;
	   Bus_Addr_AID;		
   END;
	
	
	EXPORT cont_info  :=RECORD
	  string1 	CONTACT_TYPE			  :='';
		string55 	CONTACT_NAME			  :='';
		string10 	CONTACT_STATUS		  :='';
		string10 	CONTACT_PHONE			  :='';
		string10	CONTACT_NAME_FORMAT :='';
		string40 	CONTACT_ADDR			  :='';
		string28 	CONTACT_CITY			  :='';
		string2 	CONTACT_STATE			  :='';
		Unsigned6	CONTACT_ZIP				  :=0;
		string12 	CONTACT_COUNTRY		  :='';
		unsigned4 CONTACT_FEI_NUM		  :=0;
		string12 	CONTACT_CHARTER_NUM	:='';
		string9 	ssn                 :='';
		unsigned3 SEQ_NO							:=0;
		unsigned4 WITHDRAWAL_DATE			:=0;
	END;

	EXPORT Contact_Addr_AID := RECORD
		AID.Common.xAID	RawAID							:= 0;
		AID.Common.xAID	ACEAID 							:= 0;
		string100				Prep_Addr_Line1			:='';
		string50				Prep_Addr_Line_Last	:='';
	END;
	 
	EXPORT contact := RECORD
		STRING38 		Tmsid								:='';
		STRING35 		Rmsid								:='';
		unsigned4 	dt_first_seen				:=0;    
		unsigned4 	dt_last_seen				:=0;     
    vendor_dates;
		CONT_info;
		STRING5  		title							:='';
		STRING20 		fname							:='';
		STRING20 		mname							:='';
		STRING20 		lname							:='';
		STRING5  		name_suffix				:='';
		STRING3  		name_score				:='';
		string10 		prim_range 				:='';
		string2  		predir 						:='';
		string28 		prim_name 				:='';
		string4  		addr_suffix 			:='';
		string2  		postdir 					:='';
		string10 		unit_desig				:='';
		string8  		sec_range					:='';
		string25 		v_city_name 			:='';
		string2  		st 								:='';
		string5  		zip5 							:='';
		string4  		zip4 							:='';
    addr_fip_geo; 
		unsigned6 	did  							:=0 ;
		unsigned6		did_score 				:=0 ;
		unsigned6		bdid 							:=0 ;
		unsigned6   bdid_score 				:=0 ;
		CCPA_fields;
	END ;
	
	EXPORT Contact_AID := RECORD
		Contact;
		Contact_Addr_AID;		
	END ;	

	
END ;