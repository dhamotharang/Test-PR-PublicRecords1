import ut, NID;

export fun_in_hd_penalty(string in_fname, string hd_fname, 
				     string in_mname, string hd_mname,
					string in_lname, string hd_lname, 
					string in_ssn, string hd_ssn, 
					string in_dob, string hd_dob,   
					string in_predir, string hd_predir,	
					string in_prange, string hd_prange,
					string in_pname, string hd_pname, 
					string in_suffix, string hd_suffix,
					string in_postdir, string hd_postdir, 
					string in_sec_range, string hd_sec_range,
					string in_city, string hd_city, 
					string in_state, string hd_state, 
					string in_zip, string hd_zip,
					string in_phone, string hd_phone, unsigned1 score_threshold,
					boolean is_us_zip = true) := FUNCTION
			
RETURN MAP(in_lname='' or hd_lname=in_lname => 0,
           hd_lname='' => 3,
           MIN((datalib.namesimilar(hd_lname,in_lname,1)+ 3)/ 
		 IF(metaphonelib.DMetaPhone1(hd_lname)=metaphonelib.DMetaPhone1(in_lname),2,1),10)) + 
MAP(in_fname='' or hd_fname=in_fname => 0,
    NID.mod_PFirstTools.PFLeqPFR(hd_fname, in_fname) => 1,
    hd_fname[1]=in_fname or hd_fname=in_fname[1] => 1,   
    hd_fname='' => 3,
    MIN((datalib.namesimilar(hd_fname,in_fname,1) + 3),10)) +
MAP(in_mname='' or hd_mname=in_mname => 0,
    hd_mname[1]=in_mname or hd_mname=in_mname[1] => 2,
    hd_mname='' => 2,
		LENGTH(TRIM(in_mname))=1 => 3,
    MIN((datalib.namesimilar(hd_mname,in_mname,1) * 3),10)) +
MAP(in_ssn='' or hd_ssn=in_ssn => 0,
    hd_ssn='' => 3,
    length(trim(in_ssn))=4 and in_ssn=hd_ssn[6..9] => 0,
    IF(ut.stringsimilar(hd_ssn,in_ssn)>4, score_threshold-1,ut.stringsimilar(hd_ssn,in_ssn))) +
// test against input city (input_city_value) and cleaned city (city_value)
MAP (in_city='' or hd_city=in_city => 0, 
     hd_city='' => 3,
     ut.stringsimilar(hd_city,in_city)<3 => 1,	 
     5) +
IF (in_state='' or hd_state=in_state, 0 , 10 ) +
MAP (in_zip='' => 0,
     hd_zip='' => 2,
	in_zip=hd_zip => 0,
     if(is_us_zip,(unsigned4)(4*ut.zip_Dist(in_zip,hd_zip)),10)) +
MAP (in_phone='' or hd_phone=in_phone or hd_phone[4..10]=in_phone => 0 ,
	hd_phone=in_phone[4..10] => 1,
	hd_phone[4..10]=in_phone[4..10] => 2,
	hd_phone='' =>3, score_threshold-1) +
MAP (in_predir='' or hd_predir=in_predir => 0,
     1 ) +
MAP (in_postdir='' or hd_postdir=in_postdir => 0, 1) +
MAP (in_suffix='' or hd_suffix=in_suffix => 0, 1) +
MAP (in_pname='' or ut.StripOrdinal(hd_pname)=in_pname => 0,     
     hd_pname='' => 8, 
     ut.stringsimilar(in_pname,hd_pname)) +
MAP ((unsigned8)in_prange=0 or (unsigned8)hd_prange=(unsigned8)in_prange => 0,
     (unsigned8)hd_prange=0 => 2, 
     ut.stringsimilar(in_prange,hd_prange)) +
MAP (((unsigned8)in_dob div 100) % 100 = 0 or 
     ((unsigned8)hd_dob div 100) % 100 = ((unsigned8)in_dob div 100) % 100 => 0,
      (unsigned8)hd_dob=0 => 3,
			  hd_dob[5..6] IN ['00','01'] => 3,	// like a null
      10 ) +
MAP ( (unsigned8)in_dob % 100 = 0 or 
      (unsigned8)hd_dob % 100 = (unsigned8)in_dob % 100 => 0,
      (unsigned8)hd_dob=0 => 2,
			  hd_dob[7..8] IN ['00','01'] => 2,	// like a null
      10) +
MAP ( ((unsigned8)in_dob div 10000) = 0 or 
      ((unsigned8)hd_dob div 10000) = ((unsigned8)in_dob div 10000) => 0,
      (unsigned8)hd_dob=0 => 5,
      10 );	
END;