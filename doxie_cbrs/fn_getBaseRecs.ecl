import Census_data, doxie, doxie_cbrs, business_header, Business_Header_SS, ut;

export fn_getBaseRecs(
  dataset(doxie_cbrs.layout_references) in_group_ids,
	boolean in_use_supergroup,
	boolean append_goup_id = true
) :=
function
	doxie_cbrs.mac_Selection_Declare()
	mod_access := Doxie.compliance.GetGlobalDataAccessModule();
	bhk2 := business_header_ss.Key_BH_BDID_pl;
	
	doxie_cbrs.layout_supergroup keepl(in_group_ids l) := transform
	  self.group_id := 0;
	  self := l;
	end;
	
	tempsg :=
		if(
			in_use_supergroup,
			doxie_cbrs.fn_getSupergroup(
				project(
					in_group_ids,
					transform(
						doxie_cbrs.layout_supergroup,
						self.group_id := 0,
						self.level := 0,
						self := left)),
				business_header.stored_use_Levels_val),
			project(
				in_group_ids,
				keepl(left)));

	kb := Business_Header.Key_BH_SuperGroup_BDID;
	tempsg attachgroupid(tempsg l, kb r) := transform
	  self.group_id := r.group_id;
		self := l;
	end;
	tempsg0 := join(tempsg, kb,
                  append_goup_id and 
                  keyed (left.bdid=right.bdid),
                  attachgroupid(left,right),
                  left outer, keep (1), limit (0));
  mybdids := table(tempsg0,{bdid,group_id});
	
	extralayout := record
	  bhk2;
		unsigned6 group_id;
	end;
	
	extralayout BaseRecs(recordof(mybdids) l, bhk2 r) := TRANSFORM
	  self.group_id := l.group_id;
		SELF := r;
	END;

	base_BH_recs := JOIN(mybdids, bhk2
							         ,KEYED(LEFT.bdid = RIGHT.bdid)
		                    and IF(mod_access.isConsumer()
		                           ,RIGHT.source in ut.IndustryClass.BH_KnowX_src
					                     ,true) AND
                        doxie.compliance.source_ok(mod_access.glb, mod_access.DataRestrictionMask, RIGHT.source) AND
                        doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask)
					             ,BaseRecs(left,RIGHT)
					    				 ,LIMIT(0)											 
											 ,KEEP(50));

	ext_rec := record
		base_bh_recs;
		unsigned2 name_source_id;
		unsigned2 addr_source_id;
		unsigned2 phone_source_id;
		unsigned2 fein_source_id;
	end;

	ext_rec project_ids(base_BH_recs l, unsigned c) := transform
		self.name_source_id := c;
		self.addr_source_id := c;
		self.phone_source_id := c;
		self.fein_source_id := c;
		self := l;
	end;

  base_BH_recs_id := project(group(sort(base_BH_recs, group_id,record),group_id),project_ids(left,counter));


	br_msa_county := RECORD
		doxie_cbrs.Layout_BH;
		string60 msaDesc := '';
		string18 county_name := '';
		string120 company_clean := '';
		unsigned2 name_source_id := 0;
		unsigned2 addr_source_id := 0;
		unsigned2 phone_source_id := 0;
		unsigned2 fein_source_id := 0;
		unsigned6 group_id := 0;
	END;
					
	br_msa_county add_msa_county(base_BH_recs_id L, Census_Data.Key_Fips2County R) := TRANSFORM
		SELF.msaDesc := if(L.msa <> '' and L.msa <> '0000', ziplib.MSAToCityState(L.msa), '');
		SELF.county_name := if (L.county <> '', R.county_name, '');
//		SELF.phone := if(L.phone > 0, (string)L.phone, '');
		SELF.phone := if(L.phone % 10000000 != 0, (string)L.phone, ''); // Filters out phone numbers whose value is zero, or whose last seven digits are zero. cda May 2006.
		SELF.fein := if(L.fein > 0, INTFORMAT(L.fein, 9, 1), '');
		SELF.zip := if(L.zip > 0, INTFORMAT(L.zip,5,1), '');
		SELF.zip4 := if(L.zip4 > 0, INTFORMAT(L.zip4,4,1), '');
		SELF.msa := if(L.msa <> '0000', L.msa, '');
		SELF := L;
	END;
	
	
	tempBaseRecs := JOIN(base_BH_recs_id(not dppa or (mod_access.isValidDPPA() AND mod_access.isValidDPPAState(vendor_st, , source))),
	                     Census_Data.Key_Fips2County,
											 KEYED(LEFT.state = RIGHT.state_code and
							         LEFT.county = RIGHT.county_fips),
							         add_msa_county(LEFT,RIGHT), LEFT OUTER, KEEP (1), LIMIT (0));
	
	br_msa_county project_clean(tempBaseRecs l) := transform
		self.company_clean := doxie_cbrs.cleancompany(l.company_name);
		self := l;
	end;

	sortbyname := sort(project(tempBaseRecs,project_clean(left)),group_id,company_clean,name_source_id);
	//////////////////////
	tempded := dedup(table(sortbyname,{group_id,company_clean,clean_len := length(trim(company_clean,left,right))}),group_id,company_clean);
	tempjoinrec := record
	  unsigned6 group_id;
		string shortclean;
		string longclean;
	end;
	tempjoinrec xform_join(tempded l, tempded r) := transform
	  self.group_id := l.group_id;
		self.shortclean := trim(l.company_clean,left,right);
		self.longclean := trim(r.company_clean,left,right);
	end;
	tempjoin := join(tempded,tempded,left.group_id = right.group_id and left.company_clean[1] = right.company_clean[1] and left.clean_len < right.clean_len and left.company_clean = right.company_clean[1..left.clean_len],xform_join(left,right));
	tempjoinrec xform_roll(tempjoinrec l, tempjoinrec r) := transform
	   self.group_id := l.group_id;
		 self.shortclean := l.shortclean;
		 self.longclean := if(trim(l.longclean,left,right) = l.shortclean,l.shortclean,
												 if(length(l.longclean) > length(r.longclean),
														 if(l.longclean[1..length(r.longclean)] = r.longclean,
																l.longclean,doxie_cbrs.getmatchinginitialstring(l.longclean,r.longclean)),
														 if(r.longclean[1..length(l.longclean)] = l.longclean,
																r.longclean,doxie_cbrs.getmatchinginitialstring(l.longclean,r.longclean))));
		// self.longclean := doxie_cbrs.getmatchinginitialstring(l.longclean,r.longclean);
	end;
	temproll := rollup(sort(tempjoin,group_id,shortclean,longclean),left.group_id = right.group_id and left.shortclean = right.shortclean,xform_roll(left,right));
	temproll xform_jointemp(temproll l) := transform
	  self := l;
	end;
	
	tempfilt := dedup(join(temproll(longclean <> ''),tempded,left.group_id = right.group_id and left.longclean = right.company_clean,xform_jointemp(left)));
	br_msa_county xform_join2(br_msa_county l, tempfilt r) := transform
		self.company_clean := if(r.longclean <> '',r.longclean,l.company_clean);
		self := l;
	end;
	reduced_names := join(sortbyname,tempfilt,left.group_id = right.group_id and left.company_clean = right.shortclean,xform_join2(left,right),left outer);
	br_msa_county xform_remove(br_msa_county l) := transform
		self.company_clean := doxie_cbrs.stripcompany(l.company_clean);
		self := l;
	end;
	sortbyname2 := group(sort(project(reduced_names,xform_remove(left)),group_id,company_clean,name_source_id),group_id);

	//////////////////////

	br_msa_county iterbyname(br_msa_county l, br_msa_county r, unsigned c) := transform
		self.name_source_id := if(c != 1 and l.company_clean = r.company_clean,l.name_source_id,r.name_source_id);
		self := r;
	end;

	rollbyname := iterate(sortbyname2,iterbyname(left,right,counter));

	sortbyaddr := sort(rollbyname,state,zip,prim_name,prim_range,sec_range,addr_source_id);

	br_msa_county iterbyaddr(br_msa_county l, br_msa_county r) := transform
		self.addr_source_id := if(l.state = r.state and
															l.zip = r.zip and
															l.prim_name = r.prim_name and
															l.prim_range = r.prim_range and
															l.sec_range = r.sec_range,l.addr_source_id,r.addr_source_id);
		self := r;
	end;

	rollbyaddr := iterate(sortbyaddr,iterbyaddr(left,right));

	sortbyphone := sort(rollbyaddr,phone,phone_source_id);

	br_msa_county iterbyphone(br_msa_county l, br_msa_county r) := transform
		self.phone_source_id := if(l.phone = r.phone,l.phone_source_id,r.phone_source_id);
		self := r;
	end;

	rollbyphone := iterate(sortbyphone,iterbyphone(left,right));
	
	sortbyfein := sort(rollbyphone,fein,fein_source_id);
	
	br_msa_county iterbyfein(br_msa_county l, br_msa_county r) := transform
	  self.fein_source_id := if(l.fein = r.fein,l.fein_source_id,r.fein_source_id);
		self := r;
	end;
	
	rollbyfein := iterate(sortbyfein,iterbyfein(left,right));

	filterbyid := rollbyfein((SourceIdName = '' or name_source_id = (unsigned)SourceIdName) and
													 (SourceIdAddr = '' or addr_source_id = (unsigned)SourceIdAddr) and
													 (SourceIdPhone = '' or phone_source_id = (unsigned)SourceIdPhone) and
													 (SourceIdFein = '' or fein_source_id = (unsigned)SourceIdFein));

	return filterbyid;

end;
