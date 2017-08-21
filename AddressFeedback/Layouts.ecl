Export Layouts := module

Export Lay_AddressFeedback_in := Record
			String20	Address_feedback_id;
			String20	Login_history_id;
			String12	Phone_number;
			String7	Unique_id;
			String20	Fname;
			String20	Lname;
			String20	Mname;
			String2	Orig_Street_pre_direction;
			String2	Orig_Street_post_direction;
			String10	Orig_Street_number;
			String28	Orig_Street_name;
			String4	Orig_Street_suffix;
			String8	Orig_Unit_number;
			String10	Orig_Unit_designation;
			String5	Orig_Zip5;
			String4	Orig_Zip4;
			String25	Orig_City;
			String2	Orig_State;
			String10	Alt_phone;
			String128	Other_info;
			String1	Address_contact_type;
			String2	Feedback_source;
			String16	Transaction_id;
			String19	date_time_added;
			String20	LoginId; //UserId  -Vendor Field
			String7	Companyid;
End;
 
Export Lay_AddressFeedback_base := record
			Unsigned6 did := 0;   //known as unique_id for online, generated for customers
			Unsigned1 did_score := 0;	    
			Unsigned8 raw_aid := 0;  
			Unsigned6 hhid := 0;
			String	Address_feedback_id;
			String	Login_history_id;
			String10	Phone_number;
			String	Unique_id;
			String	Fname;
			String	Lname;
			String	Mname;
			String2	Orig_Street_pre_direction;//predir
			String2	Orig_Street_post_direction;//postdir
			String10	Orig_Street_number;//prim_range
			String28	Orig_Street_name;//prim_name
			String4	Orig_Street_suffix;//addr_suffix
			String8	Orig_Unit_number;//sec_range
			String10	Orig_Unit_designation;//unit_desig
			String5	Orig_Zip5;//zip
			String4	Orig_Zip4;//zip4
			String25	Orig_City;
			String2	Orig_State;//st			
			String2	Street_pre_direction;//AID_predir
			String2  Street_post_direction;//AID_postdir
			String10	Street_number;//AID_prim_range
			String28	Street_name;//AID_prim_name
			String4  Street_suffix;//AID_addr_suffix
			String8	Unit_number;//AID_sec_range
			String10	Unit_designation;//AID_unit_desig
			String5	Zip5;//AID_zip
			String4	Zip4;//AID_zip4
			String25	City;
			String2	State;//AID_st
			String	Alt_phone;
			String	Other_info;
			String	Address_contact_type;
			String	Feedback_source;
			// String	Transaction_id;
			String	date_time_added;
			String	LoginId;//UserId -Vendor Field
			String	Companyid;
End;

Export Lay_key  := Record
			Unsigned6 did := 0;   //known as unique_id for online, generated for customers
			Unsigned1 did_score := 0;	    
			Unsigned8 raw_aid := 0;  
			Unsigned6 hhid := 0;
			String	Login_history_id;
			String10	Phone_number;
			String	Unique_id;
			String	Fname;
			String	Lname;
			String	Mname;
			String2	Predir;//Street_pre_direction
			String2	Postdir;//Street_post_direction
			String10	Prim_range;//Street_number
			String28	Prim_name;//Street_name
			String4	Addr_suffix;//Street_suffix
			String8	Sec_range;//Unit_number
			String10	Unit_desig;//Unit_designation
			String5	Zip;//zip5
			String4	Zip4;//zip4
			String25	City;
			String2	St;//state
			String	Alt_phone;
			String	Other_info;
			Unsigned1	Address_contact_type;
			Unsigned1	Feedback_source;
			Unsigned4	date_time_added;
			String	LoginId;//UserId - vendor Field
			String	Companyid;
End;


End;