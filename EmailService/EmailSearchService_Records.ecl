import ut,AutoStandardI,doxie,suppress,Email_Data,codes,D2C,Royalty;

export EmailSearchService_Records := MODULE

  // export recs(Grouped dataset(Assorted_Layouts.did_w_input) in_dids =dataset([],Assorted_Layouts.did_w_input),
//For deployment to dev64, comment out line above and uncoment the line below:
export recs(Grouped dataset(Assorted_Layouts.did_w_input) in_dids,
			boolean by_email_key=FALSE, 
			string32 appType=Suppress.Constants.ApplicationTypes.Default,
			boolean multipleRoyalties=FALSE,
			string5 industry_class = '') := FUNCTION
		
		Assorted_Layouts.layout_entiera_rollup_w_seq get_penalt(Assorted_Layouts.did_w_input l,Email_Data.Key_Did r):=transform
		
			self.src := r.email_src;
		
			tempindvmod := module(AutoStandardI.LIBIN.PenaltyI_Indv.full)
				export	addr	:=	l.	addr;
				export	agehigh	:=	l.	agehigh;
				export	agelow	:=	l.	agelow;
				export	asisname	:=	l.	asisname;
				export	city	:=	l.	city;
				export 	othercity1 := '';
				export	county	:=	l.	county;
				export	did	:=	l.input_did;
				export	dob	:=	l.	dob;
				export	firstname	:=	l.	firstname;
				export	fname3	:=	l.	fname3;
				export	isfcraval	:=	l.	isfcraval;
				export	isprp	:=	l.	isprp;
				export	lastname	:=	l.	lastname;
				export	lfmname	:=	l.	lfmname;
				export	lname	:=	l.	lname;
				export	lname4	:=	l.	lname4;
				export	lnbranded	:=	l.	lnbranded;
				export	middlename	:=	l.	middlename;
				export	nameasis	:=	l.	nameasis;
				export	nonexclusion	:=	l.	nonexclusion;
				export	phone	:=	l.	phone;
				export	phoneticdistancematch	:=	l.	phoneticdistancematch;
				export	phoneticmatch	:=	l.	phoneticmatch;
				export	postdir	:=	l.	postdir;
				export	predir	:=	l.	predir;
				export	prim_name	:=	l.	prim_name;
				export	prim_range	:=	l.	prim_range;
				export	sec_range	:=	l.	sec_range;
				export	primname	:=	l.	primname;
				export	primrange	:=	l.	primrange;
				export	secrange	:=	l.	secrange;
				export	scorethreshold	:=	l.	scorethreshold;
				export	ssn	:=	l.	ssn;
				export	st	:=	l.	st;
				export	st_orig	:=	l.	st_orig;
				export	state	:=	l.	state;
				export	otherstate1 := '';
				export	otherstate2 := '';
				export	statecityzip	:=	l.	statecityzip;
				export	street_name	:=	l.	street_name;
				export	suffix	:=	l.	suffix;
				export	unparsedfullname	:=	l.	unparsedfullname;
				export	z5	:=	l.	z5;
				export	zip	:=	l.	zip;
				export	zipradius	:=	l.	zipradius	;			
				export allow_wildcard := false;
				export city_field := r.clean_address.v_city_name;
				export did_field := (string)r.did;
				export fname_field := r.clean_name.fname;
				export lname_field := r.clean_name.lname;
				export mname_field := r.clean_name.mname;
				export phone_field := '';
				export pname_field := r.clean_address.prim_name;
				export postdir_field := r.clean_address.postdir;
				export prange_field := r.clean_address.prim_range;
				export predir_field := r.clean_address.predir;
				export ssn_field := r.best_ssn;
				export state_field := r.clean_address.st;
				export suffix_field := r.clean_address.addr_suffix;
				export zip_field := r.clean_address.zip;
				export city2_field := r.clean_address.p_city_name;
				export county_field := '';
				export dob_field := (string8) r.best_dob;
				export dod_field := '';
				export useGlobalScope := true;				
				export BpsLeadingNameMatch := false;				
				export CheckNameVariants := false;
				export UseSSNFallback := false;
				export mileRadius := 0;
				export CleanFMLName := false;
			end;

			// Get the minimum penalty for the individual info using both addresses.


			penalt_didssndob := AutoStandardI.LIBCALL_PenaltyI_Indv.val_did(tempindvmod) +
				AutoStandardI.LIBCALL_PenaltyI_Indv.val_ssn(tempindvmod) +
				AutoStandardI.LIBCALL_PenaltyI_Indv.val_dob(tempindvmod);
			self.penalt_didssndob := penalt_didssndob;
			penalt_name :=AutoStandardI.LIBCALL_PenaltyI_Indv.val_indv_name(tempindvmod);	
			self.names :=project(r.clean_name,transform(Assorted_Layouts.Layout_names, 
			self.penalt_name :=penalt_name,
			self:=left));
			penalt_addr :=AutoStandardI.LIBCALL_PenaltyI_Indv.val_addr(tempindvmod);
			self.addresses := project(r.clean_address,transform(Assorted_Layouts.Layout_addresses,
			self.penalt_addr :=penalt_addr,
			self:=left)),
			self.emails := dataset([{r.orig_email,r.clean_email,r.orig_login_date,r.orig_site,r.date_first_seen,r.date_last_seen,r.date_vendor_first_reported,r.date_vendor_last_reported}],
					Assorted_Layouts.layout_emails),
			self := r;
			self := l;
			self := [];
		END;

		
		recs_w_dids_penalt := join(in_dids,Email_Data.Key_Did,
													keyed(left.did=right.did) and 
													~( industry_class = ut.IndustryClass.Knowx_IC and 
														 right.email_src in D2C.Constants.EmailRestrictedSources ),
				get_penalt(left,right),
				keep(Constants.recs_per_did),limit(ut.limits.default));

		Suppress.MAC_Suppress(recs_w_dids_penalt,pull_dids,apptype,Suppress.Constants.LinkTypes.DID,did);
		Suppress.MAC_Suppress(pull_dids,pull_ssns,apptype,Suppress.Constants.LinkTypes.SSN,best_ssn);
		doxie.MAC_PruneOldSSNs(pull_ssns, recs_pruned, best_ssn, did);
		suppress.mac_mask(recs_pruned, recs_masked, best_ssn, blank, true, false,true);
		
		recs_masked_grp := if(multipleRoyalties,
													group(sort(recs_masked, did,src), did,src),
													group(sort(recs_masked, did), did));
		
		royal_codes := Royalty.Constants.EMAIL_ROYALTY_TABLE();
		royal_recs := 
      JOIN( recs_masked_grp, 
            royal_codes, 
            LEFT.src = RIGHT.code, grouped);
		
		royal_recs_sorted := if(multipleRoyalties,
														project(royal_recs, Assorted_Layouts.layout_entiera_rollup_w_seq),
														project(sort(royal_recs, field_name2), Assorted_Layouts.layout_entiera_rollup_w_seq));
		
		nonroyal_recs := join(recs_masked, group(royal_recs), left.src = right.src, transform(left), left only);

		Assorted_Layouts.layout_entiera_rollup_w_seq get_all(Assorted_Layouts.layout_entiera_rollup_w_seq l, dataset(Assorted_Layouts.layout_entiera_rollup_w_seq) r) := transform
			keep_src := evaluate(l, src);
			ds := if(multipleRoyalties,r,r(src = keep_src));
			
			self.names := choosen(dedup (sort(ds.names,penalt_name,record),record),Constants.MAX_NAMES_PER_PERSON);
			self.addresses := choosen(dedup(sort(ds.addresses,penalt_addr,record),record),Constants.MAX_ADDRS_PER_PERSON);
			self.emails := sort(choosen(dedup(sort(ds.emails,-orig_email,-orig_login_date,-orig_site),
			(trim(left.orig_email)+trim(left.orig_login_date)+trim(left.orig_site))[1..length(
			trim(right.orig_email)+trim(right.orig_login_date)+trim(right.orig_site))]=
			trim(right.orig_email)+trim(right.orig_login_date)+trim(right.orig_site))
			,Constants.MAX_EMAILS_PER_PERSON),-orig_login_date);
			self.latest_orig_login_date := (unsigned4) max(ds.emails,(unsigned4) orig_login_date);
			self.penalt := min(ds.names,penalt_name) + min(ds.addresses,penalt_addr) + l.penalt_didssndob;
			self := l;
		END;


		royal_recs_rolled := 
						group(ungroup(rollup(royal_recs_sorted, group,get_all(left,rows(left)))),seq);
						
		all_recs := nonroyal_recs & royal_recs_rolled;
		
		recs_chkd := all_recs(if(by_email_key,penalt=0,TRUE));
		
		RETURN ungroup(sort(recs_chkd(penalt <= penalt_Threshold),seq,if(isDeepDive,1,0),penalt,-latest_orig_login_date,record));
	END;


 //the in_dids actually contains email Ids which uses either LexIds or fake ids:
export val(Grouped dataset(Assorted_Layouts.did_w_input) in_dids =group(dataset([],Assorted_Layouts.did_w_input),seq,did),
			string search_type='',
			boolean mult_results=false,
			string32 appType,
			string5 industry_class = '')
			:= function

		isEICsearch := search_type = EmailService.Constants.SearchType.EIC;  // email identity check
		isEIAsearch := search_type = EmailService.Constants.SearchType.EIA;  //email identity append - by_email_key=true
		isEAAsearch := search_type = EmailService.Constants.SearchType.EAA;  //email address append
		
		recs_sort := recs(in_dids,isEIAsearch,appType,,industry_class)(did<>0);  //did here might be fake Id
		
		recs_grp_pen := group(sort(recs_sort, penalt), penalt);
		recs_dep_did := dedup(sort(recs_grp_pen, did), did);
		
		table_rec := record
		  recs_dep_did.penalt;
		  penaltCnt := COUNT(GROUP);
		end;
		
		temp_table := SORT(TABLE(recs_dep_did,table_rec,penalt,FEW),penalt);
		
		boolean first_one_good := temp_table[1].penaltCnt=1;
		boolean more_than_one  := count(recs_sort) > 1;
	  
		// if(more_than_one and ~first_one_good,ut.outputMessage(ut.constants_MessageCodes.SUBJECT_NOT_UNIQUE));
		if(more_than_one and ~first_one_good and ~mult_results,
			map(isEIAsearch => ut.outputMessage(ut.constants_MessageCodes.EMAIL_NOT_UNIQUE),
			isEAAsearch => ut.outputMessage(ut.constants_MessageCodes.SUBJECT_NOT_UNIQUE))
		   );

		lowest_pen := temp_table[1].penalt;
		recs_returned := IF(first_one_good, recs_sort(penalt = lowest_pen));

    // Added for debugging
	  // output(recs_chkd,named('essrecs_recs_chkd'));
		// output(recs_sort,named('essrecs_recs_sort'));
		// output(temp_table,named('essrecs_temp_table'));
		// output(recs_returned,named('essrecs_recs_returned'));
		// output(first_one_good,named('essrecs_first_one_good'));
		// output(more_than_one,named('essrecs_more_than_one'));

		return if(mult_results or isEICsearch, recs_sort, recs_returned);
	END;
END;	