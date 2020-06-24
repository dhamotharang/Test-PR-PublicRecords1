
Import RISK_INDICATORS, doxie, ut, header, mdr, drivers, riskwise, header_quick, VotersV2, Suppress, data_services, AML;

export IndGetHeader(DATASET(Layouts.RelatLayoutV2) idsIN,
                    $.IParam.iAml mod_aml,
                    boolean isFCRA = false
                    ) := FUNCTION

data_environment :=  IF(isFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);

//version 2
boolean isUtility := false;
integer bsversion := 50;
boolean ln_branded := false;

glb_ok := isFCRA OR mod_aml.isValidGlb();
dppa_ok := isFCRA OR mod_aml.isValidDppa();
DataRestriction := mod_aml.DataRestrictionMask;

relatives_slim := record

  unsigned4 historydate;
  unsigned4 seq;
  unsigned4 addrSeq;
  unsigned6 origdid;
  unsigned6 relatdid;
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
  string3   county;
  string7   geo_blk;
  // unsigned3 age;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string50  src;
  integer   IsVoter;
  integer   IsVoterSrc;
  qstring9  ssn;
  integer   isITIN;
  boolean   HasITIN;
  integer   isNON_US_SSN;
  Boolean   hasNON_US_SSN;
  unsigned4 socllowissue;
end;

relatives_slim_CCPA := RECORD
  unsigned4 global_sid;
  relatives_slim;
END;

relatHdrTbl_slim := record

  unsigned4 historydate;
  unsigned4 seq;
  unsigned4 addrSeq;
  unsigned6 origdid;
  unsigned6 relatdid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string50  src;
  boolean   IsVoter;
  boolean   IsVoterSrc;
  boolean   isITIN;
end;

relatives_slim_CCPA getHeader(idsIN le, doxie.Key_Header ri) := TRANSFORM
  Self.seq := le.seq;
  SELF.origDID := LE.origDID;
  SELF.relatDID := LE.relatDID;
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
  SELF.dt_first_seen := if(ri.dt_first_seen = 0, 999999, ri.dt_first_seen);
  SELF.dt_last_seen :=  ri.dt_last_seen;
  SELF.src := ri.src;
  self.ssn := ri.ssn;
  self.socllowissue := le.socllowissue;
  self.isvoter := 0;  //remove
  self.global_sid := ri.global_sid;
  SELF := le;
  SELF := ri;
  SELF := [];

END;

IDSSortDD:= dedup(sort(idsIN(relatdegree <> 0), seq, relatdid), seq, relatdid);

Keyheader_Join :=  JOIN(IDSSortDD, doxie.Key_Header,
                            keyed(LEFT.relatdid = RIGHT.s_did)
                            AND
                            right.src not in Risk_Indicators.iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
                            RIGHT.dt_first_seen < left.historydate
                            AND    // check permissions
                            (~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)  AND
                            (header.isPreGLB(RIGHT) OR glb_ok)
                            AND (~mdr.Source_is_DPPA(RIGHT.src) OR
                              (dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),mod_aml.dppa,RIGHT.src)))
                            AND ~Risk_Indicators.iid_constants.filtered_source(right.src, right.st)  ,
                            getHeader(LEFT,RIGHT),  LEFT OUTER, atmost(RiskWise.max_atmost), keep(150));

Keyheader_Flagged := Suppress.MAC_FlagSuppressedSource(Keyheader_Join, mod_aml, did_field := relatdid, data_env := data_environment);

Keyheader := PROJECT(Keyheader_Flagged, TRANSFORM(relatives_slim,
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
  SELF.dt_first_seen := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_first_seen);
  SELF.dt_last_seen := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_last_seen);
  SELF.src := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.src);
  SELF.ssn := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.ssn);
  SELF := LEFT;
));
// get quick header

relatives_slim_CCPA getQH(IDSSortDD le, header_quick.key_DID ri) := TRANSFORM

  SELF.origDID := LE.origDID;
  SELF.relatDID := LE.relatDID;
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
  SELF.dt_first_seen := if(ri.dt_first_seen = 0, 999999, ri.dt_first_seen);
  SELF.dt_last_seen :=  ri.dt_last_seen;
  SELF.src := ri.src;
  self.ssn := ri.ssn;
  self.socllowissue := le.socllowissue;
  self.isvoter := 0;  //remove
  self.global_sid := ri.global_sid;
  SELF := le;
  SELF := ri;
  SELF := [];

END;

quickHeader_Join := join(IDSSortDD, header_quick.key_DID,
                            LEFT.relatdid<>0 AND keyed(LEFT.relatdid = RIGHT.did) AND
                            right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
                            RIGHT.dt_first_seen < left.historydate
                            AND     // check permissions
                            (~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)  AND
                            (header.isPreGLB(RIGHT) OR glb_ok) AND
                            (~mdr.Source_is_DPPA(RIGHT.src) OR
                            (dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),mod_aml.dppa,RIGHT.src)))
                              AND
                            ~risk_indicators.iid_constants.filtered_source(right.src, right.st),
                            getQH(left,right),
                            atmost(ut.limits.HEADER_PER_DID), keep(100));

quickHeader_Flagged := Suppress.MAC_FlagSuppressedSource(quickHeader_Join, mod_aml, did_field := relatdid, data_env := data_environment);

quickHeader := PROJECT(quickHeader_Flagged, TRANSFORM(relatives_slim,
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
  SELF.dt_first_seen := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_first_seen);
  SELF.dt_last_seen := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_last_seen);
  SELF.src := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.src);
  SELF.ssn := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.ssn);
  SELF := LEFT;
));

allheader :=  sort(ungroup(quickHeader + Keyheader), seq ,origdid, relatdid);

RealHeader := if(DataRestriction[risk_indicators.iid_constants.posEquifaxRestriction]= risk_indicators.iid_constants.sTrue, allheader(src NOT IN [MDR.sourceTools.src_Equifax, MDR.sourcetools.src_Equifax_Quick, MDR.sourcetools.src_Equifax_Weekly]), allheader);

relatives_slim evalheader(RealHeader le, RECORDOF(VotersV2.Key_Voters_States(isFCRA)) ri) := TRANSFORM
  SELF.IsVoter   := IF(LE.src = 'VO', 1, 0);
  self.IsVoterSrc  := (INTEGER)((INTEGER)ri.date_first_seen > 0);
  Self.isITIN :=   if(Risk_Indicators.rcSet.isCodeIT(le.ssn), 1, 0);
  self.isNON_US_SSN := if(Risk_Indicators.rcSet.isCode85(le.ssn, (string)le.socllowissue), 1, 0);
  self := le;
END;

getSSNType := JOIN(RealHeader, VotersV2.Key_Voters_States(isFCRA),
                                LEFT.State <> '' AND KEYED(LEFT.State = RIGHT.State) AND RIGHT.Date_First_Seen[1..6] < risk_indicators.iid_constants.myGetDate((unsigned) LEFT.historydate)[1..6],
                                evalheader(LEFT, RIGHT), SMART, FEW, LEFT OUTER);
                                //since Key_Voters_States is a ~25 record key, use options SMART and FEW in the join in order to read the key into memory and improve performance


IsHits := getSSNType(isvoter > 0 or isvotersrc > 0 or isITIN > 0 or isNON_US_SSN > 0);

TableHits := table(IsHits,
                    {seq ,origdid, relatdid, integer isVoterCnt := count(group,isvoter = 1), integer isVoterSRCcnt := count(group, IsVoterSrc = 1), integer isITINCnt := count(group, isITIN = 1), integer isNON_US_SSNCnt := count(group, isNON_US_SSN = 1)},
                     seq, origdid, relatdid);


hdrdatestbl := table(getSSNType, {seq ,origdid, relatdid,
                                    unsigned4 dt_first_seen := min(group, dt_first_seen),
                                    unsigned4 dt_last_seen := max(group, dt_last_seen)},
                                    seq ,origdid, relatdid);


Layouts.RelatLayoutV2  prepout(idsIN le, TableHits  ri)  := TRANSFORM
    self.EverITIN  := if(ri.isITINCnt > 0, true, false);
    self.EverNon_US_SSN := if(ri.isNON_US_SSNCnt > 0, true, false);
    self.hasITIN  := le.hasITIN;
    self.hasNon_US_SSN := le.hasNON_US_SSN;
    self.isVoter   := if(ri.isvoterCnt > 0, true, false);
    self.VoterSrc   := if(ri.isvoterSRCCnt > 0, true, false);

    self := le;
    self := [];
END;

addHeaderSSN := join(idsIN(relatdegree <> 0), TableHits,
                  left.seq = right.seq and
                  left.origdid = right.origdid and
                  left.relatdid = right.relatdid ,
                  prepout(left,right), left outer);

Layouts.RelatLayoutV2  prepoutDates(idsIN le, hdrdatestbl  ri)  := TRANSFORM

    self.HdrFirstSeenDate := if(ri.relatdid <> 0,  ri.dt_first_seen, 999999);
    self.HdrLastSeenDate := if(ri.relatdid <> 0,  ri.dt_last_seen, 0);
    self := le;
    self := [];
END;

addHeaderDts := join(addHeaderSSN, hdrdatestbl,
                  left.seq = right.seq and
                  left.origdid = right.origdid and
                  left.relatdid = right.relatdid ,
                  prepoutDates(left,right), left outer);

Alldids :=     addHeaderDts +   idsIN(relatdegree = 0);

Getparents := GetIndParents(Alldids);




// output(idsIN, named('idsIN'));
// output(Keyheader, named('Keyheader'), all);
// output(quickHeader, named('quickHeader'), all);

// output(allheader, named('allheader'));
// output(RealHeader, named('RealHeader'));

// output(getSSNType, named('getSSNType'));
// output(IsHits, named('IsHits'));
// output(TableHits, named('TableHits'));
// output(hdrdatestbl, named('hdrdatestbl'));
// output(rolledHdr, named('rolledHdr'));
// output(HeaderOut, named('HeaderOut'));
// output(Alldids, named('Alldids'));
// output(Getparents, named('Getparents'));

RETURN Getparents;
END;
