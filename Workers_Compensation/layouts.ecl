IMPORT Workers_Compensation,address,AID,bipv2;

EXPORT Layouts := MODULE

	SHARED max_size := _Dataset().max_record_size;

	EXPORT Input := RECORD,MAXLENGTH(40000)
					STRING Master_UID;
					STRING Unique_ID;
					STRING RMID;
					STRING Business_Name;  					//Changed from Description 9/11/2015
					STRING ADDRESS;
					STRING City;
					STRING STATE;
					STRING ZIP;
					STRING ZipPlus4;
					STRING ClassCode; 							/* these are state class codes and no lookup table is available */
					STRING Effective_Month_Day ;
					STRING Policy_Eff_Month; 				//Changed from EffectiveMonth 9/11/2015
					STRING Carrier_NAIC_Name;//Changed from NAICCarrierName 9/11/2015
					STRING Carrier_NAIC_Id; 				//Changed from NAICCarrierNumber 9/11/2015
					STRING Group_NAIC_NAME; 	//Changed from NAICGroupName 9/11/2015
					STRING Group_NAIC_Id; 					//Changed from NAICGroupNumber 9/11/2015
					STRING FEIN;
					STRING Policy_Number; 					//Changed from PolicySelf 9/11/2015
					STRING Record_Type;
					STRING Insured_Status ; 				/* New field added 3/26/12 */
					STRING EMP_SICCode; 						/* New field added 9/11/2015*/
					STRING EMP_SicCode_ID; 					/* New field added 9/11/2015*/
					STRING EMP_Phone; 							/* New field added 9/11/2015*/
					STRING EMP_Phone_ID; 						/* New field added 9/11/2015*/
					STRING EMP_Contact_Name; 				/* New field added 9/11/2015*/
					STRING EMP_Contact_Name_ID; 		/* New field added 9/11/2015*/
					STRING Emp_Size_Ind; 						/* New field added 9/11/2015*/
					STRING Emp_Size_ID; 						/* New field added 9/11/2015*/
					STRING ID; 											/* New field added 9/11/2015*/
					STRING Build_Status; 						/* New field added 9/11/2015*/
					STRING Prior_Policy_Number; 		/* New field added 9/11/2015*/
					STRING OldID; 									/* New field added 9/11/2015*/
					STRING SecID; 									/* New field added 9/11/2015*/
					STRING Business_Name_Std; 			/* New field added 9/11/2015*/
					STRING SecName; 								/* New field added 9/11/2015*/
					STRING DbaSplit; 								/* New field added 9/11/2015*/
					STRING ZIP3; 										/* New field added 9/11/2015*/
					STRING County_Name; 						/* New field added 9/11/2015*/
					STRING COUNTY_FIPS_ID; 					/* New field added 9/11/2015*/
					STRING Policy_Eff_Date; 				/* New field added 9/11/2015*/
					STRING Policy_CANCEL_EFF_DATE; 	/* New field added 9/11/2015*/
					STRING ACE_PRIM_RANGE; 					/* New field added 9/11/2015*/
					STRING ACE_PREDIR; 							/* New field added 9/11/2015*/
					STRING ACE_PRIM_NAME; 					/* New field added 9/11/2015*/
					STRING ACE_ADDR_SUFFIX; 				/* New field added 9/11/2015*/
					STRING ACE_UNIT_DESIG; 					/* New field added 9/11/2015*/
					STRING CASSCodeID; 							/* New field added 9/11/2015*/
					STRING CASSDate; 								/* New field added 9/11/2015*/
					STRING COAMoveType; 						/* New field added 9/11/2015*/
					STRING COAMatchType; 						/* New field added 9/11/2015*/
					STRING COAFootNote; 						/* New field added 9/11/2015*/
					STRING COAEffectiveDate; 				/* New field added 9/11/2015*/
					STRING EMP_Contact_First_Name;	/* New field added 9/11/2015*/
					STRING EMP_Contact_Last_Name; 	/* New field added 9/11/2015*/
					STRING EMP_Contact_Gender; 			/* New field added 9/11/2015*/
					STRING Emp_Size_Range; 					/* New field added 9/11/2015*/
					STRING Emp_Sales_Vol_Range; 		/* New field added 9/11/2015*/
					STRING StandardAddress; 				/* New field added 9/11/2015*/
					STRING StandardName; 						/* New field added 9/11/2015*/
					STRING StandardName15; 					/* New field added 9/11/2015*/
					STRING UniqueID_State; 					/* New field added 9/11/2015*/
					STRING createdDate; 						/* New field added 9/11/2015*/
					STRING modifiedDate; 						/* New field added 9/11/2015*/
					STRING Phone_Date; 							/* New field added 9/11/2015*/
					STRING Received_State_Date; 		/* New field added 9/11/2015*/
					STRING Siccode_Date; 						/* New field added 9/11/2015*/
					STRING Size_Range_Date; 				/* New field added 9/11/2015*/
					STRING SicCode; 								/* New field added 9/11/2015*/
					STRING Naics_Id;							  /* New field added 9/11/2015*/
					STRING AMBest_Ultimate_Number; 	/* New field added 9/11/2015*/
					STRING AMBest_Ultimate_Name; 		/* New field added 9/11/2015*/
					STRING Legal_Entity_Type_IND; 	/* New field added 9/11/2015*/
					STRING Contact_Name; 						/* New field added 9/11/2015*/
					STRING Contact_Name_Date; 			/* New field added 9/11/2015*/
					STRING Phone; 									/* New field added 9/11/2015*/
					STRING Phone2; 									/* New field added 9/11/2015*/
					STRING Payroll; 								/* New field added 9/11/2015*/
					STRING Sales_Vol_Exact; 				/* New field added 9/11/2015*/
					STRING Sales_Vol_Range; 				/* New field added 9/11/2015*/
					STRING Standard_Premium; 				/* New field added 9/11/2015*/
					STRING PEO_or_PayRoll_Name; 		/* New field added 9/11/2015*/
					STRING Size_Exact; 							/* New field added 9/11/2015*/
					STRING Size_Range; 							/* New field added 9/11/2015*/
					STRING Reporting_State; 				/* New field added 9/11/2015*/
					STRING BUSINESS_MARKET; 				/* New field added 9/11/2015*/
					STRING ABL_Ind; 								/* New field added 9/11/2015*/
					STRING Carrier_ID; 							/* New field added 9/11/2015*/
					STRING Carrier_Name; 						/* New field added 9/11/2015*/
					STRING DnB_Update_Date; 				/* New field added 9/11/2015*/
					STRING DnB_ID; 									/* New field added 9/11/2015*/
					STRING DnB_Phone; 							/* New field added 9/11/2015*/
					STRING DnB_Contact_Name; 				/* New field added 9/11/2015*/
					STRING DnB_Class; 							/* New field added 9/11/2015*/
					STRING DnB_Location; 						/* New field added 9/11/2015*/
					STRING DnB_SicCode; 						/* New field added 9/11/2015*/
					STRING DnB_Last_Update_Date; 		/* New field added 9/11/2015*/
					STRING DnB_Size_Range; 					/* New field added 9/11/2015*/
					STRING DnB_ConfidenceCode; 			/* New field added 9/11/2015*/
					STRING DnB_ContactName_Date; 		/* New field added 9/11/2015*/
					STRING DnB_Phone_Date; 					/* New field added 9/11/2015*/
					STRING DnB_Primary_Date; 				/* New field added 9/11/2015*/
					STRING DnB_SicCode_Date; 				/* New field added 9/11/2015*/
					STRING DnB_Size_Range_Date; 		/* New field added 9/11/2015*/
					STRING Experian_Business_ID; 		/* New field added 9/11/2015*/
					STRING Experian_Business_Name; 	/* New field added 9/11/2015*/
					STRING Experian_Contact_Name; 	/* New field added 9/11/2015*/
					STRING Experian_Contact_Title;  /* New field added 9/11/2015*/
					STRING Experian_Contact_First_Name; 		/* New field added 9/11/2015*/
					STRING Experian_Contact_Middle_Initial; /* New field added 9/11/2015*/
					STRING Experian_Contact_Last_Name; 			/* New field added 9/11/2015*/
					STRING Experian_Contact_Gender; 				/* New field added 9/11/2015*/
					STRING Experian_Parent_BIN; 						/* New field added 9/11/2015*/
					STRING Experian_Parent_Company_Ind; 		/* New field added 9/11/2015*/
					STRING Experian_Parent_Name; 						/* New field added 9/11/2015*/
					STRING Experian_Parent_City_Providence; /* New field added 9/11/2015*/
					STRING Experian_Parent_State; 					/* New field added 9/11/2015*/
					STRING Experian_Parent_Country_Code; 		/* New field added 9/11/2015*/
					STRING Experian_HQ_BIN; 								/* New field added 9/11/2015*/
					STRING Experian_HQ_Company_Ind; 				/* New field added 9/11/2015*/
					STRING Experian_HQ_Name; 								/* New field added 9/11/2015*/
					STRING Experian_HQ_Address; 						/* New field added 9/11/2015*/
					STRING Experian_HQ_City; 								/* New field added 9/11/2015*/
					STRING Experian_HQ_City_Providence; 		/* New field added 9/11/2015*/
					STRING Experian_HQ_State; 							/* New field added 9/11/2015*/
					STRING Experian_HQ_Zip_Code; 						/* New field added 9/11/2015*/
					STRING Experian_HQ_Phone; 							/* New field added 9/11/2015*/
					STRING Experian_HQ_Country_Code;			  /* New field added 9/11/2015*/
					STRING Experian_SicCode; 								/* New field added 9/11/2015*/
					STRING Experian_Primary_SicCode; 				/* New field added 9/11/2015*/
					STRING Experian_Primary_SicCode_Classification; /* New field added 9/11/2015*/
					STRING Experian_Linkage_Type_Ind; /* New field added 9/11/2015*/
					STRING Experian_Linkage_Level; 		/* New field added 9/11/2015*/
					STRING Experian_MRC; 							/* New field added 9/11/2015*/
					STRING Experian_Sales_Vol_Ind; 		/* New field added 9/11/2015*/
					STRING Experian_Sales_Vol_Sign; 	/* New field added 9/11/2015*/
					STRING Experian_Sales_Vol_Range; 	/* New field added 9/11/2015*/
					STRING Experian_Size_Exact; 			/* New field added 9/11/2015*/
					STRING Experian_Size_Ind; 				/* New field added 9/11/2015*/
					STRING Experian_Size_Range; 			/* New field added 9/11/2015*/
					STRING Experian_Subsidiary_Ind; 	/* New field added 9/11/2015*/
					STRING Experian_Contact_Name_Date;/* New field added 9/11/2015*/
					STRING Experian_MRC_Date; 				/* New field added 9/11/2015*/
					STRING Experian_Phone_Date; 			/* New field added 9/11/2015*/
					STRING Experian_SicCode_Date; 		/* New field added 9/11/2015*/
					STRING Experian_Size_Range_Date; 	/* New field added 9/11/2015*/
					STRING Experian_Near_Business_ID; /* New field added 9/11/2015*/
					STRING Experian_Near_Name; 				/* New field added 9/11/2015*/
					STRING Experian_Near_Address; 		/* New field added 9/11/2015*/
					STRING Experian_Near_City; 				/* New field added 9/11/2015*/
					STRING Experian_Near_State; 			/* New field added 9/11/2015*/
					STRING Experian_Near_Zip; 				/* New field added 9/11/2015*/
					STRING Experian_Near_Phone; 			/* New field added 9/11/2015*/
					STRING Experian_Near_HQ_State; 		/* New field added 9/11/2015*/
					STRING Master_Build_Date; 				/* New field added 9/11/2015*/
					STRING createdBy; 								/* New field added 9/11/2015*/
					STRING modifiedBy; 								/* New field added 9/11/2015*/
					STRING CONVERTED_E_TO_I; 					/* New field added 9/11/2015*/
					STRING MatchCriteria; 						/* New field added 9/11/2015*/
					STRING DB_MatchGrade; 						/* New field added 1/19/2016*/
					STRING Secondary_Master_Uid; 			/* New field added 1/19/2016*/
					STRING TEMPID; 										/* New field added 1/19/2016*/
	END;

	EXPORT Temp	:=	RECORD
				STRING15  Master_UID;
				STRING15	unique_id;
				STRING15	RMID;
				STRING100	Description;
				STRING100 ADDRESS;
				STRING50  CITY;
				STRING2	  State;
				STRING5	  ZIP;
				STRING4	  ZipPlus4;
				STRING15  classCode; /* these are state class codes and no lookup table is available */
				STRING5	  Effective_Month_Day;
				STRING2	  EffectiveMonth;
				STRING8	  Effective_Date;
				STRING100	NAICCarrierName;
				STRING15	NAICCarrierNumber;
				STRING100	NAICGroupName;
				STRING15	NAICGroupNumber;
				STRING30	FEIN;
				STRING30	PolicySelf;
				STRING5	  Record_Type;
				STRING2   Insured_Status; /* New field added 3/26/12 "E" for Exempt & "B" for Bare*/
				STRING100	Append_MailAddress1;
				STRING50	Append_MailAddressLast;
				AID.Common.xAID		Append_MailRawAID;
				AID.Common.xAID   Append_MailACEAID;                                 
		END;
		
	EXPORT Temp_Full	:=	RECORD
			STRING12  Master_UID;
			STRING13	unique_id;
			STRING15	RMID;
			STRING150	Business_Name;/*Field Name Updated 9/11/2015*/
			STRING200 ADDRESS;
			STRING60  CITY;
			STRING2	  State;
			STRING5	  ZIP;
			STRING4	  ZipPlus4;
			STRING5  classCode; /* these are state class codes and no lookup table is available */
			STRING5	  Effective_Month_Day;
			STRING2	  Policy_Eff_Month; /*Field Name Updated 9/11/2015*/
			STRING8	  Policy_Eff_Date; /*Effective_Date; /*Field Name Updated 9/11/2015*/ 
			STRING100	Carrier_NAIC_Name; /*Field Name Updated 9/11/2015*/
			STRING15	Carrier_NAIC_Id; /*Field Name Updated 9/11/2015*/
			STRING100	Group_NAIC_NAME; /*Field Name Updated 9/11/2015*/
			STRING15	Group_NAIC_Id; /*Field Name Updated 9/11/2015*/
			STRING10	FEIN;
			STRING100	Policy_Number; /*Field Name Updated 9/11/2015*/
			STRING10	  Record_Type;
			STRING2   Insured_Status; /* New field added 3/26/12 "E" for Exempt & "B" for Bare*/
			//Start New			
			STRING6 EMP_SICCode;
			STRING10 EMP_SicCode_ID;
			STRING35 EMP_Phone;
			STRING10 EMP_Phone_ID;
			STRING75 EMP_Contact_Name;
			STRING10 EMP_Contact_Name_ID;
			STRING10 Emp_Size_Ind;
			STRING10 Emp_Size_ID;
			STRING50 ID;
			STRING10 Build_Status;
			STRING100 Prior_Policy_Number;
			STRING80 OldID;
			STRING55 SecID;
			STRING80 Business_Name_Std;
			STRING250 SecName;
			STRING150 DbaSplit;
			STRING3 ZIP3;
			STRING80 County_Name;
			STRING10 COUNTY_FIPS_ID;
			STRING10 Policy_CANCEL_EFF_DATE;
			STRING10 ACE_PRIM_RANGE;
			STRING2 ACE_PREDIR;
			STRING28 ACE_PRIM_NAME;
			STRING4 ACE_ADDR_SUFFIX;
			STRING10 ACE_UNIT_DESIG;
			STRING5 CASSCodeID;
			STRING10 CASSDate;
			STRING2 COAMoveType;
			STRING2 COAMatchType;
			STRING5 COAFootNote;
			STRING10 COAEffectiveDate;
			STRING30 EMP_Contact_First_Name;
			STRING30 EMP_Contact_Last_Name;
			STRING10 EMP_Contact_Gender;
			STRING55 Emp_Size_Range;
			STRING80 Emp_Sales_Vol_Range;
			STRING80 StandardAddress;
			STRING80 StandardName;
			STRING15 StandardName15;
			STRING40 UniqueID_State;
			STRING10 createdDate;
			STRING10 modifiedDate;
			STRING10 Phone_Date;
			STRING10 Received_State_Date;
			STRING10 Siccode_Date;
			STRING10 Size_Range_Date;
			STRING4 SicCode;
			STRING10 Naics_Id;
			STRING50 AMBest_Ultimate_Number;
			STRING100 AMBest_Ultimate_Name;
			STRING5 Legal_Entity_Type_IND;
			STRING100 Contact_Name;
			STRING10 Contact_Name_Date;
			STRING35 Phone;
			STRING35 Phone2;
			STRING20 Payroll;
			STRING10 Sales_Vol_Exact;
			STRING80 Sales_Vol_Range;
			STRING10 Standard_Premium;
			STRING150 PEO_or_PayRoll_Name;
			STRING8 Size_Exact;
			STRING50 Size_Range;
			STRING30 Reporting_State;
			STRING60 BUSINESS_MARKET;
			STRING1 ABL_Ind;
			STRING20 Carrier_ID;
			STRING100 Carrier_Name;
			STRING10 DnB_Update_Date;
			STRING50 DnB_ID;
			STRING15 DnB_Phone;
			STRING100 DnB_Contact_Name;
			STRING2 DnB_Class;
			STRING9 DnB_Location;
			STRING40 DnB_SicCode;
			STRING10 DnB_Last_Update_Date;
			STRING50 DnB_Size_Range;
			STRING5 DnB_ConfidenceCode;
			STRING10 DnB_ContactName_Date;
			STRING10 DnB_Phone_Date;
			STRING10 DnB_Primary_Date;
			STRING10 DnB_SicCode_Date;
			STRING10 DnB_Size_Range_Date;
			STRING9 Experian_Business_ID;
			STRING150 Experian_Business_Name;
			STRING100 Experian_Contact_Name;
			STRING10 Experian_Contact_Title;
			STRING10 Experian_Contact_First_Name;
			STRING1 Experian_Contact_Middle_Initial;
			STRING20 Experian_Contact_Last_Name;
			STRING3 Experian_Contact_Gender;
			STRING9 Experian_Parent_BIN;
			STRING1 Experian_Parent_Company_Ind;
			STRING120 Experian_Parent_Name;
			STRING40 Experian_Parent_City_Providence;
			STRING2 Experian_Parent_State;
			STRING3 Experian_Parent_Country_Code;
			STRING9 Experian_HQ_BIN;
			STRING1 Experian_HQ_Company_Ind;
			STRING120 Experian_HQ_Name;
			STRING60 Experian_HQ_Address;
			STRING40 Experian_HQ_City;
			STRING40 Experian_HQ_City_Providence;
			STRING2 Experian_HQ_State;
			STRING5 Experian_HQ_Zip_Code;
			STRING16 Experian_HQ_Phone;
			STRING5 Experian_HQ_Country_Code;
			STRING4 Experian_SicCode;
			STRING4 Experian_Primary_SicCode;
			STRING1 Experian_Primary_SicCode_Classification;
			STRING1 Experian_Linkage_Type_Ind;
			STRING2 Experian_Linkage_Level;
			STRING6 Experian_MRC;
			STRING1 Experian_Sales_Vol_Ind;
			STRING1 Experian_Sales_Vol_Sign;
			STRING8 Experian_Sales_Vol_Range;
			STRING7 Experian_Size_Exact;
			STRING50 Experian_Size_Ind;
			STRING50 Experian_Size_Range;
			STRING1 Experian_Subsidiary_Ind;
			STRING10 Experian_Contact_Name_Date;
			STRING10 Experian_MRC_Date;
			STRING10 Experian_Phone_Date;
			STRING10 Experian_SicCode_Date;
			STRING10 Experian_Size_Range_Date;
			STRING9 Experian_Near_Business_ID;
			STRING120 Experian_Near_Name;
			STRING60 Experian_Near_Address;
			STRING40 Experian_Near_City;
			STRING2 Experian_Near_State;
			STRING5 Experian_Near_Zip;
			STRING10 Experian_Near_Phone;
			STRING3 Experian_Near_HQ_State;
			STRING10 Master_Build_Date;
			STRING30 createdBy;
			STRING30 modifiedBy;
			STRING150 CONVERTED_E_TO_I;
			STRING160 MatchCriteria;
			//End New
			STRING100	Append_MailAddress1;
			STRING50	Append_MailAddressLast;
			AID.Common.xAID		Append_MailRawAID;
			AID.Common.xAID   Append_MailACEAID;                                 
	END;

	EXPORT Base := RECORD,MAXLENGTH(40000)
			UNSIGNED8 Date_FirstSeen;
			UNSIGNED8 Date_LastSeen;
			UNSIGNED6 bdid 	:= 0;
			BIPV2.IDlayouts.l_xlink_ids;
			unsigned8 source_rec_id := 0;  
			Temp;
	END;
  
	EXPORT Base_Full := RECORD
			UNSIGNED8 Date_FirstSeen;
			UNSIGNED8 Date_LastSeen;
			UNSIGNED6 bdid 	:= 0;
			BIPV2.IDlayouts.l_xlink_ids;
			unsigned8 source_rec_id := 0;  
			Temp_Full;
	END;
	
	EXPORT KeyBuild_Full := RECORD
			Base_Full;
			STRING10	m_prim_range; 
			STRING2		m_predir;	
			STRING28	m_prim_name;	
			STRING4		m_addr_suffix; 
			STRING2		m_postdir;	
			STRING10	m_unit_desig;	
			STRING8		m_sec_range;	
			STRING25	m_p_city_name;	
			STRING25	m_v_city_name; 
			STRING2		m_st;	
			STRING5		m_zip;	
			STRING4		m_zip4;	
			STRING4		m_cart;	
			STRING1		m_cr_sort_sz;	
			STRING4		m_lot;	
			STRING1		m_lot_order;	
			STRING2		m_dbpc;	
			STRING1		m_chk_digit;	
			STRING2		m_rec_type;	
			STRING2		m_fips_state;	
			STRING3		m_fips_county;	
			STRING10	m_geo_lat;	
			STRING11	m_geo_long;	
			STRING4		m_msa;	
			STRING7		m_geo_blk;	
			STRING1		m_geo_match;	
			STRING4		m_err_stat;		
	END;
	
	EXPORT KeyBuild := RECORD
			Base;
			STRING10	m_prim_range; 
			STRING2		m_predir;	
			STRING28	m_prim_name;	
			STRING4		m_addr_suffix; 
			STRING2		m_postdir;	
			STRING10	m_unit_desig;	
			STRING8		m_sec_range;	
			STRING25	m_p_city_name;	
			STRING25	m_v_city_name; 
			STRING2		m_st;	
			STRING5		m_zip;	
			STRING4		m_zip4;	
			STRING4		m_cart;	
			STRING1		m_cr_sort_sz;	
			STRING4		m_lot;	
			STRING1		m_lot_order;	
			STRING2		m_dbpc;	
			STRING1		m_chk_digit;	
			STRING2		m_rec_type;	
			STRING2		m_fips_state;	
			STRING3		m_fips_county;	
			STRING10	m_geo_lat;	
			STRING11	m_geo_long;	
			STRING4		m_msa;	
			STRING7		m_geo_blk;	
			STRING1		m_geo_match;	
			STRING4		m_err_stat;		
	END;
	
	
	export BdidSlim := record
			unsigned8		bh_unique_id					;
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string8			sec_range			 		;
			string5			zip5							;
			string2			state		 					;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			string25    city         := '';
			bipv2.IDlayouts.l_xlink_ids   ;
			unsigned8 	source_rec_id := 0;
			string2     source            ;
			STRING30	  FEIN              ;
	  end;
		
	EXPORT UniqueId := RECORD,MAXLENGTH(max_size)
			UNSIGNED8	BH_Unique_id;
			KeyBuild_FULL;
	END;
	
END;
