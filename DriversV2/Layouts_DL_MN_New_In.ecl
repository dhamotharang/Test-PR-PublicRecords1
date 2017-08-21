export Layouts_DL_MN_New_In := module

//Vendor Update record lenght = 245
	export Layout_MN_Update := record
		string1        	RECORD_TYPE ;
		string13     	DRIVER_LICENSE_NUMBER;	
		string13     	PREVIOUS1_LICENSE_NUMBER;		
		string13     	PREVIOUS2_LICENSE_NUMBER;	
		string13     	PREVIOUS3_LICENSE_NUMBER;	
		string32 		NAME_FML;
		string32  		ADDRESS1;
		string20        CITY;
		string2         COUNTY_ST_CODE;	
		string5         ZIP_CODE;
		string8         BIRTHDAY;
		string1         SEX ;
		string1         EYE_COLOR;
		string3         HEIGHT ;
		string3         WEIGHT;
		string8         LICENSE_ISSUE_DATE;
		string8         LICENSE_EXPIR_DATE;
		string1         LICENSE_CLASS;
		string8         LICENSE_TYPE;
		string8         LICENSE_STATUS;
		string1         B_CARD_NDICATOR;
		string1         DONOR_INDICATOR;
		string4         ENDORSEMENTS;
		string8         RESTRICTIONS;
		string1         INDC_COMMERCIALDRIVER;
		string8         COMMERCIAL_DRIVER_STATUS;
		string1         RESTRICTED_DATA_IND;
		string1         SCHOOL_BUS_PHYSICAL_TYPE;
		string8         SCHOOL_BUS_PHYSICAL_EXPDATE;
		string4         FILLER;
		string13        OLD_DL_NUMBER;
		string2        	FILLER1
   end; 
	
	
	export Layout_MN_With_ProcessDte := record
		string8 process_date;
		Layout_MN_Update;
		string5         title;
		string20        fname;
		string20        mname;
		string20        lname;
		string5         name_suffix;
		string3         cleaning_score;
		string10        prim_range;
		string2         predir;
		string28        prim_name;
		string4         suffix;
		string2         postdir;
		string10        unit_desig;
		string8         sec_range;
		string25        p_city_name;
		string25        v_city_name;
		string2         state;
		string5         zip;
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

	export Layout_MN_Convic := record
			string13 	DLNUMBER;
			string4 	CODED_ENDORSEMENTS;
			string1 	INDICATE_B_CARD;
			string8 	LICENSE_ISSUE_DATE;
			string8 	LICENSE_EXPIR_DATE; 
			string1  	LICENSE_CLASS;
			string8 	LICENSE_TYPE;
			string8  	DL_LICENSE_STATUS;
			string8  	CDL_LICENSE_STATUS;
			string32 	Name_FML;
			string32  	ADDRESS1;
			string20  	CITY;	
			string2  	ST; 
			string5  	ZIP_cose;
			string8 	DOB;
			string1  	SEX ; 
			string3  	HEIGHT; 
			string3  	WEIGHT;
			string1  	EYE_COLOR;
			string1  	DONOR_IND;
			string8  	OFFENSE_DATE; 
			string1  	FELONY;	
			string3  	OUT_OF_STATE;
			string49  	CONVICTION;	
			string1  	RESTRICTED_INDICATOR;	
			string1  	VEHICLE_CONVICTION;	
			string13  	OLD_SOUNDEX_DLNUMBER;	
			string2 	filler ;
   
   end; 
	
	
	export Layout_MN_conv_ProcessDte := record
		string8 process_date;
		Layout_MN_Convic;
	end;


end;