import Business_Risk, Business_Header_SS, ut, Business_Header, BankruptcyV3, liensv2,
       RiskWise, YellowPages, Risk_indicators, corp2, LN_PropertyV2, ADVO, BusReg, doxie, EASI, Address_Attributes, header, mdr, drivers, Suppress, AML, STD;

EXPORT AMLAssocBusnAttrib(DATASET(AML.Layouts.AMLBusnAssocLayout) AssocBusn,
                                  $.IParam.IAml mod_aml
                                  ) := FUNCTION

mod_access := PROJECT(mod_aml, doxie.IDataAccess);

isFCRA := false;
min_score := 80;
min_addrscore := 70;
min_numscore := 90;
gScore(UNSIGNED1 i) := i BETWEEN min_score AND 100;
gaScore(UNSIGNED1 i) := i BETWEEN min_addrscore AND 100;
gnScore(UNSIGNED1 I) := i BETWEEN min_numscore AND 100;
tscore(UNSIGNED1 i) := IF(i>100,0,i);
unsigned tmax2(unsigned i1, unsigned i2) := map(i1 > 100 => if (i2 > 100, 0, i2),
                     i2 > 100 => if (i1 > 100, 0, i1),
                     i1 > i2 => i1,
                     i2);

glb_ok := mod_access.isValidGlb();
dppa_ok := mod_access.isValidDppa();

// highrisk address
AML.Layouts.AMLBusnAssocLayout hrtrans(AssocBusn l, risk_indicators.key_HRI_Address_To_SIC r) := transform
  baddrtype     := if (L.prim_name = '', '', risk_indicators.iid_constants.dwelltype(L.addr_type));
  self.hriskaddrflag := MAP(baddrtype = 'M' => '3',
             l.prim_name='' OR l.z5='' => '5',
             r.sic_code='' => '0',
             r.sic_code in ['2310','2300','2220','2280','2320'] => '4',
             '');
  self.dwelltype := Risk_Indicators.iid_constants.dwelltype(L.addr_type);
  self       := l;
  self      := [];
END;


AddrHRrecAssoc := join(AssocBusn, risk_indicators.key_HRI_Address_To_SIC,
                    right.dt_first_seen < left.historydate and
                    right.sic_code <>'' and
                    keyed(left.z5=right.z5) and
                    keyed(left.prim_name=right.prim_name) and
                    keyed(left.addr_suffix=right.suffix) and
                    keyed(left.predir=right.predir) and
                    keyed(left.postdir=right.postdir) and
                    keyed(left.prim_range=right.prim_range) and
                    keyed(left.sec_range=right.sec_range) ,
                    hrtrans(left,right),
                    left outer, keep(1), atmost(keyed(left.z5=right.z5) and
                                        keyed(left.prim_name=right.prim_name) and
                                        keyed(left.addr_suffix=right.suffix) and
                                        keyed(left.predir=right.predir) and
                                        keyed(left.postdir=right.postdir) and
                                        keyed(left.prim_range=right.prim_range) and
                                        keyed(left.sec_range=right.sec_range) , RiskWise.max_atmost));



// Business header

BusnHeader := Business_Header_SS.Key_BH_BDID_pl;


BusnHeadRec := join(AssocBusn(bdid!=0), BusnHeader,
                    Keyed(right.Bdid = left.AssocBdid) and
                    right.dt_first_seen < left.historydate AND 
                    doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
                    transform({recordof(BusnHeader), unsigned4 seq,  unsigned6 AssocBdid,  unsigned4  historydate},
                              self.seq := left.seq,
                              self.bdid := left.bdid,
                              self.historydate :=  left.historydate,
                              self.AssocBdid := left.AssocBdid,
                              self.dt_first_seen := if((unsigned)((STRING)right.dt_first_seen)[1..6]>0 and
                                                       ((unsigned)((STRING)right.dt_first_seen)[7..8]=0 or trim(((STRING)right.dt_first_seen)[7..8])=''),
                                                            (unsigned)(((string)right.dt_first_seen)[1..6]+'01'),
                                                            right.dt_first_seen),
                              self := right),
                    atmost(Keyed(right.Bdid = left.AssocBdid), RiskWise.max_atmost), left outer);

BusnHdrFirstSort := dedup(sort(BusnHeadRec(prim_name!=''and dt_first_seen<>0), seq,bdid,AssocBdid,dt_first_seen),seq,bdid, AssocBdid);  // get BusnHdrDtFirstSeen

AddBusnHdrFrstDt :=   join(AddrHRrecAssoc, BusnHdrFirstSort,
                         left.seq=right.seq and
                         left.bdid=right.bdid and
                         left.AssocBdid = right.AssocBdid,
                         transform(AML.Layouts.AMLBusnAssocLayout,
                              self.BusnHdrDtFirstSeen := right.dt_first_seen,
                              self := left),
                      left outer);

BusnHdrlastSort := dedup(sort(BusnHeadRec(dt_last_seen!=0), seq,bdid, AssocBdid,-dt_last_seen),seq, bdid, AssocBdid);  // get BusnHdrDtLastSeen

 AddBusnHdrDt :=   join(AddBusnHdrFrstDt, BusnHdrlastSort,
                         left.seq=right.seq and
                         left.bdid=right.bdid and
                         left.assocbdid = right.assocbdid,
                         transform(AML.Layouts.AMLBusnAssocLayout,
                              self.BusnHdrDtLastSeen := right.dt_Last_seen,
                              self := left),
                      left outer);


BusnHdrSrcSort := dedup(sort(BusnHeadRec(source!=''), seq,bdid,AssocBdid, source),seq,bdid, AssocBdid,source);

HdrSrcTable := table(BusnHdrSrcSort, {seq,bdid, AssocBdid, SrcCount := count(group)}, seq,bdid,AssocBdid);   // get src count

AddHdrSrcCnt := join(AddBusnHdrDt,HdrSrcTable,
                     left.seq=right.seq and
                     left.bdid=right.bdid and
                     left.AssocBdid = right.AssocBdid,
                     transform(AML.Layouts.AMLBusnAssocLayout,
                              self.srcCount := right.SrcCount,
                              self := left),
                     left outer);

BusnHdrAddrSort := dedup(sort(BusnHeadRec(prim_name!=''), seq,bdid, AssocBdid,prim_range,prim_name,addr_suffix,postdir, state, zip, dt_first_seen)
                            ,seq,bdid, AssocBdid,prim_range,prim_name,addr_suffix,postdir, state, zip);

HdrAddrTable := table(BusnHdrAddrSort, {seq,bdid, AssocBdid, AddrCount := count(group)}, seq,bdid, AssocBdid);  // get addr count

AddBusnHdrAddr := join(AddHdrSrcCnt, HdrAddrTable,
                       left.seq=right.seq and
                       left.bdid=right.bdid and
                       left.AssocBdid = right.AssocBdid,
                       transform(AML.Layouts.AMLBusnAssocLayout,
                              self.AddrCount := right.AddrCount,
                              self := left),
                       left outer);

LenInputAddr := join(AssocBusn,BusnHeadRec,
                     right.seq=left.seq and
                     right.bdid=left.bdid and
                     right.AssocBdid=left.AssocBdid and
                     right.prim_name = left.prim_name and
                     right.prim_range = left.prim_range and
                     right.predir = left.predir and
                     right.addr_suffix = left.addr_suffix and
                     right.postdir = left.postdir and
                     (string)right.zip = left.z5,
                     transform({recordof(BusnHdrAddrSort)},
                               self := right));


LenInputAddrSort := dedup(sort(LenInputAddr(prim_name!='' and dt_first_seen <>0), seq,bdid, AssocBdid,prim_range,prim_name,addr_suffix,postdir, state, zip, dt_first_seen)
                               ,seq,bdid, AssocBdid);

AML.Layouts.AMLBusnAssocLayout   addAddrLen(AddBusnHdrAddr le, LenInputAddrSort ri)  := TRANSFORM
  self.LengthInputAddr := ut.DaysApart((string)le.historydate,(string)ri.dt_first_seen);
  self := le;

END;

AddBusnAddrLen :=  join(AddBusnHdrAddr , LenInputAddrSort ,
                        left.seq=right.seq and
                        left.bdid=left.bdid and
                        left.AssocBdid=right.AssocBdid,
                        addAddrLen(left,right),
                        left outer);

//------------------check for 'good standing' ---------
corprec := record
  unsigned4 seq;
  unsigned4 historydate;
  string30  corp_key;
  unsigned6 bdid;
  unsigned6 Assocbdid;

end;

corprec get_corpkeys(AssocBusn L, corp2.key_Corp_bdid R) := transform
  self.seq := l.seq;
  self.corp_key := R.corp_key;
  self.historyDate := l.historyDate;
  self.bdid := l.bdid;
  self.Assocbdid := l.Assocbdid;
end;

corpkeys := join(AssocBusn, corp2.key_Corp_bdid,
          right.bdid != 0 and
          keyed(left.AssocBdid = right.bdid),
        get_corpkeys(LEFT,RIGHT), left outer, atmost(250));

corprec2 := record
  unsigned4  seq;
  unsigned6 assocbdid;
  corp2.key_corp_corpkey;
  unsigned4 historyDate;
  string corpStatus;
  boolean EverReinstat;
  boolean EverDissolution;
  boolean Reported90d;
  boolean contactChangeSOS;
  boolean addressChangeSOS;
  unsigned3 CorpStateCount;

end;

corprec2 get_corp_recs(corpkeys L, corp2.key_corp_corpkey R) := transform
  self.CorpStatus := if (l.corp_key ='', 'U', if (business_header.is_ActiveCorp(r.record_type, R.corp_status_cd, R.corp_status_desc), 'A',
              if (STD.Str.find(R.corp_status_desc, 'INACTIVE', 1) != 0, 'I',
              if (STD.Str.find(R.corp_status_desc, 'DISSOLVED', 1) != 0, 'D',
              if (STD.Str.find(R.corp_status_desc, 'REINSTATE', 1) != 0, 'R'
              ,'U')))));
  self.bdid := l.bdid;
  self.assocbdid :=  l.assocbdid;
  self := R;
  self := L;
  self := [];
end;




corprecs := join(corpkeys,  corp2.key_corp_corpkey,
                left.corp_key!='' and
                keyed(Left.corp_key = right.corp_key) and
                left.bdid = right.bdid,
                get_corp_recs(LEFT,RIGHT), ATMOST(keyed(Left.corp_key = right.corp_key),RiskWise.max_atmost), left outer, keep(100));

//  Current record status
corp_sortDD := dedup(sort(corprecs,seq, bdid, Assocbdid, if (business_header.is_ActiveCorp(record_type, corp_status_cd, corp_status_desc),0,1), if (corp_status_desc != '', 0, 1)),seq, bdid, Assocbdid);

AddBusnStatus := join(AddBusnAddrLen, corp_sortDD,
                      left.seq=right.seq and
                      left.bdid=right.bdid and
                      left.Assocbdid = right.Assocbdid,
                      transform(AML.Layouts.AMLBusnAssocLayout,
                                self.corpStatus := if(right.CorpStatus = '', 'U', right.CorpStatus),
                                self := left),
                      left outer);

corp_sort_all := sort(corprecs,seq, bdid, Assocbdid, corp_key, if (business_header.is_ActiveCorp(record_type, corp_status_cd, corp_status_desc),0,1), if (corp_status_desc != '', 0, 1));

corprec2 checkStatus(corp_sort_all le) := transform
  self.EverReinstat  := if(le.CorpStatus = 'R', 1,0);
  self.EverDissolution  := if(le.CorpStatus = 'D', 1,0);
  self.Reported90d   := ut.DaysApart((string)le.Dt_first_seen, (string)le.historydate) <= 90;
  self := le;
  self := []
end;

AllStatus := project(  corp_sort_all, checkStatus(left));

corprec2 rollStatus(AllStatus le, AllStatus ri) := transform
  self.EverReinstat  := if(le.EverReinstat, le.EverReinstat, ri.EverReinstat);
  self.EverDissolution  := if(le.EverDissolution, le.EverDissolution, ri.EverDissolution);
  self.Reported90d  := if(le.Reported90d, le.Reported90d, ri.Reported90d);
  self := le;
  self := []
end;

FinalStatus := rollup(AllStatus,
                      left.Assocbdid=right.Assocbdid and
                      left.seq=right.seq and
                      left.bdid=right.bdid ,
                      rollStatus(left,right));

AddBusnStatusEver := join(AddBusnStatus, FinalStatus,
                          left.seq=right.seq and
                          left.bdid=right.bdid and
                          left.Assocbdid=right.Assocbdid,
                          transform(AML.Layouts.AMLBusnAssocLayout,
                                    self.EverReinstat := right.EverReinstat,
                                    self.EverDissolution := right.EverDissolution,
                                    self  := left),
                          left outer);

// AddrChange
corprec2 checkAddrChng(corp_sort_all le, corp_sort_all ri) := transform
  self.addressChangeSOS     := if(ri.corp_address1_type_cd = 'B' and
                                  (le.corp_address1_line1   <> ri.corp_address1_line1  or
                                  le.corp_address1_line2  <>  ri.corp_address1_line2  or
                                  le.corp_address1_line3  <>  ri.corp_address1_line3  or
                                  le.corp_address1_line4  <>  ri.corp_address1_line4  or
                                  le.corp_address1_line5  <>  ri.corp_address1_line5), 1, 0);
  self := le;
  self := []
end;

AddrChange := rollup(corp_sort_all,
                      left.seq=right.seq and
                      left.bdid=right.bdid and
                      left.Assocbdid=right.Assocbdid,
                      checkAddrChng(left,right));

AddBusnAddrChng := join(AddBusnStatusEver, AddrChange,
                        left.seq=right.seq and
                        left.bdid=right.bdid and
                        left.Assocbdid=right.Assocbdid,
                        transform(AML.Layouts.AMLBusnAssocLayout,
                                self.addressChangeSOS := right.addressChangeSOS,
                                self  := left),
                        left outer);

// ContactChange
corprec2 checkContactChng(corp_sort_all le, corp_sort_all ri) := transform
  self.contactChangeSOS := if(ri.corp_address1_type_cd = 'T' and
                                          (le.corp_address1_line1  <>  ri.corp_address1_line1  or
                                          le.corp_address1_line2   <>  ri.corp_address1_line2  or
                                          le.corp_address1_line3   <>  ri.corp_address1_line3  or
                                          le.corp_address1_line4   <>  ri.corp_address1_line4  or
                                          le.corp_address1_line5   <>  ri.corp_address1_line5 ), 1, 0);
  self := le;
  self := []
end;

ContactChange := rollup(corp_sort_all,
                      left.seq=right.seq and
                      left.bdid=right.bdid and
                      left.Assocbdid=right.Assocbdid,
                      checkContactChng(left,right));

AddBusnContChng := join(AddBusnAddrChng, ContactChange,
                        left.seq=right.seq and
                        left.bdid=right.bdid and
                        left.Assocbdid=right.Assocbdid,
                        transform(AML.Layouts.AMLBusnAssocLayout,
                                self.contactChangeSOS := right.contactChangeSOS,
                                self  := left),
                          left outer);

CorpStTbl := table(corp_sort_all, {seq, bdid, Assocbdid, corp_inc_state}, seq, bdid, Assocbdid, corp_inc_state);
CorpStCount := table(CorpStTbl, {seq, bdid, Assocbdid, unsigned3 CorpStateCount := count(group)}, seq,bdid, Assocbdid);


AddBusnCorpSt := join(AddBusnContChng, CorpStCount,
                        left.seq=right.seq and
                        left.bdid=right.bdid and
                        left.Assocbdid=right.Assocbdid,
                        transform(AML.Layouts.AMLBusnAssocLayout,
                                self.CorpStateCount := right.CorpStateCount,
                                self  := left),
                          left outer);





//PROPERTY

kfs_nonFCRA  := LN_PropertyV2.key_search_fid(false);
kafid_nonFCRA  := LN_PropertyV2.key_assessor_fid(false);


proprec := Record
  unsigned6 AssocBdid;
  unsigned4 seq;
  unsigned4 historydate;
  string120 company_name ;
  string12 ln_fares_id;
  BOOLEAN applicant_owned;
  BOOLEAN applicant_sold;
  string2 source_code_1;
  string2 source_code_2;
  string120 cname;
  unsigned3 cmpymatch_score;
  unsigned3 CountSoldProp;
  unsigned3 CountOwnProp;
  string PurchaseDate;
  unsigned6 TaxAssdValue;
  recordof(LN_PropertyV2.key_search_fid()) - ln_fares_id - source_code_2 - source_code_1 - cname ;
  recordof(LN_PropertyV2.key_assessor_fid()) - ln_fares_id - process_date - vendor_source_flag - __internal_fpos__;

END;




proprec  checkCmpyMatch(AssocBusn  le, LN_PropertyV2.key_search_bdid ri)   := TRANSFORM

  self.AssocBdid := le.AssocBdid;
  self.seq := le.seq;
  self.historydate := le.historydate;
  self.company_name := le.company_name;
  self.ln_fares_id := ri.ln_fares_id;
  self := [];
END;

BusnProp := join(AssocBusn , LN_PropertyV2.key_search_bdid ,
                Keyed(left.AssocBdid=right.s_bid)
                and right.ln_fares_id <> '',
                checkCmpyMatch(left,right),
                left outer, atmost(RiskWise.max_atmost));

proprec  getSearch_nonFCRA(BusnProp le, kfs_nonFCRA ri)   := TRANSFORM
  cmpymatch_score   := Business_Risk.CnameScore(le.company_name, ri.cname);
  cmpymatch     := gScore(cmpymatch_score);
  self.AssocBdid := le.AssocBdid;
  self.seq := le.seq;
  self.cmpymatch_score := cmpymatch_score;
  self.company_name := le.company_name;
  self.ln_fares_id := le.ln_fares_id;
  self.source_code_1 := ri.source_code_1;
  self.source_code_2 := ri.source_code_2;
  self.cname := ri.cname;
  SELF.applicant_owned :=  cmpymatch and ri.source_code_2='P' and ri.source_code_1 = 'O';
  SELF.applicant_sold := ri.source_code_1='S' AND cmpymatch and ri.source_code_2='P' ;
  self.historydate := le.historydate;

  self := ri;
  self := [];
END;

property_searched :=  JOIN(BusnProp, kfs_nonFCRA, //search_fid
                keyed(LEFT.ln_fares_id=RIGHT.ln_fares_id) AND
                wild(right.which_orig) and
                keyed(RIGHT.source_code_2='P'),

                getSearch_nonFCRA(LEFT,RIGHT),LEFT OUTER,
                ATMOST(
                  keyed(LEFT.ln_fares_id=RIGHT.ln_fares_id) AND
                  wild(right.which_orig) and
                  keyed(RIGHT.source_code_2='P'),
                  RiskWise.max_atmost
                 ));

AssocOwnProp := property_searched(applicant_owned);
AssocSoldProp := property_searched(applicant_sold);


AssocownPropDD := dedup(sort(AssocOwnProp, seq, AssocBdid, prim_range, prim_name, predir,suffix,postdir, zip),
                         seq, AssocBdid, prim_range, prim_name, predir,suffix,postdir, zip);

AssocSoldPropDD := dedup(sort(AssocSoldProp, seq, AssocBdid, prim_range, prim_name, predir,suffix,postdir, zip),
                        seq, AssocBdid, prim_range, prim_name, predir,suffix,postdir, zip);

owned_prop := join(AssocownPropDD, AssocSoldPropDD,
                    left.prim_range = right.prim_range and
                    left.prim_name = right.prim_name and
                    left.suffix = right.suffix and
                    left.postdir = right.postdir and
                    left.st = right.st and
                    left.p_city_name = right.p_city_name and
                    left.zip = right.zip,
                    transform(recordof(left), self := left),
                    left only);

AssocCountOwnProp := table(AssocownPropDD, {seq, AssocBdid, OwnPropCnt := count(group)}, seq, AssocBdid) ;
AssocCountSoldProp := table(AssocSoldPropDD, {seq, AssocBdid, SoldPropCnt := count(group)}, seq, AssocBdid) ;


PropTaxValue :=   join(property_searched, kafid_nonFCRA, // assessor fid
                  Keyed(left.ln_fares_id = right.ln_fares_id )and
                  (unsigned4)right.tax_year <= (unsigned4)(((string)left.historydate)[1..4])
                  AND (unsigned4)right.assessed_value_year <= (unsigned4)(((string)left.historydate)[1..4])
                  AND (unsigned4)right.market_value_year <= (unsigned4)(((string)left.historydate)[1..4])
                  AND (unsigned4)right.sale_date[1..6] <= (unsigned4)left.historydate
                  AND (unsigned4)right.recording_date[1..6] <= (unsigned4)left.historydate,

                  transform(proprec,
                  SELF.PurchaseDate := if((integer)right.sale_date=0, right.recording_date, right.sale_date)  ,
                  self.AssocBdid:=left.AssocBdid,
                  self.seq :=left.seq,
                  self.taxAssdValue := if((unsigned)right.assessed_total_value = 0, (unsigned)right.market_total_value, (unsigned)right.assessed_total_value),
                  self := right,
                  self := left),
                  left outer, ATMOST(keyed(LEFT.LN_fares_id=RIGHT.ln_fares_id), RiskWise.max_atmost));

RemoveZeroValues := PropTaxValue(Trim(assessed_total_value)<>'' and trim(market_total_value)<>'');


PropTaxValueDD :=  dedup(sort(RemoveZeroValues, seq, AssocBdid, prim_range, prim_name, predir,suffix,postdir, zip, -assessed_value_year, -PurchaseDate, taxAssdValue),
                         seq, AssocBdid, prim_range, prim_name, predir,suffix,postdir, zip);




proprec  RollPropTaxValue(PropTaxValueDD le,PropTaxValueDD ri) := Transform
   self.seq  := le.seq;
   self.AssocBdid := le.AssocBdid;
   self.TaxAssdValue  := le.TaxAssdValue + ri.TaxAssdValue;
   self := le;
END;


BusnPropTaxRolled := rollup(PropTaxValueDD,
                      left.AssocBdid=right.AssocBdid and left.seq=right.seq,
                      RollPropTaxValue(LEFT,RIGHT));

AddBusnPropValue := join(AddBusnCorpSt, BusnPropTaxRolled,
                     left.seq=right.seq and
                     left.AssocBdid=right.AssocBdid,
                     transform(AML.Layouts.AMLBusnAssocLayout,
                             self.PropTaxValue := right.TaxAssdValue,
                             self.CountSoldProp := right.CountSoldProp;
                             self.CountOwnProp := right.CountOwnProp;
                             self  := left),
                     left outer);

FirstProp := dedup(sort(PropTaxValueDD, seq ,AssocBdid,if(PurchaseDate='','999999', purchaseDate) ), seq, AssocBdid);  // need first prop and value

AddBusnFirstProp := join(AddBusnPropValue, FirstProp,
                     left.seq=right.seq and
                     left.AssocBdid=right.AssocBdid,
                     transform(AML.Layouts.AMLBusnAssocLayout,
                             self.FirstPurchaseDate := (unsigned4)right.PurchaseDate,
                             self.FirstPropTaxValue := if((unsigned)right.assessed_total_value = 0, (unsigned)right.market_total_value, (unsigned)right.assessed_total_value),
                             self  := left),
                    left outer);

AddPropSoldCount  := join(AddBusnFirstProp, AssocCountSoldProp,
                      left.seq=right.seq and left.AssocBdid=right.AssocBdid,
                      transform(AML.Layouts.AMLBusnAssocLayout,
                                self.CountSoldProp := right.SoldPropCnt,
                                self := left),
                      left outer);

AddPropOwnCount  := join(AddPropSoldCount, AssocCountOwnProp,
                      left.seq=right.seq and left.AssocBdid=right.AssocBdid,
                      transform(AML.Layouts.AMLBusnAssocLayout,
                                self.CountOwnProp := right.OwnPropCnt,
                                self := left),
                      left outer);

//end property

// easi census

  Layout_EasiSeq := record
    unsigned4 seq := 0;
    unsigned6 bdid;
    unsigned6 assocBdid;
    EASI.Layout_Easi_Census easi;
  END;
// keep totcrime
  easi_census := join(AssocBusn, Easi.Key_Easi_Census,
    keyed(right.geolink=left.st+left.county+left.geo_blk),
    transform(Layout_EasiSeq,
      self.bdid := left.bdid,
      self.assocBdid := left.assocBdid,
      self.seq := left.seq,
      self.easi.state := left.st,
      self.easi.tract := left.geo_blk[1..6],
      self.easi.blkgrp := left.geo_blk[7],
      self.easi.county :=  left.county,
      self.easi.geo_blk := left.geo_blk,
      self.easi := right
    ),
    ATMOST(keyed(right.geolink=left.st+left.county+left.geo_blk), Riskwise.max_atmost), KEEP(1));

AddBusnEasi := join(AddPropOwnCount, easi_census,
               left.seq=right.seq and
               left.bdid=right.bdid and
               left.assocBdid = right.assocBdid,
               transform(AML.Layouts.AMLBusnAssocLayout,
                         self.EasiTotCrime := right.easi.totCrime,
                         self  := left),
               left outer);

// end easi

// SICS

with_sics := JOIN(AssocBusn,Business_header.key_sic_code,
                KEYED(left.Assocbdid = right.bdid) and
                right.sic_code <> '' and
                (right.sic_code[1..4] in AML.AMLConstants.setHRBusCatgSicCds or
                right.sic_code in AML.AMLConstants.setHRBusFullSicCds),
                transform(AML.Layouts.AMLBusnAssocLayout,
                          self.bdid := left.bdid,
                          self.Assocbdid := left.Assocbdid,
                          self.seq := left.seq,
                          self.HRBusiness := if(right.sic_code[1..4] in AML.AMLConstants.setHRBusCatgSicCds or
                                                right.sic_code in AML.AMLConstants.setHRBusFullSicCds, 1, 0);
                          self:= left),
                atmost(riskwise.max_atmost),
                left outer, keep(1));



AddBusnSIC := join(AddBusnEasi, with_sics,
               left.seq=right.seq and
               left.bdid=right.bdid and
               left.AssocBdid=right.AssocBdid,
               transform(AML.Layouts.AMLBusnAssocLayout,
                         self.HRBusiness := right.HRBusiness,
                         self  := left),
               atmost(riskwise.max_atmost),left outer);


AssocwithNaics := join(AddBusnSIC,  YellowPages.Key_YellowPages_BDID,
                        left.bdid != 0 and
                        keyed(left.Assocbdid = right.bdid) and
                        right.naics_code <> '' and
                        right.naics_code in AML.AMLConstants.setHRNAICSCodes,
                        transform(AML.Layouts.AMLBusnAssocLayout,
                                    self.HRBusiness := if(right.naics_code in AML.AMLConstants.setHRNAICSCodes and
                                                          ~left.HRBusiness, 1,(integer)left.HRBusiness);
                                    self := left),
                atmost(riskwise.max_atmost), LEFT OUTER      ,keep(1));

// suspicious events

bans_bdid := BankruptcyV3.key_bankruptcyV3_bdid();

bkrupt_slim := record
  string bk_tmsid;
  string  court_code;
  string  case_number;
  unsigned6 bdid;
  unsigned6 Assocbdid;
  unsigned4  seq;
  unsigned4 historydate;

end;

bkrupt_slim get_bankruptcies(AssocBusn L, recordof(bans_bdid) R) := transform
  self.seq := L.seq;
  self.bdid := L.bdid;
  self.Assocbdid := L.Assocbdid;
  self.bk_tmsid := R.tmsid;
  self.court_code := R.court_code;
  self.case_number := R.case_number;
  self.historydate := l.historydate;
end;

bk_keys := join(AssocBusn, bans_bdid,
      left.Assocbdid != 0 and
      keyed(left.Assocbdid = right.p_bdid),
      get_bankruptcies(LEFT,RIGHT), keep(100));

bk_search := BankruptcyV3.key_bankruptcyv3_search_full_bip();
bkrec := record
  recordof(bk_search);
  unsigned4  seq;

  unsigned4 BK12Count;
  unsigned4 BKCount;
  unsigned4 historydate;
end;

bkrec get_bkrupt_info(bk_keys L, recordof(bk_search) R) := transform
  self.seq := L.seq;
  self.historydate := l.historydate;

  self := R;
  self := [];
end;

bkrecs := join(bk_keys, bk_search,
        keyed(left.bk_tmsid = right.tmsid) and
        right.name_type='D' and   // business should be debtor
        (unsigned6)left.Assocbdid=(unsigned6)right.bdid and
        (unsigned4)right.date_filed <= left.historydate,
        get_bkrupt_info(LEFT,RIGHT), keep(100));



bkrec countBK(bkrecs L) := transform
  self.seq := L.seq;
  self.BK12Count :=  if ((integer)l.date_filed != 0 and ut.DaysApart(l.date_filed,(string)l.historydate)<=365 , 1, 0);
  self.BKCount :=  if (l.date_filed != '' and l.cname != '' , 1, 0);
  self := l;
end;

BusnCountBKs := project(bkrecs, countBK(LEFT));

bkrec roll_and_countBK(BusnCountBKs L, BusnCountBKs R) := transform
  self.seq := L.seq;
  self.BK12Count := l.BK12Count + r.BK12Count;
  self.BKCount := l.BKCount + r.BKCount;
  self := l;
end;

BusnBKsRolled := rollup(sort(BusnCountBKs,seq,bdid),
                      left.bdid=right.bdid and
                      left.seq=right.seq ,
                      roll_and_countBK(LEFT,RIGHT));


AML.Layouts.AMLBusnAssocLayout fill_in_bkrupt(AssocwithNaics L, BusnBKsRolled R) := transform
  self.BKcount        := R.BKCount;
  self.BKcount12      := r.BK12Count;
  self := L;
end;

wBKs := join(AssocwithNaics,  BusnBKsRolled,
            left.seq = right.seq and
            left.Assocbdid = (unsigned6)right.bdid,
            fill_in_bkrupt(LEFT,RIGHT),
            left outer, many lookup);


bdidLiens :=  liensv2.key_liens_bdid;
DIDContacts := join(AssocBusn, Business_Header.Key_Business_Contacts_BDID,
                    right.did != 0 and
                    keyed(left.assocBdid=right.bdid),
                    transform({unsigned6 assocBdid, unsigned did, unsigned4 seq, unsigned4 historydate},
                              self.assocBdid:=left.assocBdid, self.did:=right.did,
                                self.seq:=left.seq, self.historydate := left.historydate),
                    left outer, atmost(RiskWise.max_atmost));

DIDContDD := dedup(sort(DIDContacts, seq,assocBdid,did), seq,assocBdid,did);

Risk_indicators.layouts.layout_derogs_input  GetDerogs(DIDContDD le) := TRANSFORM
   self.seq := le.seq;
   self.historydate := (unsigned3)((string)le.historydate)[1..6];
   self.did  := le.did;
   self.isrelat := true;
   self := [];
End;

DerogIds := project(group(sort(DIDContDD, seq, did),seq,did), GetDerogs(left));

DerogsContacts := Risk_Indicators.Boca_Shell_Derogs_Hist(DerogIds, mod_aml.bs_version);

DerogsContBDID := join(DIDContDD, DerogsContacts,
                       left.did = right.did and
                       left.seq = right.seq,
                       transform({unsigned6 assocBdid, recordof(DerogsContacts)},
                                 self.assocBdid := left.assocBdid,
                                 self      := right),
                                 left outer);

DerogSlim := Record
  unsigned4  seq;
  unsigned6  assocBdid;
  unsigned4 historydate;
  unsigned4 RepFelonyCnt;
  unsigned4 RepFelonyCnt12;
  unsigned4 RepFelonyCnt2to5yr;
  unsigned4 RepFelonyCnt5plus;
  unsigned4 RepMinorEventCnt;
  unsigned3 RepMinorCnt12;
END;


 DerogSlim  countDerogs(DerogsContBDID le) := Transform
    self.assocBdid  := le.assocBdid;
    self.seq   := le.seq;
    self.historydate := le.historydate;
    self.RepFelonyCnt12       :=  le.BJL.criminal_count12;
    self.RepFelonyCnt2to5yr   :=  le.BJL.criminal_count60 - le.BJL.criminal_count12;
    self.RepFelonyCnt5plus    :=  le.BJL.felony_count - le.BJL.criminal_count60;
    self.RepMinorEventCnt   := (le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count +
                             le.bjl.liens_historical_released_count + le.bjl.liens_recent_released_count  +
                             le.bjl.eviction_count );
    self.RepFelonyCnt := le.bjl.Felony_count;
    self.RepMinorCnt12         := if((le.bjl.liens_unreleased_count12 + le.bjl.liens_released_count12 + le.bjl.eviction_count12) between 6 and 9, 1, 0);
END;

RepLegalEvents := project(DerogsContBDID, countDerogs(left));


 DerogSlim  RollRepDerogs(RepLegalEvents le, RepLegalEvents ri) := Transform
    self.assocBdid  := le.assocBdid;
    self.seq   := le.seq;
    self.historydate := le.historydate;
    self.RepMinorEventCnt   := le.RepMinorEventCnt + ri.RepMinorEventCnt;
    self.RepFelonyCnt := le.RepFelonyCnt  + ri.RepFelonyCnt;
    self.RepFelonyCnt12 := le.RepFelonyCnt12  + ri.RepFelonyCnt12;
    self.RepFelonyCnt2to5yr := le.RepFelonyCnt2to5yr  + ri.RepFelonyCnt2to5yr;
    self.RepFelonyCnt5plus := le.RepFelonyCnt5plus  + ri.RepFelonyCnt5plus;
    self.RepMinorCnt12  := le.RepMinorCnt12 + ri.RepMinorCnt12;
END;

RepLegalEventsRolled  :=  rollup(sort(RepLegalEvents,seq, assocBdid),left.assocBdid=right.assocBdid and left.seq=right.seq,
                            RollRepDerogs(LEFT,RIGHT));


AddRepContDerogs := join( wBKs ,RepLegalEventsRolled,
                      left.seq=right.seq and
                      left.assocBdid=right.assocBdid,
                      transform(AML.Layouts.AMLBusnAssocLayout,
                         self.RepFelonyCnt := right.RepFelonyCnt,
                         self.RepMinorEventCnt := right.RepMinorEventCnt,
                         self.RepMinorCnt12 := right.RepMinorCnt12,
                         self.RepFelonyCnt5plus := right.RepFelonyCnt5plus,
                         self.RepFelonyCnt2to5yr := right.RepFelonyCnt2to5yr,
                         self.RepFelonyCnt12 := right.RepFelonyCnt12,
                         self  := left,
                         self := []),
                      left outer);


//--------------------- Get Liens Info ----------------

lienrec := record
  unsigned4  seq := 0;
  unsigned4 historydate;
  unsigned6   assocBdid := 0;
  string50 tmsid := '';
  string50 rmsid := '';
  unsigned2  cnt_rel12 := 0;
  unsigned2  cnt_rel := 0;
  unsigned2  cnt_unrel12 := 0;
  unsigned2  cnt_unrel := 0;
  unsigned4 lien_total := 0;
  string120 def_company := '';
  string50 address := '';
  string25 orig_city := '';
  string2 orig_state := '';
  string5 orig_zip := '';
  string4 zip4 := '';
  string8 filing_date := '';
  string8 release_date := '';
  string name_type := '';
  string50 filingtype_desc := '';
end;

lienrec get_lien_rmsid(AddRepContDerogs L, liensv2.key_liens_bdid R) := transform
  self.seq := L.seq;
  self.historydate := l.historydate;
  self.assocBdid := L.assocBdid;
  self.rmsid := R.rmsid;
  self.tmsid := R.tmsid;
  self := [];
end;

rmsids := join(AddRepContDerogs,   liensv2.key_liens_bdid,
        left.assocBdid != 0 and
        keyed(left.assocBdid = right.p_bdid),
        get_lien_rmsid(LEFT,RIGHT), keep(100));


{lienrec, unsigned4 global_sid, unsigned6 did} get_liens(rmsids L, liensv2.key_liens_party_ID R) := transform
  self.global_sid := R.global_sid;
  self.did := (unsigned6)R.did;
  self.seq := L.seq;
  self.historydate := l.historydate;
  self.assocBdid := L.assocBdid;
  self.tmsid := l.tmsid;
  self.rmsid := r.rmsid;
  self.cnt_rel := if ((integer)R.date_last_seen != 0, 1, 0);
  self.cnt_unrel := if (self.cnt_rel = 0, 1, 0);
  self.def_company := r.cname;
  self.address := r.orig_address1;
  self.orig_city := r.orig_city;
  self.orig_state := r.orig_state;
  self.orig_zip := r.orig_zip5;
  self.zip4 := r.orig_zip4;
  self.filing_date := r.date_first_seen;
  self.release_date := r.date_last_seen;
  self.name_type := r.name_type;
  self.lien_total := 0;  // comes from main
  self.filingtype_desc := '';  // comes from main
  self := [];
end;

liensrecs1_unsuppressed := join(rmsids, liensv2.key_liens_party_ID,
        keyed(left.rmsid = right.rmsid) and
        keyed(left.tmsid = right.tmsid) and
        left.assocBdid = (unsigned)right.bdid and  // for cases with multiple debtors, make sure to only include the party records that match on bdid
        right.name_type='D' and
        (unsigned4)right.date_first_seen < left.historydate,
         get_liens(LEFT,RIGHT),
         atmost( (keyed(left.rmsid=right.rmsid) and keyed(left.tmsid=right.tmsid)), riskwise.max_atmost), keep(100));
liensrecs1 := Suppress.Suppress_ReturnOldLayout(liensrecs1_unsuppressed, mod_access, lienrec);
lienrec get_liens_main(liensrecs1 L, liensv2.key_liens_main_ID R) := transform
  self.lien_total := (integer)R.amount;
  self.filingtype_desc := r.filing_type_desc;
  self.filing_date := if((integer)L.filing_date=0 and (integer)R.filing_date!=0, r.filing_date, l.filing_date);
  self := L;
end;

liensrecs := join(liensrecs1,  liensv2.key_liens_main_ID,
        keyed(left.rmsid = right.rmsid) and
        keyed(left.tmsid = right.tmsid) and
        (integer)right.amount > 0 and
        (unsigned4)right.orig_filing_date < left.historydate,
         get_liens_main(LEFT,RIGHT),
         atmost( (keyed(left.rmsid=right.rmsid) and keyed(left.tmsid=right.tmsid)), riskwise.max_atmost), keep(100));


lienrec roll_and_count(liensrecs L, liensrecs R) := transform
  self.seq := L.seq;
  self.cnt_rel12 := L.cnt_rel12 + if ((integer)R.release_date != 0 and ut.DaysApart(R.release_date,(string)R.historydate)<=365 , 1, 0);
  self.cnt_rel := L.cnt_rel + if ((integer)R.release_date != 0, 1, 0);
  self.cnt_unrel12 := L.cnt_unrel12 + if ((integer)R.release_date != 0 and ut.DaysApart(R.release_date,(string)R.historydate)<=365 , 1, 0);
  self.cnt_unrel := L.cnt_unrel + if ((integer)R.release_date != 0, 0, 1);
  self.def_company := if (L.def_company = '', R.def_company, L.def_company);
  self.lien_total := L.lien_total + R.lien_total;
  self.filingtype_desc := if (L.filingtype_desc = '', R.filingtype_desc, L.filingtype_desc);
  self := if (L.filing_date = '' or (integer)L.filing_date < (integer)R.filing_date, R, L);
end;

lrecs_srt_ddp := rollup(sort(liensrecs,seq,assocbdid, -(if (filing_date = '', '0000000', filing_date)), if (def_company ='', 1, 0)),
                        left.seq=right.seq and
                        left.assocbdid=right.assocbdid,
                        roll_and_count(LEFT,RIGHT));


AML.Layouts.AMLBusnAssocLayout  AddBusnLiensCnts(AddRepContDerogs le,lrecs_srt_ddp ri)  := Transform
      self.UnreleasedLienCount := ri.cnt_unrel;
      self.ReleasedLienCount  := ri.cnt_rel;
      self.UnreleasedLienCount12 := ri.cnt_unrel12;
      self.ReleasedLienCount12  := ri.cnt_rel12;
      self := le;
END;

AddBusnLiens :=   join( AddRepContDerogs ,lrecs_srt_ddp  ,
                      left.seq=right.seq and
                      left.assocBdid=right.assocBdid,
                      AddBusnLiensCnts(left,right),
                      left outer);



//  Rep is incarcerated

Rep_slim := record
  unsigned3   seq;
  unsigned4   historydate;
  unsigned6   did;
  unsigned6   assocBdid;
  STRING20    fname;
  STRING20    lname;
  string10    prim_range;
  string2     predir;
  string28    prim_name;
  string4     addr_suffix;
  string2     postdir;
  string10    unit_desig;
  string8     sec_range;
  string25    city_name;
  string2     st := '';
  string5     zip5 := '';
  unsigned4   dt_first_seen;
  unsigned4   dt_last_seen;
  boolean     RepisIncarcerated;
  string1     RepPossIncarcerated;
  unsigned3   RepIncarceratedCnt;
end;

{Rep_slim, unsigned4 global_sid} getRepHdr(DIDContDD le, doxie.Key_Header ri) :=
TRANSFORM
  self.global_sid := ri.global_sid;
  self.assocBdid  := le.assocBdid;
  self.did   := le.did;
  self.fname  := ri.fname;
  self.lname  := ri.lname;
  SELF.prim_range := ri.prim_range;
  SELF.predir := ri.predir;
  SELF.prim_name := ri.prim_name;
  SELF.addr_suffix := ri.suffix;
  SELF.postdir := ri.postdir;
  SELF.unit_desig := ri.unit_desig;
  SELF.sec_range := ri.sec_range;
  SELF.city_name := ri.city_name;
  SELF.zip5 := ri.zip;
  SELF.st := ri.st;
  SELF.dt_first_seen := ri.dt_first_seen;
  SELF.dt_last_seen :=  ri.dt_last_seen;
  SELF := le;
  // SELF := ri;
  SELF := [];

END;


DIDContHdr_unsuppressed :=   join(DIDContDD, doxie.Key_Header,
                            keyed(LEFT.did=RIGHT.s_did) AND
                            right.src not in risk_indicators.iid_constants.masked_header_sources(mod_access.DataRestrictionMask, isFCRA) AND
                            RIGHT.dt_first_seen < (unsigned3)((string)left.historydate)[1..6] AND
                            (header.isPreGLB(RIGHT) OR glb_ok) AND
                            (~mdr.Source_is_DPPA(RIGHT.src) OR
                              (dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),mod_access.dppa,RIGHT.src))) AND
                            ~risk_indicators.iid_constants.filtered_source(right.src, right.st),
                            getRepHdr(LEFT,RIGHT), LEFT OUTER,atmost(RiskWise.max_atmost), keep(100));

DIDContHdr_flagged := Suppress.MAC_FlagSuppressedSource(DIDContHdr_unsuppressed, mod_access);

DIDContHdr := PROJECT(DIDContHdr_flagged, TRANSFORM(Rep_slim,
  self.fname  := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.fname);
  self.lname  := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.lname);
  SELF.prim_range := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.prim_range);
  SELF.predir := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.predir);
  SELF.prim_name := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.prim_name);
  SELF.addr_suffix := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.addr_suffix);
  SELF.postdir := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.postdir);
  SELF.unit_desig := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.unit_desig);
  SELF.sec_range := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.sec_range);
  SELF.city_name := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.city_name);
  SELF.zip5 := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.zip5);
  SELF.st := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.st);
  SELF.dt_first_seen := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_first_seen);
  SELF.dt_last_seen :=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_last_seen);
    SELF := LEFT;
));

DIDContHdrDS  :=   dedup(sort(DIDContHdr(dt_last_seen<>0 and prim_name<>''), seq, did, -dt_last_seen),
                            seq, did);


Rep_slim getSICCode(DIDContHdrDS le, risk_indicators.key_HRI_Address_To_SIC ri) := TRANSFORM
     self.RepisIncarcerated := if(trim(ri.sic_code)='2225', true, false);
     self := le;
     self := [];
END;

PrepHdrSIC := join(DIDContHdrDS,risk_indicators.key_HRI_Address_To_SIC,
        left.zip5!='' and left.prim_name != '' and
        keyed(left.zip5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and
        keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
        keyed(left.sec_range=right.sec_range) AND
        trim(right.sic_code)='2225' and
        // check date
        right.dt_first_seen < (unsigned3)((string)left.historydate)[1..6],
        getSICCode(left,right),left outer,
        ATMOST(keyed(left.zip5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and
            keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
            keyed(left.sec_range=right.sec_range), RiskWise.max_atmost), keep(1));

JustIds :=  project(DIDContDD,  transform(doxie.layout_references,
                                         self.did := left.did));

PossIncarceration :=  Risk_Indicators.Collection_Shell_MOD.getIncarceration(JustIds);

idsPosIncar :=  join(PrepHdrSIC, PossIncarceration,
                     left.did=right.did,
                     transform(Rep_slim,
                              self.RepPossIncarcerated := if((string)right.incarceration_flag='', '0', right.incarceration_flag) ,
                              self := left),
                    left outer);

Rep_slim  countIncarcerations(idsPosIncar le) := Transform
    self.assocBdid  := le.assocBdid;
    self.seq   := le.seq;
    self.historydate := le.historydate;
    self.RepIncarceratedCnt  := If(le.RepPossIncarcerated = '1' or le.RepisIncarcerated, 1, 0);
    self := le;

END;

RepIncarceration := sort(project(idsPosIncar, countIncarcerations(left)),seq, assocBdid);

Rep_slim  rollIncarcerations(RepIncarceration L, RepIncarceration R) := transform
  self.seq := L.seq;
  self.assocBdid  := l.assocBdid;
  self.RepIncarceratedCnt := l.RepIncarceratedCnt + r.RepIncarceratedCnt;
  self := l;
end;

BusnIncarRolled := rollup(RepIncarceration,
                      left.assocBdid=right.assocBdid and
                      left.seq=right.seq,
                      rollIncarcerations(LEFT,RIGHT));

AML.Layouts.AMLBusnAssocLayout IncarcerationAdd(wBKs L, BusnIncarRolled R) := transform

  self.RepIncarceratedCnt    := R.RepIncarceratedCnt;
  self := L;
end;

AddIncarceration :=  join(AddBusnLiens, BusnIncarRolled,
                      left.assocBdid=right.assocBdid and
                      left.seq=right.seq,
                          IncarcerationAdd(left, right),
                          left outer);


// relatives suspicious events


//ADVO

AdvoKey := Advo.Key_Addr1_history;

withAdvo := join(AssocBusn, Advo.Key_Addr1_history,

          left.z5 != '' and
          left.prim_name != '' and
          keyed(left.z5 = right.zip) and
          keyed(left.prim_range = right.prim_range) and
          keyed(left.prim_name = right.prim_name) and
          keyed(left.addr_suffix = right.addr_suffix) and
          keyed(left.predir = right.predir) and
          keyed(left.postdir = right.postdir) and
          keyed(left.sec_range = right.sec_range)  and
          ((unsigned4)RIGHT.date_first_seen < left.historydate),
          transform({recordof(AdvoKey), unsigned4 seq, unsigned6 assocBdid},
                     self.seq := left.seq,
                     self.assocBdid := left.assocBdid,
                     self := right)
                      ,atmost(riskwise.max_atmost));

withAdvo1DDVac :=  dedup(sort(withAdvo, seq, assocBdid, zip,prim_range, prim_name, addr_suffix, predir, postdir, sec_range, -date_first_seen),
                              seq, assocBdid,  zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range  );



AddBusnADVO :=   join( AddIncarceration, withAdvo1DDVac,
                      left.seq=right.seq and
                      left.assocBdid=right.assocBdid,
                      transform(AML.Layouts.AMLBusnAssocLayout,
                                self.AddressVacancyInd := if(right.Address_Vacancy_Indicator = '', 'U', right.Address_Vacancy_Indicator),
                                self := left),
                      left outer);

withAdvo1DDFir :=  dedup(sort(withAdvo, seq, assocBdid, zip,prim_range,  prim_name, addr_suffix, predir, postdir, sec_range, date_first_seen)
                              ,seq, assocBdid,  zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range  );

AddBusnFrstADVO :=   join( AddBusnADVO ,withAdvo1DDFir  ,
                      left.seq=right.seq and
                      left.assocBdid=right.assocBdid,
                      transform(AML.Layouts.AMLBusnAssocLayout,
                                self.AdvoFirstSeenDt  := (integer)right.date_first_seen,
                                self := left),
                      left outer);

//end ADVO

//EMPLOYEE COUNT

BusReg := BusReg.key_busreg_company_bdid;   //get emp size

busRegRecs := join(AddBusnFrstADVO, BusReg,
                left.assocBdid = right.Bdid and
                right.bdid!=0,
               transform({recordof(BusReg), unsigned4 seq},
                          self.seq := left.seq,
                          self :=  right),
               left outer);

busRegRecsSD := dedup(Sort(busRegRecs, seq, bdid, -dt_last_seen  ), seq, bdid);


AML.Layouts.AMLBusnAssocLayout GetbusnEmpCnt(  AddBusnFrstADVO le, busRegRecsSD ri ) := transform
                         self.EmpCount := (unsigned3)ri.emp_size;
                         self :=   le;
END;

AddbusnEmpCnt := join(AddBusnFrstADVO, busRegRecsSD,
              left.assocBdid = right.Bdid and
              left.seq = right.seq ,
              GetbusnEmpCnt(left,right),
              left outer);


RickBdidKey := Address_Attributes.key_business_risk_bdid  ;

AML.Layouts.AMLBusnAssocLayout GetBusnShelf(  AddBusnFrstADVO le, RickBdidKey ri ) := transform
        self.ShellShelfBusn := (unsigned3)ri.potential_shelf_address;
        self :=   le;
END;

AddBusnShelf := join(AddBusnEmpCnt, RickBdidKey,
                left.assocBdid = right.Bdid ,
                GetBusnShelf(left,right),
                left outer);

// crime geolink
crimeGeolink := Address_Attributes.key_crime_geolink;

  GeoCrime := join(AddBusnShelf, crimeGeolink,
    keyed(right.geolink=left.st+left.county+left.geo_blk),
    transform({recordof(crimeGeolink), unsigned4 seq, unsigned6 assocBdid},

            self.seq := left.seq;
            self.assocBdid := left.assocBdid;
            self := right;
            self := [];
    ), left outer,
    ATMOST(keyed(right.geolink=left.st+left.county+left.geo_blk), Riskwise.max_atmost), KEEP(1));

AddGeoCrime  :=  join(AddBusnShelf, GeoCrime,
                        left.seq=right.seq
                        and left.assocBdid=right.assocBdid,
                        transform(AML.Layouts.AMLBusnAssocLayout,
                                   self.HighFelonNeighborhood := 100 * right.felon_ratio > 8,
                                   self := left),
                        atmost(Riskwise.max_atmost), left outer);

addAssocHRBusiness :=  join(AddGeoCrime, Address_Attributes.key_business_risk_geolink,
                        keyed(right.geolink=left.st+left.county+left.geo_blk),
                        transform(AML.Layouts.AMLBusnAssocLayout,
                                   Self.HRBusPct :=if(((right.cnt_shell+right.cnt_shelf) / right.cnt_businesses)>= .1, TRUE, FALSE),
                                   self := left),
                        atmost(Riskwise.max_atmost),
                        left outer);



Return addAssocHRBusiness;

END;
