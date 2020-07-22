﻿IMPORT Address, AID, BIPV2;

EXPORT Layouts := MODULE

	////////////////////////////////////////////////////////////////////////
	// -- Input Layout 
	////////////////////////////////////////////////////////////////////////
EXPORT Sprayed_Input := RECORD
	STRING10 EFX_ID;
  STRING75 EFX_NAME;
  STRING75 EFX_LEGAL_NAME;
  STRING75 EFX_ADDRESS;
  STRING75 EFX_CITY;
  STRING2 EFX_STATE;
  STRING2 EFX_STATEC;
  STRING15 EFX_ZIPCODE;
  STRING4 EFX_ZIP4;
  STRING15 EFX_LAT;
  STRING15 EFX_LON;
  STRING3 EFX_GEOPREC;
  STRING50 EFX_REGION;
  STRING3 EFX_CTRYISOCD;
  STRING10 EFX_CTRYNUM;
  STRING100 EFX_CTRYNAME;
  STRING100 EFX_COUNTYNM;
  STRING3 EFX_COUNTY;
  STRING4 EFX_CMSA;
  STRING100 EFX_CMSADESC;
  STRING1 EFX_SOHO;
  STRING1 EFX_BIZ;
  STRING1 EFX_RES;
  STRING1 EFX_CMRA;
  STRING2 EFX_CONGRESS;
  STRING75 EFX_SECADR;
  STRING75 EFX_SECCTY;
  STRING2 EFX_SECSTAT;
  STRING2 EFX_STATEC2;
  STRING15 EFX_SECZIP;
  STRING4 EFX_SECZIP4;
  STRING15 EFX_SECLAT;
  STRING15 EFX_SECLON;
  STRING3 EFX_SECGEOPREC;
  STRING50 EFX_SECREGION;
  STRING3 EFX_SECCTRYISOCD;
  STRING10 EFX_SECCTRYNUM;
  STRING100 EFX_SECCTRYNAME;
  STRING10 EFX_CTRYTELCD;
  STRING18 EFX_PHONE;
  STRING18 EFX_FAXPHONE;
  STRING50 EFX_BUSSTAT;
  STRING10 EFX_BUSSTATCD;
  STRING100 EFX_WEB;
  STRING10 EFX_YREST;
  STRING10 EFX_CORPEMPCNT;
  STRING10 EFX_LOCEMPCNT;
  STRING1 EFX_CORPEMPCD;
  STRING1 EFX_LOCEMPCD;
  STRING10 EFX_CORPAMOUNT;
  STRING1 EFX_CORPAMOUNTCD;
  STRING50 EFX_CORPAMOUNTTP;
  STRING50 EFX_CORPAMOUNTPREC;
  STRING10 EFX_LOCAMOUNT;
  STRING1 EFX_LOCAMOUNTCD;
  STRING50 EFX_LOCAMOUNTTP;
  STRING50 EFX_LOCAMOUNTPREC;
  STRING1 EFX_PUBLIC;
  STRING1 EFX_STKEXC;
  STRING10 EFX_TCKSYM;
  STRING4 EFX_PRIMSIC;
  STRING4 EFX_SECSIC1;
  STRING4 EFX_SECSIC2;
  STRING4 EFX_SECSIC3;
  STRING4 EFX_SECSIC4;
  STRING250 EFX_PRIMSICDESC;
  STRING250 EFX_SECSICDESC1;
  STRING250 EFX_SECSICDESC2;
  STRING250 EFX_SECSICDESC3;
  STRING250 EFX_SECSICDESC4;
  STRING6 EFX_PRIMNAICSCODE;
  STRING6 EFX_SECNAICS1;
  STRING6 EFX_SECNAICS2;
  STRING6 EFX_SECNAICS3;
  STRING6 EFX_SECNAICS4;
  STRING250 EFX_PRIMNAICSDESC;
  STRING250 EFX_SECNAICSDESC1;
  STRING250 EFX_SECNAICSDESC2;
  STRING250 EFX_SECNAICSDESC3;
  STRING250 EFX_SECNAICSDESC4;
  STRING1 EFX_DEAD;
  STRING10 EFX_DEADDT;
  STRING1 EFX_MRKT_TELEVER;
  STRING10 EFX_MRKT_TELESCORE;
  STRING10 EFX_MRKT_TOTALSCORE;
  STRING2 EFX_MRKT_TOTALIND;
  STRING1 EFX_MRKT_VACANT;
  STRING1 EFX_MRKT_SEASONAL;
  STRING1 EFX_MBE;
  STRING1 EFX_WBE;
  STRING1 EFX_MWBE;
  STRING1 EFX_SDB;
  STRING1 EFX_HUBZONE;
  STRING1 EFX_DBE;
  STRING1 EFX_VET;
  STRING1 EFX_DVET;
  STRING1 EFX_8a;
  STRING10 EFX_8aEXPDT;
  STRING1 EFX_DIS;
  STRING1 EFX_SBE;
  STRING1 EFX_BUSSIZE;
  STRING1 EFX_LBE;
  STRING1 EFX_GOV;
  STRING1 EFX_FGOV;
  STRING10 EFX_GOV1057;
  STRING1 EFX_NONPROFIT;
  STRING1 EFX_MERCTYPE;
  STRING1 EFX_HBCU;
  STRING1 EFX_GAYLESBIAN;
  STRING1 EFX_WSBE;
  STRING1 EFX_VSBE;
  STRING1 EFX_DVSBE;
  STRING30 EFX_MWBESTATUS;
  STRING1 EFX_NMSDC;
  STRING1 EFX_WBENC;
  STRING1 EFX_CA_PUC;
  STRING1 EFX_TX_HUB;
  STRING13 EFX_TX_HUBCERTNUM;
  STRING1 EFX_GSAX;
  STRING1 EFX_CALTRANS;
  STRING1 EFX_EDU;
  STRING1 EFX_MI;
  STRING1 EFX_ANC;
  STRING10 AT_CERT1;
  STRING10 AT_CERT2;
  STRING10 AT_CERT3;
  STRING10 AT_CERT4;
  STRING10 AT_CERT5;
  STRING10 AT_CERT6;
  STRING10 AT_CERT7;
  STRING10 AT_CERT8;
  STRING10 AT_CERT9;
  STRING10 AT_CERT10;
  STRING100 AT_CERTDESC1;
  STRING100 AT_CERTDESC2;
  STRING100 AT_CERTDESC3;
  STRING100 AT_CERTDESC4;
  STRING100 AT_CERTDESC5;
  STRING100 AT_CERTDESC6;
  STRING100 AT_CERTDESC7;
  STRING100 AT_CERTDESC8;
  STRING100 AT_CERTDESC9;
  STRING100 AT_CERTDESC10;
  STRING255 AT_CERTSRC1;
  STRING255 AT_CERTSRC2;
  STRING255 AT_CERTSRC3;
  STRING255 AT_CERTSRC4;
  STRING255 AT_CERTSRC5;
  STRING255 AT_CERTSRC6;
  STRING255 AT_CERTSRC7;
  STRING255 AT_CERTSRC8;
  STRING255 AT_CERTSRC9;
  STRING255 AT_CERTSRC10;
  STRING50 AT_CERTLEV1;
  STRING50 AT_CERTLEV2;
  STRING50 AT_CERTLEV3;
  STRING50 AT_CERTLEV4;
  STRING50 AT_CERTLEV5;
  STRING50 AT_CERTLEV6;
  STRING50 AT_CERTLEV7;
  STRING50 AT_CERTLEV8;
  STRING50 AT_CERTLEV9;
  STRING50 AT_CERTLEV10;
  STRING30 AT_CERTNUM1;
  STRING30 AT_CERTNUM2;
  STRING30 AT_CERTNUM3;
  STRING30 AT_CERTNUM4;
  STRING30 AT_CERTNUM5;
  STRING30 AT_CERTNUM6;
  STRING30 AT_CERTNUM7;
  STRING30 AT_CERTNUM8;
  STRING30 AT_CERTNUM9;
  STRING30 AT_CERTNUM10;
  STRING19 AT_CERTEXP1;
  STRING19 AT_CERTEXP2;
  STRING19 AT_CERTEXP3;
  STRING19 AT_CERTEXP4;
  STRING19 AT_CERTEXP5;
  STRING19 AT_CERTEXP6;
  STRING19 AT_CERTEXP7;
  STRING19 AT_CERTEXP8;
  STRING19 AT_CERTEXP9;
  STRING19 AT_CERTEXP10;
  STRING19 EFX_EXTRACT_DATE;
  STRING20 EFX_MERCHANT_ID;
  STRING10 EFX_PROJECT_ID;
  STRING1 EFX_FOREIGN;
  STRING19 Record_Update_Refresh_Date;
	STRING10 EFX_DATE_CREATED;
END;

EXPORT Sprayed_Input_Contacts := RECORD, MAXLENGTH(3000000)
	STRING10  EFX_ID;
	STRING130 EFX_CONTCT;
	STRING2   EFX_TITLECD;
	STRING50  EFX_TITLEDESC;
	STRING75  EFX_LASTNAM;
	STRING50  EFX_FSTNAM;
	STRING100 EFX_EMAIL;
	STRING10  EFX_DATE;
END;	
	
	////////////////////////////////////////////////////////////////////////
	// -- Base Layout
	////////////////////////////////////////////////////////////////////////
	EXPORT Base := RECORD	
		STRING6    										source                            := '';
		UNSIGNED6   									rcid                              := 0;
	 	BIPV2.IDlayouts.l_xlink_ids;
		UNSIGNED4 										dt_first_seen								      := 0;
	  UNSIGNED4 										dt_last_seen								      := 0;
	  UNSIGNED4 										dt_vendor_first_reported		      := 0;
	  UNSIGNED4 										dt_vendor_last_reported			      := 0;
	  UNSIGNED4 										dt_effective_first       		      := 0;
	  UNSIGNED4 										dt_effective_last     			      := 0;
		UNSIGNED4   									process_date                      := 0;
		STRING1												record_type									      := '';
    Sprayed_Input;
		STRING100			NormCompany_Name 												:= '';
		STRING1 			NormCompany_Type 												:= '';
	  STRING1  			NormAddress_Type 												:= '';
		STRING75 			Norm_Address 														:= '';
    STRING75 			Norm_City 															:= '';
    STRING2 			Norm_State 															:= '';
    STRING2 			Norm_StateC2 														:= '';
    STRING15 			Norm_Zip 																:= '';
    STRING4 			Norm_Zip4 															:= '';
    STRING15 			Norm_Lat 																:= '';
    STRING15 			Norm_Lon 																:= '';
    STRING3 			Norm_Geoprec 														:= '';
    STRING50 			Norm_Region 														:= '';
    STRING3 			Norm_Ctryisocd 													:= '';
    STRING10 			Norm_Ctrynum 														:= '';
    STRING100 		Norm_Ctryname 													:= '';
		STRING10 			Norm_Geo_Precision 											:= '';
		
		STRING9 			Exploded_Desc_Corporate_Amount_Precision 				:= '';
		STRING9 			Exploded_Desc_Location_Amount_Precision 					:= '';
		STRING8 			Exploded_Desc_Public_Co_Indicator 								:= '';
		STRING48			Exploded_Desc_Stock_Exchange 										:= '';
		STRING18 			Exploded_Desc_Telemarketablity_Score 						:= '';
		STRING25 			Exploded_Desc_Telemarketablity_Total_Indicator 	:= '';
		STRING18 			Exploded_Desc_Telemarketablity_Total_Score 			:= '';
		STRING21 			Exploded_Desc_Government1057_Entity 							:= '';
		STRING22 			Exploded_Desc_Merchant_Type 											:= '';
		STRING50      Exploded_Desc_Busstatcd                          := '';
		STRING100     Exploded_Desc_CMSA                               := '';
		STRING13      Exploded_Desc_Corpamountcd                       := '';
		STRING50      Exploded_Desc_Corpamountprec                     := '';
		STRING50      Exploded_Desc_Corpamounttp                       := '';
		STRING9       Exploded_Desc_Corpempcd                          := '';
		STRING100     Exploded_Desc_Ctrytelcd                          := '';		
		Address.Layout_Clean182_fips; 
    STRING100   									clean_company_name                := '';		
		string10											clean_phone												:='';
		string10											clean_secondary_phone			 				:='';
		UNSIGNED8											raw_aid														:= 0;
		UNSIGNED8											ace_aid														:= 0;
	  STRING100											prep_addr_line1		    			 			:= '';
	  STRING50											prep_addr_line_last		    				:= '';
		UNSIGNED4                     clean_date_created                := 0;
		UNSIGNED4                     clean_extract_date                := 0;
		UNSIGNED4                     clean_record_update_refresh_date  := 0;		
		UNSIGNED4 										clean_dead_date                   := 0;
		UNSIGNED4                     clean_expiration_date             := 0;
		UNSIGNED4                     clean_certexp1_date               := 0;
		UNSIGNED4                     clean_certexp2_date               := 0;
		UNSIGNED4                     clean_certexp3_date               := 0;
		UNSIGNED4                     clean_certexp4_date               := 0;
		UNSIGNED4                     clean_certexp5_date               := 0;
		UNSIGNED4                     clean_certexp6_date               := 0;
		UNSIGNED4                     clean_certexp7_date               := 0;
		UNSIGNED4                     clean_certexp8_date               := 0;
		UNSIGNED4                     clean_certexp9_date               := 0;
		UNSIGNED4                     clean_certexp10_date              := 0;
		unsigned4 global_sid := 0;   //this is a unique source ID that will be coming from Orbit.  
																 // The Orbit infrastructure is not available yet.  
																 // In the meantime, when adding the field leave it unpopulated.  
																 // More information will come as the Orbit change moves along.
    unsigned8 record_sid := 0; //this is a source specific unique and persistent record id.  
															 // Same as the persistent record id we have in some datasets.  
															 // In new development using the ingest process, it will be the record id from SALT.  
															 // For CCPA, this field is not required to be populated.  

END;	

EXPORT clean_phones :=
	record
		string10   	Phone                        ;     
		string10   	Fax                          ;      
		string10   	Telex                        ;     
END;

EXPORT Base_Contacts := RECORD 
			unsigned6														rcid											;
			unsigned6														did												;
			unsigned1														did_score									;
			BIPV2.IDlayouts.l_xlink_ids																		;
			unsigned4   												dt_first_seen							;
			unsigned4   												dt_last_seen							;
			unsigned4   												dt_vendor_first_reported	;
			unsigned4   												dt_vendor_last_reported		;
			string1  													  record_type					 := ''; 
		  unsigned4         									process_date          := 0;
			Address.Layout_Clean_Name           clean_name                ; 
			Address.Layout_Clean182_fips        clean_company_address     ;	
		  string10									      		clean_company_phone		:='';			
			string75                            company_name         := '';
			string10                            company_phone        := '';
			string1                             company_record_type  := '';
			unsigned4  	                     company_date_first_seen :=  0;
			unsigned4  	                     company_date_last_seen  :=  0;
			unsigned8     	 				  					raw_aid							 :=  0;
		  unsigned8					      						ace_aid							 :=  0;
	    Sprayed_Input_Contacts                                        ;	
			string50                      Exploded_Title_Description := '';
		  unsigned4                                     global_sid :=  0;   
      unsigned8                                     record_sid :=  0; 
END;		
	  		
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	EXPORT Temp := MODULE
				
	  EXPORT BIPSlim := RECORD
			UNSIGNED8		unique_id;
			STRING80  	company;
			STRING10  	prim_range;
			STRING28		prim_name;
			STRING8			sec_range;
			STRING25 		city;   		      // p_city
			STRING2			state;
			STRING5			zip5;
			string20 		fname;
			string20 		mname;
			string20 		lname;
			STRING10		phone;
			STRING      url;
			string      email;
			BIPV2.IDlayouts.l_xlink_ids;
	  END;
					
	  EXPORT DidSlim := RECORD
			UNSIGNED8		unique_id    :=  0;
			STRING50    title        := '';
			STRING20 		fname        := '';
			STRING20 		mname        := '';
			STRING20 		lname        := '';
			string5  		name_suffix		    ;
			string10  	prim_range			  ;
			string28		prim_name				  ;
			string8			sec_range			 	  ;
			string5			zip5						  ;
			string2			state						  ;
			string10		phone						  ;
			string8			dob							  ;
			string9			ssn							  ;
			UNSIGNED6		did           := 0;
			UNSIGNED1		did_score		  := 0;	
			UNSIGNED6		bdid				  := 0;
			UNSIGNED1		bdid_score	  := 0;		
			BIPV2.IDlayouts.l_xlink_ids   ;
	  END;
		
		EXPORT UniqueId := RECORD
 		  UNSIGNED8		unique_id;
		  Base;
		END;		
		
		EXPORT UniqueIdContacts := RECORD
 		  UNSIGNED8		unique_id;
		  Base_Contacts;
		END;
    
	END;  //End Temporary
	
END;  //End Layouts