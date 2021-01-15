EXPORT Layouts := MODULE

	
	EXPORT Layout_AuditLog := RECORD   //layout for audit logfile
		UNSIGNED4  	Process_dt;
		string			Input_file;
		string			Output_file;
		string8			Archive_Date;
		unsigned8		Count_of_input_records;
		unsigned8		Count_of_output_records;
		string20		wuid;
		unsigned8		Count_of_Records_w_error;
	END;
	
EXPORT Layout_Insurance_Header := RECORD
			UNSIGNED8 Lexid;
			UNSIGNED4 date_first_seen;
			UNSIGNED4 date_last_seen;	
			UNSIGNED4 IH_date_first_seen;
			UNSIGNED4 IH_date_last_seen;
			STRING1   active_flag;
		  STRING10 	adl_segmentation;
		  STRING1 	gender;
      STRING1 	derived_gender;
			UNSIGNED4	DOB;	
			STRING9		SSN;			
			STRING25	dl_nbr;
			STRING2	  dl_state;
			STRING20	first_name;
			STRING20	middle_name;
			STRING28	last_name;
			STRING2 	suffix;
			STRING2		predir;
			STRING10	prim_range;
			STRING28	prim_name;
			STRING4		addr_suffix;
			STRING2		postdir;
			STRING10	unit_desig;
			STRING8		sec_range;
			STRING25	city;
			STRING2		state;
			STRING5		zip;
			STRING4		zip4;
			STRING3 	addrtype;
			UNSIGNED6 hhid;
			UNSIGNED6 hhid_indiv;
			UNSIGNED6 hhid_relat;
			UNSIGNED8 rid;
END;	
	
END;