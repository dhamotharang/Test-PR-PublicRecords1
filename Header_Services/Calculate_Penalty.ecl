import header,ut, doxie, NID,suppress,ut;
		
// l_rec is the header records, r_rec is the input data
export Calculate_Penalty(DATASET(header.Layout_Header)l_rec, DATASET(header.Layout_Header) r_rec,
												unsigned1 score_threshold_value, unsigned2 zipradius_value, string32 appType) 
:= FUNCTION
	Layout_HeaderOut_Calculate_Penalty toPenlty(header.Layout_Header l):= TRANSFORM
		SELF := l;
	END;

	Layout_HeaderOut_Calculate_Penalty doJoin(Layout_HeaderOut_Calculate_Penalty le, Layout_HeaderOut_Calculate_Penalty re) := TRANSFORM
		city_zip_value := ziplib.CityToZip5(re.st, re.city_name);
		zip_value := IF(re.zip<>'', IF(ziplib.ZipsWithinRadius(re.zip, zipradius_value)=[],
																																[(unsigned4)re.zip],
																																ziplib.ZipsWithinRadius(re.zip, zipradius_value)),
				 IF(re.st<>'' AND re.city_name<>'' AND zipradius_value>0, ziplib.ZipsWithinRadius(city_zip_value, zipradius_value),
					[]));

		find_year_low := MAP( re.dob div 10000 <> 0 => re.dob div 10000,
													0 );   
		find_year_high := MAP( re.dob div 10000 <> 0 => re.dob div 10000,
													0 );

		find_month := (re.dob div 100) % 100;
		find_day := re.dob % 100;

		temp_penlty := 
		if(find_month=0,1,0) +
		if(find_day=0,1,0) +
		if(re.fname='',1,0) +
		if(re.mname='',1,0) +
		if(re.lname='',1,0) +
		if(re.ssn='',1,0) +
		if(re.prim_name='',1,0) +
		if(re.city_name='',1,0) +
		if(re.st='',1,0) +
		if(zip_value=[],1,0) +
		if(re.phone='',1,0) +
		MAP(re.lname='' or le.lname=re.lname => 0,
				 le.lname='' => 3,
				 //namesimilar seems return either 0-6 or 99, so it is adjusted +3
				 //metaphone appears to have too many false positives, so penalty is
				 //calculated using both, with a cap of 10 for last name mismatch
				 ut.imin2((datalib.namesimilar(le.lname,re.lname,1)+ 3)/ 
				 IF(metaphonelib.DMetaPhone1(le.lname)=metaphonelib.DMetaPhone1(re.lname),2,1),10)) + 
		MAP(re.fname='' or le.fname=re.fname => 0,
				NID.mod_PFirstTools.PFLeqPFR(le.fname, re.fname) => 1,
				le.fname[1]=re.fname or le.fname=re.fname[1] => 1,
				le.fname='' => 3,
				ut.imin2((datalib.namesimilar(le.fname,re.fname,1) + 3),10)) +
		MAP(re.mname='' or le.mname=re.mname => 0,
				le.mname[1]=re.mname or le.mname=re.mname[1] => 2,
				le.mname='' => 2,
				ut.imin2((datalib.namesimilar(le.mname,re.mname,1) * 3),10)) +
		MAP(re.ssn='' or le.ssn=re.ssn => 0,
				le.ssn='' => 3,
				length(trim(re.ssn))=4 and re.ssn=le.ssn[6..9] => 0,
				IF(ut.stringsimilar(le.ssn,re.ssn)>4,score_threshold_value-1,ut.stringsimilar(le.ssn,re.ssn))) +
		MAP ((unsigned8)re.did=0 or (unsigned8)le.did = (unsigned8)re.did => 0 , 
				10) +
		MAP (re.city_name='' or le.city_name=re.city_name => 0, 
				 le.city_name='' => 3,
				 zipradius_value>0 or ut.stringsimilar(le.city_name,re.city_name)<3 => 1,	 
				 5 ) +
		MAP (re.county='' or le.county=re.county => 0, 
				 le.county='' => 3,
				 ut.stringsimilar(le.county,re.county)<3 => 1,	 
				 10 ) +
		IF (re.st='' or le.st=re.st, 0 , 10 ) +
		MAP (zip_value=[] => 0,
				 (unsigned4)le.zip=0 => 2,
				 (unsigned4)(4*ut.zip_Dist(IF(re.zip<>'',re.zip,city_zip_value),le.zip) / ut.max2(zipradius_value,1))) +
		MAP (re.phone='' or le.phone=re.phone or le.phone[4..10]=re.phone => 0 ,
			le.phone=re.phone[4..10] => 1,
			le.phone[4..10]=re.phone[4..10] => 2,
			le.phone='' =>3, score_threshold_value-1 ) +
		MAP ( re.predir='' or le.predir=re.predir => 0,
				 1 ) +
		MAP ( re.postdir='' or le.postdir=re.postdir => 0,
				 1 ) +
		MAP ( re.suffix='' or le.suffix=re.suffix => 0,
				 1 ) +
		MAP (re.prim_name='' or ut.StripOrdinal(le.prim_name)=re.prim_name => 0,
				 le.prim_name='' => 8, 
				 ut.stringsimilar(re.prim_name,le.prim_name)) +
		MAP ((unsigned8)re.prim_range=0 or (unsigned8)le.prim_range=(unsigned8)re.prim_range => 0,
//				 re.addr_range AND (unsigned)le.prim_range >= re.prange_beg_value AND 
//						(unsigned)le.prim_range <= re.prange_end_value => 0,
//			re.addr_wild AND Stringlib.StringWildMatch(le.prange, re.prange_wild_value, TRUE) => 0,
			(unsigned8)le.prim_range=0 => 2, 
				 ut.stringsimilar(re.prim_range,le.prim_range)) +
		MAP ( find_month = 0 or ((unsigned8)le.dob div 100) % 100 = find_month => 0,
					(unsigned8)le.dob=0 => 3,
				le.dob[5..6] IN ['00','01'] => 3,	// like a null
 				10 ) +
		MAP ( find_day = 0 or (unsigned8)le.dob % 100 = find_day => 0,
					(unsigned8)le.dob=0 => 2,
				le.dob[7..8] IN ['00','01'] => 2,	// like a null
				10 ) +
		MAP ( ( find_year_high = 0 or find_year_high >= (unsigned8)le.dob div 10000 ) and 
						( find_year_low = 0 or find_year_low <= (unsigned8)le.dob div 10000 )  => 0,
					(unsigned8)le.dob=0 => 5,
					10 );
		SELF.penlty := IF(le.penlty = -1,temp_penlty,
											IF(le.penlty < temp_penlty, le.penlty,temp_penlty));
		SELF := le;
	END;
	l_rec_pre := project(l_rec,toPenlty(LEFT));
	//Suppress left records for SSN and DID
	Suppress.MAC_Suppress(l_rec_pre,l_rec_pull,appType,Suppress.Constants.LinkTypes.DID,did);
	Suppress.MAC_Suppress(l_rec_pull,l_rec_p,appType,Suppress.Constants.LinkTypes.SSN,ssn);

	r_rec_p := project(r_rec,toPenlty(LEFT));
	outrec :=DENORMALIZE(l_rec_p,r_rec_p,Left.penlty = right.penlty,doJoin(LEFT,RIGHT));
 return outrec;    
 END;