Import RISK_INDICATORS, ln_propertyv2, doxie, ut, header, mdr, drivers, riskwise, Suppress, data_services, AML, STD;


export AMLGetHeader(GROUPED DATASET(AML.Layouts.RelativeInLayout) idsOnly,
                           doxie.IDataAccess mod_access,
                           boolean isFCRA = false
                           ) := FUNCTION

data_environment :=  IF(isFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);

glb_ok := mod_access.isValidGlb();
dppa_ok := mod_access.isValidDppa();

boolean isUtility := mod_access.isUtility();

relatives_slim := record

  unsigned4 historydate;
  unsigned4 seq;
  unsigned4 addrSeq;
  unsigned6 did;
  boolean   isrelat;
  STRING20  relation;
  STRING20  fname;
  STRING20  lname;
  string10  prim_range;
  string2   predir;
  string28  prim_name;
  string4   addr_suffix;
  string2   postdir;
  string5   unit_desig;
  string8   sec_range;
  STRING2   state;
  STRING5   zip5;
  string3   county ;
  string7   geo_blk ;
  unsigned3 age;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string50  sources;
  unsigned1 relatIsVoter;
  unsigned1 parentIsVoter;
  unsigned1 parent_pubRec_10yrs;
  boolean   isIncarcerated;
  string8   firstSeenDt;
  integer   addrs_last36;
  integer   addrs_last_5years;
  integer   LengthAtPrevAddr;
  boolean   LastMoveOvrYr;
  boolean   OwnPrevAddr;
  boolean   OwnCurrAddr;

  STRING    hriskaddrflag;

end;

{relatives_slim, unsigned4 global_sid} get_relat_info(idsOnly le, doxie.Key_Header ri) := TRANSFORM
  SELF.global_sid := ri.global_sid;
  SELF.DID := LE.DID;
  SELF.historydate := le.historydate;
  SELF.relation := le.relation;
  SELF.prim_range := ri.prim_range;
  SELF.predir := ri.predir;
  SELF.prim_name := ri.prim_name;
  SELF.addr_suffix := ri.suffix;
  SELF.postdir := ri.postdir;
  SELF.unit_desig := ri.unit_desig;
  SELF.sec_range := ri.sec_range;
  SELF.zip5 := ri.zip;
  SELF.state := ri.st;
  SELF.county := ri.county;
  SELF.geo_blk := ri.geo_blk;
  SELF.age := ut.Age(ri.dob);
  SELF.dt_first_seen := ri.dt_first_seen;
  SELF.dt_last_seen :=  ri.dt_last_seen;
  SELF.sources := ri.src;
  SELF.isIncarcerated := FALSE;
  SELF.addrs_last36 := 0;
  SELF.addrs_last_5years := 0;
  SELF := le;
  SELF := ri;
  SELF := [];

END;

relatheader_unsuppressed :=  JOIN(idsOnly, doxie.Key_Header,
                            keyed(LEFT.did=RIGHT.s_did) AND
                            right.src not in risk_indicators.iid_constants.masked_header_sources(mod_access.DataRestrictionMask, isFCRA) AND
                            RIGHT.dt_first_seen < left.historydate
                            AND
                            // check permissions
                            (~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)  AND
                            (header.isPreGLB(RIGHT) OR glb_ok) AND
                            (~mdr.Source_is_DPPA(RIGHT.src) OR
                              (dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),mod_access.dppa,RIGHT.src)))
                              AND
                            ~risk_indicators.iid_constants.filtered_source(right.src, right.st)
                            ,
                            get_relat_info(LEFT,RIGHT), LEFT OUTER,atmost(RiskWise.max_atmost), keep(100));

relatheader_flagged := Suppress.MAC_FlagSuppressedSource(relatheader_unsuppressed, mod_access, data_env := data_environment);

relatheader := PROJECT(relatheader_flagged, TRANSFORM(relatives_slim,
  SELF.prim_range := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.prim_range);
  SELF.predir := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.predir);
  SELF.prim_name := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.prim_name);
  SELF.addr_suffix := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.addr_suffix);
  SELF.postdir := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.postdir);
  SELF.unit_desig := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.unit_desig);
  SELF.sec_range := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.sec_range);
  SELF.zip5 := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.zip5);
  SELF.state := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.state);
  SELF.county := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.county);
  SELF.geo_blk := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.geo_blk);
  SELF.age := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.age);
  SELF.dt_first_seen := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_first_seen);
  SELF.dt_last_seen :=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_last_seen);
  SELF.sources := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.sources);
  SELF := LEFT;
));

// dedup by address then determine addr_last,   rollup and count, move final count to field back in join back to all records.

relatHeaderADDRSrt := dedup(sort(relatheader,seq, did, prim_name, prim_range, addr_suffix, zip5, -dt_first_seen), seq, did, prim_name, prim_range, addr_suffix, zip5);

relatives_slim getAddrCount(relatHeaderADDRSrt le) := TRANSFORM
     fsDate31 := ((STRING)le.dt_first_seen)[1..6]+'31';
     myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
     self.addrs_last36 :=  if(Risk_indicators.iid_constants.checkdays(myGetDate,fsDate31,Risk_indicators.iid_constants.threeyears, le.historydate), 1, 0);
     self.addrs_last_5years :=  if(Risk_indicators.iid_constants.checkdays(myGetDate,fsDate31,Risk_indicators.iid_constants.fiveyears, le.historydate), 1, 0);
     self := le;
END;

relatHdrAddr := project(relatHeaderADDRSrt, getAddrCount(left));

// aml addr last 3-5 years.
relatives_slim rollHDRAddr(relatHdrAddr le, relatHdrAddr ri) := TRANSFORM
  self.addrs_last36 :=  le.addrs_last36 + ri.addrs_last36;
  self.addrs_last_5years := le.addrs_last_5years + ri.addrs_last_5years;
  self := le;
END;

//  how many address last 5 years
relatHdrAddrRoll := rollup(sort(relatHdrAddr, seq,did),rollHDRAddr(left, right), seq,did);

addcountaddr := join(idsOnly, relatHdrAddrRoll,
                      left.seq = right.seq and
                      left.did = right.did,
                      transform(relatives_slim,
                                self.seq := left.seq,
                                self.did := left.did,
                                self := right),
                      left outer);


// Get voter and public record
relatHeaderSrt := sort(relatheader(dt_first_seen<>0), seq, did, -dt_first_seen);


relatives_slim getHDRVote(relatHeaderSrt le) := TRANSFORM
     fsDate31 := le.dt_first_seen[1..6]+'31';
     myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
     self.relatIsVoter := if (le.sources = 'VO' , 1,0);
     self.parentIsVoter  := if (le.sources = 'VO' and STD.Str.tolowercase(le.relation) in ['father','mother', 'parent'], 1,0);
     self.parent_pubRec_10yrs := if(STD.Str.tolowercase(le.relation) in ['father','mother', 'parent'] and (ut.DaysApart((string)le.dt_first_seen, (string)risk_indicators.iid_constants.myGetDate(le.historydate)) >= ut.DaysInNYears(10)),1,0);
     self.firstSeenDt := (string)le.dt_first_seen;
     self := le;
END;

relatHdrPubVote := project(relatHeaderSrt, getHDRVote(left));


relatives_slim rollRelat(relatives_slim le, relatives_slim ri) := TRANSFORM

  SELF.relatIsVoter := if(le.relatIsVoter = 0, if(ri.relatIsVoter <>0, ri.relatIsVoter, le.relatIsVoter), le.relatIsVoter);
  SELF.parentIsVoter := if(le.parentIsVoter = 0, if(ri.parentIsVoter <>0, ri.parentIsVoter, le.parentIsVoter), le.parentIsVoter);
  SELF.parent_pubRec_10yrs := if(le.parent_pubRec_10yrs = 0, if(ri.parent_pubRec_10yrs <>0, ri.parent_pubRec_10yrs, le.parent_pubRec_10yrs), le.parent_pubRec_10yrs);
  SELF.firstSeenDt := if(le.firstSeenDt < ri.firstSeenDt, le.firstSeenDt, ri.firstSeenDt);
  SELF := le;
END;
//voter and header info
idrollRelatSlim := ROLLUP(SORT(relatHdrPubVote, seq, did, state, zip5, county, geo_blk) ,rollRelat(LEFT,RIGHT),
             seq, did);




relatives_slim Addvoter(relatives_slim le, relatives_slim ri) := TRANSFORM
  self.addrs_last36 := le.addrs_last36;
  self.addrs_last_5years := le.addrs_last_5years;
  SELF.relatIsVoter :=  ri.relatIsVoter;
  SELF.parentIsVoter :=  ri.parentIsVoter;
  SELF.parent_pubRec_10yrs :=  ri.parent_pubRec_10yrs;
  SELF.firstSeenDt := ri.firstSeenDt;
  self := le;
END;

AddVoterInfo :=  join(addcountaddr, idrollRelatSlim,
                      left.seq = right.seq and
                      left.did = right.did,
                      Addvoter(left,right),
                  left outer);



// Incarcerated
relatHdrSICSrt := dedup(sort(relatheader(dt_first_seen<>0),seq, did, -dt_last_seen, dt_first_seen), seq, did);

relatives_slim getSICCode(relatHdrSICSrt le, risk_indicators.key_HRI_Address_To_SIC ri) := TRANSFORM
     self.isIncarcerated := if(trim(ri.sic_code)='2225', true, false);
     self := le;
END;

relatHdrSIC := join(relatHdrSICSrt,risk_indicators.key_HRI_Address_To_SIC,
        left.zip5!='' and left.prim_name != '' and
        keyed(left.zip5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and
        keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
        keyed(left.sec_range=right.sec_range) AND
        right.dt_first_seen < left.historydate and right.sic_code='2225',
        getSICCode(left,right),left outer,
        ATMOST(keyed(left.zip5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and
            keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
            keyed(left.sec_range=right.sec_range), RiskWise.max_atmost), keep(1));




AddIncarcertion := join(AddVoterInfo, relatHdrSIC,
                    left.seq=right.seq and left.did=right.did,
                    transform(relatives_slim,
                        self.isIncarcerated := right.isIncarcerated,
                        self := left;), left outer);

//Last two address details
HdrAddrMoveSrt := dedup(sort(relatheader(dt_first_seen<>0),seq, did, -dt_last_seen, dt_first_seen), seq, did);

relatives_slim  recentMove(HdrAddrMoveSrt le)  := TRANSFORM
    fsDate31 := ((STRING)le.dt_first_seen)[1..6]+'31';
    myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
    self.LastMoveOvrYr    :=  if(Risk_indicators.iid_constants.checkdays(myGetDate,fsDate31,Risk_indicators.iid_constants.oneyear, le.historydate), 0, 1);
    self := le;

END;

HdrAddrLastMove  :=  project(HdrAddrMoveSrt, recentMove(left));

addLastMove := join(AddIncarcertion, HdrAddrLastMove,
                    right.seq=left.seq and
                    right.did=left.did,
                    transform(relatives_slim,
                              self.LastMoveOvrYr := right.LastMoveOvrYr,
                              SELF.prim_range := right.prim_range;
                              SELF.predir := right.predir;
                              SELF.prim_name := right.prim_name;
                              SELF.addr_suffix := right.Addr_suffix;
                              SELF.postdir := right.postdir;
                              SELF.unit_desig := right.unit_desig;
                              SELF.sec_range := right.sec_range;
                              SELF.zip5 := right.zip5;
                              SELF.state := right.state;
                              SELF.county := right.county;
                              SELF.geo_blk := right.geo_blk;
                              self := left),
                    left outer);

//length at prev addr
hdrLastAddrDD := dedup(sort(relatheader(dt_first_seen<>0),seq, did, prim_name, prim_range, addr_suffix, zip5, -dt_last_seen, dt_first_seen), seq, did, prim_name, prim_range, addr_suffix, zip5);

hdrLastAddrS  := sort(hdrLastAddrDD, seq, did, -dt_last_seen, dt_first_seen);

relatives_slim addSeq(hdrLastAddrS le, Integer C) := TRANSFORM
                self.Addrseq := c;
                SELF := le;
                self := [];
END;

HdrAddrSeqd    := project(group(hdrLastAddrS, seq,did), addSeq(left, Counter));

 relatives_slim  PrevAddr(HdrAddrSeqd le)  := TRANSFORM
    fsDate31 := le.dt_first_seen[1..6]+'31';
    myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
    self.LengthAtPrevAddr     :=  ut.DaysApart((string)le.dt_first_seen, (string)risk_indicators.iid_constants.myGetDate(le.historydate));
    self := le;
END;

PrevAddrs  :=  project(HdrAddrSeqd(addrseq<=2), PrevAddr(left));

addLastAddrLen := join(addLastMove, PrevAddrs(addrseq=2),
                    right.seq=left.seq and
                    right.did=left.did,
                    transform(relatives_slim,
                              self.LengthAtPrevAddr := right.LengthAtPrevAddr,
                              self := left),
                    left outer);

// Detemine prev address ownership

kpa := ln_propertyv2.key_prop_address_v4;
kpo := ln_propertyv2.key_prop_ownership_v4;

layout_name := record
  qstring20  fname;
  qstring20  lname;
end;

matchrec := record
  boolean  match;
end;

matchrec fname_match(layout_name L, string20 fname) := transform
  self.match := risk_indicators.g(risk_indicators.FnameScore(l.fname, fname));
end;

matchrec lname_match(layout_name L, string20 lname) := transform
  self.match := risk_indicators.g(risk_indicators.LnameScore(L.lname, lname));
end;

layout_PropertyRecord := RECORD

  BOOLEAN   applicant_owned;
  BOOLEAN   applicant_sold;
  BOOLEAN   OwnPrevAddr;
  BOOLEAN   OwnCurrAddr;
  unsigned4 date_first_seen;
  unsigned4 date_last_seen;
  unsigned4 historydate;
  unsigned4 seq;
  unsigned4 addrSeq;
  unsigned6 did;
  boolean   isrelat;
  STRING20  relation;
  STRING20  fname;
  STRING20  lname;
  string10  prim_range;
  string2   predir;
  string28  prim_name;
  string4   addr_suffix;
  string2   postdir;
  string5   unit_desig;
  string8   sec_range;
  STRING2   state;
  STRING5   zip5;
  string3   county ;
  string7   geo_blk ;
END;


layout_PropertyRecord join_address(PrevAddrs L, KPA R) := transform
  buyer_fname_match := count(project(R.buyers, fname_match(LEFT, L.fname))(match)) > 0;
  buyer_lname_match := count(project(R.buyers, lname_match(LEFT, l.lname))(match)) > 0;
  seller_fname_match := count(Project(R.sellers, fname_match(LEFT,L.fname))(match)) > 0;
  seller_lname_match := count(project(R.sellers, lname_match(LEFT, L.lname))(match)) > 0;
  self.applicant_owned := buyer_fname_match and buyer_lname_match;
  self.applicant_sold :=  seller_lname_match and seller_fname_match;
  self.date_first_seen := R.date_first_seen;
  self.date_last_seen := R.date_last_seen;
  self.county := if (l.county = '', R.county, L.county);
  self.geo_blk := if (L.geo_blk = '', R.geo_blk, L.geo_blk);
  self := L;
  SELF := [];
end;

by_addr := join(PrevAddrs(prim_name != '', zip5 != ''), KPA,
                        keyed(left.prim_range = right.prim_range) and
                        keyed(left.prim_name = right.prim_name) and
                        keyed(left.sec_range = right.sec_range) and
                        keyed(left.zip5 = right.zip) and
                        keyed(left.addr_suffix = right.suffix) and
                        keyed(left.predir = right.predir) and
                        keyed(left.postdir = right.postdir),
            join_address(LEFT,RIGHT), left outer, ATMOST(100));



layout_PropertyRecord join_did2(PrevAddrs L, kpo R) := transform

  self.applicant_owned := R.applicant_owned;
  self.applicant_sold := R.applicant_sold;

  self := L;
  self := R;
  self := [];
end;


by_did2 := join(PrevAddrs, KPO,
                left.did != 0 and
                keyed(left.did = right.did) AND
                left.prim_range = right.prim_range and
                left.prim_name = right.prim_name and
                left.sec_range = right.sec_range and
                left.zip5 = right.zip5 and
                left.addr_suffix = right.addr_suffix and
                left.predir = right.predir and
                left.postdir = right.postdir  and
                (right.applicant_owned or right.applicant_sold),
              join_did2(LEFT,RIGHT), atmost(riskwise.max_atmost), KEEP(100));


AddrAll := ungroup(sort(by_did2 + by_addr, seq,did, addrseq));


layout_PropertyRecord DetermineOwnership(AddrAll L) := transform
  self.OwnPrevAddr := if((l.applicant_owned or l.applicant_sold) and l.addrseq = 2, 1, 0);
  self.OwnCurrAddr := if((l.applicant_owned or l.applicant_sold) and l.addrseq = 1, 1, 0);
  self := L;
END;


AddrOwnership := project(AddrAll, DetermineOwnership(LEFT));


layout_PropertyRecord rollOwnershipAll(AddrOwnership L, AddrOwnership R) := transform

  self.OwnPrevAddr := if(l.OwnPrevAddr, l.OwnPrevAddr, r.OwnPrevAddr);
  self.OwnCurrAddr := if(l.OwnCurrAddr, l.OwnCurrAddr, r.OwnCurrAddr);
  self := L;
END;


OwnershipRolled := rollup(sort(AddrOwnership,seq,did), left.seq=right.seq and left.did=right.did, rollOwnershipAll(LEFT,RIGHT));


AddOwnership := join(addLastAddrLen, OwnershipRolled,
                    left.did=right.did and
                    left.seq=right.seq,
                    transform(relatives_slim,
                              self.OwnPrevAddr := right.OwnPrevAddr,
                              self.OwnCurrAddr := right.OwnCurrAddr,
                              self := left),
                    left outer);


RETURN(AddOwnership);

END;
