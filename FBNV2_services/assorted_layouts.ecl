
import  FBNV2,doxie;
export assorted_layouts := MODULE
  
	shared unwanted_fields := RECORD
	  FBNV2.Layout_Common.vendor_dates;
		FBNV2.Layout_Common.addr_fip_geo;
		FBNV2.Layout_Common.mailing_adr_fip_geo;
		unsigned6	bdid ;
		unsigned6   bdid_score ;
		
	END;
	
	export batch_out_layout := RECORD
	  doxie.layout_inBatchMaster.acctno;
		// FBNV2.Layout_Common.Business - unwanted_fields - bus_status;
		
		STRING38 	Tmsid					;
		STRING35 	Rmsid					;
		string8 	dt_first_seen			;
		string8 	dt_last_seen			;  

		STRING3 	Filing_Jurisdiction		;
		STRING35 	FILING_NUMBER			;
		string8	  Filing_date     		;  	
		STRING 		FILING_TYPE   			;      	
		string8 	EXPIRATION_DATE			;
		string8 	CANCELLATION_DATE		;
		STRING12 	ORIG_FILING_NUMBER		;
		string8 	ORIG_FILING_DATE  		; 
		STRING192 BUS_NAME				;
		STRING    LONG_BUS_NAME    		;
		string8   bus_comm_dATE 			;
		STRING30  bus_statUS				;
		string12 	orig_FEIN  				; 	
		string10 	BUS_PHONE_NUM			;
		STRING9 	SIC_CODE				;
		STRING100 BUS_TYPE_DESC			;
		STRING40 	BUS_ADDRESS1			;
		STRING40 	BUS_ADDRESS2			;
		STRING28 	BUS_CITY     			;           	
		STRING12 	BUS_COUNTY				;
		STRING2 	BUS_STATE  				;             	
		string5 	BUS_ZIP					;
		string4 	BUS_ZIP4				;
		STRING12 	BUS_COUNTRY				;
		STRING80 	MAIL_STREET				;
		STRING28 	MAIL_CITY				;
		STRING2 	MAIL_STATE				;
		STRING10 	MAIL_ZIP				;

		
		string10 	prim_range 				;
		string2  	predir 					;
		string28 	prim_name 				;
		string4  	addr_suffix 			;
		string2  	postdir 				;
		string10 	unit_desig				;
		string8  	sec_range				;
		string25 	v_city_name 			;
		string2  	st 						;
		string5  	zip5 					;
		string4  	zip4 					;

		string10 	mail_prim_range 		;
		string2  	mail_predir 			;
		string28 	mail_prim_name 			;
		string4  	mail_addr_suffix 		;
		string2  	mail_postdir 			;
		string10 	mail_unit_desig			;
		string8  	mail_sec_range			;
		string25 	mail_v_city_name 		;
		string2  	mail_st 				;
		string5  	mail_zip5 				;
		string4  	mail_zip4 				;
		
		

		STRING38 	Tmsid_1 ;
		STRING35 	Rmsid_1 ;
		string8 	dt_first_seen_1 ;
		string8 	dt_last_seen_1 ;
		string20 	CONTACT_TYPE_1 ;
		string9 	ssn_1 ;
		string55 	CONTACT_NAME_1 ;
		string10 	CONTACT_STATUS_1 ;
		string10 	CONTACT_PHONE_1 ;
		string10	CONTACT_NAME_FORMAT_1 ;
		string40 	CONTACT_ADDR_1_1 ;
		string40 	CONTACT_ADDR_1_2 ;
		string28 	CONTACT_CITY_1 ;
		string2 	CONTACT_STATE_1 ;
		string5	CONTACT_ZIP_1 ;
		string12 	CONTACT_COUNTRY_1 ;
		string12 	CONTACT_FEI_NUM_1 ;
		string12 	CONTACT_CHARTER_NUM_1 ;
		STRING38 	Tmsid_2 ;
		STRING35 	Rmsid_2 ;
		string8 	dt_first_seen_2 ;
		string8 	dt_last_seen_2 ;
		string20	CONTACT_TYPE_2 ;
		string9 	ssn_2 ;
		string55 	CONTACT_NAME_2 ;
		string10 	CONTACT_STATUS_2 ;
		string10 	CONTACT_PHONE_2 ;
		string10	CONTACT_NAME_FORMAT_2 ;
		string40 	CONTACT_ADDR_2_1 ;
		string40 	CONTACT_ADDR_2_2 ;
		string28 	CONTACT_CITY_2 ;
		string2 	CONTACT_STATE_2 ;
		string5	CONTACT_ZIP_2 ;
		string12 	CONTACT_COUNTRY_2 ;
		string12 	CONTACT_FEI_NUM_2 ;
		string12 	CONTACT_CHARTER_NUM_2 ;
		STRING38 	Tmsid_3 ;
		STRING35 	Rmsid_3 ;
		string8 	dt_first_seen_3 ;
		string8 	dt_last_seen_3 ;
		string20	CONTACT_TYPE_3 ;
		string9 	ssn_3 ;
		string55 	CONTACT_NAME_3 ;
		string10 	CONTACT_STATUS_3 ;
		string10 	CONTACT_PHONE_3 ;
		string10	CONTACT_NAME_FORMAT_3 ;
		string40 	CONTACT_ADDR_3_1 ;
		string40 	CONTACT_ADDR_3_2 ;
		string28 	CONTACT_CITY_3 ;
		string2 	CONTACT_STATE_3 ;
		string5	CONTACT_ZIP_3 ;
		string12 	CONTACT_COUNTRY_3 ;
		string12 	CONTACT_FEI_NUM_3 ;
		string12 	CONTACT_CHARTER_NUM_3 ;
		STRING38 	Tmsid_4 ;
		STRING35 	Rmsid_4 ;
		string8 	dt_first_seen_4 ;
		string8	dt_last_seen_4 ;
		string20	CONTACT_TYPE_4 ;
		string9 	ssn_4 ;
		string55 	CONTACT_NAME_4 ;
		string10 	CONTACT_STATUS_4 ;
		string10 	CONTACT_PHONE_4 ;
		string10	CONTACT_NAME_FORMAT_4 ;
		string40 	CONTACT_ADDR_4_1 ;
		string40 	CONTACT_ADDR_4_2 ;
		string28 	CONTACT_CITY_4 ;
		string2 	CONTACT_STATE_4 ;
		string5	CONTACT_ZIP_4 ;
		string12 	CONTACT_COUNTRY_4 ;
		string12 	CONTACT_FEI_NUM_4 ;
		string12 	CONTACT_CHARTER_NUM_4 ;
		STRING38 	Tmsid_5 ;
		STRING35 	Rmsid_5 ;
		string8 	dt_first_seen_5 ;
		string8 	dt_last_seen_5 ;
		string20	CONTACT_TYPE_5 ;
		string9 	ssn_5 ;
		string55 	CONTACT_NAME_5 ;
		string10 	CONTACT_STATUS_5 ;
		string10 	CONTACT_PHONE_5 ;
		string10	CONTACT_NAME_FORMAT_5 ;
		string40 	CONTACT_ADDR_5_1 ;
		string40 	CONTACT_ADDR_5_2 ;
		string28 	CONTACT_CITY_5 ;
		string2 	CONTACT_STATE_5 ;
		String5	CONTACT_ZIP_5 ;
		string12 	CONTACT_COUNTRY_5 ;
		string12 	CONTACT_FEI_NUM_5 ;
		string12 	CONTACT_CHARTER_NUM_5 ;	
	ENd;

	
END;