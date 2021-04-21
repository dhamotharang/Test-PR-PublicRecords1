import doxie, risk_indicators, riskwise, AML;

EXPORT SSNData (DATASET(AML.Layouts.RelatLayoutV2) RelatsIn,
                           AML.IParam.iAml mod_aml,
                           boolean isFCRA = false,
                           boolean IsBusn
                           ) := FUNCTION;

// this is not requred, strictly speaking, but perhaps makes it a bit more clear
mod_access := PROJECT(mod_aml, doxie.IDataAccess);

IndDDIDs := dedup(sort(RelatsIn(origdid <> relatdid), seq, relatdid), seq, relatdid);
BusnDDIds := dedup(sort(RelatsIn, seq, relatdid), seq, relatdid);

DedupIDs := If(IsBusn, BusnDDIds, IndDDIDs);

unique_dids := project(ungroup(DedupIDs)(isrelat),transform(doxie.layout_references,self.did := left.relatdid));

// get best ssn from same function we use in the collection shell  just relatives
bestSSN := risk_indicators.collection_shell_mod.getBestCleaned(unique_dids,
                                                               mod_aml.DataRestrictionMask,
                                                               mod_aml.glb,
                                                               clean_address:=false); // don't need clean address, just the best SSN

AML.Layouts.RelatLayoutV2 addBEST(DedupIDs le, bestSSN ri) := TRANSFORM

    self.seq := le.seq;
    self.origdid := le.origdid;
    self.subjectdid := le.subjectdid;
    self.relatdid := le.relatdid;
    self.ssn := ri.ssn;
    self.dob := (string)ri.dob;
    self.phone := ri.phone;
    self.relatfname := ri.fname;   //really relatdid name
    self.relatlname := ri.lname;   //really relatdid name
    self.relatdegree := le.relatdegree;
    self.relation := le.relation;
    self.name_suffix := ri.name_suffix;
    self.prim_range := ri.prim_range;
    self.predir :=  ri.predir;
    self.prim_name :=  ri.prim_name;
    self.suffix := ri.suffix;
    self.postdir := ri.postdir;
    self.unit_desig := ri.unit_desig;
    self.sec_range :=  ri.sec_range;
    self.city_name := ri.city_name;
    self.st := ri.st;
    self.zip := ri.zip;
    self.zip4 := ri.zip4;
    self.street_addr := ri.street_addr;
    self.lat := ri.lat;
    self.long := ri.long;
    self.addr_type := ri.addr_type;
    self.addr_status := ri.addr_status;
    self.county := ri.county;
    self.geo_blk := ri.geo_blk;
    self.historydate := le.historydate;
    self := le;
END;



withBest := join(DedupIDs(isrelat), bestSSN, left.relatdid = right.did,
            addBEST(left, right), left outer);


SSNFlags_layout := RECORD
  UNSIGNED4 origseq;
  integer  RelatDegree;
  risk_indicators.Layout_output;
  boolean ITIN;
  boolean ValidSSN;
  boolean NonUSSSN;
  unsigned3 SSNPerADL;
  unsigned3 adlsperssn;
  boolean NoSSN;
  // boolean PossFamSharedSSN;
  unsigned3 SSNMultiIdentites
END;

// Risk_indicators.layout_output
//  need best info for relatives but Individual should be input info
SSNFlags_layout prep_ssnflags(withBest le ) := TRANSFORM
  self.seq := 0;
  self.origseq := le.seq;
  self.relatDegree := le.relatDegree;
  self.historydate := le.historydate;
  self.DID := if(le.relatdegree = 0, le.origdid, le.relatdid);
  self.score := 0;
  self.title := '';
  self.fname := le.relatfname;
  self.mname := '';
  self.lname  := le.relatlname;
  self.suffix := le.name_suffix;
  self.in_streetAddress := le.street_addr;
  self.in_city  := le.city_name;
  self.in_state :=  le.st;
  self.in_zipCode := le.zip;
  self.prim_range := le.prim_range;
  self.predir  := le.predir;
  self.prim_name  := le.prim_name;
  self.addr_suffix := le.suffix;
  self.postdir   := le.postdir;
  self.unit_desig  := le.unit_desig;
  self.sec_range   := le.sec_range;
  self.p_city_name := le.city_name;
  self.st           := le.st;
  self.z5           := le.zip;
  self.zip4         := le.zip4;
  self.lat := '';
  self.long := '';
  self.county := le.county;
  self.geo_blk := le.geo_blk;

  self.addr_type      := le.addr_type;
  self.addr_status     := le.addr_status;

  self.ssn  := le.ssn;
  self.dob  := (string)le.dob;
  self.phone10 := le.phone;
  self := [];
END;

 bestSSNsd := dedup(sort(withBest, seq,relatdid), seq,relatdid);
 RelatssnFlagsPrep := project(bestSSNsd, prep_ssnflags(left));

 INDssnFlagsPrep := project(RelatsIn(~isrelat), prep_ssnflags(left));

 AllSSNPrep := dedup(sort(RelatssnFlagsPrep + INDssnFlagsPrep, origseq, did) ,origseq, did);


risk_indicators.Layout_output into_seq(AllSSNPrep le, integer C) := TRANSFORM
  self.seq := C;
  self.account := (string)le.origseq;
  self := le;
END;

ssnFlagsPrepseq := project(AllSSNPrep, into_seq(left,counter));

// ssnFlagsPrepforAddr := group(project(ssnFlagsPrep, transform(risk_indicators.Layout_output, self.seq := left.origseq, self := left)), seq);
unsigned8 BSOptions := 0;

ExactMatchLevel:=  risk_indicators.iid_constants.default_ExactMatchLevel;
runSSNCodes := True;
//aml  just ids with ssn flags    iid_getssnflags expects diff seq for each individual.
withSSNFlags := risk_indicators.iid_getSSNFlags(group(ssnFlagsPrepseq, seq),
                                                mod_access, isFCRA, runSSNCodes,
                                                ExactMatchLevel, mod_aml.bs_version, mod_aml.bs_options);


withBSADL := Risk_Indicators.Boca_Shell_ADL(withSSNFlags, isFCRA, mod_access);  //ssn per adl   ssns_per_adl_seen_18months



SSNFlags_layout  SSNCnt(AllSSNPrep le, withBSADL ri) := TRANSFORM
  self.SSNPerADL  := ri.ssns_per_adl;
  self := le;
END;

AddSSNCnt := join(AllSSNPrep, withBSADL,
                left.did = right.did and
                left.origseq = (UNSIGNED4)right.account,
                SSNCnt(left, right), left outer);




SSNFlags_layout  SSNchecks(AddSSNCnt le, withSSNFlags ri) := TRANSFORM
  SELF.validSSN := ri.socsvalflag in ['3', '0'] or (ri.socsvalflag = '2' and length(trim(ri.ssn))=4); //remove '3' from socsvalflag
  Self.ITIN :=  Risk_Indicators.rcSet.isCodeIT(ri.ssn);
  self.NonUSSSN := Risk_Indicators.rcSet.isCode85(ri.ssn, ri.socllowissue);
  self.NoSSN  := if(trim(ri.ssn) ='', true, false);
  self.deceasedDate := ri.deceasedDate;
  self.socsdobflag := ri.socsdobflag;
  self.socsvalflag := ri.socsvalflag;
  self.socllowissue := ri.socllowissue;
  self.soclhighissue := ri.soclhighissue;
  self.adlsperssn   := ri.adls_per_ssn_created_6months;
  self := le;
  self := [];
END;

CheckSSNTypes := join(AddSSNCnt, withSSNFlags,
                      left.origseq = (UNSIGNED4)right.account
                      and left.did = right.did,
                      SSNchecks(left, right), left outer);


//  multi identies
suspiciousSSNs := join(CheckSSNTypes, risk_indicators.Key_SSN_Table_v4_2,
  keyed(left.ssn=right.ssn)  and
    // only keep records that are suspicious
    right.combo.recentcount >= 3,
    transform(SSNFlags_layout,  self.SSNMultiIdentites := right.combo.recentcount,
                              self := left), atmost(riskwise.max_atmost), Keep(200),left outer);



AML.Layouts.RelatLayoutV2  PrepOutput(RelatsIn le, suspiciousSSNs ri)  := TRANSFORM

  self.seq := le.seq;
  self.historydate := le.historydate;
  self.origdid := le.origdid;
  self.subjectdid  := le.subjectdid;
  self.relatDID := le.relatDID;
  self.isrelat  := le.isrelat;
  self.relatfname := ri.fname;
  self.relatlname := ri.lname;
  self.relation  := le.relation;  // relation from relatDID to SubjectDID
  self.RelatDegree := le.RelatDegree;
  self.phone := ri.phone10;
  self.ssn := ri.ssn;
  self.dob := ri.dob;
  self.name_suffix := ri.suffix;
  self.prim_range := ri.prim_range;
  self.predir := ri.predir;
  self.prim_name := ri.prim_name;
  self.suffix := ri.addr_suffix;
  self.postdir := ri.postdir;
  self.unit_desig := ri.unit_desig;
  self.sec_range := ri.sec_range;
  self.city_name := ri.p_city_name;
  self.st := ri.st;
  self.zip := ri.z5;
  self.zip4 := ri.zip4;
  self.street_addr := ri.in_streetaddress;
  self.lat := ri.lat;
  self.long := ri.long;
  self.addr_type := ri.addr_type;
  self.addr_status := ri.addr_status;
  self.county := ri.county;
  self.geo_blk := ri.geo_blk;
  self.deceasedDate := ri.deceasedDate;
  self.socsdobflag := ri.socsdobflag;
  self.socsvalflag := ri.socsvalflag;
  self.socllowissue := (unsigned4)ri.socllowissue;
  self.soclhighissue := (unsigned4)ri.soclhighissue;
  self.NoSSN  := ri.NoSSN;
  self.SSNPerADL :=  ri.SSNPerADL;
  self.adlsperssn :=  ri.adlsperssn;
  self.validSSN  := ri.validSSN;
  self.SSNMultiIdentites  := ri.SSNMultiIdentites;
  self.hasITIN := ri.ITIN;
  self.HasNON_us_SSN := ri.NonUSSSN;
  self := [];

END;


SSNFlagsOrigSeq := join(RelatsIn, suspiciousSSNs,
                        (integer)left.seq = right.origseq and
                                left.relatdid = right.did,
                        PrepOutput(left,right), left outer);



// output(RelatsIn, named('RelatsIn'));
// output(unique_dids, named('unique_dids'));
// output(DedupIDs, named('DedupIDs'));
// output(bestSSN, named('bestSSN'));
// output(withBest, named('withBest'));
// output(bestSSNsd, named('bestSSNsd'));
// output(AllSSNPrep, named('AllSSNPrep'));
// output(RelatSSNFlagsPrep, named('RelatSSNFlagsPrep'));
// output(INDssnFlagsPrep, named('INDssnFlagsPrep'));
// output(ssnFlagsPrepseq, named('ssnFlagsPrepseq'));
// output(withSSNFlags, named('withSSNFlags'));
// output(withBSADL, named('withBSADL'));
// output(AddSSNCnt, named('AddSSNCnt'));

// output(matchingSSN, named('matchingSSN'));
// output(CheckSSNTypes, named('CheckSSNTypes'));
// output(SSNperADLs, named('SSNperADLs'));
// output(dedupSSNDIDs, named('dedupSSNDIDs'));

// output(TableMatchSSN, named('TableMatchSSN'));
// output(DIDMatchSSN, named('DIDMatchSSN'));
// output(AddSharedSSN, named('AddSharedSSN'));
// output(suspiciousSSNs, named('suspiciousSSNs'));
// output(SSNFlagsOrigSeq, named('SSNFlagsOrigSeq'));


RETURN(SSNFlagsOrigSeq);
END;
