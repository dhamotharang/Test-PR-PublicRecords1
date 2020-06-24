import doxie, risk_indicators, doxie_raw, ut, mdr, header, drivers, Riskwise, Relationship, Suppress, Data_Services, AML, STD;

EXPORT AMLRelativesAssocs ( Grouped DATASET(AML.Layouts.RelativeParentLayout) iid_res,
                           doxie.IDataAccess mod_access,
                           boolean isFCRA = false
                           ) := FUNCTION;

data_environment :=  IF(isFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);

Relationship.mac_read_application_type();
glb_ok := mod_access.isValidGlb();
dppa_ok := mod_access.isValidDppa();

boolean isUtility := false; //can I use value from mod_access?

AML.Layouts.RelativeParentLayout addSeq(iid_res le, Integer C) := TRANSFORM
                SELF.seq := le.seq;
                self.DIDseq := c;
                SELF := le;
                self := [];
END;

relIdsWseq := project(ungroup(iid_res)(isrelat), addSeq(left,counter));


risk_indicators.Layout_Boca_Shell_ids get_all_dids(relIdsWseq le, unsigned6 in_did,
                                                           boolean relat,STRING20 f_name,
                                                           STRING20 l_name, UNSIGNED1 titleNo=0) := TRANSFORM
                SELF.seq := le.DIDseq;
                self.historydate := le.historydate;
                SELF.did := in_did;
                SELF.isrelat := relat;
                SELF.fname := f_name;
                SELF.lname := l_name;
                SELF.relation := Header.relative_titles.fn_get_str_title(titleNo);
                self := [];
END;

justDids := PROJECT(relIdsWseq,
      TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.relatdid));
rellyids := Relationship.proc_GetRelationshipNeutral(justDids,TopNCount:= 100,
      RelativeFlag :=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost,
      HighConfidenceRelatives:= HighConfidenceRelatives_Value ,
      HighConfidenceAssociates := HighConfidenceAssociates_Value ,
      RelLookbackMonths := RelLookbackMonths_Value).result;

rel_ids := JOIN(relIdsWseq, rellyids,
                LEFT.relatdid=RIGHT.did1,
                get_all_dids(LEFT,RIGHT.did2,true, LEFT.fname,LEFT.lname, RIGHT.title));

risk_indicators.Layout_Boca_Shell_ids get_Subjestdids(relIdsWseq le)
                                                          // , unsigned6 in_did,
                                                           // boolean relat,STRING20 f_name, STRING20 l_name)
                                                           := TRANSFORM
                SELF.seq := le.DIDseq;
                self.historydate := le.historydate;
                SELF.did := le.relatdid;
                SELF.isrelat := le.isrelat;
                SELF.fname := le.fname;
                SELF.lname := le.lname;
                self := [];
END;

SubjectDIDS := project(RelidsWseq, get_Subjestdids(LEFT));



relatives_slim := record

  unsigned4 seq;
  unsigned3 historydate;
  unsigned6 did;
  unsigned6 relatDID;
  boolean   isrelat;
  STRING20   fname;
  STRING20   lname;
  STRING20   relation;

  string10   prim_range;
  string2    predir;
  string28   prim_name;
  string4    addr_suffix;
  string2    postdir;
  string5    unit_desig;
  string8    sec_range;

  STRING2    state;
  STRING5    zip5;

  string3   county ;
  string7   geo_blk ;
  unsigned3 firstseendt;
  unsigned3 lastseendt;
  string50   sources;
  unsigned1 RelatParentPubRec10yrs;
end;


AllDIDs :=  rel_ids + SubjectDIDS ;

Doxie_Raw_CCPA := RECORD
  unsigned4 global_sid;
  Doxie_Raw.Layout_HeaderRawOutput;
END;

  Doxie_Raw_CCPA getHeaderRaw(AllDIDs le, Doxie.Key_Header ri) := TRANSFORM
    SELF.rid := le.seq;
    self.did := le.did;
    self.global_sid := ri.global_sid;
    SELF := ri;
    SELF := [];
  END;


header_raw_unsuppressed := JOIN(allDids, Doxie.Key_Header, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.s_did) AND

                            (~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)  AND
                            (header.isPreGLB(RIGHT) OR glb_ok) AND
                            RIGHT.dt_first_seen < left.historydate and
                            (~mdr.Source_is_DPPA(RIGHT.src) OR (dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),mod_access.dppa,RIGHT.src))) AND
                            ~risk_indicators.iid_constants.filtered_source(right.src, right.st)
                            and  ~Doxie.DataRestriction.isHeaderSourceRestricted(RIGHT.src, mod_access.DataRestrictionMask),
                            getHeaderRaw(LEFT, RIGHT),   atmost(200), keep(100)); //LIMIT(UT.limits.HEADER_PER_DID, SKIP));

header_raw := Suppress.Suppress_ReturnOldLayout(header_raw_unsuppressed, mod_access, Doxie_Raw.Layout_HeaderRawOutput, data_environment := data_environment);

ParentIDs := rel_ids(STD.Str.tolowercase(relation)  in ['father','mother', 'parent'] );

relatives_slim getParentHistDt(ParentIDs le, RelidsWseq ri ) := TRANSFORM
  self.did := le.did;
  SELF.relation := le.relation;
  SELF.seq   :=  le.seq;
  SELF.firstseendt := 0;
  SELF.lastseendt :=  0;
  self.RelatParentPubRec10yrs := 0;  // if we get a hit on this join at all, we have a relative on file who's been on header for over ten years
  SELF.historydate := ri.historydate;
  SELF := le;
  SELF := ri;
  SELF := [];

END;

JustParents := join(ParentIDs, RelidsWseq,
                         right.didseq=left.seq ,
                   getParentHistDt(left,right));

relatives_slim getParentHeader(JustParents le, header_raw ri) := TRANSFORM
  self.did := le.did;
  SELF.relation := le.relation;
  SELF.seq   :=  le.seq;
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

  SELF.firstseendt :=  ri.dt_first_seen;
  SELF.lastseendt :=  ri.dt_last_seen;
  self.RelatParentPubRec10yrs := 0;  // if we get a hit on this join at all, we have a relative on file who's been on header for over ten years
  SELF.sources := ri.src;
  SELF.historydate := le.historydate;
  SELF.fname := ri.fname;  // since ParentIDs layout now contains fname/lname as well we need to assign the proper value in clear way
  SELF.lname := ri.lname;
  SELF := le;
  SELF := ri;
  SELF := [];

END;




ParentHeader := join(JustParents, header_raw, right.dt_first_seen <> 0 and left.did = right.did and left.seq = right.rid and
                    (ut.DaysApart((string)right.dt_first_seen, (string)risk_indicators.iid_constants.myGetDate(left.historydate)) >= ut.DaysInNYears(10)),
                     getParentHeader(left,right), left outer, keep(1));


ParentHdrTenYrs := project(ParentHeader, TRANSFORM(relatives_slim,
                                          self.RelatParentPubRec10yrs := if((ut.DaysApart((string)left.firstseendt, (string)risk_indicators.iid_constants.myGetDate(left.historydate)) >= ut.DaysInNYears(10)),1,0),
                                          self := left));


relatives_slim rollrelatives(ParentHdrTenYrs le,ParentHdrTenYrs ri ) := Transform
    self.RelatParentPubRec10yrs := if(le.RelatParentPubRec10yrs = 1, le.RelatParentPubRec10yrs, ri.RelatParentPubRec10yrs);
    self := le;
End;

rollRelatPar := rollup(ParentHdrTenYrs, left.seq=right.seq, rollrelatives(left, right));

RelateParentResults :=   join(RelidsWseq, rollRelatPar,
                         left.didseq=right.seq ,
                         transform(AML.Layouts.RelativeParentLayout,
                                   self.RelatParentPubRec10yrs := right.RelatParentPubRec10yrs,
                                   self := left),
                        left outer);

// output(iid_res, named('iid_res'));
// output(RelidsWseq, named('RelidsWseq'));
// output(rel_ids, named('rel_ids'), overwrite);
// output(SubjectDIDS, named('SubjectDIDS'), overwrite);
// output(PossParents, named('PossParents'), overwrite);
// output(header_raw, named('header_raw'));
// output(ParentIDs, named('ParentIDs'));
// output(JustParents, named('JustParents'));
// output(ParentHdrTenYrs, named('ParentHdrTenYrs'));
// output(ParentHeader, named('ParentHeader'));
// output(rollRelatPar, named('rollRelatPar'));
// output(RelateParentResults, named('RelateParentResults'));

RETURN(RelateParentResults);

END;
