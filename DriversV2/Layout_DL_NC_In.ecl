 export Layout_DL_NC_In :=  module

	  export	raw_full 									:=  RECORD
 		unsigned6          DID;
 		unsigned6          SOURCE_RID;
		string9            SRC;  
		string2            SOURCE_CODE;
		string1            STATUS;
 		unsigned4          TIMEDATE;
		string12           DL_NBR;
		string2            DL_STATE;
 		unsigned4          ISSUE_DATE;
 		unsigned4          EXP_DATE;
 		unsigned4          DOB;
		string20           FIRST_NAME;
		string20           MIDDLE_NAME;
		string25           LAST_NAME;
		string4            SUFFIX;
		string5            TITLE;
    string20           FNAME;
		string20           MNAME;
		string28           LNAME;
		string5            SNAME;                             
		string1            GENDER;
		string25           ADDRESS;
		string25           APT_NUM;
		string22           O_CITY;
		string2            O_STATE;
		string5            O_ZIP5;
		string4            O_ZIP4;
		string10           PRIM_RANGE;
		string2            PREDIR;
		string28           PRIM_NAME;
		string4            ADDR_SUFFIX;
    string2            POSTDIR;
		string10           UNIT_DESIG;
		string8            SEC_RANGE;
		string25           P_CITY_NAME;
		string25           V_CITY_NAME;
		string2            ST;
		string5            ZIP;
		string4            ZIP4;
		string4            ADDR_ERROR_CODE;
		string10           LICENSE_TYPE;     
		string10           LICENSE_CLASS;
		string50           RESTRICTIONS;
		string1            CDL_IND;
    string1            LICENSE_TYPE_FLAG;
    unsigned4          LICENSE_TYPE_UPD_DATE;
 		unsigned4          DT_FIRST_SEEN;
 		unsigned4          DT_LAST_SEEN;
 		unsigned4          DT_VENDOR_FIRST_REPORTED;
 		unsigned4          DT_VENDOR_LAST_REPORTED;
	END;
	
		export  Layout_NC_Update 					:= record 
		
	  string		Customer_Id;
		string		License_Number	;
		string  	FirstName			;
		string  	MiddleName			;
		string 		LastName				;
		string   	Suffix					;
		string    Address1				;
		string    Address2				;
		string    City						;
		string    State						;
		string    Zip							;
		string    DOB							;
		string    LicenseType		;
		string    IssueDate			;
		string    Expiration;
		string    Restriction1		;
		string    Restriction2		;
		string    Restriction3		;
		string    Restriction4		;
		string    Restriction5		;
		string	  Status;
      end;
	  

		export 	Layout_NC_With_ProcessDt := record
			string8 process_date;
			Layout_NC_Update;
	  end;
	
		export 	Layout_NC_With_Clean 			:= record
	
				Layout_NC_With_ProcessDt;
				string5         title;
				string20        fname;
				string20        mname;
				string20        lname;
				string5         name_suffix;
				string3         cleaning_score;
				string10        prim_range;
				string2         predir;
				string28        prim_name;
				string4         addr_suffix;
				string2         postdir;
				string10        unit_desig;
				string8         sec_range;
				string25        p_city_name;
				string25        v_city_name;
				string2         st;
				string5         zip5;
				string4         zip4;
				string4         cart;
				string1         cr_sort_sz;
				string4         lot;
				string1         lot_order;
				string2         dpbc;
				string1         chk_digit;
				string2         rec_type;
				string2         ace_fips_st;
				string3         county;
				string10        geo_lat;
				string11        geo_long;
				string4         msa;
				string7         geo_blk;
				string1         geo_match;
				string4         err_stat;
	end;

		export 	Layout_CHG_Update 				:= record
		
				string	Customer_Id;
				string	License_Number	;
				string	FirstName;
				string	Change_indicator1;
				string	MiddleName;
				string	Changeindicator;
				string	LastName;
				string	Change_indicator2;
				string	Suffix;
				string	Change_indicator3;
				string	Address1;
				string	Change_indicator4;
				string	Address2;
				string	Change_indicator5;
				string	City;
				string	Change_indicator6;
				string	State;
				string	Change_indicator7;
				string	Zip;
				string	Change_indicator8;
				string	DOB;
				string	Change_indicator9;
				string	LicenseType;
				string	Change_indicator10;
				string	IssueDate;
				string	Change_indicator11;
				string	Expiration; 
				string	DateChange_indicator12;
				string	Restriction1;
				string	Change_indicator13;
				string	Restriction2;
				string	Change_indicator14;
				string	Restriction3;
				string	Change_indicator15;
				string	Restriction4;
				string	Change_indicator16;
				string	Restriction5;
				string	Change_indicator17;
				string	Status;
				string	Change_indicator18;
	end;

end;