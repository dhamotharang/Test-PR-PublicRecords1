export Layouts_PhonesFeedback := MODULE

	export Layout_PhonesFeedback_in := record    //Len = 457                                    
		string20		phone_feedback_id;
    string20		login_history_id;                              
		string7			customerid;      //same as companyid
		string12		phone_number;
		string9			ssn;
		string20		fname;
		string20		lname;
		string20		mname;
		string2			street_pre_direction;
		string2			street_post_direction;
		string10		street_number;  		//prim range
		string28		street_name;    		//prim name
		string4			street_suffix;
		string8			unit_number;     		//sec range
		string10		unit_designation;
		string5			zip5;
		string4			zip4;
		string25		city;
		string2			state;
		string10		alt_phone; 					//blank for customer recs
		string128		other_info; 				//blank for customer recs
		string1			phone_contact_type;
		string2			feedback_source; 		//'3 ' = online source and includes dids (adls)
		string16		transaction_id; 		//blank for customer recs
		string19		date_time_added;
		string32		did;            		//unique_id  (blank for customer recs)
		string20		loginid; 
		string1			lf_filler;   				//lf for online recs, filler for customer recs
		end;		
		
	export Layout_PhonesFeedback_base := record
	  unsigned6		did := 0;  					//known as unique_id for online, generated for customers
		unsigned1		did_score := 0;
		unsigned6		hhid := 0;
		string10		phone_number;
		string			login_history_id;
		string			fname;
		string			lname;
		string			mname;
		string			street_pre_direction;
		string			street_post_direction;
		string			street_number;			//prim range
		string			street_name;				//prim name
		string			street_suffix;
		string			unit_number;				//sec range
		string			unit_designation;
		string			zip5;
		string			zip4;
		string			city;
		string			state;
		string			alt_phone;
		string			other_info;
		string			phone_contact_type;
		string			feedback_source;
		string			date_time_added;
		string			loginid;
		string			customerid;
		//Added for CCPA-355
		unsigned4		global_sid;
		unsigned8		record_sid;
		end;
		
	export Layout_base_temp := record
		Layout_PhonesFeedback_base;
		string100   prep_addr_line1			:= '';
		string50		prep_addr_line_last	:= '';
		unsigned8		raw_aid							:=  0;		
	end;	
	
	export layoutPhonesFeedbackDID := RECORD
		unsigned6		did								:= 0;
		unsigned1		did_score					:= 0;
		unsigned6		hhid 							:= 0;
		string10		phone_number			:= '';
		string			login_history_id	:= '';
		string20		fname							:= '';
		string20		lname							:= '';
		string20		mname							:= '';
		string10		Prim_Range				:= '';
		string2			Predir						:= '';
		string28		Prim_Name					:= '';
		string4			Addr_Suffix				:= '';
		string2			Postdir						:= '';
		string10		Unit_Desig				:= '';
		string8			Sec_Range					:= '';
		string5			Zip5							:= '';
		string4			Zip4							:= '';
		string25		City							:= '';
		string2			State							:= '';
		string10		Alt_Phone					:= '';
		string			other_info				:= '';
		string			phone_contact_type:= '';
		string			feedback_source		:= '';
		string			date_time_added		:= '';
		string			loginid						:= '';
		string			customerid				:= '';
		//Added for CCPA-355
		unsigned4		global_sid;
		unsigned8		record_sid;
	end;
	
	export layoutPhonesFeedbackAddress := RECORD
		unsigned6		did								:= 0;
		unsigned1		did_score					:= 0;
		unsigned6		hhid							:= 0;
		string10		phone_number			:= '';
		string			login_history_id	:= '';
		string20		fname 						:= '';
		string20		lname							:= '';
		string20		mname							:= '';
		string10		Prim_Range				:= '';
		string2			Predir						:= '';
		string28		Prim_Name					:= '';
		string4			Addr_Suffix				:= '';
		string2			Postdir						:= '';
		string10		Unit_Desig				:= '';
		string8			Sec_Range					:= '';
		string5			Zip5							:= '';
		string4			Zip4							:= '';
		string25		City							:= '';
		string2			State							:= '';
		string10		Alt_Phone					:= '';
		string			other_info				:= '';
		string			phone_contact_type:= '';
		string			feedback_source		:= '';
		string			date_time_added		:= '';
		string			loginid						:= '';
		string			customerid				:= '';
		//Added for CCPA-355
		unsigned4		global_sid;
		unsigned8		record_sid;
	end;

	end;