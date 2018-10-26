import AutostandardI,doxie,driversv2,mdr;

export Did_Score() := FUNCTION

	inputmod := AutoStandardI.GlobalModule();
  mod_access := doxie.functions.GetGlobalDataAccessModuleTranslated (inputmod);
	
	zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.zip_value.params)); 

	string2 dl_state_val := '' : stored('dl_state');
	
	just_digits_and_alphas(string20 dl) :=  Stringlib.StringFilter(dl,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
	
	dl_val := just_digits_and_alphas(AutoStandardI.InterfaceTranslator.dl_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.dl_value.params))); 


	in_rec := record
		didville.Layout_Did_OutBatch;
	end;	


	in_rec get_inputs(doxie.layout_references l, unsigned cnt) := transform
		self.seq := cnt;
		self.title := '';
		self.addr_suffix := AutoStandardI.InterfaceTranslator.addr_suffix_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.addr_suffix_value.params));			
		self.suffix :=AutoStandardI.InterfaceTranslator.name_suffix_val.val(project(inputmod,AutoStandardI.InterfaceTranslator.name_suffix_val.params)); 
		self.fname := AutoStandardI.InterfaceTranslator.fname_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.fname_value.params)); 
		self.mname := AutoStandardI.InterfaceTranslator.mname_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.mname_value.params)); 
		self.lname := AutoStandardI.InterfaceTranslator.lname_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.lname_value.params)); 
		self.dob := (qstring8) AutoStandardI.InterfaceTranslator.dob_val.val(project(inputmod,AutoStandardI.InterfaceTranslator.dob_val.params));
		self.prim_name := AutoStandardI.InterfaceTranslator.pname_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.pname_value.params)); 
		self.prim_range := AutoStandardI.InterfaceTranslator.prange_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.prange_value.params)); 
		self.predir := AutoStandardI.InterfaceTranslator.predir_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.predir_value.params)); 
		self.postdir := AutoStandardI.InterfaceTranslator.postdir_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.postdir_value.params)); 
		self.sec_range := AutoStandardI.InterfaceTranslator.sec_range_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.sec_range_value.params)); 
		self.p_city_name := AutoStandardI.InterfaceTranslator.city_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.city_value.params)); 
		self.st := AutoStandardI.InterfaceTranslator.state_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.state_value.params)); 
		self.z5 := AutoStandardI.InterfaceTranslator.zip_val.val(project(inputmod,AutoStandardI.InterfaceTranslator.zip_val.params)); 
		self := [];
	end;


	f_in := project(dataset([{0}],doxie.layout_references), get_inputs(left, counter));

	didville.MAC_DidAppend(f_in, f_with_did, true, 'true');


	score_threshold_val := AutoStandardI.InterfaceTranslator.score_threshold_value.val(project(inputmod
	 ,AutoStandardI.InterfaceTranslator.score_threshold_value.params)); 

	score_threshold_value := if(score_threshold_val=10,75,score_threshold_val);


	did := ungroup(project(f_with_did(score>=score_threshold_value),doxie.layout_references));


	br := doxie.best_records(did, doSuppress:=false, includeDOD:=true, modAccess := mod_access);

	// Get uncleaned records so that dt_first_seen may be pulled off any records. Later get passed through MAC_GlbClean_Header
		//have to reset mod_access to ensure same call as was here before:
	mod_access_local := MODULE (mod_access)
    EXPORT boolean ln_branded := FALSE;
    EXPORT boolean probation_override := FALSE;
    EXPORT boolean no_scrub := FALSE;
    EXPORT unsigned3 date_threshold := 0;
	END;
	header_recs0 := doxie.mod_header_records(
		false,true,,,true, modAccess := mod_access_local).results(project(did,doxie.layout_references_hh));

	// Get best address record
	best_from_func := didville.BestAddress.Best_Recs(header_recs0,did,mod_access.dppa,mod_access.glb,'','',0,0);



	best_addr_rec := if(exists(best_from_func),best_from_func,project(br,Didville.Layout_Did_Numeric_Out.Addr_Best));

	best_dob_rec := if(exists(br),br,project(choosen(header_recs0(dob<>0),1),transform(doxie.layout_best,self.dod :='',self:=left,self:=[])));

	score_w_src := record
	didville.layout_Did_Score;
	string2 src;
	end;

	score_w_src w_header(header_recs0 l):=transform
		self.score_any_addr := max(if((unsigned3) l.zip in zip_value,9,0), 100-(10*doxie.FN_Tra_Penalty_Addr(l.predir,l.prim_range,l.prim_name,l.suffix,
			l.postdir, l.sec_range,l.city_name,l.st,l.zip)));
			self.src := l.src;
		self := [];
	END;


	header_addr_recs := project(header_recs0,w_header(left));

	header_addr_score := if(~exists(header_addr_recs),255,max(header_addr_recs,score_any_addr));

	// Get best equifax address record that exists in the header or the daily records.
	credit_header_srcs := ['EQ','QH',MDR.sourceTools.WH_src];

	credit_addr_recs :=header_Addr_recs(src in credit_header_srcs);

	credit_addr_score := if(~exists(credit_addr_recs),255, max(credit_addr_recs,score_any_addr));


	// The dl score is for the current dl
	matching_dl_by_did_any := join(did,driversV2.Key_DL_DID,keyed(left.did=right.did),
	transform(recordof(driversV2.Key_DL_DID),self:=right),limit(ut.limits.did_per_person,skip));
	
	// if either one of the following attributes exist the score any dl number field is 100
	matching_dl_by_dl_num_any := matching_dl_by_did_any(dl_val=just_digits_and_alphas(dl_number));
	matching_dl_by_dl_num_prev := matching_dl_by_did_any(dl_val= just_digits_and_alphas(oos_previous_dl_number));
		
	matching_dl_by_did_best := matching_dl_by_did_any(history='');
	
	matching_dl_by_dl_num_best := matching_dl_by_did_best(dl_val=just_digits_and_alphas(dl_number) );

	didville.layout_Did_Score  w_dl(driversV2.Key_DL_DID r):=transform		
		// The best dl addr score is in this field for matching_dl_w_scores_best until we compute dl_addr_score_best
		self.score_dl_addr_any :=MAX(if((unsigned3) r.zip in zip_value,9,0),100-(10*doxie.FN_Tra_Penalty_Addr(r.predir,r.prim_range,r.prim_name,r.suffix,
			r.postdir, r.sec_range,r.city,r.st,r.zip)));
		self := [];
	END;


	matching_dl_w_scores_best := project(matching_dl_by_dl_num_best,w_dl(LEFT));
	matching_dl_w_scores_any := project(matching_dl_by_dl_num_any,w_dl(LEFT));


	dl_addr_score_best :=   if(~exists(matching_dl_by_dl_num_best),255,max(matching_dl_w_scores_best,score_dl_addr_any));
	
	// A dl addr score may be 255 if either there are no dl matches for the did or there are matches but the only dl number match
	// is on a previous dl number and we do not have addresses for previous dl numbers (which are different than historical or expired
	// dl records).
	dl_addr_score_any :=   if(~exists(matching_dl_by_dl_num_any),255, max(matching_dl_w_scores_any,score_dl_addr_any));
	
	dl_number_score_best := map(~exists(matching_dl_by_did_best) or dl_val=''=>255, 
														  ~exists(matching_dl_by_dl_num_best)=>0,
															100);
	
	// dl number must be input for this score to work properly													
	dl_number_score_any := map(~exists(matching_dl_by_did_any) or dl_val=''=>255, 
														 ~exists(matching_dl_by_dl_num_any)  and ~exists(matching_dl_by_dl_num_prev) =>0,
														 100);


	didville.layout_Did_Score w_best(f_in l, best_dob_rec ri):=transform
			temp_dob_val := (unsigned8) if(((integer) l.dob) < 1300,l.dob,(((trim(l.dob)) + '0000')[1..8]));
			find_year := doxie.DOBTools(temp_dob_val).find_year_high(0);

			find_month := doxie.DOBTools(temp_dob_val).find_month;
			find_day := 	doxie.DOBTools(temp_dob_val).find_day;

		self.score_best_dob := if((integer) l.dob=0 or ri.dob=0, 255,
														if(find_year =(integer)((STRING)ri.dob)[1..4] or find_year=0,50,0) +
														if(find_month = (integer)((STRING)ri.dob)[5..6] or find_month=0,30,0) +
														if(find_day = (integer)((STRING)ri.dob)[7..8] or find_day=0,20,0));
		self.score_any_addr	:= l.score_any_addr;
		self.score := l.score;
		self.did := l.did;
		self := [];
	END;											
													



	j0 := JOIN(f_with_did,best_dob_rec,LEFT.did=RIGHT.did,w_best(LEFT,RIGHT), LEFT OUTER);


	didville.layout_Did_Score w_best_addr(j0 l,best_addr_rec r):=transform
		self.score_best_addr := if(r.did=0,255, max(if((unsigned3) r.zip in zip_value,9,0), 100-(10*doxie.FN_Tra_Penalty_Addr(r.predir,r.prim_range,r.prim_name,r.suffix,
			r.postdir, r.sec_range,r.city_name,r.st,r.zip))));
		self.score_any_addr := header_addr_score;
		self.score_credit_addr := credit_addr_score;
		self.score_dl_number_any := dl_number_score_any;
		self.score_dl_number_best := dl_number_score_best;
		self.score_dl_addr_any := dl_addr_score_any;
		self.score_dl_addr_best := dl_addr_score_best;
		self.score_threshold := score_threshold_value;
		self := l;
	end;	



	j1 := JOIN(j0,best_addr_rec,left.did=right.did,w_best_addr(LEFT,RIGHT),LEFT OUTER);

	//output(best_dob_rec);
	// output(credit_addr_recs);
	// output(header_recs0);
	// output(br);

	j2 := if(~exists(did(did<>0)),project(f_in,transform(didville.Layout_Did_Score,
	self.score_threshold:= score_threshold_value, self:=[])),j1);

	return j2;

END;