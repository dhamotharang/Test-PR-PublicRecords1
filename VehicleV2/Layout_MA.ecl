import	AID;

export	Layout_MA	:=
module

	export	RAW	:= 	RECORD
	
		//01 OUTPUT-REGISTRATION-RECORD. Document provided by vendor - Reg Data Unpacked.docx. 2/25/14
    STRING4	  			VEHC_SURROGATE;			     			//04  OUT-VEHC-SURROGATE            PIC 9(4)   001-004  
    STRING1					CUMULATIVE_INTERFACE_CODE;		//04  OUT-CUMULATIVE-INTERFACE-CODE PIC X(01)  005-005   
                                                  //04  OUT-VEHICLE-DATA.   
		STRING3					REG_PREFIX;										//08  OUT-REG-PREFIX                PIC X(03)  006-008   
		STRING1					REG_COLOR;										//08  OUT-REG-COLOR                	PIC X(01)  009-009 
																									//		R-Red,G-Green,Y-Yellow,B-Blue,A-Authority,S-State,M-Municiple,V-Varible,W-White
		STRING7					REG_NUMBER;										//08  OUT-REG-NUMBER                PIC X(07)  010-016   
		STRING1					REG_EFF_DATE_FILLER;					//08  OUT-REG-EFF-DATE-YYYYMMDD     PIC 9(9)   017-025
		STRING8					REG_EFF_DATE;									//08  OUT-REG-EFF-DATE-YYYYMMDD     PIC 9(9)   017-025
		STRING1					REG_EXP_DATE_FILLER;					//08  OUT-REG-EXP-DATE-YYYYMM       PIC 9(7)   026-032 
		STRING6					REG_EXP_DATE;									//08  OUT-REG-EXP-DATE-YYYYMM       PIC 9(7)   026-032 
		STRING1         REG_PLTISS_DATE_FILLER;				//08  OUT-REG-PLTISS-DATE-YYYYMMDD  PIC 9(9)   033-041   
		STRING8         REG_PLTISS_DATE;							//08  OUT-REG-PLTISS-DATE-YYYYMMDD  PIC 9(9)   033-041   
		STRING1					REG_STACHG_DATE_FILLER;				//08  OUT-REG-STACHG-DATE-YYYYMMDD  PIC 9(9)   042-050
		STRING8					REG_STACHG_DATE;							//08  OUT-REG-STACHG-DATE-YYYYMMDD  PIC 9(9)   042-050
		STRING17				VEH_VIN;											//08  OUT-VEH-VIN                   PIC X(17)  051-067
		STRING1			  	VEH_YRMFGR_FILLER;						//08  OUT-VEH-YRMFGR                PIC 9(5)   068-072  
		STRING4     		VEH_YRMFGR;										//08  OUT-VEH-YRMFGR                PIC 9(5)   068-072  
		STRING5					VEH_MFGR;	                    //08  OUT-VEH-MFGR                  PIC X(05)  073-077 
		STRING5					VEH_BODY_STYLE;               //08  OUT-VEH-BODY-STYLE            PIC X(05)  078-082 
		STRING3					VEH_NUM_CYLL;	                //08  OUT-VEH-NUM-CYLL              PIC 9(3)   083-085   
    STRING3					VEH_NUM_PASS;           			//08  OUT-VEH-NUM-PASS              PIC 9(3)   086-088   
    STRING1					VEH_NUM_DOORS;	           		//08  OUT-VEH-NUM-DOORS             PIC 9(1)   089-089   
    STRING1					COLOR_MAJOR;									//08  OUT-COLOR-MAJOR               PIC X(01)  090-090  
																									//    1-Black,2-Blue,3-Brown,4-Red,5-Yellow,6-Green,7-White,8-Gray,9-Purple,0-Orange,blank-no colur
    STRING1         COLOR_MINOR;  								//08  OUT-COLOR-MINOR               PIC X(01)  091-091   
    STRING6         VEH_MODL_NUMB;  							//08  OUT-VEH-MODL-NUMB             PIC X(06)  092-097   
    STRING6         VEH_MODL_NAME;  							//08  OUT-VEH-MODL-NAME             PIC X(06)  098-103   
    STRING1         TRANSMISSION_TYPE;  					//08  OUT-TRANSMISSION-TYPE         PIC X(01)  104-104   
    STRING3         COMMERCIAL_GVW_THOUSANDS;  		//08  OUT-COMMERCIAL-GVW-THOUSANDS  PIC 9(3)   105-107   
    STRING2         TITLE_PREFIX;  								//08  OUT-TITLE-PREFIX              PIC X(02)  108-109   
    STRING7         TITLE_NUMBER;   							//08  OUT-TITLE-NUMBER              PIC 9(7)   110-116   
    STRING1         VEHR_TYPE;  									//08  OUT-VEHR-TYPE                 PIC X(01)  117-117   
    STRING1         VEHR_ADVANCED;  							//08  OUT-VEHR-ADVANCED             PIC X(01)  118-118   
    STRING3         PLACE_OF_GARAGING;  					//08  OUT-PLACE-OF-GARAGING         PIC 9(3)   119-121   
    STRING1         VEHC_TYPE;  									//08  OUT-VEHC-TYPE                 PIC X(01)  122-122   
    STRING1         JUNKED_VEHICLE;  							//08  OUT-JUNKED-VEHICLE            PIC X(01)  123-123   
    STRING3         INSURANCE_CODE;  							//08  OUT-INSURANCE-CODE            PIC 9(3)   124-126   
																									//04  OUT-VEH_MAILING-ADDRESS.                               
    STRING20        VEHMAIL_STREET1;							//08  OUT-VEHMAIL-STREET1           PIC X(20)  127-146   
    STRING20        VEHMAIL_STREET2;   						//08  OUT-VEHMAIL-STREET2           PIC X(20)  147-166   
    STRING15        VEHMAIL_CITY;   							//08  OUT-VEHMAIL-CITY              PIC X(15)  167-181   
    STRING2         VEHMAIL_ST;		  							//08  OUT-VEHMAIL-STATE             PIC X(02)  182-183   
    STRING9         VEHMAIL_ZIP;  								//08  OUT-VEHMAIL-ZIP               PIC 9(9)   184-192   
																									//04  OUT-OWNER1-DATA.                                       
    STRING1         OWNER1_TYPE; 									//08  OUT-OWNER1-TYPE               PIC X(01)  193-193   
																									//08  OUT-OWNER1-CORPORATE-FIDNO.                        
    STRING9         OWNER1_LICNO;     						//12  OUT-OWNER1-LICNO          		PIC X(09)  194-202   
    STRING1         OWNER1_BDATE_FILLER;					//08  OUT-OWNER1-BDATE-YYYYMMDD     PIC 9(9)   203-211   
    STRING8         OWNER1_BDATE;									//08  OUT-OWNER1-BDATE-YYYYMMDD     PIC 9(9)   203-211   
    STRING1         OWNER1_EDATE_FILLER;					//08  OUT-OWNER1-EDATE-YYYYMMDD     PIC 9(9)   212-220   
    STRING8         OWNER1_EDATE;									//08  OUT-OWNER1-EDATE-YYYYMMDD     PIC 9(9)   212-220   
    STRING2         OWNER1_LIC_CLASS; 						//08  OUT-OWNER1-LIC-CLASS          PIC X(02)  221-222   
    STRING3         OWNER1_HEIGHT; 								//08  OUT-OWNER1-HEIGHT             PIC 9(3)   223-225   
    STRING1         OWNER1_SEX; 									//08  OUT-OWNER1-SEX                PIC X(01)  226-226   
																									//08  OUT-OWNER1-NAME-NOWN.                              
    STRING16        OWNER1_LAST_NAME;      				//12  OUT-OWNER1-LAST-NAME      		PIC X(16)  227-242   
    STRING1         FILLER1;     									//12  FILLER                    		PIC X(01)  243-243   
    STRING12        OWNER1_FIRST_NAME;						//12  OUT-OWNER1-FIRST-NAME     		PIC X(12)  244-255   
    STRING1         FILLER2;     									//12  FILLER                    		PIC X(01)  256-256   
    STRING8         OWNER1_MIDDLE_NAME;     			//12  OUT-OWNER1-MIDDLE-NAME    		PIC X(08)  257-264   
    STRING26        FILLER3;      								//12  FILLER                    		PIC X(26)  265-290   
    STRING20        OWNER1_MAIL_STREET1;  				//08  OUT-OW1MAIL-STREET1           PIC X(20)  291-310   
    STRING20        OWNER1_MAIL_STREET2;  				//08  OUT-OW1MAIL-STREET2           PIC X(20)  311-330   
    STRING15        OWNER1_MAIL_CITY;  						//08  OUT-OW1MAIL-CITY              PIC X(15)  331-345   
    STRING2         OWNER1_MAIL_ST;	 							//08  OUT-OW1MAIL-STATE             PIC X(02)  346-347   
    STRING9         OWNER1_MAIL_ZIP; 							//08  OUT-OW1MAIL-ZIP               PIC 9(9)   348-356   
    STRING20        OWNER1_RESI_STREET1;  				//08  OUT-OW1RESI-STREET1           PIC X(20)  357-376   
    STRING20        OWNER1_RESI_STREET2;  				//08  OUT-OW1RESI-STREET2           PIC X(20)  377-396   
    STRING15        OWNER1_RESI_CITY;  						//08  OUT-OW1RESI-CITY              PIC X(15)  397-411   
    STRING2         OWNER1_RESI_ST; 							//08  OUT-OW1RESI-STATE             PIC X(02)  412-413   
    STRING9         OWNER1_RESI_ZIP; 							//08  OUT-OW1RESI-ZIP               PIC 9(9)   414-422   
																									//04  OUT-OWNER2-DATA.                                       
    STRING1         OWNER2_TYPE; 									//08  OUT-OWNER2-TYPE               PIC X(01)  423-423   
																									//08  OUT-OWNER2-CORPORATE-FIDNO.                        
    STRING9         OWNER2_LICNO;     						//12  OUT-OWNER2-LICNO          		PIC X(09)  424-432   
    STRING1         OWNER2_BDATE_FILLER;					//08  OUT-OWNER2-BDATE-YYYYMMDD     PIC 9(9)   433-441   
    STRING8         OWNER2_BDATE; 								//08  OUT-OWNER2-BDATE-YYYYMMDD     PIC 9(9)   433-441   
    STRING1         OWNER2_EDATE_FILLER;					//08  OUT-OWNER2-EDATE-YYYYMMDD     PIC 9(9)   442-450   
    STRING8         OWNER2_EDATE; 								//08  OUT-OWNER2-EDATE-YYYYMMDD     PIC 9(9)   442-450   
    STRING2         OWNER2_LIC_CLASS; 						//08  OUT-OWNER2-LIC-CLASS          PIC X(02)  451-452   
    STRING3         OWNER2_HEIGHT; 								//08  OUT-OWNER2-HEIGHT             PIC 9(3)   453-455   
    STRING1         OWNER2_SEX; 									//08  OUT-OWNER2-SEX                PIC X(01)  456-456   
																									//08  OUT-OWNER2_NAME-NOWN.                              
    STRING16        OWNER2_LAST_NAME;      				//12  OUT-OWNER2-LAST-NAME      		PIC X(16)  457-472   
    STRING1         FILLER4;											//12  FILLER                    		PIC X(01)  473-473   
    STRING12        OWNER2_FIRST_NAME;      			//12  OUT-OWNER2-FIRST-NAME     		PIC X(12)  474-485   
    STRING1         FILLER5;     									//12  FILLER                    		PIC X(01)  486-486     
    STRING8         OWNER2_MIDDLE_NAME;     			//12  OUT-OWNER2-MIDDLE-NAME    		PIC X(08)  487-494     
    STRING26        FILLER6;      								//12  FILLER                    		PIC X(26)  495-520     
    STRING20        OWNER2_MAIL_STREET1;  				//08  OUT-OW2MAIL-STREET1           PIC X(20)  521-540     
    STRING20        OWNER2_MAIL_STREET2;  				//08  OUT-OW2MAIL-STREET2           PIC X(20)  541-560     
    STRING15        OWNER2_MAIL_CITY;  						//08  OUT-OW2MAIL-CITY              PIC X(15)  561-575     
    STRING2         OWNER2_MAIL_ST; 							//08  OUT-OW2MAIL-STATE             PIC X(02)  576-577     
    STRING9         OWNER2_MAIL_ZIP; 							//08  OUT-OW2MAIL-ZIP               PIC 9(9)   578-586     
    STRING20        OWNER2_RESI_STREET1;  				//08  OUT-OW2RESI-STREET1           PIC X(20)  587-606     
    STRING20        OWNER2_RESI_STREET2;  				//08  OUT-OW2RESI-STREET2           PIC X(20)  607-626     
    STRING15        OWNER2_RESI_CITY;							//08  OUT-OW2RESI-CITY              PIC X(15)  627-641     
    STRING2         OWNER2_RESI_ST;								//08  OUT-OW2RESI-STATE             PIC X(02)  642-643     
    STRING9         OWNER2_RESI_ZIP;							//08  OUT-OW2RESI-ZIP               PIC 9(9)   644-652     
    STRING9      		EXCISE_MSRP;									//04  OUT-EXCISE-MSRP               PIC 9(9)   653-661     
																									//04  OUT-ADDTNL-TITLE-DATA.                                   
    STRING5         VEHT_LIEN_KEY1;								//08  OUT-VEHT-LIEN-KEY1            PIC 9(05)  662-666     
    STRING1         VEHT_LIEN_TYPE1; 							//08  OUT-VEHT-LIEN-TYPE1           PIC X      667-667     
    STRING5         VEHT_LIEN_KEY2; 							//08  OUT-VEHT-LIEN-KEY2            PIC 9(05)  668-672     
    STRING1         VEHT_LIEN_TYPE2;							//08  OUT-VEHT-LIEN-TYPE2           PIC X      673-673     
    STRING9         VEHT_TITLE_MILAGE;						//08  OUT-VEHT-TITLE-MILAGE         PIC 9(9)   674-682     
    STRING1         VEHT_PURCHDATE_FILLER;				//08  OUT-VEHT-PURCHDATE-YYYYMMDD   PIC 9(9)   683-691     
    STRING8         VEHT_PURCHDATE;								//08  OUT-VEHT-PURCHDATE-YYYYMMDD   PIC 9(9)   683-691     
    STRING1         VEHT_TITLEDATE_FILLER;				//08  OUT-VEHT-TITLEDATE-YYYYMMDD   PIC 9(9)   692-700     
    STRING8         VEHT_TITLEDATE;								//08  OUT-VEHT-TITLEDATE-YYYYMMDD   PIC 9(9)   692-700     
    STRING1         VEHT_NEW_USED; 								//08  OUT-VEHT-NEW-USED             PIC X(01)  701-701     
    STRING1         VEHT_TITLE_BRAN; 							//08  OUT-VEHT-TITLE-BRAN           PIC X(01)  702-702     
    STRING55        BRAN_TABLE_BASE;							//08  OUT-BRAN-TABLE-BASE           PIC X(55)  703-757     
		string2					crlf;

	END;
	
	//------------------------------------------------------------
	//ADD NAME TYPE INDICATORS
	//------------------------------------------------------------
	export	PREPPED	:=
	record
		RAW;
		string8	Process_Date;
		string2	state_origin;
		string2	source_code;
		string1	Append_Owner1NameTypeInd	:=	'';
		string1	Append_Owner2NameTypeInd	:=	'';
		string10 OWNER1_SUFFIX_NAME;
		string10 OWNER2_SUFFIX_NAME;
	end;

	EXPORT AID_ADDR	:= RECORD
		STRING100				Append_MailAddr1;
		STRING50				Append_MailAddr2;
		AID.Common.xAID	Append_MailRawAID:=0;
		STRING10        veh_mail_prim_range;
		STRING2         veh_mail_predir;
		STRING28        veh_mail_prim_name;
		STRING4         veh_mail_suffix;
		STRING2         veh_mail_postdir;
		STRING10        veh_mail_unit_desig;
		STRING8         veh_mail_sec_range;
		STRING25        veh_mail_p_city_name;
		STRING25        veh_mail_v_city_name;
		STRING2         veh_mail_state;
		STRING5         veh_mail_zip5;
		STRING4         veh_mail_zip4;
		STRING2					veh_mail_rec_type;
		STRING5         veh_mail_county;
		STRING10        veh_mail_geo_lat;
		STRING11        veh_mail_geo_long;
		string4					veh_mail_cbsa;
		string7					veh_mail_geo_blk;
		string1					veh_mail_geo_match;
		STRING4					veh_mail_err_stat;
		string100				Append_Owner1MailAddr1;
		string50				Append_Owner1MailAddr2;
		AID.Common.xAID	Append_Owner1MailRawAID:=0;
		STRING10        owner1_mail_prim_range;
		STRING2         owner1_mail_predir;
		STRING28        owner1_mail_prim_name;
		STRING4         owner1_mail_suffix;
		STRING2         owner1_mail_postdir;
		STRING10        owner1_mail_unit_desig;
		STRING8         owner1_mail_sec_range;
		STRING25        owner1_mail_p_city_name;
		STRING25        owner1_mail_v_city_name;
		STRING2         owner1_mail_state;
		STRING5         owner1_mail_zip5;
		STRING4         owner1_mail_zip4;
		STRING2					owner1_mail_rec_type;
		STRING5         owner1_mail_county;
		STRING10        owner1_mail_geo_lat;
		STRING11        owner1_mail_geo_long;
		string4					owner1_mail_cbsa;
		string7					owner1_mail_geo_blk;
		string1					owner1_mail_geo_match;
		STRING4					owner1_mail_err_stat;
		string100				Append_Owner1ResiAddr1;
		string50				Append_Owner1ResiAddr2;
		AID.Common.xAID	Append_Owner1ResiRawAID:=0;
		STRING10        owner1_resi_prim_range;
		STRING2         owner1_resi_predir;
		STRING28        owner1_resi_prim_name;
		STRING4         owner1_resi_suffix;
		STRING2         owner1_resi_postdir;
		STRING10        owner1_resi_unit_desig;
		STRING8         owner1_resi_sec_range;
		STRING25        owner1_resi_p_city_name;
		STRING25        owner1_resi_v_city_name;
		STRING2         owner1_resi_state;
		STRING5         owner1_resi_zip5;
		STRING4         owner1_resi_zip4;
		STRING2					owner1_resi_rec_type;
		STRING5         owner1_resi_county;
		STRING10        owner1_resi_geo_lat;
		STRING11        owner1_resi_geo_long;
		string4					owner1_resi_cbsa;
		string7					owner1_resi_geo_blk;
		string1					owner1_resi_geo_match;
		STRING4					owner1_resi_err_stat;
		string100				Append_Owner2MailAddr1;
		string50				Append_Owner2MailAddr2;
		AID.Common.xAID	Append_Owner2MailRawAID:=0;
		STRING10        owner2_mail_prim_range;
		STRING2         owner2_mail_predir;
		STRING28        owner2_mail_prim_name;
		STRING4         owner2_mail_suffix;
		STRING2         owner2_mail_postdir;
		STRING10        owner2_mail_unit_desig;
		STRING8         owner2_mail_sec_range;
		STRING25        owner2_mail_p_city_name;
		STRING25        owner2_mail_v_city_name;
		STRING2         owner2_mail_state;
		STRING5         owner2_mail_zip5;
		STRING4         owner2_mail_zip4;
		STRING2					owner2_mail_rec_type;
		STRING5         owner2_mail_county;
		STRING10        owner2_mail_geo_lat;
		STRING11        owner2_mail_geo_long;
		string4					owner2_mail_cbsa;
		string7					owner2_mail_geo_blk;
		string1					owner2_mail_geo_match;
		STRING4					owner2_mail_err_stat;
		string100				Append_Owner2ResiAddr1;
		string50				Append_Owner2ResiAddr2;
		AID.Common.xAID	Append_Owner2ResiRawAID:=0;
		STRING10        owner2_resi_prim_range;
		STRING2         owner2_resi_predir;
		STRING28        owner2_resi_prim_name;
		STRING4         owner2_resi_suffix;
		STRING2         owner2_resi_postdir;
		STRING10        owner2_resi_unit_desig;
		STRING8         owner2_resi_sec_range;
		STRING25        owner2_resi_p_city_name;
		STRING25        owner2_resi_v_city_name;
		STRING2         owner2_resi_state;
		STRING5         owner2_resi_zip5;
		STRING4         owner2_resi_zip4;
		STRING2					owner2_resi_rec_type;
		STRING5         owner2_resi_county;
		STRING10        owner2_resi_geo_lat;
		STRING11        owner2_resi_geo_long;
		string4					owner2_resi_cbsa;
		string7					owner2_resi_geo_blk;
		string1					owner2_resi_geo_match;
		STRING4					owner2_resi_err_stat;

	END;
	EXPORT CLEAN_ADDR_NAME := RECORD
		PREPPED;
		unsigned6 			Append_SeqNum:=0;
		AID_ADDR;
		STRING16				RAW_OWNER1_LNAME;
		STRING12				RAW_OWNER1_FNAME;
		STRING8					RAW_OWNER1_MNAME;
		STRING8					OWNER1_SNAME;
		STRING50				COMPANY_NAME1;
		STRING50				APPEND_OWNER1_NAME;
		STRING20				OWNER1_CLEAN_LNAME;
		STRING20				OWNER1_CLEAN_FNAME;
		STRING20				OWNER1_CLEAN_MNAME;
		STRING5					OWNER1_CLEAN_TITLE;
		STRING5					OWNER1_CLEAN_SUFFIX;
		STRING16				RAW_OWNER2_LNAME;
		STRING12				RAW_OWNER2_FNAME;
		STRING8					RAW_OWNER2_MNAME;
		STRING8					OWNER2_SNAME;
		STRING50				COMPANY_NAME2;
		STRING50				APPEND_OWNER2_NAME;
		STRING20				OWNER2_CLEAN_LNAME;
		STRING20				OWNER2_CLEAN_FNAME;
		STRING20				OWNER2_CLEAN_MNAME;
		STRING5					OWNER2_CLEAN_TITLE;
		STRING5					OWNER2_CLEAN_SUFFIX;


	END;
		
	EXPORT	MA_as_VehicleV2	:=
	record
		string30				VEHICLE_KEY;
		string15				ITERATION_KEY;
		string15				SEQUENCE_KEY;
		unsigned4    		DT_FIRST_SEEN;
		unsigned4				DT_LAST_SEEN;
		unsigned4    		DT_VENDOR_FIRST_REPORTED;
		unsigned4    		DT_VENDOR_LAST_REPORTED;
		//string8					VEHT_PURCHDATE;
		string2     		STATE_ORIGIN;
		string1     		VINA_VINFLAG;
		string1					History;
		string2     		source_code;
		//string2     		CategoryCode;
		STRING3					RAW_REG_PREFIX;
		STRING3					PLATE_TYPE;
		string25				RAW_VIN;
		string25    		ORIG_VIN;
		string4					RAW_VEH_YRMFGR;
		string4    			YEAR_MAKE;
		STRING5					RAW_VEH_MFGR;
		string5    			MAKE_CODE;
		string5    			Orig_MAKE_CODE;
		STRING5					RAW_VEH_BODY_STYLE;
		string5    			BODY_CODE;
		string25        body_style_desc;
    STRING6         RAW_VEH_MODL_NUMB; 	
    STRING6         RAW_VEH_MODL_NAME;
		string36        ORIG_MODEL_DESC;
		STRING1					RAW_TRANSMISSION_TYPE;
		STRING3					RAW_COMMERCIAL_GVW_THOUSANDS;
		STRING3					RAW_VEH_NUM_CYLL;
		UNSIGNED2				number_of_cylinders;
		
		STRING2					RAW_TITLE_PREFIX;
		STRING7					RAW_TITLE_NUMBER;
		string20        TITLE_NUMBER;
		STRING9					RAW_VEHT_TITLE_MILAGE;
		STRING8					RAW_VEHT_PURCHDATE;
		STRING8					RAW_VEHT_TITLEDATE;
		STRING8					TITLE_ISSUE_DATE;
		
		string3					Orig_Series_Code;
		string6     		ORIG_GROSS_WEIGHT;
		
		string3         VESSEL_TYPE;
		//string1         NUMBER_OF_AXLES;
		//string1         VEHICLE_USE;
		string10        LICENSE_PLATE_NUMBERxBG4;
		string8					RAW_REG_PLTISS_DATE;
		string8					REGISTRATION_ISSUE_DATE;
		STRING8					RAW_REG_EFF_DATE;
		string8         REGISTRATION_EFFECTIVE_DATE;
		STRING8					RAW_REG_EXP_DATE;
		string8         REGISTRATION_EXPIRATION_DATE;
		string1         REGISTRATION_STATUS_CODE;
		string10        TRUE_LICENSE_PLSTE_NUMBER;  
		STRING1					RAW_VEHR_TYPE;
		STRING1					RAW_VEHC_TYPE;
		string4    			VEHICLE_TYPE;
		STRING1					RAW_MAJOR_COLOR_CODE;
		STRING3					ORIG_MAJOR_COLOR_CODE;
		STRING1					RAW_MINOR_COLOR_CODE;
		STRING3					ORIG_MINOR_COLOR_CODE;

		STRING20        RAW_VEHMAIL_STREET1;  
    STRING20        RAW_VEHMAIL_STREET2;   
    STRING15        RAW_VEHMAIL_CITY;   
    STRING2         RAW_VEHMAIL_STATE;   
    STRING9         RAW_VEHMAIL_ZIP;  
		
		STRING1					RAW_OWNER1_TYPE;
		STRING9					RAW_OWNER1_LIC_NUM;
		STRING8					RAW_OWNER1_BDATE;
		STRING8					RAW_OWNER1_EDATE;
		STRING2					RAW_OWNER1_LIC_CLASS;
		STRING16				RAW_OWNER1_LNAME;
		STRING12				RAW_OWNER1_FNAME;
		STRING8					RAW_OWNER1_MNAME;
		STRING50				COMPANY_NAME1;
		STRING50				APPEND_OWNER1_NAME;
		STRING1					Append_Owner1NameTypeInd;
		STRING20				OWNER1_CLEAN_LNAME;
		STRING20				OWNER1_CLEAN_FNAME;
		STRING20				OWNER1_CLEAN_MNAME;
		STRING5					OWNER1_CLEAN_TITLE;
		STRING5					OWNER1_CLEAN_SUFFIX;
		STRING20				RAW_OWNER1_MAIL_STREET1;
		STRING20				RAW_OWNER1_MAIL_STREET2;
		STRING15				RAW_OWNER1_MAIL_CITY;
		STRING2					RAW_OWNER1_MAIL_STATE;
		STRING9					RAW_OWNER1_MAIL_ZIP;
		STRING20				RAW_OWNER1_RESI_STREET1;
		STRING20				RAW_OWNER1_RESI_STREET2;
		STRING15				RAW_OWNER1_RESI_CITY;
		STRING2					RAW_OWNER1_RESI_STATE;
		STRING9					RAW_OWNER1_RESI_ZIP;
		
		STRING1					RAW_OWNER2_TYPE;
		STRING9					RAW_OWNER2_LIC_NUM;
		STRING8					RAW_OWNER2_BDATE;
		STRING8					RAW_OWNER2_EDATE;
		STRING2					RAW_OWNER2_LIC_CLASS;
		STRING16				RAW_OWNER2_LNAME;
		STRING12				RAW_OWNER2_FNAME;
		STRING8					RAW_OWNER2_MNAME;
		STRING50				COMPANY_NAME2;
		STRING50				APPEND_OWNER2_NAME;
		STRING1					Append_Owner2NameTypeInd;
		STRING20				OWNER2_CLEAN_LNAME;
		STRING20				OWNER2_CLEAN_FNAME;
		STRING20				OWNER2_CLEAN_MNAME;
		STRING5					OWNER2_CLEAN_TITLE;
		STRING5					OWNER2_CLEAN_SUFFIX;
		STRING20				RAW_OWNER2_MAIL_STREET1;
		STRING20				RAW_OWNER2_MAIL_STREET2;
		STRING15				RAW_OWNER2_MAIL_CITY;
		STRING2					RAW_OWNER2_MAIL_STATE;
		STRING9					RAW_OWNER2_MAIL_ZIP;
		STRING20				RAW_OWNER2_RESI_STREET1;
		STRING20				RAW_OWNER2_RESI_STREET2;
		STRING15				RAW_OWNER2_RESI_CITY;
		STRING2					RAW_OWNER2_RESI_STATE;
		STRING9					RAW_OWNER2_RESI_ZIP;
		//AID fields
		AID_ADDR;
		
		//****VINA fields start
		string1 				VINA_Veh_Type;
		string5 				VINA_NCIC_Make;
		string2 				VINA_Model_Year_YY;
		string17				VINA_VIN;
		string1 				VINA_VIN_Pattern_Indicator;
		string1 				VINA_Bypass_Code;
		string1 				VINA_VP_Restraint;
		string4 				VINA_VP_Abbrev_Make_Name;
		string2 				VINA_VP_Year;
		string3 				VINA_VP_Series;
		string3 				VINA_VP_Model;
		string1 				VINA_VP_Air_Conditioning;
		string1 				VINA_VP_Power_Steering;
		string1 				VINA_VP_Power_Brakes;
		string1 				VINA_VP_Power_Windows;
		string1 				VINA_VP_Tilt_Wheel;
		string1 				VINA_VP_Roof;
		string1 				VINA_VP_Optional_Roof1;
		string1 				VINA_VP_Optional_Roof2;
		string1 				VINA_VP_Radio;
		string1 				VINA_VP_Optional_Radio1;
		string1 				VINA_VP_Optional_Radio2;
		string1 				VINA_VP_Transmission;
		string1 				VINA_VP_Optional_Transmission1;
		string1 				VINA_VP_Optional_Transmission2;
		string1 				VINA_VP_Anti_Lock_Brakes;
		string1 				VINA_VP_Front_Wheel_Drive;
		string1 				VINA_VP_Four_Wheel_Drive;
		string1 				VINA_VP_Security_System;
		string1 				VINA_VP_Daytime_Running_Lights;
		string25				VINA_VP_Series_Name;
		string4 				VINA_Model_Year;
		string3 				VINA_Series;
		string3 				VINA_Model;
		string2 				VINA_Body_Style;
		string36				VINA_Make_Desc;
		string36				VINA_Model_Desc;
		string25				VINA_Series_Desc;
		string25				VINA_Body_Style_Desc;
		string2 				VINA_Number_Of_Cylinders;
		string4 				VINA_Engine_Size;
		string1 				VINA_Fuel_Code;
		string6 				VINA_Price;
		string5					Best_Make_Code;
		string3					Best_Series_Code;
		string3					Best_Model_Code;
		string5					Best_Body_Code;
		string4					Best_Model_Year;
		string3					Best_Major_Color_Code;
		string3					Best_Minor_Color_Code;
				//****VINA fields End

		string3         MAJOR_COLOR_CODE;
		string3         MINOR_COLOR_CODE;  
		string15				orig_Major_Color_Desc;
		string15				orig_Minor_Color_Desc;
		string20				Orig_Body_Desc;
		string25				Orig_Series_Desc;
		string30        Orig_Vehicle_Use_Desc;
		string30				Orig_Vehicle_Type_Desc;
		string1					VEHICLE_USE;
		//These fields are set to vina_.. value in MA_As_Base
		string4         model_year; 
		string36        make_desc;	
		STRING3					MODEL;
		string36        model_desc;
		string40        vehicle_type_desc;
		string25        series_desc;
		string15        major_color_desc;
		string15        minor_color_desc;
		string36        make_description;
		string36        model_description;
		string25        series_description;
		string25        body_style_description;
		unsigned8				source_rec_id := 0;	 	//Added for BIP project
		//Fields in the vendor dataset and are not used by LN
		STRING4					RAW_VEHC_SURROGATE;
		STRING1					RAW_CUMULATIVE_INTERFACE_CODE;
		STRING1					RAW_REG_COLOR;
		STRING8					RAW_REG_STACHG_DATE;
		STRING3					RAW_VEH_NUM_PASS;
		STRING1					RAW_VEH_NUM_DOORS;
		STRING1					RAW_VEHR_ADVANCED;
		STRING3					RAW_PLACE_OF_GARAGING;
		STRING1					RAW_JUNKED_VEHICLE;
		STRING3					RAW_INSURANCE_CODE;
		STRING3					RAW_OWNER1_HEIGHT;
		STRING1					RAW_OWNER1_SEX;
		STRING3					RAW_OWNER2_HEIGHT;
		STRING1					RAW_OWNER2_SEX;
		STRING9					RAW_EXCISE_MSRP;
		STRING5					RAW_VEHT_LIEN_KEY1;
		STRING1					RAW_VEHT_LIEN_TYPE1;
		STRING5					RAW_VEHT_LIEN_KEY2;
		STRING1					RAW_VEHT_LIEN_TYPE2;
		STRING1					RAW_VEHT_NEW_USED;
		STRING1					RAW_VEHT_TITLE_BRAN;
		STRING55				RAW_BRAN_TABLE_BASE;
		//Added for CCPA-103
		UNSIGNED4       global_sid := 0;
		UNSIGNED8       record_sid := 0;
	end;

end;