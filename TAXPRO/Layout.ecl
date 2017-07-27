IMPORT Standard;

EXPORT Layout := 
  MODULE
	EXPORT practitioner_in 
	:=RECORD
		STRING8 	vENDorUpdatedate;	
		STRING26 	firstnm;	
		STRING24 	midinit;	
		STRING26 	lastnm;	
		STRING48 	company;	
		STRING16 	occupation;	
		STRING40 	addr1;	
		STRING40 	addr2;
		STRING28 	city;	
		STRING2  	state;	
		STRING20 	zip;	
		STRING30  	country;
		STRING182	clean_address; 
		STRING73 	pname;
	END;
   
    EXPORT IRS_enrolled_agent_in 
	:=RECORD 
	   STRING8 		date_first_reported;
	   STRING8 		date_last_reported;
	   STRING30 	firstnm;
	   STRING15 	midinit;
	   STRING30 	lastnm;
	   STRING4 		enroll_year;
	   STRING35 	addr1;
	   STRING35 	addr2;
	   STRING35 	addr3;
	   STRING35 	city;
	   STRING5 		state;
	   STRING10 	zip;
	   STRING20 	province;
	   STRING35 	country;
	   STRING10 	filler;
	   STRING1 		lf;
	   STRING182    clean_address;
	   STRING73     pname;
	 
	END;
    
	EXPORT Taxpro_Base 
	:=RECORD 
	
	   unsigned4 	dt_first_seen			:=0;    
	   unsigned4 	dt_last_seen			:=0;     
	   unsigned4 	dt_vendor_first_reported:=0;
	   unsigned4 	dt_vendor_last_reported	:=0;
	   string10     tmsid;
	   STRING14     source;
	   STRING30 	firstnm;
	   STRING15 	midinit;
	   STRING30 	lastnm;
	   STRING48 	company;	
	   STRING16 	occupation;	
	   STRING4 		enroll_year;
	   STRING35 	addr1;
	   STRING35 	addr2;
	   STRING35 	addr3;
	   STRING35 	city;
	   STRING20		state;
	   STRING20 	zip;
	   STRING35 	country;
	   STRING5      title;
	   STRING20 	fname;
	   STRING20 	mname;
	   STRING20 	lname;
	   STRING5  	name_suffix;
	   STRING3  	name_score;
	   STRING10		prim_range;
	   STRING2		predir;
	   STRING28		prim_name;
	   STRING4		suffix;
	   STRING2		postdir;
	   STRING10		unit_desig;
	   STRING8		sec_range;
	   STRING25		p_city_name;
	   STRING25		v_city_name;
	   STRING2		st;
	   STRING5		zip5;
	   STRING4		zip4;
	   STRING3		county;
	   STRING4		cart;
	   STRING1		cr_sort_sz;
	   STRING4		lot;
	   STRING1		lot_order;
	   STRING2		dpbc;
	   STRING1		chk_digit;
	   STRING2		rec_type;
	   STRING2		ace_fips_st;
	   STRING3		ace_fips_county;
	   STRING10		geo_lat;
	   STRING11		geo_long;
	   STRING4		msa;
	   STRING7		geo_blk;
	   STRING1		geo_match;
	   STRING4		err_stat;
	   STRING9 		ssn                     :='';
	   unsigned6 	did  					:=0 ;
	   unsigned6	did_score 				:=0 ;
	   unsigned6	bdid 					:=0 ;
	   unsigned6    bdid_score 				:=0 ;
	 
	END;
	EXPORT Taxpro_Standard_Base
	:=RECORD 
	   unsigned4 	dt_first_seen			:=0;    
	   unsigned4 	dt_last_seen			:=0;     
	   unsigned4 	dt_vendor_first_reported:=0;
	   unsigned4 	dt_vendor_last_reported	:=0;
	   string10     tmsid;
	   STRING14     source;
	   STRING30 	firstnm;
	   STRING15 	midinit;
	   STRING30 	lastnm;
	   STRING48 	company;	
	   STRING16 	occupation;	
	   STRING4 		enroll_year;
	   STRING35 	addr1;
	   STRING35 	addr2;
	   STRING35 	addr3;
	   STRING35 	city;
	   STRING20		state;
	   STRING20 	zip;
	   STRING35 	country;
	   standard.Name name;
	   Standard.L_Address.detailed addr;
	   STRING9 		ssn                     :='';
	   unsigned6 	did  					:=0 ;
	   unsigned6	did_score 				:=0 ;
	   unsigned6	bdid 					:=0 ;
	   unsigned6    bdid_score 				:=0 ;
	 END;
	
	 EXPORT Payload:=RECORD
			
		taxpro_standard_base.company    	;
		taxpro_standard_base.tmsid 		;
		taxpro_standard_base.ssn			;
		taxpro_standard_base.did			;
		taxpro_standard_base.bdid		;
		standard.Name name;
		Standard.L_Address.detailed addr;
		unsigned1 zero 					:= 0;

	 END;

END;