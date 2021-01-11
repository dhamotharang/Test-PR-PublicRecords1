IMPORT Census_data, doxie, doxie_cbrs, business_header, Business_Header_SS, ut;

EXPORT fn_getBaseRecs(
  DATASET(doxie_cbrs.layout_references) in_group_ids,
  BOOLEAN in_use_supergroup,
  BOOLEAN append_goup_id = TRUE
) :=
FUNCTION
  outrec := doxie_cbrs.layout_base_rec;

  doxie_cbrs.mac_Selection_Declare()
  mod_access := Doxie.compliance.GetGlobalDataAccessModule();
  bhk2 := business_header_ss.Key_BH_BDID_pl;
  
  doxie_cbrs.layout_supergroup keepl(in_group_ids l) := TRANSFORM
    SELF.group_id := 0;
    SELF := l;
  END;
  
  tempsg :=
    IF(
      in_use_supergroup,
      doxie_cbrs.fn_getSupergroup(
        PROJECT(
          in_group_ids,
          TRANSFORM(
            doxie_cbrs.layout_supergroup,
            SELF.group_id := 0,
            SELF.level := 0,
            SELF := LEFT)),
        business_header.stored_use_Levels_val),
      PROJECT(
        in_group_ids,
        keepl(LEFT)));

  kb := Business_Header.Key_BH_SuperGroup_BDID;
  tempsg attachgroupid(tempsg l, kb r) := TRANSFORM
    SELF.group_id := r.group_id;
    SELF := l;
  END;
  tempsg0 := JOIN(tempsg, kb,
                  append_goup_id AND
                  KEYED (LEFT.bdid=RIGHT.bdid),
                  attachgroupid(LEFT,RIGHT),
                  LEFT OUTER, KEEP (1), LIMIT (0));
  mybdids := table(tempsg0,{bdid,group_id});
  
  extralayout := RECORD
    bhk2;
    UNSIGNED6 group_id;
  END;
  
  extralayout BaseRecs(RECORDOF(mybdids) l, bhk2 r) := TRANSFORM
    SELF.group_id := l.group_id;
    SELF := r;
  END;

  base_BH_recs := JOIN(mybdids, bhk2
                       ,KEYED(LEFT.bdid = RIGHT.bdid)
                        AND IF(mod_access.isConsumer()
                               ,RIGHT.source IN ut.IndustryClass.BH_KnowX_src
                               ,TRUE) AND
                        doxie.compliance.source_ok(mod_access.glb, mod_access.DataRestrictionMask, RIGHT.source) AND
                        doxie.compliance.isBusHeaderSourceAllowed(RIGHT.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask)
                       ,BaseRecs(LEFT,RIGHT)
                       ,LIMIT(0)
                       ,KEEP(50));

  ext_rec := RECORD
    base_bh_recs;
    UNSIGNED2 name_source_id;
    UNSIGNED2 addr_source_id;
    UNSIGNED2 phone_source_id;
    UNSIGNED2 fein_source_id;
  END;

  ext_rec project_ids(base_BH_recs l, UNSIGNED c) := TRANSFORM
    SELF.name_source_id := c;
    SELF.addr_source_id := c;
    SELF.phone_source_id := c;
    SELF.fein_source_id := c;
    SELF := l;
  END;

  base_BH_recs_id := PROJECT(GROUP(SORT(base_BH_recs, group_id,RECORD),group_id),project_ids(LEFT,COUNTER));
          
  outrec add_msa_county(base_BH_recs_id L, Census_Data.Key_Fips2County R) := TRANSFORM
    SELF.msaDesc := IF(L.msa <> '' AND L.msa <> '0000', ziplib.MSAToCityState(L.msa), '');
    SELF.county_name := IF (L.county <> '', R.county_name, '');
    // SELF.phone := if(L.phone > 0, (string)L.phone, '');
    SELF.phone := IF(L.phone % 10000000 != 0, (STRING)L.phone, ''); // Filters out phone numbers whose value is zero, OR whose last seven digits are zero. cda May 2006.
    SELF.fein := IF(L.fein > 0, INTFORMAT(L.fein, 9, 1), '');
    SELF.zip := IF(L.zip > 0, INTFORMAT(L.zip,5,1), '');
    SELF.zip4 := IF(L.zip4 > 0, INTFORMAT(L.zip4,4,1), '');
    SELF.msa := IF(L.msa <> '0000', L.msa, '');
    SELF := L;
  END;
  
  
  tempBaseRecs := JOIN(base_BH_recs_id(NOT dppa OR (mod_access.isValidDPPA() AND mod_access.isValidDPPAState(vendor_st, , source))),
                       Census_Data.Key_Fips2County,
                       KEYED(LEFT.state = RIGHT.state_code AND
                       LEFT.county = RIGHT.county_fips),
                       add_msa_county(LEFT,RIGHT), LEFT OUTER, KEEP (1), LIMIT (0));
  
  outrec project_clean(tempBaseRecs l) := TRANSFORM
    SELF.company_clean := doxie_cbrs.cleancompany(l.company_name);
    SELF := l;
  END;

  sortbyname := SORT(PROJECT(tempBaseRecs,project_clean(LEFT)),group_id,company_clean,name_source_id);
  //////////////////////
  tempded := DEDUP(table(sortbyname,{group_id,company_clean,clean_len := LENGTH(TRIM(company_clean,LEFT,RIGHT))}),group_id,company_clean);
  tempjoinrec := RECORD
    UNSIGNED6 group_id;
    STRING shortclean;
    STRING longclean;
  END;
  tempjoinrec xform_join(tempded l, tempded r) := TRANSFORM
    SELF.group_id := l.group_id;
    SELF.shortclean := TRIM(l.company_clean,LEFT,RIGHT);
    SELF.longclean := TRIM(r.company_clean,LEFT,RIGHT);
  END;
  tempjoin := JOIN(tempded,tempded,LEFT.group_id = RIGHT.group_id AND LEFT.company_clean[1] = RIGHT.company_clean[1] AND LEFT.clean_len < RIGHT.clean_len AND LEFT.company_clean = RIGHT.company_clean[1..LEFT.clean_len],xform_join(LEFT,RIGHT));
  tempjoinrec xform_roll(tempjoinrec l, tempjoinrec r) := TRANSFORM
     SELF.group_id := l.group_id;
     SELF.shortclean := l.shortclean;
     SELF.longclean := IF(TRIM(l.longclean,LEFT,RIGHT) = l.shortclean,l.shortclean,
                         IF(LENGTH(l.longclean) > LENGTH(r.longclean),
                             IF(l.longclean[1..LENGTH(r.longclean)] = r.longclean,
                                l.longclean,doxie_cbrs.getmatchinginitialstring(l.longclean,r.longclean)),
                             IF(r.longclean[1..LENGTH(l.longclean)] = l.longclean,
                                r.longclean,doxie_cbrs.getmatchinginitialstring(l.longclean,r.longclean))));
    // self.longclean := doxie_cbrs.getmatchinginitialstring(l.longclean,r.longclean);
  END;
  temproll := ROLLUP(SORT(tempjoin,group_id,shortclean,longclean),LEFT.group_id = RIGHT.group_id AND LEFT.shortclean = RIGHT.shortclean,xform_roll(LEFT,RIGHT));
  temproll xform_jointemp(temproll l) := TRANSFORM
    SELF := l;
  END;
  
  tempfilt := DEDUP(JOIN(temproll(longclean <> ''),tempded,LEFT.group_id = RIGHT.group_id AND LEFT.longclean = RIGHT.company_clean,xform_jointemp(LEFT)));
  outrec xform_join2(outrec l, tempfilt r) := TRANSFORM
    SELF.company_clean := IF(r.longclean <> '',r.longclean,l.company_clean);
    SELF := l;
  END;
  reduced_names := JOIN(sortbyname,tempfilt,LEFT.group_id = RIGHT.group_id AND LEFT.company_clean = RIGHT.shortclean,xform_join2(LEFT,RIGHT),LEFT OUTER);
  outrec xform_remove(outrec l) := TRANSFORM
    SELF.company_clean := doxie_cbrs.stripcompany(l.company_clean);
    SELF := l;
  END;
  sortbyname2 := GROUP(SORT(PROJECT(reduced_names,xform_remove(LEFT)),group_id,company_clean,name_source_id),group_id);

  //////////////////////

  outrec iterbyname(outrec l, outrec r, UNSIGNED c) := TRANSFORM
    SELF.name_source_id := IF(c != 1 AND l.company_clean = r.company_clean,l.name_source_id,r.name_source_id);
    SELF := r;
  END;

  rollbyname := ITERATE(sortbyname2,iterbyname(LEFT,RIGHT,COUNTER));

  sortbyaddr := SORT(rollbyname,state,zip,prim_name,prim_range,sec_range,addr_source_id);

  outrec iterbyaddr(outrec l, outrec r) := TRANSFORM
    SELF.addr_source_id := IF(l.state = r.state AND
                              l.zip = r.zip AND
                              l.prim_name = r.prim_name AND
                              l.prim_range = r.prim_range AND
                              l.sec_range = r.sec_range,l.addr_source_id,r.addr_source_id);
    SELF := r;
  END;

  rollbyaddr := ITERATE(sortbyaddr,iterbyaddr(LEFT,RIGHT));

  sortbyphone := SORT(rollbyaddr,phone,phone_source_id);

  outrec iterbyphone(outrec l, outrec r) := TRANSFORM
    SELF.phone_source_id := IF(l.phone = r.phone,l.phone_source_id,r.phone_source_id);
    SELF := r;
  END;

  rollbyphone := ITERATE(sortbyphone,iterbyphone(LEFT,RIGHT));
  
  sortbyfein := SORT(rollbyphone,fein,fein_source_id);
  
  outrec iterbyfein(outrec l, outrec r) := TRANSFORM
    SELF.fein_source_id := IF(l.fein = r.fein,l.fein_source_id,r.fein_source_id);
    SELF := r;
  END;
  
  rollbyfein := ITERATE(sortbyfein,iterbyfein(LEFT,RIGHT));

  filterbyid := rollbyfein((SourceIdName = '' OR name_source_id = (UNSIGNED)SourceIdName) AND
                           (SourceIdAddr = '' OR addr_source_id = (UNSIGNED)SourceIdAddr) AND
                           (SourceIdPhone = '' OR phone_source_id = (UNSIGNED)SourceIdPhone) AND
                           (SourceIdFein = '' OR fein_source_id = (UNSIGNED)SourceIdFein));

  RETURN filterbyid;

END;
