IMPORT thrive,address,AID,Bipv2;

EXPORT layouts := MODULE

	SHARED max_size := _Dataset().max_record_size;
	
	EXPORT Input_LT := RECORD,MAXLENGTH(40000)
			STRING  orig_Fname;					
			STRING	orig_Lname;					 
			STRING  orig_Addr;
			STRING  orig_City;						
			STRING  orig_Zip4;						 
			STRING  orig_State;
			STRING  orig_zip5;						
			STRING  Email;					 
			STRING  Phone;
			STRING  LoanType;				
			STRING  BestTime;				 
			STRING  MortRate;
			STRING  PropertyType;		
			STRING  RateType;				 
			STRING  LTV;
			STRING  YrsThere;				
			STRING  Employer;				 
			STRING  Income;
			STRING  Credit;					
			STRING  LoanAmt;				 
			STRING  DT;
	END;
	
	EXPORT Input_PD := RECORD,MAXLENGTH(40000)
			STRING  orig_fname;					
			STRING	orig_mname;					 
			STRING  orig_lname;
			STRING  orig_addr;						
			STRING  orig_city;						 
			STRING  orig_state;
			STRING  orig_zip5;						
			STRING  orig_zip4;						 
			STRING  phone_home;
			STRING  phone_cell;			
			STRING  phone_work;			 
			STRING  email;
			STRING  dob;						
			STRING  own_home;				 
			STRING  dr;
			STRING  is_military;		
			STRING  employer;				 
			STRING  pay_frequency;
			STRING  income_monthly;	
			STRING  months_employed; 
			STRING  months_at_bank;  
			STRING  ip;
			STRING  DT;
  END;
	

	EXPORT Base := RECORD,MAXLENGTH(40000)

			STRING20	persistent_record_id ;
			STRING2   src;			//	Code to indicate source: 'PD' or 'LT'			
			UNSIGNED6 Dt_first_seen;
			UNSIGNED6 Dt_last_seen;
			UNSIGNED6 Dt_vendor_first_reported;
			UNSIGNED6 Dt_vendor_last_reported;
			UNSIGNED6 bdid 			:= 0;
			UNSIGNED1 bdid_score	:= 0;
			UNSIGNED6 did 			:= 0;
			UNSIGNED1 did_score 			:= 0;
			STRING40  orig_Fname;						//	LT & PD
			STRING40  orig_Mname;						//	PD	
			STRING60	orig_Lname;						//	LT & PD
			STRING75  orig_Addr;							//	LT & PD
			STRING40  orig_City;							//	LT & PD
			STRING2   orig_State;						//	LT & PD
			STRING5   orig_Zip5;							//	LT & PD
			STRING4   orig_Zip4;							//	LT & PD
			STRING90  Email;						//	LT & PD
			STRING50  Employer;					//	LT & PD
			STRING10  Income;						//	LT & PD
			STRING20  Pay_Frequency;		//	LT & PD
			STRING20  Phone_Work;				//	LT & PD
			STRING20  Phone_Home;				//	PD
			STRING20  Phone_Cell;				//	PD
			STRING8   DOB;							//	PD
			STRING4   MonthsEmployed;		//	PD
			STRING1   Own_Home;					//	PD
			STRING1   Is_Military;			//	PD		
			STRING2   Drvlic_State;			//	PD	
			STRING4   MonthsAtBank;			//	PD
			STRING25  IP;								//	PD
			STRING25  YrsThere;					//	LT
			STRING20  BestTime;					//	LT
			STRING20  Credit;						//	LT
			STRING15  LoanAmt;					//	LT
			STRING25  LoanType;					//	LT
			STRING15  RateType;					//	LT
			STRING15  MortRate;					//	LT	
			STRING10  LTV;							//	LT
			STRING25  PropertyType;			//	LT
			STRING20  DateCollected;		//	LT
		  address.Layout_Clean_Name.title;
		  address.Layout_Clean_Name.fname;
		  address.Layout_Clean_Name.mname;
		  address.Layout_Clean_Name.lname;
		  address.Layout_Clean_Name.name_suffix;
			unsigned8 nid;
		  address.Layout_Clean182.prim_range;
		  address.Layout_Clean182.predir;
		  address.Layout_Clean182.prim_name;
		  address.Layout_Clean182.addr_suffix;
		  address.Layout_Clean182.postdir;
		  address.Layout_Clean182.unit_desig;
		  address.Layout_Clean182.sec_range;
		  address.Layout_Clean182.p_city_name;
		  address.Layout_Clean182.v_city_name;
		  address.Layout_Clean182.st;
		  address.Layout_Clean182.zip;
		  address.Layout_Clean182.zip4;
		  address.Layout_Clean182.cart;
		  address.Layout_Clean182.cr_sort_sz;
		  address.Layout_Clean182.lot;
		  address.Layout_Clean182.lot_order;
		  address.Layout_Clean182.dbpc;
		  address.Layout_Clean182.chk_digit;
		  address.Layout_Clean182.rec_type;
		  string2		fips_st:='';
		  string3		fips_county:='';
		  address.Layout_Clean182.geo_lat;
		  address.Layout_Clean182.geo_long;
		  address.Layout_Clean182.msa;
		  address.Layout_Clean182.geo_blk;
		  address.Layout_Clean182.geo_match;
		  address.Layout_Clean182.err_stat;
			AID.Common.xAID		RawAID;		
			AID.Common.xAID   ACEAID;
			string10 clean_Phone_Work;
			string10 clean_Phone_Home;			
			string10 clean_Phone_Cell;		
			string8 clean_DOB;	
			BIPV2.IDlayouts.l_xlink_ids;
			// The below 2 fields are added for CCPA (California Consumer Protection Act) project enhancements - JIRA# CCPA-8
			unsigned4 global_sid := 0;
			unsigned8 record_sid := 0;
	END;

Export BaseOld	:=	record
			base - BIPV2.IDlayouts.l_xlink_ids;
end;


END;

