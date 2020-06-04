EXPORT Layouts := MODULE

	EXPORT ACCT_MGR := RECORD
		STRING30  	 Acct_Mgr;
	END;

	EXPORT ACCT_NBR := RECORD
		STRING6     Acct_Nbr;
	END;

	EXPORT ACCT_SUFFIX := RECORD
		STRING3     Acct_Suffix;
	END;

	EXPORT ADJUSTER_ID := RECORD
		STRING15    Adjuster_ID;
	END;	

	EXPORT CARRIER_ID := RECORD
		STRING3     Carrier_ID;
	END;

	EXPORT CHECKIN_DATE := RECORD
		STRING19    Checkin_Date;
	END;	

	EXPORT CLAIM_NBR := RECORD
		STRING28    Claim_Nbr;
	END;

	EXPORT CLIENT_ID := RECORD
		STRING15    Client_ID;
	END;

	EXPORT CREATION_DATE := RECORD
		STRING19    Creation_Date;
	END;	

	EXPORT CROSS_STREET := RECORD
		STRING57    Cross_Street;
	END;	

	EXPORT DOB := RECORD
		STRING19    Dob;
		STRING19    Dob_1;
		//Joining Vehicle party with combined order
		STRING8     VP_CO_DOB;
	END;	

	EXPORT DL_INFO := RECORD
		STRING25    DL_Nbr;
		STRING2     DL_ST;
		STRING25    VP_DL_Nbr;
		STRING2     VP_DL_ST; 
		STRING20    Previous_DL_Nbr;
		STRING2     Previous_DL_State;
	END;	

	EXPORT NAME := RECORD 
	 STRING30 First_Name;  
		STRING15 Middle_Name;
		STRING30 Last_Name; 
		STRING3  o_Suffix;
	END;

	EXPORT NAME_1 := RECORD
		STRING20    First_Name_1;
		STRING15    Middle_Name_1;
		STRING30    Last_Name_1;
		STRING3     o_Suffix_1; 
	END;	
	
	EXPORT NAME_2 := RECORD
		STRING20    First_Name_2;
		STRING15    Middle_Name_2;
		STRING30    Last_Name_2;
		STRING3     o_Suffix_2; 
	END;	
	
	EXPORT NAME_3 := RECORD
		STRING20    First_Name_3;
		STRING15    Middle_Name_3;
		STRING30    Last_Name_3;
		STRING3     o_Suffix_3; 
	END;	
	
	EXPORT BUSINESS_NAME := RECORD
			STRING30 Business_name;
	END;
	
	EXPORT GENDER := RECORD
	 STRING1 Gender;
	 STRING1 Gender_1;
	END;

	EXPORT LAST_CHANGED := RECORD
		STRING19    Last_Changed;
	END;	

	EXPORT LOSS_DATE := RECORD
		STRING19    Loss_Date;
	END;	

	EXPORT LOSS_TIME := RECORD
		STRING12    Loss_Time;
	END;	

	EXPORT MAKE := RECORD
		STRING20    Make;
	END;	

	EXPORT MODEL := RECORD
		STRING20    Model;
	END;		

	EXPORT ORDER_ID := RECORD
		STRING9    	 Order_ID;
	END;	

	EXPORT ORDERPOINT_STATUS := RECORD
		STRING1   	 Orderpoint_Status;
	END;		

	EXPORT PROCESSED_DATE := RECORD
		STRING19    Processed_Date;
	END;		

	EXPORT QUEUE := RECORD
		STRING1     Queue;
	END;

	EXPORT REASON_ID := RECORD
		STRING5     Reason_ID;
	END;

	EXPORT REPORT_NBR := RECORD
		STRING31    Report_Nbr;
	END;

	EXPORT RESULT_ID := RECORD
		STRING9     Result_ID;
	END;	

	EXPORT SEQUENCE_NBR := RECORD
		STRING2     Sequence_Nbr;
	END;

	EXPORT O_SERVICE_ID := RECORD
		STRING3     O_Service_ID;
	END;

	EXPORT SERVICE_ID := RECORD
		STRING3     Service_ID;
	END;
	
	EXPORT SPECIAL_BILLING_ID := RECORD
		STRING15    Special_Billing_ID;
	END;	

	EXPORT SSN := RECORD
		STRING9     SSN;
		STRING9     SSN_1;
		//Combined order SSN used in Vehicle party
		STRING9     CO_SSN;
	END;

	EXPORT STATE_SERVICE_TYPE_NAME := RECORD
		STRING30    State_Service_Type_Name;
	END;	

	EXPORT STATUS_ID := RECORD
		STRING5     Status_ID;
	END;	

	EXPORT USERID := RECORD
		STRING8     Userid;
	END;	

	EXPORT VEHICLE_ID := RECORD
	 STRING9     Vehicle_ID;
	END;	

	EXPORT VEHICLE_INCIDENT_ID := RECORD
	 STRING11     Vehicle_Incident_ID;
	END;

	EXPORT VERSION := RECORD
	 STRING5     Version;
	END;

	EXPORT VIN := RECORD
	 STRING25    VIN;
	END;

	EXPORT YEAR := RECORD
	 STRING4      Year;
	END;		

	EXPORT VEHICLE_STATUS := RECORD
	 STRING5      Vehicle_Status;
	END;	
	
 EXPORT INQUIRY_FIELDS := RECORD 
		STRING9 					Inquiry_SSN;
		STRING8 					Inquiry_Dob;
		STRING20     Inquiry_MName;
		STRING5      Inquiry_ZIP5;
		STRING5      Inquiry_ZIP4;
	END;

	EXPORT VINA_CLEAN := RECORD	
		STRING42  Vehicle_Seg;
		STRING1   Vehicle_Seg_Type;
		STRING1   Fuel_Code;
		STRING1   Number_Of_Driving_Wheels;
		STRING4   Model_Year;
		STRING2   Body_Style_Code;
		STRING4   Engine_Size;
		STRING1   Steering_Type;
		STRING3   Vina_Series;
		STRING3   Vina_Model;
		STRING3   Vina_Make;
		STRING2   Vina_Body_Style;
		STRING100 Make_Description;
		STRING20  Model_Description;
		STRING20  Series_Description;
		STRING2   Car_Cylinders;
	END;

	EXPORT NAME_CLEAN := RECORD
	 UNSIGNED8 NID   := 0;
		STRING5   Title := '';
		STRING20  FName := '';
		STRING20  LName := '';
		STRING20  MName := '';
		STRING5   SName := '';
		STRING5   Suffix := '';
		STRING3   Name_Score := '';
	END;

	EXPORT NAME_CLEAN_2 := RECORD
	 UNSIGNED8 NID2   := 0;
		STRING5   Title2 := '';
		STRING20  FName2 := '';
		STRING20  LName2 := '';
		STRING20  MName2 := '';
		STRING5   SName2 := '';
		STRING5   Suffix2 := '';
		STRING3   Name_Score2 := '';
	END;

	EXPORT NAME_CLEAN_3 := RECORD
	 UNSIGNED8 NID3   := 0;
		STRING5   Title3 := '';
		STRING20  FName3 := '';
		STRING20  LName3 := '';
		STRING20  MName3 := '';
		STRING5   SName3 := '';
		STRING5   Suffix3 := '';
		STRING3   Name_Score3 := '';
	END;
	
	EXPORT AID_ADDRESS := RECORD
		STRING pLine1 := '';
		STRING pLineLast := '';
	END;

	EXPORT ADDRESS_CLEAN := RECORD
	 UNSIGNED8 	 AID := '';
	 UNSIGNED2 	 DALI := '';
		STRING10 	 Prim_Range := '';
		STRING2 	  Predir := '';
		STRING28 	 Prim_Name := '';
		STRING4 	  Addr_Suffix := '';
		STRING2 	  Postdir := '';
		STRING10 	 Unit_Desig := '';
		STRING8 	  Sec_Range := '';
		STRING25 	 P_City_Name := '';
		STRING25 	 V_City_Name := '';
		STRING2 	  ST := '';
		STRING5 	  Z5 := '';
		STRING4    Z4 := '';
		STRING4 	  Cart := '';
		STRING1 	  CR_Sort_SZ := '';
		STRING4 	  Lot := '';
		STRING1    Lot_Order := '';
		STRING2 	  Dpbc := '';
		STRING1 	  Chk_Digit := '';
		STRING2 	  Rec_Type := '';
		STRING5 	  County_Code := '';
		STRING10 	 Geo_Lat := '';
		STRING11 	 Geo_Long := '';
		STRING4 	  Msa := '';
		STRING7 	  Geo_Blk := '';
		STRING1 	  Geo_Match := '';
		STRING4 	  Err_Stat := '';
	END;

	EXPORT DID_APPEND := RECORD
		UNSIGNED6 DID:=0;
		UNSIGNED1 DID_Score:=0;
	END;

	EXPORT DID_APPEND_2 := RECORD
		UNSIGNED6 DID2:=0;
		UNSIGNED1 DID_Score2:=0;
	END;

	EXPORT DID_APPEND_3 := RECORD
		UNSIGNED6 DID3:=0;
		UNSIGNED1 DID_Score3:=0;
	END;

	EXPORT BDID_APPEND := RECORD
		UNSIGNED INTEGER6 Bdid:=0;
		UNSIGNED1         Bdid_Score:=0;		
	END;

	EXPORT BDID_APPEND_2 := RECORD
		UNSIGNED INTEGER6 Bdid2:=0;
		UNSIGNED1         Bdid_Score2:=0;		
	END;

	EXPORT BDID_APPEND_3 := RECORD
		UNSIGNED INTEGER6 Bdid3:=0;
		UNSIGNED1         Bdid_Score3:=0;		
	END;
	
	EXPORT PARTY_MAIN := RECORD
  UNSIGNED6 DID_Party;
  STRING20 FName_Party;
  STRING20 LName_Party;
	END;

END;