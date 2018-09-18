import doxie_crs, ut, header, doxie,doxie_raw,lib_date,codes,PhonesFeedback_Services,PhonesFeedback,Address;

EXPORT Person_records_functions := Module

	shared header_records(boolean include_dailies = false, boolean allow_wildcard = false, set of STRING1 daily_autokey_skipset=[],
												boolean noFail = false, boolean isrollup = false,	dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) :=	FUNCTION
		d := PROJECT (doxie.get_dids(,noFail), doxie.layout_references);
		l := doxie.header_records_byDID(project (if(count(dids(did>0))>0, dids,d), doxie.layout_references_hh), include_dailies, allow_wildcard, daily_autokey_skipset,,,,,,,,isrollup);
		RETURN l;
	END;	
	shared historic_nbr_records_crs(boolean checkRNA=true,dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) := FUNCTION
		doxie.MAC_Selection_Declare();
		doxie.MAC_Header_Field_Declare();
    mod_access := doxie.functions.GetGlobalDataAccessModule();
		doxie.historic_nbr_records(header_records(,,,,,dids),a,checkRNA, mod_access);
		ut.PermissionTools.GLB.mac_FilterOutMinors(a,afil,,,dob)
		RETURN afil;
	END;
	export Comp_Subject_Addresses_wrap(dataset (doxie.layout_references) dids=dataset([],doxie.layout_references)) := function
		doxie.MAC_Selection_Declare();
		doxie.MAC_Header_Field_Declare();
    mod_access := doxie.functions.GetGlobalDataAccessModule ();
		// csa := Doxie.Comp_Subject_Addresses(dids,dateVal,dppa_purpose,glb_purpose,ln_branded_value,,probation_override_value,industry_class_value,
		// 																					 no_scrub,dial_contactprecision_value, Addresses_PerSubject);
		csa := Doxie.Comp_Subject_Addresses(dids,,dial_contactprecision_value, Addresses_PerSubject, mod_access);
		return csa;
	END;
	EXPORT nbr_records(dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) := function
		// snag header records
		doxie.MAC_Selection_Declare();
		doxie.MAC_Header_Field_Declare();
		headerRecs := Comp_Subject_Addresses_wrap(dids).addresses;

		// convert to target record type
		rawTargetRecs := project(headerRecs, doxie.layout_nbr_targets);
		// OUTPUT(rawTargetRecs, named('rawTargetRecs')); // DEBUG

		// quick reduction if we really don't want to be here
		filtHR := rawTargetRecs(Neighbors_PerAddress>0);

		// reduce header recs down to targets
		targetRecs := doxie.nbr_records_targets(filtHR, Max_Neighborhoods);
		// OUTPUT(targetRecs, named('targetRecs')); // DEBUG

		// then find the corresponding neighbor records
		nbr_records_mode(string1 mode) := doxie.nbr_records(targetRecs,mode,	
			// attrs declared in doxie.MAC_Selection_Declare
			Max_Neighborhoods,
			Neighbors_PerAddress,
			Neighbors_Per_NA,
			Neighbor_Recency,
			industry_class_value,
			GLB_Purpose,
			DPPA_Purpose,
			probation_override_value,
			no_scrub,
			glb_ok,
			dppa_ok,
			// attrs declared in doxie.MAC_Header_Field_Declare
			ssn_mask_value,,,
			neighbors_proximity // generally, the radius of neighbors' units: houses, or appartments or etc.
		);

		// generate current/historic neighbors as specified
		noResults := DATASET([], doxie.layout_nbr_records);
		nbr_records_curr := IF(
			Include_Neighbors_val, // doxie.MAC_Selection_Declare
			nbr_records_mode('C'),
			noResults
		);
		nbr_records_hist := IF(
			Include_HistoricalNeighbors_val, // doxie.MAC_Selection_Declare
			nbr_records_mode('H'),
			noResults
		);

		both := nbr_records_curr + nbr_records_hist;
		ut.PermissionTools.GLB.mac_FilterOutMinors(both,bothfil,,,dob)

		return bothfil;
	end;
	export Relative_Records(boolean checkRNA=true,dataset (doxie.layout_references) inputdids=dataset([],doxie.layout_references)) := FUNCTION
		doxie.MAC_Selection_Declare();
		doxie.MAC_Header_Field_Declare();
		dids_pick :=inputdids(Include_relatives_val or include_associates_val);
		Suppress.MAC_Suppress(dids_pick,dids,application_type_value,suppress.constants.LinkTypes.DID,did);

		results_max := doxie_Raw.relative_raw
			(dids,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,ln_branded_value,probation_override_value,
			 include_relatives_val,include_associates_val,Relative_Depth,max_relatives,isCRS,max_associates);

		ut.PermissionTools.GLB.mac_FilterOutMinors(results_max,results_max_fil,person2)

		doxie_raw.mac_JoinHeader_Raw(results_max_fil, recs, person2, false,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,ln_branded_value,probation_override_value)

		rr := sort(recs,p2_sort,p3_sort,p4_sort,-number_cohabits, - recent_cohabit, -isRelative, person1, person2, rid);
		header.MAC_GLB_DPPA_Clean_RNA(rr,rr_rna)
		ret_results := if (checkRNA, rr_rna, rr);
		return ret_results;
	END;	
	EXPORT Comp_Addresses(dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) := function
		doxie.MAC_Selection_Declare();
		doxie.MAC_Header_Field_Declare();
		Address_Format := doxie.Layout_Comp_Addresses;
		isKnowx := ut.IndustryClass.is_knowx;
		Nbrs := historic_nbr_records_crs(,dids);

		Address_Format fn(NBrs  le) := transform
			self.dt_first_seen := le.dt_first_seen;
			self.dt_last_seen := MAP( ~glb_ok=>le.dt_nonglb_last_seen,
																le.dt_last_seen<>0 => le.dt_last_seen, 0);
			self.hri_address := [];
			// self.Feedback := [];
			self.shared_address := '';  // neighbors never share an addr with the subject, by definition
			self := le;
			end;

		Ns1 := project(Nbrs,fn(left));

		// new neighbors routine
		Nbrs2 := nbr_records(dids);
		Address_Format fn_nbr(NBrs2 le) := transform
			self.hri_address := [];
			self.shared_address := '';  // neighbors never share an addr with the subject, by definition
			self.dt_vendor_first_reported := 0;
			self.dt_vendor_last_reported := 0;
			self := le;
			end;
		Ns2 := project(Nbrs2,fn_nbr(left));

		Relative_addresses := 
			relative_records(header.constants.checkRNA,dids)((Include_RelativeAddresses_val and isRelative) or 
											 (Include_Associates_val and ~isRelative));
											 
		Address_Format fr(Relative_Addresses  le) := transform
			self.dt_first_seen := le.dt_first_seen;
			// knowx key has non glb data so it does not need to get dt_nonglb_last_seen.
			self.dt_last_seen := MAP( ~glb_ok and ~isKnowx =>le.dt_nonglb_last_seen,
																le.dt_last_seen<>0 => le.dt_last_seen, 0);
			self.hri_address := [];
			self := le;
			end;
			
		Rels := project(Relative_Addresses,fr(left));  

		Main_tmp_a := Comp_Subject_Addresses_wrap(dids).addresses;

		Main_tmp_a add_sub_Ind (Main_tmp_a le):=transform
		self.isSubject:=true;
		self:=le;
		end;
		Main_tmp :=project(Main_tmp_a,add_sub_Ind(LEFT));
		// Main is for the subj add here

		PhonesFeedback_Services.Mac_Append_Feedback(Main_tmp
																								,did
																								,Phone
																								,Main_all);


		Main_all select_fb_subj (Main_all le):=transform
			self.feedback:=if(le.issubject=true,le.feedback,DATASET ([], PhonesFeedback_Services.Layouts.feedback_report));
			self:=le;
		end;
		Main_fb:=project(Main_all,select_fb_subj(LEFT));
		Main:=if(IncludePhonesFeedback,Main_fb,Main_tmp);

		Address_Format add_s(Address_Format le, Main ri) := transform
			self.shared_address := IF(ri.did<>0,'S','');
			self := le;
			end;

		Rels1 := join(Rels,Main, left.prim_name=right.prim_name and
							left.prim_range = right.prim_range and
							ut.nneq(left.sec_range, Right.sec_range) and
							left.zip = right.zip,
							add_s(left,right),left outer);  

		doxie.MAC_Address_Rollup(Rels1,Max_RelativeAddresses,Rels_Dn, isKnowx)
		doxie.MAC_Address_Rollup(NS1,Addresses_PerNeighbor,NS_Dn)
		doxie.MAC_Address_Rollup(NS2,Addresses_PerNeighbor,NS2_Dn)

		NS_All := NS_Dn+NS2_Dn;
		// if consumer copy seen dates to vendor dates so later on the switch dates
		// for consmer will get the right dates.
		NS_All_Dn := if(isKnowx, project(NS_All, transform(recordof(NS_Dn),
				self.dt_vendor_last_reported := left.dt_last_seen,
				self.dt_vendor_first_reported := left.dt_first_seen,
				self := left)), NS_All);
		//output(Rels1, named('relatives'));
		//output(NS_All, named('neighbors'));
		//output(NS_All_Dn, named('NS_All_Dn'));
		Dn := Main+Rels_Dn+NS_All_Dn;
		//output(dn, named('dn'));
		doxie.MAC_Address_Rollup(Dn,1000,res, isKnowx)
		//output(res, named('res'));
		doxie.mac_AddHRIAddress(res, res_wrisk)

		res4out := if(include_hri_val, res_wrisk, res);

		//need sequence numbers on all addresses now for residents
		needseq := res4out(address_seq_no < 0);
		hadseq := res4out(address_seq_no >= 0);

		Address_Format tra(Address_Format lef,Address_Format ref) := transform
			self.address_seq_no := if(lef.address_seq_no <=0,1,lef.address_seq_no +1);
			self := ref;
			end;

		// Switches all the infutor dates that comes from data in the vendor dates.
		Address_Format traConsumer(Address_Format lef,Address_Format ref) := transform
			self.address_seq_no := if(lef.address_seq_no <=0,1,lef.address_seq_no +1);  
			self.dt_last_seen := if(ref.isSubject, ref.dt_last_seen, ref.dt_vendor_last_reported);
			self.dt_first_seen := if(ref.isSubject, ref.dt_first_seen, ref.dt_vendor_first_reported);
			self.dt_vendor_first_reported := if(ref.isSubject, ref.dt_vendor_first_reported, ref.dt_first_seen);
			self.dt_vendor_last_reported := if(ref.isSubject, ref.dt_vendor_last_reported , ref.dt_last_seen);
			self := ref;		
			end;
			
		//****** Push infile through transform above, note that only non-subject 
		//addresses will go through the transform because subject addresses 
		// already have a sequence.
		wseq := iterate(sort(hadseq, address_seq_no) & needseq, tra(left,right));
		wseq_C := iterate(sort(hadseq, address_seq_no) & needseq, traConsumer(left, right));

		//ut.MAC_Sequence_Records_Seeded(needseq, address_seq_no, max(hadseq,address_seq_no), gotseq)

		results := choosen(IF (isKnowx, wseq_C, wseq), Max_Addresses);
		return results (prim_name[1..4]<>'DOD ', prim_name<>'' OR prim_range<>'' OR sec_range<>'');
	end;
	EXPORT relative_summary(dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) := function
		r := relative_records(header.constants.checkRNA,dids);

		unsigned1 t_age := if(r.dob=0,0,ut.Age(r.dob));
		re := record
			unsigned1 depth := min(group,r.depth);
			r.p2_sort;
			r.p3_sort;
			r.p4_sort;
			r.person2;
			unsigned1 age := max(group,t_age);
			r.fname;
			r.mname;
			r.lname;
			unsigned2 cnt := count(group);
			boolean relative := max(group,r.isRelative);
			boolean aka := false;
			typeof(r.recent_cohabit)  recent_cohabit  := max(group, r.recent_cohabit);
			typeof(r.number_cohabits) number_cohabits := max(group, r.number_cohabits);
			end;
			
		re add_cnt(re le,re ri) := transform
			self.cnt := le.cnt+ri.cnt;
			self := le;
			end;  
			
		t := group(table(r,re,p2_sort,p3_sort,p4_sort,person2,fname,mname,lname),p2_sort,p3_sort,person2);

		st1 := sort(t,fname,lname,-mname);

		r_snames := rollup(st1,left.fname=right.fname and left.lname=right.lname and
												 left.mname[1..length(trim(right.mname))]=right.mname,add_cnt(left,right));
							 
		st2 := rollup(sort(r_snames,lname,mname,-fname),left.lname=right.lname and left.mname=right.mname and 
													left.fname[1..length(trim(right.fname))]=right.fname,add_cnt(left,right));

		st := sort(st2,-cnt,-age,-lname,-fname);					 

		re add_aka(st le, st ri) := transform
			self.aka := le.person2 = ri.person2;
			self := ri;
			end;

		iter := iterate(st,add_aka(left,right));
		outrec := doxie_crs.layout_relative_summary;
		ut.MAC_Slim_Back(iter, outrec, outfile)

		return outfile;
	end;
	EXPORT associate_summary(dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) := function
		rels := sort(group(relative_summary(dids)(~relative)), person2, if(aka, 0, 1), -cnt);
		return dedup(rels, person2);
	end;
	EXPORT Resident_Records(dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) := function
		doxie.MAC_Selection_Declare();
		doxie.MAC_Header_Field_Declare();

		//use all comp address, but if Exclude_ResidentsForAssociatesAddresses_val then exclude those by DID
		all_addrs:= Comp_Addresses(dids)((not Exclude_ResidentsForAssociatesAddresses_val) or (did not in set(associate_summary(dids), person2)));
		//don't use residents of address older than 12 months
		sys_dt := (string)StringLib.GetDateYYYYMMDD();
		ca_entrp :=  all_addrs(LIB_Date.DaysApart((string8)dt_last_seen ,sys_dt)<= 365);
		ca:= if(ut.IndustryClass.is_entrp,ca_entrp,all_addrs);

		//
		doxie.Layout_AddressSearch_plus makelas(ca l) := transform
			self.seq := l.address_Seq_no;
			self.state := l.st;
			self := l;
		end;

		ca_slim := project(ca, makelas(left));
		r := doxie_raw.residents_raw
			(ca_slim,
			dateVal,
			dppa_purpose,
			glb_purpose,
			ssn_mask_value,
			ln_branded_value,
			probation_override_value);
			
		ut.PermissionTools.GLB.mac_FilterOutMinors(r,rfil,,,dob)

		return rfil;
	end;
	EXPORT Comp_names(dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) := function
		rt := record
			doxie_crs.layout_comp_names;
			unsigned1 var_cnt := 1; // the idea here is to use this counter to move records with multiple name variations to the top
		end;

		//relatives
		rr := Relative_Records(header.constants.checkRNA,dids);
			
		rt fr(rr le) := transform
			self := le;
			end;  
			
		rels := project(rr,fr(left));

		//nbrs
		hnrs := historic_nbr_records_crs(header.constants.checkRNA,dids);

		rt fn(hnrs le) := transform
			self := le;
			end;  
			
		nb := project(hnrs,fn(left));

		//new version of nbrs
		nbrs := nbr_records(dids);

		rt fn_nbr(nbrs le) := transform
			self := le;
			end;  
			
		nb2 := project(nbrs,fn_nbr(left));

		//residents
		resrecs := Resident_Records(dids);

		rt fn2(resrecs le) := transform
			self := le;
			end;  
			
		resrecs2 := project(resrecs,fn2(left));

		allrecs := nb+nb2+rels+resrecs2;

		doxie.MAC_PruneOldSSNs(allrecs, recs, ssn, did);
			
		ta := sort(recs,did,fname,lname,mname,ssn,dob);

		rt roll_into(rt le,rt ri) := transform
			self.dob := if ( ut.date_quality(le.dob)>ut.date_quality(ri.dob),le.dob,ri.dob );
			self.ssn := if ( length(trim(le.ssn)) > length(trim(ri.ssn)), le.ssn, ri.ssn );
			self.ssn_unmasked := if ( length(trim(le.ssn_unmasked)) > length(trim(ri.ssn_unmasked)), le.ssn_unmasked, ri.ssn_unmasked );
			self.mname := if ( length(trim(le.mname)) > length(trim(ri.mname)), le.mname, ri.mname );
			self.var_cnt := le.var_cnt + ri.var_cnt;
			self := le;
			end;
			
		r := rollup( ta, left.did=right.did and left.fname=right.fname and ut.lead_contains(left.mname,right.mname) and
										 left.lname=right.lname and ut.NNEQ(left.ssn,right.ssn) and 
						ut.NNEQ_Date(left.dob,right.dob),roll_into(left,right) ); 

		//add the age
		doxie_crs.layout_comp_names addage(rt l) := transform
			self.age := if ( l.dob = 0, 0, ut.Age(l.dob) );
			self := l;
		end;

		// need to sort it again, now with var_cnt populated
		wage := project(sort(r, did,-var_cnt,fname,lname,mname,ssn,dob), addage(left));

		return wage;
	end;

	export ssn_persons ( boolean checkRNA = false,dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references) ) := function
		doxie.MAC_Header_Field_Declare();
    mod_access := doxie.functions.GetGlobalDataAccessModule ();

		keepOldSsns := doxie.keep_old_ssns_val;

		dids_ssns := record
			string9 ssn;
			unsigned6 did;
			end;
				
		csa := Comp_Subject_Addresses_wrap(dids).raw;
		recs := dedup (sort(csa, did,ssn), did, ssn);


		trecs := recs((integer)ssn>1000000 and (integer)ssn not in ut.Set_IntBadSSN);
		// eliminate old SSN before looking for imposters if prune_old_ssns
		trecs_pruned := join(trecs, doxie.Key_DID_SSN_Date (), left.did = right.did and
													left.ssn = right.ssn, TRANSFORM(LEFT),
													LEFT ONLY);
												
		keep_trecs := IF(keepOldSsns, trecs, trecs_pruned);
		use_trecs := project(keep_trecs, dids_ssns);
												
		dids_ssns get_dds(use_trecs le, Doxie.Key_Header_SSN ri) := transform
			self.ssn := le.ssn;
			self := ri;
			end;

		others_pre := join(use_trecs,Doxie.Key_Header_SSN,left.ssn[1]=right.s1 and
											 left.ssn[2]=right.s2 and
											 left.ssn[3]=right.s3 and
											 left.ssn[4]=right.s4 and
											 left.ssn[5]=right.s5 and
											 left.ssn[6]=right.s6 and
											 left.ssn[7]=right.s7 and
											 left.ssn[8]=right.s8 and
											 left.ssn[9]=right.s9,get_dds(left,right), atmost (5000), keep(ut.limits.DID_PER_SSN + 1));

		others := choosen (others_pre, ut.limits.DID_PER_SSN);

		// prune others that are old
		others_pruned := join(others, doxie.Key_DID_SSN_Date (), left.did = right.did and
													left.ssn = right.ssn, TRANSFORM(LEFT),
													LEFT ONLY);

		use_others := IF(keepOldSsns, others, others_pruned);
													
		the_set := dedup(use_others,did,ssn,all);

		ssn_people := record
			string20 fname;
			string30 mname;
			string20 lname;
			qstring5  title;
			string5  name_suffix;
			string9  ssn;
			unsigned6 did;
			integer4  date_ob;
			unsigned4 dt_first_seen;
			unsigned4 dt_last_seen;
			boolean dead;
			end;
			
		ssn_people_plus := record //some extra fields to allow us to use mac_glbclean
			ssn_people;
			string1 	 pflag1;		//for original pflag purposes
			string1		 pflag2;		//for phone number related work
			string1		 pflag3;		//for marking records that will have to be split into multiples for despray
			string2      src;
			unsigned3    dt_vendor_last_reported;
			unsigned3    dt_vendor_first_reported;
			unsigned3    dt_nonglb_last_seen;
			string1      rec_type;
			qstring18    vendor_id;
			qstring10    phone;
			integer4     dob;
			qstring10    prim_range;
			string2      predir;
			qstring28    prim_name;
			qstring4     suffix;
			string2      postdir;
			qstring10    unit_desig;
			qstring8     sec_range;
			qstring25    city_name;
			string2      st;
			qstring5     zip;
			qstring4     zip4;
			string3      county;
			qstring7	   geo_blk;
			qstring5     cbsa;
			string1      tnt;
			string1	   valid_SSN;
			string1	   jflag1;  
			string1      jflag2;
		string1	   jflag3;
			unsigned6 rid;
		end;

		ssn_people_plus get_people(doxie.Key_Header le) := transform
			self.dead := le.tnt='D';
			self.name_suffix := IF(ut.is_unk(le.name_suffix),'',le.name_suffix);
			self.date_ob := le.dob;
			self.dt_first_seen := MAP(le.dt_first_seen<>0 => le.dt_first_seen,le.dt_last_seen<>0 => le.dt_last_seen, 99999999);
			self.dt_last_seen := MAP(le.dt_last_seen<>0 => le.dt_last_seen,le.dt_first_seen);
			self := le;
			end;
			
		jdirty := join(the_set,doxie.Key_Header,
									 keyed(left.did=right.s_did) and 
									 (left.ssn = right.ssn or keepOldSsns),
									 get_people(right), LIMIT (ut.limits.DID_PER_PERSON, SKIP));

		// if any DID/ssn pairs existed in keep_trecs but were not found in Key_Header_SSN (i.e., from the dailies)
		// they need to be preserved
		daily_ssns := join(keep_trecs, jdirty, left.did=right.did and left.ssn = right.ssn,
											 transform(ssn_people_plus, 
																 self.date_ob := left.dob, 
																 self.dead := left.tnt = 'D',
																 self := left), 
											 left only);
		combined := jdirty+daily_ssns;
		header.MAC_GlbClean_Header(combined,j_preRNA, , , mod_access);
		Header.MAC_GLB_DPPA_Clean_RNA(j_preRNA, j_postRNA)
		j:= if(checkRNA,j_postRNA,j_preRNA);

		//back to original format
		ut.MAC_Slim_Back(j,ssn_people,jslim)

		// if (count (others_pre) > ut.limits.DID_PER_SSN, ut.outputMessage (ut.constants_MessageCodes.IMPOSTERS_EXCEED_LIMIT));
		return jslim;
	END;
	EXPORT comp_ssns(dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) := function
		rel := comp_names(dids);

		r := record
			string9 ssn9 := rel.ssn;
			unsigned6 did := rel.did;
			rel.ssn_unmasked;
			end;
			
		t := table(rel(ssn[1..5]<>''),r);

		per := ssn_persons(,dids);

		r1 := record
			string9 ssn9;
			unsigned6 did;
			typeof(rel.ssn_unmasked) ssn_unmasked;
			end;
			
		r1 maker1(per l) := transform
			self.ssn9 := l.ssn;
			self.did := l.did;
			self.ssn_unmasked := l.ssn;
		end;

		t1 := project(per(ssn[1..5]<>''),maker1(left));
											
		return t+t1;
	end;

	export fn_SSN_Records(dataset(doxie.layout_best) best_info_mult,boolean checkRNA = false,dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) :=	FUNCTION

		doxie.MAC_Header_Field_Declare();
		doxie.MAC_Selection_Declare();
		them_all := ssn_persons(checkRNA,dids);
		big_num := 999999999;
		p_sum := record
			string1 Input := IF(them_all.did=(integer)did_value or them_all.ssn=ssn_value,'*','');
			them_all.ssn;
			cnt := count(group);
			them_all.fname;
			them_all.mname;
			them_all.lname;
			them_all.name_suffix;
			unsigned4 first_seen := MIN(group,them_all.dt_first_seen);
			unsigned4 last_seen := MAX(group,them_all.dt_last_seen);
			string4 dead := MAX(group,IF(them_all.dead,'DEAD',''));
			integer4 youngest_age := min(group,if(them_all.date_ob=0,big_num,ut.mob(them_all.date_ob)));
			integer4 oldest_age := max(group,ut.mob(them_all.date_ob));
			them_all.did;
			string30 comment := '';
			boolean likely_fragment := false;
			unsigned4 dob := max(group, them_all.date_ob);
			unsigned1 age := ut.Age(max(group, them_all.date_ob));
			boolean legacy_ssn := false; //for potentially randomized SSNs defines if SSN-DID pair was seen before
			end;

		best_info := best_info_mult[1];

		best_info_ssn := best_info.ssn;
		best_info_did := best_info.did;

		add_aggr := table(them_all (ssn<>''),p_sum,fname,mname,lname,name_suffix,ssn,did);
		p_sum_t := group(sort(add_aggr,did,-cnt,-length(trim(fname))),did)
							 ((Include_AKAs_val or did <> best_info_did) and
								(Include_Imposters_val or not(ssn = best_info_ssn and did <> best_info_did))); 
								
		Best_SSN := 'Possible fragment';
		p_sum add_prefer(p_sum_t le, p_sum_t ri) := transform
			self.comment := IF(le.did=0,Best_SSN,'');
			self := ri;
			end;

		with_pre := iterate(p_sum_t,add_prefer(left,right));

		swp := sort(with_pre,ssn,-cnt,-comment);
		AKA := 'AKA';
		p_sum add_akas(p_sum_t le, p_sum_t ri) := transform
			self.comment := IF(le.did<>0 and le.ssn=ri.ssn,AKA,ri.comment);
			self := ri;
			end;

		do_akas := iterate(swp,add_akas(left,right));

		resorted := group(sort(group(do_akas),ssn,-cnt,-comment),ssn);
		p_correct := 'Probably correct';
		p_sum add_pcorrect(p_sum_t le, p_sum_t ri) := transform
			self.comment := IF(le.ssn='' and ri.comment = Best_SSN,p_correct,ri.comment);
			self := ri;
			end;

		do_pcorrect := iterate(resorted,add_pcorrect(left,right));


		matchables := do_pcorrect(comment = p_correct);

		//output(do_pcorrect);

		boolean intNNEQ(unsigned4 l, unsigned4 r) := l = 0 or r = 0 or l = r;

		Typo := 'Probable Typo';
		Rela := 'Relative ssn';

		p_sum note_typo(p_sum_t le, p_sum_t ri,string val) := transform
			self.comment := 
												MAP( ri.ssn = '' or le.comment IN [Aka,Typo,p_correct] => le.comment,
														 le.comment = Best_SSN => val + ' causing fragment',
														 val );
			self.likely_fragment := val = rela and
													 metaphonelib.DMetaPhone1(le.fname) = metaphonelib.DMetaPhone1(ri.fname) and
													 intNNEQ(le.dob,ri.dob) and
													 ut.NNEQ(le.mname,ri.mname);
			self := le;
			end;
		//output(matchables);
		//output(do_pcorrect);

		find_morphs := join(do_pcorrect,matchables,left.did=right.did and 
																					 ut.StringSimilar(left.ssn,right.ssn)<3,
												note_typo(left,right,Typo),left outer);
		//output(find_morphs);
		find_rels := join(find_morphs,dedup(matchables,ssn,lname,all),
																												 left.ssn=right.ssn and
																												 left.lname=right.lname and
																												 left.did<>right.did,
												note_typo(left,right,rela),left outer);

		// Fetch the SSN information for all extant ssns
		ssn_info := doxie_crs.layout_ssn_records;

		// check if SSN was seen before randomization:
		// TODO: making it after validation may be more efficient
		ssn_w_legacy_info := join (find_rels, doxie.key_legacy_ssn,
															 keyed (Left.ssn = Right.ssn) AND
															 (Left.did = Right.did),
															 transform (p_sum, Self.legacy_ssn := Right.ssn != '', Self := Left),
															 LEFT OUTER, KEEP (1), limit (0)); //at most 1 : 1 relation

		// get SSN validation data:
		ssn_info ssnm(p_sum frm,doxie.Key_SSN_Map R) := transform

			// new ssn-issue data have '20990101' for the current date intervals
			r_end := IF (R.end_date='20990101', 0, (unsigned4) R.end_date);

			m_validation := ut.GetSSNValidation (frm.ssn);
			boolean is_valid := m_validation.is_valid;
			boolean is_legacy := m_validation.is_valid AND R.ssn5 = '' AND frm.legacy_ssn;

			self.youngest_age := if(frm.youngest_age=big_num,0,frm.youngest_age);
			self := frm;
			self.ssn_issue_early	:= Suppress.dateCorrect.sdate_u4(frm.ssn, (unsigned4)R.start_date);
			self.ssn_issue_last		:= Suppress.dateCorrect.edate_u4(frm.ssn, r_end);
			self.ssn_issue_place	:= Suppress.dateCorrect.state(frm.ssn, R.state);
			valid := (is_valid and not is_legacy and ((integer)frm.ssn not in doxie.bad_ssn_list));
			self.valid := Suppress.dateCorrect.valid(frm.ssn, valid);
			end;

		result := join (ssn_w_legacy_info, doxie.Key_SSN_Map,
										keyed (left.ssn[1..5] = Right.ssn5) AND
										keyed (left.ssn[6..9] between Right.start_serial AND Right.end_serial),
										ssnm (Left, Right),
										LEFT OUTER, KEEP (1), limit (0)); //1 : 1 relation

		out_f := sort(result,did,-cnt,ssn,-length(trim(fname)));

		suppress.MAC_Mask(out_f, out_mskd, ssn, blank, true, false,,true);

		//***** COMPARE RECORDS TO THE BEST INFO FOR THE SUBJECT
		str_yes 	:= 'YES';
		str_no  	:= 'NO';
		str_close := 'CLOSE';
		ssn_info check_and_skip(out_mskd l, best_info_mult r) := transform,
			skip(		//this skip is designed to mimic the behavior of the left outer join that was here before, preventing dups in front end
				 l.fname = r.fname and 
				 l.mname = r.mname and 
				 l.lname = r.lname and
				 l.dob = r.dob and
				 l.ssn = r.ssn and
				 l.did = r.did)
			
			cn := 
				if(l.fname = r.fname and 
					 l.lname = r.lname and 
					 (l.mname = r.mname or (l.mname[1] = r.mname[1] and 
																	(length(trim(l.mname)) = 1 or length(trim(r.mname)) = 1))),
					 str_yes,
					 str_no);
			ssi :=
				map(l.ssn = r.ssn 											=> str_yes,
						header.ssn_value(l.ssn, r.ssn) > 0  => str_close,	//moxie returns CLOSE
						str_no);
			cb := 
				if(l.dob = r.dob, str_yes, str_no);
			
			self.current_name := 						if(Include_AKAs_val, cn,  '');
			self.subject_ssn_indicator := 	if(Include_AKAs_val, ssi, '');
			self.correct_dob :=							if(Include_AKAs_val, cb,  '');
			
			self := l;
		end;

		ds_checked :=
			join(out_mskd(not likely_fragment), 
					 best_info_mult,
					 true,
					 check_and_skip(left, right),
					 all);

		//***** SORT RECS SIMILAR TO "BEST" TO THE TOP
		ssn_extra := record(ssn_info)
			unsigned1 best_score;
		end;
		ssn_extra addScore(ds_checked L) := transform
			B := best_info_mult[1];
			
			fn_match	:= L.fname=B.fname;
			mn_match	:= L.mname=B.mname or (L.mname[1]=B.mname[1] and (length(trim(L.mname))=1 or length(trim(B.mname))=1));
			ln_match	:= L.lname=B.lname;
			dob_match	:= L.dob=B.dob;
			ssn_match	:= L.ssn=B.ssn;
			ssn_close	:= header.ssn_value(L.ssn,B.ssn) > 0;
			
			self.best_score :=
				if(fn_match and ln_match, 1, 0) +								// 1 point for a fname+lname match
				if(fn_match and mn_match and ln_match, 1, 0) +	// 1 point for a mname match (only if fname+lname also match)
				if(dob_match, 1, 0) +														// 1 point for a dob match
				map(ssn_match=>3, ssn_close=>1, 0);							// 3 points for a perfect ssn match, 1 for a near match
			
			self := L;
		end;
		ds_scored := project(ds_checked, addScore(left));
		ds_sorted := project(sort(ds_scored, -best_score, did, -cnt, ssn, -length(trim(fname))), ssn_info);

		return ds_sorted;

	end;

	EXPORT Get_RNA_DIDs(dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) := function
		rec := doxie.layout_references;

		//get the relatives and associates
		rels_fat := relative_records(false,dids);

		rec slimrels(rels_fat l) := transform
			self := l;
		end;

		rels := project(rels_fat, slimrels(left));

		//get the neighbors
		nbrs_fat := historic_nbr_records_crs(false,dids); // this attributes only returns dids

		rec slimnbrs(nbrs_fat l) := transform
			self := l;
		end;

		nbrs := project(nbrs_fat, slimnbrs(left));
		//get all the dids together
		return dedup(rels + nbrs, all);
	end;
	
	EXPORT SSN_Lookups(dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) := function
		doxie.MAC_Header_Field_Declare();
		ssns := dedup(comp_ssns(dids)((unsigned)ssn_unmasked > 0),ssn_unmasked,all);
		// Fetch the SSN information for all extent ssns
		ssn_info := doxie_crs.layout_SSN_Lookups;

		ssn_temp_rec := record
			recordof (ssns);
			boolean legacy_ssn := false; //for potentially randomized SSNs defines if SSN-DID pair was seen before
		end;

		// check if SSN was seen before randomization:

		// this is still an issue -- DID is not preserved into the lookups,
		// since the notion of 'legacy' is for the DID/SSN pair.
		ssn_w_legacy_info := join (ssns, doxie.key_legacy_ssn,
															 keyed (Left.ssn_unmasked = Right.ssn) AND
															 (Left.did = Right.did),
															 transform (ssn_temp_rec, Self.legacy_ssn := Right.ssn != '', Self := Left),
															 LEFT OUTER, KEEP (1), limit (0)); //at most 1 : 1 relation

		// get SSN validation data:
		ssn_info ssnm(ssn_temp_rec frm,doxie.Key_SSN_Map R) := transform
			// new ssn-issue data have '20990101' for the current date intervals
			r_end := IF (R.end_date='20990101', 0, (unsigned4) R.end_date);

			m_validation := ut.GetSSNValidation (frm.ssn_unmasked);
			boolean is_valid := m_validation.is_valid;
			boolean is_legacy := m_validation.is_valid AND R.ssn5 = '' AND frm.legacy_ssn;

			self.ssn5 := frm.ssn_unmasked[1..5];
			self.ssn_issue_early	:= Suppress.dateCorrect.sdate_u4(frm.ssn_unmasked, (unsigned4)R.start_date);
			self.ssn_issue_last		:= Suppress.dateCorrect.edate_u4(frm.ssn_unmasked, r_end);
			self.ssn_issue_place	:= Suppress.dateCorrect.state(frm.ssn_unmasked, R.state);
			valid := (is_valid and not is_legacy and ((integer)frm.ssn_unmasked not in doxie.bad_ssn_list)); 
			self.valid := Suppress.dateCorrect.valid(frm.ssn_unmasked, valid);
			self.ssn := frm.ssn9;
			self.ssn_unmasked := frm.ssn_unmasked;
		 end;

		result := join(ssn_w_legacy_info,doxie.Key_SSN_Map,
									 keyed (left.ssn_unmasked[1..5] = Right.ssn5) AND
									 keyed (left.ssn_unmasked[6..9] between Right.start_serial AND Right.end_serial), //between is inclusive
									 ssnm(left,right),
									 left outer, KEEP (1), limit (0)); //1:1 relation

		result mask_ssn5(result l) := transform
			self.ssn5_unmasked := l.ssn5;
			self.ssn5 := if(ssn_mask_value='ALL' or ssn_mask_value='FIRST5', 'xxxxx', l.ssn5);
			self := l;
		end;

		out_mskd := project(result, mask_ssn5(left));

		return out_mskd;
	end;
	EXPORT nbr_records_slim(dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) := function

		slimFmt		:= doxie.layout_nbr_records_slim;
		nbrRows		:= nbr_records(dids);
		addrRows	:= Comp_Addresses(dids);

		tmpFmt := record
			unsigned2 address_seq_no;
			nbrRows;
		end;

		tmpFmt doSeq(nbrRows L, addrRows R) := transform
				SELF.address_seq_no := R.address_seq_no;
				SELF := L;
		end;

		slimRows := join(
			nbrRows, addrRows,
			LEFT.did = RIGHT.did
				AND LEFT.zip = RIGHT.zip
				AND LEFT.prim_name = RIGHT.prim_name
				AND LEFT.prim_range = RIGHT.prim_range
				AND LEFT.sec_range = RIGHT.sec_range,
			doSeq(LEFT, RIGHT), keep (1) 
		);

		slimFmt doBaseSeq(slimRows L, addrRows R) := transform
				SELF.base_address_seq_no := R.address_seq_no;
				SELF := L;
		end;

		slimRows_b := join(
			slimRows, addrRows,
			LEFT.base_did = RIGHT.did
				AND LEFT.zip = RIGHT.zip
				AND LEFT.prim_name = RIGHT.prim_name
				AND LEFT.base_prim_range = (integer)RIGHT.prim_range
				AND LEFT.base_sec_range = RIGHT.sec_range,
			doBaseSeq(LEFT, RIGHT), keep (1)
		);

		slimRows_s := sort(
			slimRows_b,
			mode, seqTarget, seqNPA, seqNbr
		);

		// OUTPUT(nbrRows, named('nbrRows'));				// DEBUG
		// OUTPUT(addrRows, named('addrRows'));			// DEBUG
		// OUTPUT(slimRows_b, named('slimRows_b'));	// DEBUG
		// OUTPUT(slimRows_s, named('slimRows_s'));	// DEBUG

		return slimRows_s;
	end;
	export verifiedPhones(boolean Legacy_Verified_Value = false,dataset (doxie.layout_references) dids=dataset ([],doxie.layout_references)) :=
	MODULE

	//****** Pull the listed phone, which comes from gong, off of the verified records
	shared csa := project(Comp_Subject_Addresses_wrap(dids).raw, transform(doxie.Layout_Comp_Addresses, self.hri_address := [], self := left));


	//****** export layout
	export RecordLayout := record
			csa.listed_phone;
			string4	timezone;
	end;

	export MaxRecords := 20;

	standard := project(csa(Address.isVerified(tnt, phone, listed_phone)), transform(RecordLayout,self.timezone:='',self:=left));

	//***** When legacy verified, we need an additional function call

	falvv := Doxie.fn_addLVV(Comp_Subject_Addresses_wrap(dids).addresses).records_wListedPhone;  

	legacy := project(falvv(Address.isVerified(tnt, phone, phone)), transform(RecordLayout,self.timezone:='',self:=left));//i intentionally passed phone in twice so that listed_phone does not unverify me.  the legacy option of comp addresses actually returns a blank listed_phone to the ESP layer, which assigns verified

	ut.getTimeZone(legacy,listed_phone,timezone,legacy_w_tzone)	
	ut.getTimeZone(standard,listed_phone,timezone,standard_w_tzone)	


	export records := choosen(dedup(if(Legacy_Verified_Value, legacy_w_tzone, standard_w_tzone)(listed_phone <> ''), all), MaxRecords);
	END;
end;