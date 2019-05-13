import Autokey_Batch, AutoStandardI, ut, doxie, paw_services, suppress;

export Functions := module
	shared fnDate(dataset(Layouts.raw) in_recs) := function
		temp_filter := in_recs(dt_last_seen != '' or dt_first_seen != '');
		temp_rollup := rollup(temp_filter,
			true,
			transform(Layouts.raw,
				self.dt_last_seen := map(
					right.dt_last_seen = '' => left.dt_last_seen,
					left.dt_last_seen = '' => right.dt_last_seen,
					left.dt_last_seen > right.dt_last_seen => left.dt_last_seen,
					right.dt_last_seen),
				self.dt_first_seen := map(
					right.dt_first_seen = '' => left.dt_first_seen,
					left.dt_first_seen = '' => right.dt_first_seen,
					left.dt_first_seen < right.dt_first_seen => left.dt_first_seen,
					right.dt_first_seen),
				self := left));
		temp_project := project(temp_rollup,Layouts.rptDtSeen);
		return temp_project;
	end;
	shared fnSsn(dataset(Layouts.raw) in_recs, string ssnmask) := function
		temp_filter := in_recs(ssn != '');
		temp_sort := sort(temp_filter,ssn,-dt_last_seen,-dt_first_seen,-score,record);
		temp_dedup := dedup(temp_sort,ssn);
		temp_resort := sort(temp_dedup,-dt_last_seen,-dt_first_seen,-score,ssn,record);
		temp_project := project(temp_resort,Layouts.rptSsn);
		suppress.MAC_Mask (temp_project, temp_masked, SSN, null, true, false, , , , ssnmask);
		return temp_masked;
	end;
	shared fnFein(dataset(Layouts.raw) in_recs) := function
		temp_filter := in_recs(company_fein != '');
		temp_sort := sort(temp_filter,company_fein,-dt_last_seen,-dt_first_seen,-score,record);
		temp_dedup := dedup(temp_sort,company_fein);
		temp_resort := sort(temp_dedup,-dt_last_seen,-dt_first_seen,-score,company_fein,record);
		temp_project := project(temp_resort,transform(Layouts.rptFein,
			self.fein := left.company_fein));
		return temp_project;
	end;
	shared fnIndvName(dataset(Layouts.raw) in_recs) := function
		temp_filter := in_recs(title != '' or fname != '' or mname != '' or lname != '' or name_suffix != '');
		temp_sort := sort(temp_filter,lname,fname,mname,name_suffix,title,-dt_last_seen,-dt_first_seen,-score,record);
		temp_dedup := dedup(temp_sort,lname,fname,mname,name_suffix,title);
		temp_resort := sort(temp_dedup,-dt_last_seen,-dt_first_seen,-score,lname,fname,mname,name_suffix,title,record);
		temp_project := project(temp_resort,Layouts.rptIndvName);
		return temp_project;
	end;
	shared fnBizName(dataset(Layouts.raw) in_recs) := function
		temp_filter := in_recs(company_name != '');
		temp_sort := sort(temp_filter,company_name,-dt_last_seen,-dt_first_seen,-score,record);
		temp_dedup := dedup(temp_sort,company_name);
		temp_resort := sort(temp_dedup,-dt_last_seen,-dt_first_seen,-score,company_name,record);
		temp_project := project(temp_resort,Layouts.rptBizName);
		return temp_project;
	end;
	shared fnPhone(dataset(Layouts.raw) in_recs) := function
		temp_filter := in_recs((integer)company_phone != 0);
		temp_sort := sort(temp_filter,company_phone,-dt_last_seen,-dt_first_seen,-score,record);
		temp_dedup := dedup(temp_sort,company_phone);
		temp_resort := sort(temp_dedup,-dt_last_seen,-dt_first_seen,-score,company_phone,record);
		temp_project := project(temp_resort,transform(Layouts.rptPhone,self.phone10 := left.company_phone,self.verified := false,self:=left) );
		return temp_project;
	end;
	shared fnAddr := module
		export params := interface
			export unsigned2 REQ_PHONES_PER_ADDR;
		end;
		export val(dataset(Layouts.raw) in_recs,params in_mod) := function
			temp_filter := in_recs(prim_range != '' or predir != '' or prim_name != '' or addr_suffix != '' or postdir != '' or unit_desig != '' or sec_range != '' or city != '' or state != '' or zip != '' or zip4 != '');
			temp_sort := sort(in_recs,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,city,state,zip,zip4,-dt_last_seen,-dt_first_seen,-score,record);
			temp_rollup := rollup(group(temp_sort,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,city,state,zip,zip4),group,
				transform(Layouts.rptAddr,
					self.phones := choosen(fnPhone(rows(left)),ut.min2(in_mod.REQ_PHONES_PER_ADDR,Constants.MAX_PHONES_PER_ADDR)),
					self := left));
			return temp_rollup;
		end;
	end;
	shared fnPosition := module
		export params := interface
			export unsigned2 REQ_DATES_PER_POSITION;
		end;
		export val(dataset(Layouts.raw) in_recs,params in_mod) := function
			temp_filter := in_recs(company_title != '' or company_department != '');
			temp_sort := sort(temp_filter,company_title,company_department);
			temp_rollup := rollup(group(temp_sort,company_title,company_department),group,
				transform(Layouts.rptPosition,
					self.dates := choosen(fnDate(rows(left)),ut.min2(in_mod.REQ_DATES_PER_POSITION,Constants.MAX_DATES_PER_POSITION)),
					self.company_title := left.company_title,
					self.company_department := left.company_department));
			return temp_rollup;
		end;
	end;
	shared fnEmployer := module
		export params := interface(fnPosition.params,fnAddr.params)
      export string ssn_mask;

			export unsigned2 REQ_DATES_PER_EMPLOYER;
			export unsigned2 REQ_FEINS_PER_EMPLOYER;
			export unsigned2 REQ_COMPANY_NAMES_PER_EMPLOYER;
			export unsigned2 REQ_ADDRS_PER_EMPLOYER;
			export unsigned2 REQ_POSITIONS_PER_EMPLOYER;
		end;
		export val(dataset(Layouts.raw) in_recs,params in_mod) := function
			temp_sort := sort(in_recs,bdid,if(bdid = 0,contact_id,0));
			temp_rollup := rollup(group(temp_sort,bdid,if(bdid = 0,contact_id,0)),group,
				transform(Layouts.rptEmployer,
					self.bdid := left.bdid,
					self.proxid := left.proxid,
					self.ultid := left.ultid,
					self.orgid := left.orgid,
					self.seleid := left.seleid,
					self.dotid := left.dotid,
					self.empid := left.empid,
					self.powid := left.powid,
					self.dates := choosen(fnDate(rows(left)),ut.min2(in_mod.REQ_DATES_PER_EMPLOYER,Constants.MAX_DATES_PER_EMPLOYER)),
					self.feins := choosen(fnFein(rows(left)),ut.min2(in_mod.REQ_FEINS_PER_EMPLOYER,Constants.MAX_FEINS_PER_EMPLOYER)),
					self.company_names := choosen(fnBizName(rows(left)),ut.min2(in_mod.REQ_COMPANY_NAMES_PER_EMPLOYER,Constants.MAX_COMPANY_NAMES_PER_EMPLOYER)),
					self.addrs := choosen(fnAddr.val(project(rows(left),transform(Layouts.raw,
						self.prim_range := left.company_prim_range,
						self.predir := left.company_predir,
						self.prim_name := left.company_prim_name,
						self.addr_suffix := left.company_addr_suffix,
						self.postdir := left.company_postdir,
						self.unit_desig := left.company_unit_desig,
						self.sec_range := left.company_sec_range,
						self.city := left.company_city,
						self.state := left.company_state,
						self.zip := left.company_zip,
						self.zip4 := left.company_zip4,
						self := left)),in_mod),ut.min2(in_mod.REQ_ADDRS_PER_EMPLOYER,Constants.MAX_ADDRS_PER_EMPLOYER)),
					self.positions := choosen(sort(fnPosition.val(rows(left),in_mod),-dates[1].dt_last_seen,-dates[1].dt_first_seen,record),ut.min2(in_mod.REQ_POSITIONS_PER_EMPLOYER,Constants.MAX_POSITIONS_PER_EMPLOYER))));
			return temp_rollup;
		end;
	end;
	export fnPerson := module
		export params := interface(fnEmployer.params)
			export unsigned2 REQ_SSNS_PER_PERSON;
			export unsigned2 REQ_NAMES_PER_PERSON;
			export unsigned2 REQ_EMPLOYERS_PER_PERSON;
		end;
		export val(dataset(Layouts.raw) in_recs,params in_mod) := function
			return rollup(group(sort(in_recs,did,if(did = 0,contact_id,0)),did,if(did = 0,contact_id,0)),group,transform(Layouts.rptPerson,
				self.did := left.did,
				self.isDeepDive := if(exists(rows(left)(not isDeepDive)),false,true),
				self.penalt := min(rows(left),penalt),
				self.ssns := choosen(fnSsn(rows(left), in_mod.ssn_mask),ut.min2(in_mod.REQ_SSNS_PER_PERSON,Constants.MAX_SSNS_PER_PERSON)),
				self.names := choosen(fnIndvName(rows(left)),ut.min2(in_mod.REQ_NAMES_PER_PERSON,Constants.MAX_NAMES_PER_PERSON)),
				self.employers := choosen(sort(fnEmployer.val(rows(left),in_mod),-dates[1].dt_last_seen,-dates[1].dt_first_seen,record),ut.min2(in_mod.REQ_EMPLOYERS_PER_PERSON,Constants.MAX_EMPLOYERS_PER_PERSON)),
        self.hasCriminalConviction := left.hasCriminalConviction,
        self.isSexualOffender := left.isSexualOffender));
		end;
	end;
	
	EXPORT BATCH_VIEW := MODULE
	   shared format_addr(paw_services.Layouts.batch_in L) := FUNCTION
				RETURN  TRIM(L.company_prim_range) +' ' +TRIM(L.company_predir) +' ' +TRIM(L.company_prim_name) 
		            +' ' +TRIM(L.company_addr_suffix) +' ' +TRIM(L.company_postdir)+' '+
								TRIM(L.company_unit_desig) +' ' +TRIM(L.company_sec_range);
		 END;
		 
		 shared check_ph_verified(paw_services.Layouts.batch_in L ) := FUNCTION
		   in_ds := DEDUP(SORT(L+L,company_phone),company_phone);
			 // ph_ds := DATASET([{1,L.phone,cname_ds}]
			                  // ,doxie.Layout_Append_Gong_Biz.Layout_In);
       doxie.Layout_Append_Gong_Biz.Layout_In xfm_gong_ph(paw_services.Layouts.batch_in in_paw) := TRANSFORM
					SELF.__seq :=1;
					SELF.phone := in_paw.company_phone;
					SELF.company_names := DATASET([{in_paw.company_name}],{string120 company_name});
			 END;
			 ph_ds := PROJECT(in_ds,xfm_gong_ph(LEFT));
			 out_ds := doxie.Append_Gong_Biz(ph_ds)[1];
			 RETURN IF(NOT TRIM(L.company_phone) in ['0',''] ,IF(out_ds.verified,'YES','NO'),'');
		 END;
		 
		 shared format_did(unsigned6 did ) := FUNCTION
			RETURN if(did<>0,(string12)did,'');
		 END;


		 shared format_bdid(unsigned6 bdid ) := FUNCTION
			RETURN if(bdid<>0,(string12)bdid,'');
		 END;

		 shared format_CPhone(String ph ) := FUNCTION
			RETURN if(ph<>'0',ph,'');
		 END;
		 
		 EXPORT paw_services.layouts.layout_for_PAW_penalties xfm_prepend_underscore(Autokey_Batch.Layouts.rec_inBatchMaster l) := 
			TRANSFORM

				SELF._acctno      := l.acctno;
												
				SELF._name_first  := l.name_first;
				SELF._name_middle := l.name_middle;
				SELF._name_last   := l.name_last;
				SELF._name_suffix := l.name_suffix;
				
				SELF._comp_name   := l.comp_name;
 
				SELF._prim_range  := l.prim_range;
				SELF._predir      := l.predir;
				SELF._prim_name   := l.prim_name;
				SELF._addr_suffix := l.addr_suffix;
				SELF._postdir     := l.postdir;
				SELF._unit_desig  := l.unit_desig;
				SELF._sec_range   := l.sec_range;
				SELF._p_city_name := l.p_city_name;
				SELF._st          := l.st;
				SELF._z5          := l.z5;
				SELF._zip4        := l.zip4;
												
				SELF._ssn         := l.ssn;
				SELF._fein        := l.fein;
				SELF._dob         := l.dob;
				SELF._homephone   := l.homephone;
				SELF._workphone   := l.workphone;
											
			END;
			
		EXPORT fn_apply_penalty(paw_services.Layouts.layout_for_PAW_penalties l, 
		                        paw_services.Layouts.batch_in r) :=
			FUNCTION			

				persons_to_compare_1 := 
					MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv.full, opt))

						// The 'input' name:
						EXPORT lastname       := l._name_last;   
						EXPORT middlename     := l._name_middle; 
						EXPORT firstname      := l._name_first;  
						EXPORT ssn            := l._ssn;
						EXPORT dob            := (INTEGER)l._dob;
						
						// The 'input' address:
						EXPORT predir         := l._predir;
						EXPORT prim_name      := l._prim_name;
						EXPORT prim_range     := l._prim_range;
						EXPORT postdir        := l._postdir;
						EXPORT addr_suffix    := l._addr_suffix;
						EXPORT sec_range      := l._sec_range;
						EXPORT p_city_name    := l._p_city_name;
						EXPORT st             := l._st;
						EXPORT z5             := l._z5;					
			
						// The name in the matching record:
						EXPORT lname_field    := r.lname; 
						EXPORT mname_field    := r.mname; 
						EXPORT fname_field    := r.fname; 
						EXPORT ssn_field      := r.ssn;
						EXPORT dob_field      := '';
						
						// The address in the matching record:						
						EXPORT allow_wildcard := FALSE;					
						EXPORT city_field     := r.city;
						EXPORT city2_field    := '';
						EXPORT pname_field    := r.prim_name;
						EXPORT postdir_field  := r.postdir;
						EXPORT prange_field   := r.prim_range;
						EXPORT predir_field   := r.predir;
						EXPORT sec_range_field:= r.sec_range;
						EXPORT state_field    := r.state;
						EXPORT zip_field      := r.zip;
						
						EXPORT county_field   := '';
						EXPORT DID_field      := '';
						EXPORT phone_field    := '';
						EXPORT suffix_field   := r.addr_suffix;
						
						EXPORT useGlobalScope := FALSE;
					END;
					
				persons_to_compare_2 := // ...compare input address against matching record's business address.
					MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv.full, opt))

						// The 'input' name:
						EXPORT lastname       := l._name_last;   
						EXPORT middlename     := l._name_middle; 
						EXPORT firstname      := l._name_first;  
						EXPORT ssn            := l._ssn;
						EXPORT dob            := (INTEGER)l._dob;
						
						// The 'input' address:
						EXPORT predir         := l._predir;
						EXPORT prim_name      := l._prim_name;
						EXPORT prim_range     := l._prim_range;
						EXPORT postdir        := l._postdir;
						EXPORT addr_suffix    := l._addr_suffix;
						EXPORT sec_range      := l._sec_range;
						EXPORT p_city_name    := l._p_city_name;
						EXPORT st             := l._st;
						EXPORT z5             := l._z5;					
			
						// The name in the matching record:
						EXPORT lname_field    := r.lname; 
						EXPORT mname_field    := r.mname; 
						EXPORT fname_field    := r.fname; 
						EXPORT ssn_field      := r.ssn;
						EXPORT dob_field      := '';
						
						// The address in the matching record:						
						EXPORT allow_wildcard  := FALSE;					
						EXPORT pname_field     := r.company_prim_name;
						EXPORT postdir_field   := r.company_postdir;
						EXPORT prange_field    := r.company_prim_range;
						EXPORT predir_field    := r.company_predir;
						EXPORT suffix_field    := r.company_addr_suffix;
						EXPORT sec_range_field := r.company_sec_range;
						EXPORT city_field      := r.company_city;
						EXPORT state_field     := r.company_state;
						EXPORT zip_field       := r.company_zip;
						EXPORT city2_field     := '';
						EXPORT county_field    := '';
						EXPORT DID_field       := '';
						EXPORT phone_field     := '';
						
						EXPORT useGlobalScope  := FALSE;
					END;					

				businesses_to_compare := 
					MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Biz.full, opt))

						// The 'input' name:
						EXPORT lastname       := l._name_last;   
						EXPORT middlename     := l._name_middle; 
						EXPORT firstname      := l._name_first;  
						EXPORT ssn            := l._ssn;
						EXPORT dob            := (INTEGER)l._dob;
						
						// The 'input' address:
						EXPORT predir         := l._predir;
						EXPORT prim_name      := l._prim_name;
						EXPORT prim_range     := l._prim_range;
						EXPORT postdir        := l._postdir;
						EXPORT addr_suffix    := l._addr_suffix;
						EXPORT sec_range      := l._sec_range;
						EXPORT p_city_name    := l._p_city_name;
						EXPORT st             := l._st;
						EXPORT z5             := l._z5;									
			
						// The name in the matching record:
						EXPORT cname_field    := r.company_name;
						EXPORT bdid_field     := (STRING)r.bdid;
						
						// The address in the matching record:						
						EXPORT allow_wildcard  := FALSE;
						EXPORT fein_field      := r.company_fein;
						EXPORT phone_field     := r.company_phone;
						EXPORT pname_field     := r.company_prim_name;
						EXPORT postdir_field   := r.company_postdir;
						EXPORT prange_field    := r.company_prim_range;
						EXPORT predir_field    := r.company_predir;
						EXPORT suffix_field    := r.company_addr_suffix;
						EXPORT sec_range_field := r.company_sec_range;
						EXPORT city_field      := r.company_city;
						EXPORT state_field     := r.company_state;
						EXPORT zip_field       := r.company_zip;
						EXPORT city2_field     := '';
						EXPORT county_field    := '';
						
						EXPORT useGlobalScope := FALSE;
					END;
					
				person_penalty_1 := AutoStandardI.LIBCALL_PenaltyI_Indv.val(persons_to_compare_1);
				person_penalty_2 := AutoStandardI.LIBCALL_PenaltyI_Indv.val(persons_to_compare_2);
				business_penalty := AutoStandardI.LIBCALL_PenaltyI_Biz.val(businesses_to_compare);

				total_penalty    := MAP( TRIM(l._comp_name) != '' AND TRIM(l._name_last) != '' => MIN(person_penalty_1, person_penalty_2) + business_penalty,
				                         TRIM(l._comp_name) != ''                              => business_penalty,
																 /* ELSE .......................................... */    MIN(person_penalty_1, person_penalty_2) );

				RETURN total_penalty + 1; 
				// We don't want to return '0' because we filter out records having '0' later. See
				// paw_services.Functions.fn_get_min_penalty().
				
			END;	
			
		 shared fn_get_min_penalty(UNSIGNED2 p1 = 0, UNSIGNED2 p2 = 0, UNSIGNED2 p3 = 0, UNSIGNED2 p4 = 0, UNSIGNED2 p5 = 0) := 
			 FUNCTION
			   penalties := DATASET([{p1},{p2},{p3},{p4},{p5}], {UNSIGNED2 penalt});
				 RETURN MIN( penalties(penalt > 0), penalt );
			 END;
			 
	   export paw_services.Layouts.batch_out format_batch_out (paw_services.Layouts.batch_in B
		                               ,DATASET(paw_services.Layouts.batch_in) P) := TRANSFORM
																	 
		     SELF.penalt                  := fn_get_min_penalty( P[1].penalt, P[2].penalt, P[3].penalt, P[4].penalt, P[5].penalt);
				 
		     SELF.pawk_1_did              := format_did(P[1].did) ;																	 
		     SELF.pawk_1_bdid             := format_bdid(P[1].bdid) ;																	 
		     SELF.pawk_1_first            := P[1].fname ;
				 SELF.pawk_1_middle           := P[1].mname  ;
				 SELF.pawk_1_last             := P[1].lname;
				 SELF.pawk_1_suffix           := P[1].name_suffix ;
				 SELF.pawk_1_ssn              := P[1].ssn;
				 SELF.pawk_1_title            := P[1].company_title ;
				 SELF.pawk_1_company_name     := P[1].company_name  ;
				 SELF.pawk_1_department       := P[1].company_department;
				 SELF.pawk_1_fein             := P[1].company_fein;
				 SELF.pawk_1_address          := format_addr(P[1])  ;
				 SELF.pawk_1_city             := P[1].company_city;
				 SELF.pawk_1_state            := P[1].company_state ;
				 SELF.pawk_1_zip5             := P[1].company_zip;
				 SELF.pawk_1_zip4             := P[1].company_zip4;
				 SELF.pawk_1_phone10          := format_CPhone(P[1].company_phone) ;
				 SELF.pawk_1_verified         := check_ph_verified(p[1]);
				 SELF.pawk_1_email            := P[1].email_address;
				 SELF.pawk_1_first_seen       := P[1].dt_first_seen ;
				 SELF.pawk_1_last_seen        := P[1].dt_last_seen;
				 SELF.pawk_1_confidence_level := P[1].score ;
				 
         SELF.pawk_2_did              := format_did(P[2].did) ;
         SELF.pawk_2_bdid             := format_bdid(P[2].bdid) ;
				 SELF.pawk_2_first            := P[2].fname ;
				 SELF.pawk_2_middle           := P[2].mname  ;
				 SELF.pawk_2_last             := P[2].lname;
				 SELF.pawk_2_suffix           := P[2].name_suffix ;
				 SELF.pawk_2_ssn              := P[2].ssn;
				 SELF.pawk_2_title            := P[2].company_title ;
				 SELF.pawk_2_company_name     := P[2].company_name  ;
				 SELF.pawk_2_department       := P[2].company_department;
				 SELF.pawk_2_fein             := P[2].company_fein;
				 SELF.pawk_2_address          := format_addr(P[2])  ;
				 SELF.pawk_2_city             := P[2].company_city;
				 SELF.pawk_2_state            := P[2].company_state ;
				 SELF.pawk_2_zip5             := P[2].company_zip;
				 SELF.pawk_2_zip4             := P[2].company_zip4;
				 SELF.pawk_2_phone10          := format_CPhone(P[2].company_phone) ;
				 SELF.pawk_2_verified         := check_ph_verified(p[2]);
				 SELF.pawk_2_email            := P[2].email_address;
				 SELF.pawk_2_first_seen       := P[2].dt_first_seen ;
				 SELF.pawk_2_last_seen        := P[2].dt_last_seen;
				 SELF.pawk_2_confidence_level := P[2].score ;
				 
				 SELF.pawk_3_did              := format_did(P[3].did) ;
				 SELF.pawk_3_bdid             := format_bdid(P[3].bdid) ;
				 SELF.pawk_3_first            := P[3].fname ;
				 SELF.pawk_3_middle           := P[3].mname  ;
				 SELF.pawk_3_last             := P[3].lname;
				 SELF.pawk_3_suffix           := P[3].name_suffix ;
				 SELF.pawk_3_ssn              := P[3].ssn;
				 SELF.pawk_3_title            := P[3].company_title ;
				 SELF.pawk_3_company_name     := P[3].company_name  ;
				 SELF.pawk_3_department       := P[3].company_department;
				 SELF.pawk_3_fein             := P[3].company_fein;
				 SELF.pawk_3_address          := format_addr(P[3])  ;
				 SELF.pawk_3_city             := P[3].company_city;
				 SELF.pawk_3_state            := P[3].company_state ;
				 SELF.pawk_3_zip5             := P[3].company_zip;
				 SELF.pawk_3_zip4             := P[3].company_zip4;
				 SELF.pawk_3_phone10          := format_CPhone(P[3].company_phone) ;
				 SELF.pawk_3_verified         := check_ph_verified(p[3]);
				 SELF.pawk_3_email            := P[3].email_address;
				 SELF.pawk_3_first_seen       := P[3].dt_first_seen ;
				 SELF.pawk_3_last_seen        := P[3].dt_last_seen;
				 SELF.pawk_3_confidence_level := P[3].score ;
				 
				 SELF.pawk_4_did              := format_did(P[4].did) ;
				 SELF.pawk_4_bdid             := format_bdid(P[4].bdid) ;
				 SELF.pawk_4_first            := P[4].fname ;
				 SELF.pawk_4_middle           := P[4].mname  ;
				 SELF.pawk_4_last             := P[4].lname;
				 SELF.pawk_4_suffix           := P[4].name_suffix ;
				 SELF.pawk_4_ssn              := P[4].ssn;
				 SELF.pawk_4_title            := P[4].company_title ;
				 SELF.pawk_4_company_name     := P[4].company_name  ;
				 SELF.pawk_4_department       := P[4].company_department;
				 SELF.pawk_4_fein             := P[4].company_fein;
				 SELF.pawk_4_address          := format_addr(P[4])  ;
				 SELF.pawk_4_city             := P[4].company_city;
				 SELF.pawk_4_state            := P[4].company_state ;
				 SELF.pawk_4_zip5             := P[4].company_zip;
				 SELF.pawk_4_zip4             := P[4].company_zip4;
				 SELF.pawk_4_phone10          := format_CPhone(P[4].company_phone) ;
				 SELF.pawk_4_verified         := check_ph_verified(p[4]);
				 SELF.pawk_4_email            := P[4].email_address;
				 SELF.pawk_4_first_seen       := P[4].dt_first_seen ;
				 SELF.pawk_4_last_seen        := P[4].dt_last_seen;
				 SELF.pawk_4_confidence_level := P[4].score ;
         
				 SELF.pawk_5_did              := format_did(P[5].did) ;
				 SELF.pawk_5_bdid             := format_bdid(P[5].bdid) ;
				 SELF.pawk_5_first            := P[5].fname ;
				 SELF.pawk_5_middle           := P[5].mname  ;
				 SELF.pawk_5_last             := P[5].lname;
				 SELF.pawk_5_suffix           := P[5].name_suffix ;
				 SELF.pawk_5_ssn              := P[5].ssn;
				 SELF.pawk_5_title            := P[5].company_title ;
				 SELF.pawk_5_company_name     := P[5].company_name  ;
				 SELF.pawk_5_department       := P[5].company_department;
				 SELF.pawk_5_fein             := P[5].company_fein;
				 SELF.pawk_5_address          := format_addr(P[5])  ;
				 SELF.pawk_5_city             := P[5].company_city;
				 SELF.pawk_5_state            := P[5].company_state ;
				 SELF.pawk_5_zip5             := P[5].company_zip;
				 SELF.pawk_5_zip4             := P[5].company_zip4;				 
				 SELF.pawk_5_phone10          := format_CPhone(P[5].company_phone) ;
				 SELF.pawk_5_verified         := check_ph_verified(p[5]);
				 SELF.pawk_5_email            := P[5].email_address;
				 SELF.pawk_5_first_seen       := P[5].dt_first_seen ;
				 SELF.pawk_5_last_seen        := P[5].dt_last_seen;
				 SELF.pawk_5_confidence_level := P[5].score ;
				 
				 SELF := B;
				 SELF := [];
		 ENd;
	END;
	
end;
