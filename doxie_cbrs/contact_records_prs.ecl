IMPORT AutoStandardI, business_header, DeathV2_Services, doxie, doxie_cbrs,
       dx_death_master, NID, STD, ut;

EXPORT contact_records_prs(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION
death_params := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
glb_ok := death_params.isValidGlb();

contacts := doxie_cbrs.contact_records(bdids);

//****** APPEND ADDRESS ID
addrs := doxie_cbrs.contact_address_records(bdids);
cr_rec := {contacts, addrs.address_id};
cr_rec add_id(contacts l, addrs r) := TRANSFORM
  SELF.address_id := r.address_id;
  SELF := l;
END;

cr := JOIN(contacts, addrs,
  LEFT.prim_Range = RIGHT.prim_range AND
  LEFT.prim_name = RIGHT.prim_name AND
  LEFT.sec_Range = RIGHT.sec_range AND
  LEFT.zip = RIGHT.zip,
  add_id(LEFT, RIGHT),
  LEFT OUTER);



ctr := {STRING60 company_title, UNSIGNED1 title_rank};

outrec := RECORD
  cr.level;
  cr.bdid;
  cr.did;
  cr.record_type;
  cr.dt_first_seen;
  cr.dt_last_seen;
  cr.company_title; // Title of Contact at Company if available
  cr.title;
  cr.fname;
  cr.mname;
  cr.lname;
  cr.name_suffix;
  STRING9 ssn;
  cr.company_name;
  DATASET(ctr) company_title_children;
  UNSIGNED1 lowest_title_rank;
  BOOLEAN has_death_record := FALSE;
  cr.address_id;
END;

cleantitle(STRING src, STRING title) := MAP(
  //specific requests
  TRIM(title,LEFT,RIGHT) IN ['DOMAIN ADMINISTRATIVE CONTACT', 'DOMAIN TECHNICAL CONTACT'] => '',
  src = 'D' => STD.Str.FindReplace(title,'PROJECT ',''),
  title);


//** prep for rollups
kct := business_header.Key_Company_Title;
outrec addid(cr l, kct r) := TRANSFORM
  mytitle := IF(r.decode_company_title <> '', r.decode_company_title, l.company_title);
  mycleantitle := cleantitle(l.source,mytitle);
  myrank := doxie_cbrs.rankTitle(mytitle);
  SELF.company_title_children :=
    DATASET([{mycleantitle, myrank }], ctr);
  SELF.lowest_title_rank := myrank;
  SELF := l;
END;

pfr0 := //PROJECT(cr, addid(LEFT));
  JOIN(cr, kct,
    KEYED(TRIM(LEFT.company_title, LEFT, RIGHT) = RIGHT.company_title),
    addid(LEFT, RIGHT), LEFT OUTER, KEEP(1));

//** see about getting a bester name
dids := DEDUP(SORT(PROJECT(pfr0, doxie.layout_references), did), did);
doxie.mac_best_records(dids, did, best_recs, TRUE, glb_ok,, doxie.DataRestriction.fixed_DRM);

pfr0 get_best_name(pfr0 l, best_recs r) := TRANSFORM
  isbest := r.fname <> '';
  SELF.title := IF(isbest, r.title, l.title);
  SELF.fname := IF(isbest, r.fname, l.fname);
  SELF.mname := IF(isbest, r.mname, l.mname);
  SELF.lname := IF(isbest, r.lname, l.lname);
  SELF.name_suffix := IF(isbest, r.name_suffix, l.name_suffix);
  SELF := l;
END;

pfr := JOIN(pfr0, best_recs,
            LEFT.did > 0 AND LEFT.did = RIGHT.did AND RIGHT.fname <> '' AND RIGHT.lname <> '',
            get_best_name(LEFT, RIGHT),
            LEFT OUTER, KEEP(1));


//****** ROLLUP TO COMBINE TITLES
outrec rollem(outrec l, outrec r) := TRANSFORM
  SELF.company_title_children :=
    DEDUP(SORT(l.company_title_children + r.company_title_children(company_title <> ''),title_rank,company_title));
  SELF.lowest_title_rank := IF(r.lowest_title_rank < l.lowest_title_rank AND r.lowest_title_rank > 0, r.lowest_title_rank, l.lowest_title_rank);
  SELF.dt_last_seen := IF(l.dt_last_seen > r.dt_last_seen, l.dt_last_seen, r.dt_last_seen);
  SELF.dt_first_seen := IF(l.dt_first_seen <> 0 AND l.dt_first_seen < r.dt_first_seen, l.dt_first_seen, r.dt_first_seen);
  SELF := l;
END;

//** once by bdid and did

fr1 := SORT(pfr, bdid, did, company_title);
                       //bdid, did, company_title);

rlld1 := ROLLUP(fr1, LEFT.bdid = RIGHT.bdid AND LEFT.did > 0 AND LEFT.did = RIGHT.did, rollem(LEFT, RIGHT));

//** once by bdid and name
STRING50 myname(STRING25 fn, STRING25 lna) :=
  TRIM(NID.PreferredFirstNew(fn)) +
  metaphonelib.DMetaPhone1(lna);

fr2 := SORT(rlld1, bdid, myname(fname, lname), company_title);
                         //bdid, myname(fname, lname), company_title);

rlld2 := ROLLUP(fr2, LEFT.bdid = RIGHT.bdid AND
                     myname(LEFT.fname, LEFT.lname) = myname(RIGHT.fname, RIGHT.lname), rollem(LEFT, RIGHT));

//** and once by cname and did

STRING40 ccn(STRING cn) := ut.CleanCompany(cn)[1..40];
fr3 := SORT(rlld2, ccn(company_name), did, company_title);
                         //ccn(company_name), did, company_title);

rlld3 := ROLLUP(fr3,
       ccn(LEFT.company_name) = ccn(RIGHT.company_name) AND LEFT.did > 0 AND LEFT.did = RIGHT.did, rollem(LEFT, RIGHT));


//** and once by cname and name
fr4 := SORT(rlld3, ccn(company_name), myname(fname, lname), company_title);
                         //ccn(company_name), myname(fname, lname), company_title);

rlld4 := ROLLUP(fr4, ccn(LEFT.company_name) = ccn(RIGHT.company_name) AND
                     myname(LEFT.fname, LEFT.lname) = myname(RIGHT.fname, RIGHT.lname), rollem(LEFT, RIGHT));


//get those dups out and sort
outrec nodup(outrec l) := TRANSFORM
  SELF.company_title_children := DEDUP(SORT(l.company_title_children(company_title <> ''),title_rank,company_title));
  SELF := l;
END;

ddpd := PROJECT(rlld4, nodup(LEFT));


//** add death indicator
wdthAppend := dx_death_master.Append.byDID(ddpd, did, death_params);

wdth :=
  PROJECT(wdthAppend,
    TRANSFORM(outrec,
      SELF.has_death_record := LEFT.death.is_deceased;
      SELF.company_title := '';
      SELF := LEFT;
    ));

//** add SSN
// well, it seems we actually just need to let it through
/*
doxie.mac_best_records(wdth,did,ssnsd,dppa_ok,glb_ok)
ssns := dedup(sort(ssnsd, did, -ssn), did);

outrec addssn(wdth l, ssns r) := transform
  self.ssn := \if(r.ssn <> '', r.ssn, l.ssn);
  self := l;
end;

wssn := join(wdth, ssns, left.did = right.did, addssn(left, right), left outer);

wout := project(wdth, transform(outrec, self.ssn := '', self := left));
pssn := if(doxie_cbrs.stored_ShowPersonalData_value, wssn, wout);
*/
pssn := PROJECT(wdth, TRANSFORM(outrec,
                SELF.ssn := IF(doxie_cbrs.stored_ShowPersonalData_value,LEFT.ssn,''),
                SELF := LEFT));
//limit
srt := SORT(pssn, level, lowest_title_rank, lname, fname, -did);


RETURN srt;
END;
