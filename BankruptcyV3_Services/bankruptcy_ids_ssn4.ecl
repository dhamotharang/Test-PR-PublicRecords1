import bankruptcyV3, AutoStandardI;
export bankruptcy_ids_ssn4(unsigned inLimit = consts.MAX_SSN4,
                           string4  inSSN4,
						   string2  inState ='',
                           string1  inPartyType = '',
						   string50 inLast = '',
						   string50 inFirst = '',
                           boolean  isFCRA = false
	                      ):= function
		   
           outrec := bankruptcyv3_services.layouts.layout_tmsid_ext;
		   
		   //index to use, contains only DEBTORS.
		   ssn4key := bankruptcyV3.key_bankruptcyV3_ssn4st(isFCRA);
	       
		   //state key, not required
		   sFilter := if (length(trim(inState)) > 0, ssn4Key.state=inState,true);    
		   
		   //lastname filter, not required
	       lFilter := if (length(trim(inLast)) > 0, 
                          IF (LENGTH(TRIM(ssn4key.lname)) > 0,
								   trim(ssn4key.lname) = inLast,
						     	   StringLib.StringFind(ssn4key.lname, TRIM(inLast), 1) > 0
						   ), 
		                   true);
		   //firstname filter, not required				   
		   fFilter := if (length(trim(inFirst)) > 0, 
		                  IF (LENGTH(TRIM(ssn4key.fname)) > 0,
							 trim(ssn4key.fname) = inFirst ,
							 StringLib.StringFind(ssn4key.lname, TRIM(inFirst), 1) > 0
					      )
						  ,true);
		             
            choosen_cnt := if (((inLimit > 0) and (inlimit < consts.MAX_SSN4)),inLimit,consts.MAX_SSN4);		 

			tmsids := choosen(ssn4key(KEYED(ssnLast4=inSSN4 and sFilter) and LFilter and FFilter),choosen_cnt);
            tmsids_sorted := sort(tmsids,tmsid);
		    tmsids_nodup := dedup(tmsids_sorted,tmsid); 						  
			tmsids_raw := project(tmsids_nodup, transform(outrec,self.isdeepdive := false,self := left)); 
			return tmsids_raw;
		end;
