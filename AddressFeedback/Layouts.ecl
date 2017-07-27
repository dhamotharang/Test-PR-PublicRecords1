Export Layouts := module

Export Lay_AddressFeedback_in := Record
			String20	Address_feedback_id;
			String20	Login_history_id;
			String12	Phone_number;
			String7	Unique_id;
			String20	Fname;
			String20	Lname;
			String20	Mname;
			String2	Street_pre_direction;
			String2	Street_post_direction;
			String10	Street_number;
			String28	Street_name;
			String4	Street_suffix;
			String8	Unit_number;
			String10	Unit_designation;
			String5	Zip5;
			String4	Zip4;
			String25	City;
			String2	State;
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
			// String	Address_feedback_id;
			String	Login_history_id;
			String10	Phone_number;
			String	Unique_id;
			String	Fname;
			String	Lname;
			String	Mname;
			String2	Street_pre_direction;//predir
			String2  Street_post_direction;//postdir
			String10	Street_number;//prim_range
			String28	Street_name;//prim_name
			String4  Street_suffix;//addr_suffix
			String8	Unit_number;//sec_range
			String10	Unit_designation;//unit_desig
			String5	Zip5;//zip
			String4	Zip4;//zip4
			String25	City;
			String2	State;//st
			String	Alt_phone;
			String	Other_info;
			String	Address_contact_type;
			String	Feedback_source;
			// String	Transaction_id;
			String	date_time_added;
			String	LoginId;//UserId -Vendor Field
			String	Companyid;
End;

End;