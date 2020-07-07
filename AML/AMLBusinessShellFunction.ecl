import Business_Risk, Business_Header_SS, ut, Business_Header, BankruptcyV3, liensv2,
       RiskWise, YellowPages, Risk_indicators, corp2, LN_PropertyV2, ADVO, BusReg, doxie, EASI,
       Address_Attributes, drivers, mdr, header, std, Suppress, AML;

EXPORT AMLBusinessShellFunction(DATASET(Business_Risk.Layout_Input) indata,
                                $.IParam.IAml mod_aml,
                                boolean NegNewsFlg) := FUNCTION

appends := 'BEST_ALL';
verify := 'BEST_ALL';
thresh_num := 0;
bdids_to_keep := 1;

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

// define synonyms for convenience -- until we're able to pass mod_access all the way.
mod_access := PROJECT(mod_aml, doxie.IDataAccess);
string DataRestriction := mod_access.DataRestrictionMask;
unsigned1 dppa := mod_access.dppa;
unsigned1 glba := mod_access.glb;
glb_ok := mod_access.isValidGlb();
dppa_ok := mod_access.isValidDppa();



BusnHeader := Business_Header_SS.Key_BH_BDID_pl;


bdidprep := project(indata(bdid=0), transform(Business_Header_SS.Layout_BDID_InBatch, self := left));

bdidnoprep := project(indata(bdid<>0), transform(Business_Header_SS.Layout_BDID_OutBatch, self := left));

Business_Header_SS.MAC_BDID_Append(bdidprep,bdidappend1,thresh_num, bdids_to_keep)

bdidAppendAll := bdidappend1 + bdidnoprep;

NoBDIDAppend := bdidappend1(bdid=0);

Layout_BDID_OutBatch := RECORD
    unsigned6 BDID := 0;
    unsigned6 AssocBDID := 0;
    unsigned2 score := 0;
    boolean   AssocBusn := false;
    Business_Header_SS.Layout_BDID_InBatch;
    Business_Header_SS.Layout_Best_Append;
END;


// append bests
Business_Header_SS.MAC_BestAppend(bdidAppendAll,appends,verify,bdidbest,true);

AML.Layouts.AMLBusnAssocLayout addBDID(bdidAppendAll le, indata ri)  := Transform
  self.bdid      := le.bdid;
  self.fein      := if(trim(ri.fein)='' or ri.fein='0',le.fein , ri.fein);
  self           := ri;
  self           := [];
END;

bdidAdded := join(bdidAppendAll(bdid<>0), indata, left.seq=right.seq,
             addBDID(left,right), left outer);

NoBDIDAdded := join(bdidAppendAll(bdid=0), indata, left.seq=right.seq,
             addBDID(left,right), left outer);

AML.Layouts.AMLBusnAssocLayout intoOutLayout(bdidAdded l, bdidbest r) := transform
  self.bdid      := r.bdid;
  self.score      := r.score;
  self.Bestaddr      := r.best_addr1;
  self.Bestcity      := r.best_city;
  self.Beststate    := r.best_state;
  self.Bestzip      := r.best_zip;
  self.BestZip4     := r.best_zip4;
  self.bestCompanyName := r.best_CompanyName;
  self.Bestphone     := r.best_phone;
  self.Bestfein      := r.best_fein;
  self.bestCompanyNamescore := Business_Risk.CnameScore(r.best_CompanyName, l.company_name);
  self.Bestphonescore   := Risk_Indicators.PhoneScore(r.best_phone, l.phone10);
  self.Bestfeinscore    := r.verify_best_fein;
  self.Bestaddrscore    := r.verify_best_address;
  myGetDate := if(l.historydate = 999999, (STRING)Std.Date.Today(), Risk_indicators.iid_constants.full_history_date(l.historydate));
  self.historydate := (integer)myGetDate;
clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(r.best_addr1, r.best_city, r.best_state, r.best_zip);
    self.prim_range      := if(l.prim_name = '', clean_a2[1..10], l.prim_range);
    self.predir          := if(l.prim_name = '', clean_a2[11..12], l.predir);
    self.prim_name       := if(l.prim_name = '', clean_a2[13..40], l.prim_name);
    self.addr_suffix     := if(l.prim_name = '', clean_a2[41..44], l.addr_suffix);
    self.postdir         := if(l.prim_name = '', clean_a2[45..46], l.postdir);
    self.unit_desig      := if(l.prim_name = '', clean_a2[47..56], l.unit_desig);
    self.sec_range       := if(l.prim_name = '', clean_a2[57..64], l.sec_range);
    self.p_city_name     := if(l.prim_name = '', clean_a2[90..114], l.p_city_name);
    self.st              := if(l.prim_name = '', clean_a2[115..116], l.st);
    self.z5              := if(l.prim_name = '', clean_a2[117..121], l.z5);
    self.zip4            := if(l.prim_name = '', clean_a2[122..125], l.zip4);
    self.lat             := if(l.prim_name = '', clean_a2[146..155], l.lat);
    self.long            := if(l.prim_name = '', clean_a2[156..166], l.long);
    self.addr_type       := if(l.prim_name = '', clean_a2[139], l.addr_type);
    self.addr_status     := if(l.prim_name = '', clean_a2[179..182], l.addr_status);
    self.county          := if(l.prim_name = '', clean_a2[143..145], l.county);
    self.geo_blk         := if(l.prim_name = '', clean_a2[171..177], l.geo_blk);

  self         := l;
  self         := [];
end;


bestrecs_init := join(bdidAdded(bdid!=0), bdidbest,
                      left.seq=right.seq,
                      intoOutLayout(left, right), left outer);

//  highrisk address
AML.Layouts.AMLBusnAssocLayout hrtrans(bestrecs_init l, risk_indicators.key_HRI_Address_To_SIC r) := transform
  baddrtype     := if (L.prim_name = '', '', risk_indicators.iid_constants.dwelltype(L.addr_type));
  self.hriskaddrflag := MAP(baddrtype = 'M' => '3',
                              l.prim_name='' OR l.z5='' => '5',
                              r.sic_code='' => '0',
                              r.sic_code in ['2310','2300','2220','2280','2320']  => '4',
                              '');
  self.dwelltype := Risk_Indicators.iid_constants.dwelltype(L.addr_type);
  self       := l;
  self      := [];
END;


AddrHRrec := join(bestrecs_init, risk_indicators.key_HRI_Address_To_SIC,
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

// highrisk address

AssocBusnLayout := record
  unsigned6   bdid;
  unsigned6   ASSOCbdid;
  unsigned4   seq;
  unsigned4   historydate;
  boolean     AssocBusn;
  string120   AssocCompanyName := '';
  string10    AssocPrim_range := '';
  string2     AssocPredir := '';
  string28    AssocPrim_name := '';
  string4     AssocAddr_suffix := '';
  string2     AssocPostdir := '';
  string10    AssocUnit_desig := '';
  string8     AssocSec_Range := '';
  string25    AssocPCityName := '';
  string2     AssocST := '';
  string5     AssocZ5 := '';
  recordof(business_header.key_business_relatives);
END;

AssocBusnLayout check_rels(bestrecs_init L, business_header.Key_Business_Relatives R) := transform
  self.AssocBusn := R.bdid2 != 0 ;
  self.AssocBDID :=  r.bdid2;
  self.bdid      := l.bdid;
  self.seq       := l.seq;
  self.historydate := l.historydate;
  self := [];
end;

// wAssocBusn to get all other data for Busn Assoc

wAssocBusn := join(bestrecs_init(bdid != 0), business_header.key_business_relatives,

        keyed(left.bdid = right.bdid1) and
            right.bdid2 <> 0 and
            ((right.name and (right.corp_charter_number or
                       right.business_registration or
                       right.dca_company_number or
                       right.fein)) or right.name_address or right.name_phone),

        check_rels(LEFT,RIGHT), left outer,
        ATMOST(RiskWise.max_atmost));

AssocBdidPrep := project(wAssocBusn(assocbusn), transform(Business_Header_SS.Layout_BDID_OutBatch,
                                  self.bdid := left.assocbdid,
                                  self.seq := left.seq));

Business_Header_SS.MAC_BestAppend(AssocBdidPrep,appends,verify,Assocbdidbest,true);

AML.Layouts.AMLBusnAssocLayout AddAssocBest(wAssocBusn le, Assocbdidbest ri) := TRANSFORM
  clean_bus_addr := Risk_Indicators.MOD_AddressClean.clean_addr(ri.best_addr1, ri.best_city, ri.best_state,ri.best_zip);
  self.prim_range  := clean_bus_addr[1..10];
  self.predir      := clean_bus_addr[11..12];
  self.prim_name   := clean_bus_addr[13..40];
  self.addr_suffix := clean_bus_addr[41..44];
  self.postdir     := clean_bus_addr[45..46];
  self.unit_desig  := clean_bus_addr[47..56];
  self.sec_range   := clean_bus_addr[57..64];
  self.p_city_name := clean_bus_addr[65..89];
  self.v_city_name := clean_bus_addr[90..114];
  self.st          := clean_bus_addr[115..116];
  self.z5          := clean_bus_addr[117..121];
  self.zip4        := clean_bus_addr[122..125];
  self.lat         := clean_bus_addr[146..155];
  self.long        := clean_bus_addr[156..166];
  self.addr_type   := clean_bus_addr[139];
  self.addr_status := clean_bus_addr[179..182];
  self.county      := clean_bus_addr[143..145];
  self.geo_blk     := clean_bus_addr[171..177];
  self.bdid      := le.bdid;
  self.AssocBdid  := le.AssocBdid;
  self.historydate := le.historydate;
  self.company_name := ri.best_CompanyName;
  self.score     := ri.score;
  self.fein      := ri.best_fein;
  self.phone10   := ri.best_phone;
  self.Bestaddr     := ri.best_addr1;
  self.Bestcity     := ri.best_city;
  self.Beststate    := ri.best_state;
  self.Bestzip      := ri.best_zip;
  self.BestZip4     := ri.best_zip4;
  self.bestCompanyName := ri.best_CompanyName;
  self.Bestphone     := ri.best_phone;
  self.Bestfein      := ri.best_fein;
  self.Bestfeinscore    := ri.verify_best_fein;
  self.Bestaddrscore    := ri.verify_best_address;
  self         := le;
  self         := [];
end;


AssocBusnBest :=  join( wAssocBusn(assocbusn), Assocbdidbest,
                       left.assocbdid = right.bdid and
                       left.seq  = right.seq,
                       AddAssocBest(left,right),
                       left outer);

AssocBusnRec := $.AMLAssocBusnAttrib(AssocBusnBest,
                                    mod_aml
                                    );

// ----------- BEGIN BNAS ------Busn----------/

for_BNAS := record
  AML.Layouts.AMLBusnAssocLayout;
  boolean  addrmatch;
  boolean  namematch;
  boolean  ssnmatch;
end;

for_BNAS check_TIN_as_SSN(AddrHRrec L, business_risk.Key_SSN_Address R) := transform
  self.addrmatch := gaScore(Risk_Indicators.AddrScore.AddressScore(l.prim_range, l.prim_name, l.sec_range,
                                            r.prim_range, r.prim_name, r.sec_range));
  self.namematch := gScore(Business_Risk.CnameScore(L.company_name,trim(R.fname) + ' ' + trim(R.mname) + ' ' +trim(r.lname)));
  self.ssnmatch := if(l.fein='', 0, if(L.fein = R.ssn, 1, 0));
  self := l;
  self := [];
end;

w_ssncheck := join(AddrHRrec,  business_risk.Key_SSN_Address,
          left.prim_name != '' and
          keyed(left.fein = right.ssn) and
          keyed(left.prim_name = right.prim_name),
          check_TIN_as_SSN(LEFT,RIGHT),
          left outer, keep(100));


for_bnas roll_SSN(for_bnas L, for_bnas R) := transform
  self.addrmatch := L.addrmatch or R.addrmatch;
  self.ssnmatch  := L.ssnmatch  or R.ssnmatch;
  self.namematch := L.namematch or R.nameMatch;
  self := L;
end;

rolled_bnas := rollup(w_ssncheck, left.seq=right.seq and
                                  left.bdid=right.bdid,
                                  roll_SSN(LEFT,RIGHT));



AddBusnBnas  := join(bestrecs_init, rolled_bnas,
                     left.seq=right.seq and
                     left.bdid=right.bdid,
                     transform(AML.Layouts.AMLBusnAssocLayout,
                              self.IndSSNMatch := right.ssnmatch,
                              self.hriskaddrflag := right.hriskaddrflag,
                              self.dwelltype := right.dwelltype,
                              self := left),
                      left outer);

BusnHeadRec := join(bestrecs_init(bdid!=0), BusnHeader,
                    Keyed(right.bdid=left.bdid) and
                    right.dt_first_seen <= left.historydate,
                    transform({recordof(BusnHeader), unsigned4 seq, unsigned4  historydate },
                    self.seq:=left.seq,
                    self.historydate := left.historydate,
                    self.dt_first_seen := if((unsigned)((STRING)right.dt_first_seen)[1..6]>0 and
                                             ((unsigned)((STRING)right.dt_first_seen)[7..8]=0 or trim(((STRING)right.dt_first_seen)[7..8])=''),
                                                  (unsigned)(((string)right.dt_first_seen)[1..6]+'01'),
                                                  right.dt_first_seen),
                    self.dt_last_seen := if((unsigned)((STRING)right.dt_last_seen)[1..6]>0 and
                                            ((unsigned)((STRING)right.dt_last_seen)[7..8]=0 or trim(((STRING)right.dt_last_seen)[7..8])=''),
                                                 (unsigned)(((string)right.dt_last_seen)[1..6]+'01'),
                                                 right.dt_last_seen),
                    self := right), keep(150),
                    atmost(Keyed(right.bdid=left.bdid), RiskWise.max_atmost),
                    left outer);

BusnHdrFirstSort := dedup(sort(BusnHeadRec, seq,bdid,if(dt_first_seen=0, 999999,dt_first_seen)),seq,bdid);  // get BusnHdrDtFirstSeen

  AddBusnHdrFrstDt :=   join(AddBusnBnas, BusnHdrFirstSort,
                         left.seq=right.seq and
                         left.bdid=right.bdid,
                         transform(AML.Layouts.AMLBusnAssocLayout,
                              self.BusnHdrDtFirstSeen := right.dt_first_seen,
                              self := left),
                      left outer);

BusnHdrlastSort := dedup(sort(BusnHeadRec, seq,bdid,-dt_last_seen),seq,bdid);  // get BusnHdrDtLastSeen

  AddBusnHdrDt :=   join(AddBusnHdrFrstDt, BusnHdrlastSort,
                         left.seq=right.seq and
                         left.bdid=right.bdid,
                         transform(AML.Layouts.AMLBusnAssocLayout,
                              self.BusnHdrDtLastSeen := right.dt_Last_seen,
                              self := left),
                      left outer);

BusnHdrSrcSort := dedup(sort(BusnHeadRec(source!=''), seq,bdid,source),seq,bdid,source);

HdrSrcTable := table(BusnHdrSrcSort, {seq,bdid, SrcCount := count(group)}, seq,bdid);   // get src count

AddHdrSrcCnt := join(AddBusnHdrDt,HdrSrcTable,
                     left.seq=right.seq and
                     left.bdid=right.bdid,
                     transform(AML.Layouts.AMLBusnAssocLayout,
                              self.srcCount := right.SrcCount,
                              self := left),
                      left outer);

BusnHdrAddrSort := dedup(sort(BusnHeadRec(prim_name!=''), seq,bdid,prim_range,prim_name,addr_suffix,postdir, state, zip, dt_first_seen)
                            ,seq,bdid,prim_range,prim_name,addr_suffix,postdir, state, zip);

HdrAddrTable := table(BusnHdrAddrSort, {seq,bdid, AddrCount := count(group)}, seq,bdid);  // get addr count

AddBusnHdrAddr := join(AddHdrSrcCnt, HdrAddrTable,
                       left.seq=right.seq and
                       left.bdid=right.bdid,
                       transform(AML.Layouts.AMLBusnAssocLayout,
                              self.AddrCount := right.AddrCount,
                              self := left),
                      left outer);

LenInputAddr := join(bestrecs_init,BusnHeadRec,
                     right.seq=left.seq and
                     right.bdid=left.bdid and
                     right.prim_name = left.prim_name and
                     right.prim_range = left.prim_range and
                     right.predir = left.predir and
                     right.addr_suffix = left.addr_suffix and
                     right.postdir = left.postdir and
                     right.state = left.st and
                     (string)right.zip = left.z5,
                     transform({recordof(BusnHdrAddrSort)},
                               self := right),
                     left outer);

LenInputAddrSort := dedup(sort(LenInputAddr(prim_name!=''and dt_first_seen<>0), seq,bdid,prim_range,prim_name,addr_suffix,postdir, state, zip, dt_first_seen)
                            ,seq,bdid,prim_range,prim_name,addr_suffix,postdir, state, zip);

AML.Layouts.AMLBusnAssocLayout   addAddrLen(AddBusnHdrAddr le, LenInputAddrSort ri)  := TRANSFORM
  self.LengthInputAddr := ut.DaysApart((string)le.historydate, (string)ri.dt_first_seen);

  self := le;

END;

AddBusnAddrLen :=  join(AddBusnHdrAddr , LenInputAddrSort ,
                        left.seq=right.seq and
                        left.bdid=left.bdid,
                        addAddrLen(left,right),
                        left outer);


//------------------check for 'good standing' ---------  corp keys
corprec := record
  unsigned4  seq;
  unsigned6 bdid;
  unsigned4  historydate;
  string30  corp_key;
end;

corprec get_corpkeys(bestrecs_init L, corp2.key_Corp_bdid R) := transform
  self.seq := l.seq;
  self.bdid := l.bdid;
  self.corp_key := R.corp_key;
  self.historyDate := l.historyDate;
end;

corpkeys := join(bestrecs_init, corp2.key_Corp_bdid,
          left.bdid != 0 and
          keyed(left.bdid = right.bdid),
        get_corpkeys(LEFT,RIGHT), atmost(250));

corprec2 := record
  corp2.key_corp_corpkey;
  unsigned4  seq;
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
  self.CorpStatus := if (l.seq = 0, 'U', if (business_header.is_ActiveCorp(r.record_type, R.corp_status_cd, R.corp_status_desc), 'A',
              if (STD.Str.find(R.corp_status_desc, 'INACTIVE', 1) != 0, 'I',
              if (STD.Str.find(R.corp_status_desc, 'DISSOLVED', 1) != 0, 'D',
              if (STD.Str.find(R.corp_status_desc, 'REINSTATE', 1) != 0, 'R'
              ,'U')))));
  self := R;
  self := L;
  self := [];
end;



corprecs := join(corpkeys,  corp2.key_corp_corpkey,
                left.corp_key!='' and
                keyed(Left.corp_key = right.corp_key) and
                left.bdid = right.bdid,
                get_corp_recs(LEFT,RIGHT), ATMOST(keyed(Left.corp_key = right.corp_key),RiskWise.max_atmost), keep(100));

//  Current record status
corp_sortDD := dedup(sort(corprecs,seq, bdid, if (business_header.is_ActiveCorp(record_type, corp_status_cd, corp_status_desc),0,1), if (corp_status_desc != '', 0, 1)),seq, bdid);

AddBusnStatus := join(AddBusnAddrLen, corp_sortDD,
                      left.seq=right.seq and
                      left.bdid=right.bdid,
                      transform(AML.Layouts.AMLBusnAssocLayout,
                                self.corpStatus := right.CorpStatus,
                                self := left),
                      left outer);

corp_sort_all := sort(corprecs,seq, bdid, corp_key, if (business_header.is_ActiveCorp(record_type, corp_status_cd, corp_status_desc),0,1), if (corp_status_desc != '', 0, 1));

corprec2 checkStatus(corp_sort_all le) := transform
  self.EverReinstat  := if(le.CorpStatus = 'R', 1,0);
  self.EverDissolution  := if(le.CorpStatus = 'D', 1,0);;
  self.Reported90d   := ut.DaysApart((string)le.Dt_first_seen, (string)le.historydate) <= 90;
  self := le;
end;

AllStatus := project(  corp_sort_all, checkStatus(left));

corprec2 rollStatus(AllStatus le, AllStatus ri) := transform
  self.EverReinstat  := if(le.EverReinstat, le.EverReinstat, ri.EverReinstat);
  self.EverDissolution  := if(le.EverDissolution, le.EverDissolution, ri.EverDissolution);
  self.Reported90d  := if(le.Reported90d, le.Reported90d, ri.Reported90d);
  self := le;
end;

FinalStatus := rollup(AllStatus,
                      left.seq=right.seq and
                      left.bdid=right.bdid,
                      rollStatus(left,right));

AddBusnStatusEver := join(AddBusnStatus, FinalStatus,
                          left.seq=right.seq and
                          left.bdid=right.bdid,
                          transform(AML.Layouts.AMLBusnAssocLayout,
                                    self.EverReinstat := right.EverReinstat,
                                    self.EverDissolution := right.EverDissolution,
                                    self  := left),
                          left outer);

// AddrChange
corprec2 checkAddrChng(corp_sort_all le, corp_sort_all ri) := transform
  self.addressChangeSOS     := if(ri.corp_address1_type_cd = 'B' and
                                  (le.corp_address1_line1 <>  ri.corp_address1_line1  or
                                  le.corp_address1_line2  <>  ri.corp_address1_line2  or
                                  le.corp_address1_line3  <>  ri.corp_address1_line3  or
                                  le.corp_address1_line4  <>  ri.corp_address1_line4  or
                                  le.corp_address1_line5  <>  ri.corp_address1_line5), 1, 0);
  self := le;
end;

AddrChange := rollup(corp_sort_all,
                      left.bdid=right.bdid,  //  bdid has multi corp keys
                      checkAddrChng(left,right));

AddBusnAddrChng := join(AddBusnStatusEver, AddrChange,
                        left.seq=right.seq and
                        left.bdid=right.bdid,
                        transform(AML.Layouts.AMLBusnAssocLayout,
                                self.addressChangeSOS := right.addressChangeSOS,
                                self  := left),
                          left outer);

// ContactChange
corprec2 checkContactChng(corp_sort_all le, corp_sort_all ri) := transform
  self.contactChangeSOS := if(ri.corp_address1_type_cd = 'T' and
                            (le.corp_address1_line1   <>   ri.corp_address1_line1  or
                            le.corp_address1_line2    <>   ri.corp_address1_line2  or
                            le.corp_address1_line3    <>   ri.corp_address1_line3  or
                            le.corp_address1_line4    <>   ri.corp_address1_line4  or
                            le.corp_address1_line5    <>   ri.corp_address1_line5 ), 1, 0);
  self := le;
end;

ContactChange := rollup(corp_sort_all,
                      left.bdid=right.bdid,
                      checkContactChng(left,right));

AddBusnContChng := join(AddBusnAddrChng, ContactChange,
                        left.seq=right.seq and
                        left.bdid=right.bdid,
                        transform(AML.Layouts.AMLBusnAssocLayout,
                                self.contactChangeSOS := right.contactChangeSOS,
                                self  := left),
                          left outer);

CorpStTbl := table(corp_sort_all, {seq, bdid, corp_inc_state}, seq, bdid, corp_key, corp_inc_state);
CorpStCount := table(CorpStTbl, {seq, bdid, unsigned3 CorpStateCount := count(group)}, seq,bdid);


AddBusnCorpSt := join(AddBusnContChng, CorpStCount,
                        left.seq=right.seq and
                        left.bdid=right.bdid,
                        transform(AML.Layouts.AMLBusnAssocLayout,
                                self.CorpStateCount := right.CorpStateCount,
                                self  := left),
                          left outer);


//----------------- AR2BI ---------------------------

AR2BILayout := record
  unsigned4   seq;
  unsigned6   bdid;
  unsigned6   AR2BiDID;
  boolean     SSNMatch;
END;

DIDContacts_unsuppressed := join(bestrecs_init, Business_Header.Key_Business_Contacts_BDID,
                    keyed(left.bdid=right.bdid),
                    transform({unsigned6 bdid, unsigned did, unsigned4 seq, unsigned4 historydate, unsigned4 global_sid},
                              self.global_sid := right.global_sid;
                              self.bdid:=left.bdid, self.did:=right.did,
                              self.seq:=left.seq, self.historydate := left.historydate),
                    left outer,  keep(200), atmost(RiskWise.max_atmost));

DIDContacts_flagged := Suppress.MAC_FlagSuppressedSource(DIDContacts_unsuppressed, mod_access);

DIDContacts := PROJECT(DIDContacts_flagged, TRANSFORM({unsigned6 bdid, unsigned did, unsigned4 seq, unsigned4 historydate},
  SELF.did := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.did);
  SELF := LEFT;
));

DIDContDD := dedup(sort(DIDContacts, seq,bdid,did), seq,bdid,did);

AR2BILayout check_corp_AR2BI(DIDContDD L, business_risk.Key_Bus_Cont_DID_2_BDID R) := transform
  self.AR2BiDID := (unsigned6)r.did;
  self.seq := l.seq;
  self.bdid := l.bdid;
  self := [];
end;

AR2a := join(DIDContDD, business_risk.Key_Bus_Cont_DID_2_BDID,
      Keyed(right.did = left.did)
      and (left.bdid=right.bdid),
      transform({recordof(business_risk.Key_Bus_Cont_DID_2_BDID), unsigned4 seq},
                 self.seq:=left.seq, self := right),
      atmost(Keyed(right.did = left.did) ,RiskWise.max_atmost),
      keep(1));

AR2DIDs := project(AR2a, transform(doxie.layout_references,  self.did:=left.DID));


checkASSOCssn :=   Risk_Indicators.Collection_Shell_MOD.getBestCleaned(AR2DIDs, DataRestriction, GLBa, false);


AddBDIDSSN := join(AR2a, checkASSOCssn,
                   left.did=right.did,
                   transform({recordof(checkASSOCssn), unsigned6 bdid}, self.bdid:=left.bdid, self := right),
                   left outer);

AR2BILayout check_Fein_AR2BI(bestrecs_init l, AddBDIDSSN r) := transform
  self.AR2BiDID := (unsigned6)r.did;
  self.seq := l.seq;
  self.bdid := l.bdid;
  self.SSNMatch := if(l.bestfein = r.ssn or l.fein = r.ssn, true, false);
end;

FeinMatch := join(bestrecs_init, AddBDIDSSN,
                  left.bdid=right.bdid and left.seq=right.seq,
                  check_Fein_AR2BI(left,right), left outer);


AddFeinMatch := join(AddBusnCorpSt, FeinMatch,
                     left.seq=right.seq and
                        left.bdid=right.bdid,
                        transform(AML.Layouts.AMLBusnAssocLayout,
                                self.IndSSNMatch := right.SSNMatch,
                                self  := left),
                          left outer);



//PROPERTY

kfs_nonFCRA  := LN_PropertyV2.key_search_fid();
kafid_nonFCRA  := LN_PropertyV2.key_assessor_fid();


proprec := Record
  unsigned6 bdid;
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
  recordof(LN_PropertyV2.key_search_fid()) - ln_fares_id - source_code_2 - source_code_1 - cname - bdid;
  recordof(LN_PropertyV2.key_assessor_fid()) - ln_fares_id - process_date - vendor_source_flag - __internal_fpos__;

END;




proprec  getLNFares(bestrecs_init  le, LN_PropertyV2.key_search_bdid ri)   := TRANSFORM

  self.bdid := le.bdid;
  self.seq := le.seq;
  self.historydate := le.historydate;
  self.company_name := le.company_name;
  self.ln_fares_id := ri.ln_fares_id;
  self := [];
END;

BusnProp := join(bestrecs_init , LN_PropertyV2.key_search_bdid ,
                Keyed(left.bdid=right.s_bid)
                and trim(right.ln_fares_id) <> '',
                getLNFares(left,right),
                left outer, atmost(RiskWise.max_atmost),atmost(500));

proprec  getSearch_nonFCRA(BusnProp le, kfs_nonFCRA ri)   := TRANSFORM
  cmpymatch_score   := Business_Risk.CnameScore(le.company_name, ri.cname);
  cmpymatch     := gScore(cmpymatch_score);
  self.bdid := le.bdid;
  self.seq := le.seq;
  self.cmpymatch_score := cmpymatch_score;
  self.company_name := le.company_name;
  self.ln_fares_id := le.ln_fares_id;
  self.source_code_1 := ri.source_code_1;
  self.source_code_2 := ri.source_code_2;
  self.cname := ri.cname;
  SELF.applicant_owned :=  cmpymatch and ri.source_code_2='P' and ri.source_code_1 = 'O';
  self.historydate := le.historydate;
  SELF.applicant_sold :=  ri.source_code_1='S' AND cmpymatch and ri.source_code_2='P' ;
  self := ri;
  self := [];
END;


property_searched :=  JOIN(BusnProp, kfs_nonFCRA, //search_fid
                keyed(LEFT.ln_fares_id=RIGHT.ln_fares_id) AND
                wild(right.which_orig) and
                keyed(RIGHT.source_code_2 in ['P', 'S']),

                getSearch_nonFCRA(LEFT,RIGHT),LEFT OUTER,
                ATMOST(
                  keyed(LEFT.ln_fares_id=RIGHT.ln_fares_id) AND
                  wild(right.which_orig) and
                  keyed(RIGHT.source_code_2 in ['P', 'S']),
                  RiskWise.max_atmost
                 ));


OwnProp := property_searched(applicant_owned);
SoldProp := property_searched(applicant_sold);

ownPropDD := dedup(sort(OwnProp, seq, bdid, prim_range, prim_name, predir,suffix,postdir, zip),
                         seq, bdid, prim_range, prim_name, predir,suffix,postdir, zip);

SoldPropDD := dedup(sort(SoldProp, seq, bdid, prim_range, prim_name, predir,suffix,postdir, zip),
                         seq, bdid, prim_range, prim_name, predir,suffix,postdir, zip);

owned_prop := join(ownPropDD, SoldPropDD,
                    left.prim_range = right.prim_range and
                    left.prim_name = right.prim_name and
                    left.suffix = right.suffix and
                    left.postdir = right.postdir and
                    left.st = right.st and
                    left.p_city_name = right.p_city_name and
                    left.zip = right.zip,
                    transform(recordof(left), self := left),
                    left only);

CountOwnProp := table(owned_prop, {seq, Bdid, OwnPropCnt := count(group)}, seq, Bdid) ;
CountSoldProp := table(SoldPropDD, {seq, Bdid, SoldPropCnt := count(group)}, seq, Bdid) ;



PropTaxValue :=   join(property_searched, kafid_nonFCRA, // assessor fid
                  Keyed(left.ln_fares_id = right.ln_fares_id )and
                  (unsigned4)right.tax_year <= (unsigned4)(((string)left.historydate)[1..4])
                  AND (unsigned4)right.assessed_value_year <= (unsigned4)(((string)left.historydate)[1..4])
                  AND (unsigned4)right.market_value_year <= (unsigned4)(((string)left.historydate)[1..4])
                  AND (unsigned3)right.sale_date[1..6] <= (unsigned3)left.historydate
                  AND (unsigned4)right.recording_date[1..6] <= (unsigned4)left.historydate,
                  transform(proprec,
                            SELF.PurchaseDate := if((integer)right.sale_date=0, right.recording_date, right.sale_date)  ,
                            self.bdid:=left.bdid,
                            self.seq :=left.seq,
                            self.taxAssdValue := if((unsigned)right.assessed_total_value = 0, (unsigned)right.market_total_value, (unsigned)right.assessed_total_value),
                            self := right,
                            self := left,
                            self := []),
                  left outer,
                  ATMOST(keyed(LEFT.LN_fares_id=RIGHT.ln_fares_id), RiskWise.max_atmost));



RemoveZeroValues := PropTaxValue(Trim(assessed_total_value)<>'' and trim(market_total_value)<>'');


PropTaxValueDD :=  dedup(sort(RemoveZeroValues, seq, bdid, prim_range, prim_name, predir,suffix,postdir, zip, -assessed_value_year, -PurchaseDate, taxAssdValue),
                         seq, bdid, prim_range, prim_name, predir,suffix,postdir, zip);



proprec  RollPropTaxValue(PropTaxValueDD le,PropTaxValueDD ri) := Transform
   self.seq  := le.seq;
   self.bdid := le.bdid;
   self.TaxAssdValue  := le.TaxAssdValue + ri.TaxAssdValue;
   self := le;
END;


BusnPropTaxRolled := rollup(PropTaxValueDD,
                      left.bdid=right.bdid and left.seq=right.seq,
                      RollPropTaxValue(LEFT,RIGHT));

AddBusnPropValue := join(AddFeinMatch, BusnPropTaxRolled,
                     left.seq=right.seq and
                     left.bdid=right.bdid,
                     transform(AML.Layouts.AMLBusnAssocLayout,
                             self.PropTaxValue := right.TaxAssdValue,
                             self  := left),
                     left outer);

FirstProp := dedup(sort(PropTaxValueDD, seq ,bdid,if(PurchaseDate='','999999', purchaseDate) ), seq,bdid);  // need first prop and value

AddBusnFirstProp := join(AddBusnPropValue, FirstProp,
                     left.seq=right.seq and
                     left.bdid=right.bdid,
                     transform(AML.Layouts.AMLBusnAssocLayout,
                             self.FirstPurchaseDate := (unsigned4)right.PurchaseDate,
                             self.FirstPropTaxValue := if((unsigned)right.assessed_total_value = 0, (unsigned)right.market_total_value, (unsigned)right.assessed_total_value),
                             self  := left),
                    left outer);

AddPropSoldCount  := join(AddBusnFirstProp, CountSoldProp,
                      left.seq=right.seq and left.bdid=right.bdid,
                      transform(AML.Layouts.AMLBusnAssocLayout,
                                self.CountSoldProp := right.SoldPropCnt,
                                self := left),
                      left outer);

AddPropOwnCount  := join(AddPropSoldCount, CountOwnProp,
                      left.seq=right.seq and left.bdid=right.bdid,
                      transform(AML.Layouts.AMLBusnAssocLayout,
                                self.CountOwnProp := right.OwnPropCnt,
                                self := left),
                      left outer);

//end property

// easi census

  Layout_EasiSeq := record
    unsigned4 seq := 0;
    unsigned6 bdid;
    EASI.Layout_Easi_Census easi;
  END;
//keep totcrime
  easi_census := join(bestrecs_init, Easi.Key_Easi_Census,
    keyed(right.geolink=left.st+left.county+left.geo_blk),
    transform(Layout_EasiSeq,
      self.bdid := left.bdid,
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
               left.bdid=right.bdid,
               transform(AML.Layouts.AMLBusnAssocLayout,
                         self.EasiTotCrime := right.easi.totCrime,
                         self  := left),
               left outer);

// end easi

// SICS

withSIC := JOIN(bestrecs_init,Business_header.key_sic_code,
                KEYED(left.bdid = right.bdid) and
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


AddBusnSIC := join(AddBusnEasi, withSIC,
               left.seq=right.seq and
               left.bdid=right.bdid,
               transform(AML.Layouts.AMLBusnAssocLayout,
                         self.HRBusiness := right.HRBusiness,
                         self  := left),
               left outer);

withNaics := join(AddBusnSIC,  YellowPages.Key_YellowPages_BDID,
                        left.bdid != 0 and
                        keyed(left.bdid = right.bdid) and
                        right.naics_code <> '' and
                        right.naics_code in AML.AMLConstants.setHRNAICSCodes,
                        transform(AML.Layouts.AMLBusnAssocLayout,
                                    self.HRBusiness := if(right.naics_code in AML.AMLConstants.setHRNAICSCodes and
                                                          ~left.HRBusiness, 1, (integer)left.HRBusiness);
                                    self := left),
                atmost(riskwise.max_atmost), LEFT OUTER      ,keep(1));

// suspicious events

bans_bdid := BankruptcyV3.key_bankruptcyV3_bdid();

bkrupt_slim := record
  string bk_tmsid;
  string  court_code;
  string  case_number;
  unsigned6 bdid;
  unsigned4  seq;
  unsigned4 historydate;

end;

bkrupt_slim get_bankruptcies(bestrecs_init L, recordof(bans_bdid) R) := transform
  self.seq := L.seq;
  self.bdid := L.bdid;
  self.bk_tmsid := R.tmsid;
  self.court_code := R.court_code;
  self.case_number := R.case_number;
  self.historydate := l.historydate;
end;

bk_keys := join(bestrecs_init, bans_bdid,
      left.bdid != 0 and
      keyed(left.bdid = right.p_bdid),
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
                  (unsigned6)right.bdid=left.bdid and
                  (unsigned4)right.date_filed < left.historydate,
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
                      left.seq=right.seq,
                      roll_and_countBK(LEFT,RIGHT));


AML.Layouts.AMLBusnAssocLayout fill_in_bkrupt(withNaics L, BusnBKsRolled R) := transform

  self.BKcount        := R.BKCount;
  self.BKcount12      := r.BK12Count;
  self := L;
end;

wBKs := join(withNaics,  BusnBKsRolled,
              left.seq = right.seq and
              left.bdid = (unsigned6)right.bdid ,
               fill_in_bkrupt(LEFT,RIGHT),
               left outer, many lookup);

//  Rep is incarcerated

Rep_slim := record
  unsigned3   seq;
  unsigned4   historydate;
  unsigned6   did;
  unsigned6   bdid;
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
  self.BDID  := le.bdid;
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
  SELF := [];

END;


DIDContHdr_unsuppressed :=   join(DIDContDD, doxie.Key_Header,
                            keyed(LEFT.did=RIGHT.s_did) AND
                            right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
                            RIGHT.dt_first_seen < (unsigned3)((string)left.historydate)[1..6] AND
                            (header.isPreGLB(RIGHT) OR glb_ok) AND
                            (~mdr.Source_is_DPPA(RIGHT.src) OR
                              (dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa,RIGHT.src))) AND
                            ~risk_indicators.iid_constants.filtered_source(right.src, right.st),
                            getRepHdr(LEFT,RIGHT), LEFT OUTER,atmost(RiskWise.max_atmost), keep(150));

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
    self.bdid  := le.bdid;
    self.seq   := le.seq;
    self.historydate := le.historydate;
    self.RepIncarceratedCnt  := If(le.RepPossIncarcerated = '1' or le.RepisIncarcerated, 1, 0);
    self := le;

END;

RepIncarceration := sort(project(idsPosIncar, countIncarcerations(left)),seq, bdid);

Rep_slim  rollIncarcerations(RepIncarceration L, RepIncarceration R) := transform
  self.seq := L.seq;
  self.bdid  := l.bdid;
  self.RepIncarceratedCnt := l.RepIncarceratedCnt + r.RepIncarceratedCnt;
  self := l;
end;

BusnIncarRolled := rollup(RepIncarceration,
                      left.bdid=right.bdid and
                      left.seq=right.seq,
                      rollIncarcerations(LEFT,RIGHT));

AML.Layouts.AMLBusnAssocLayout IncarcerationAdd(wBKs L, BusnIncarRolled R) := transform

  self.RepIncarceratedCnt    := R.RepIncarceratedCnt;
  self := L;
end;

AddIncarceration :=  join(wBKs, BusnIncarRolled,
                          left.bdid=right.bdid and
                      left.seq=right.seq,
                          IncarcerationAdd(left, right),
                          left outer);

// rep suspicious events


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
                       transform({unsigned6 bdid, recordof(DerogsContacts)},
                                 self.bdid := left.bdid,
                                 self      := right),
                                 left outer);

DerogSlim := Record
  unsigned4  seq;
  unsigned6  bdid;
  unsigned3 historydate;
  unsigned4 RepFelonyCnt;
  unsigned4 RepFelonyCnt12;
  unsigned4 RepFelonyCnt2to5yr;
  unsigned4 RepFelonyCnt5plus;
  unsigned4 RepMinorEventCnt;
  unsigned3 RepMinorCnt12;
END;


 DerogSlim  countDerogs(DerogsContBDID le) := Transform
    self.bdid  := le.bdid;
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

RepMinorEvents := project(DerogsContBDID, countDerogs(left));


 DerogSlim  RollRepDerogs(RepMinorEvents le, RepMinorEvents ri) := Transform
    self.bdid  := le.bdid;
    self.seq   := le.seq;
    self.historydate := le.historydate;
    self.RepMinorEventCnt   := le.RepMinorEventCnt + ri.RepMinorEventCnt;
    self.RepFelonyCnt := le.RepFelonyCnt  + ri.RepFelonyCnt;
    self.RepFelonyCnt12 := le.RepFelonyCnt12  + ri.RepFelonyCnt12;
    self.RepFelonyCnt2to5yr := le.RepFelonyCnt2to5yr  + ri.RepFelonyCnt2to5yr;
    self.RepFelonyCnt5plus := le.RepFelonyCnt5plus  + ri.RepFelonyCnt5plus;
    self.RepMinorCnt12  := le.RepMinorCnt12 + ri.RepMinorCnt12;
END;

RepMinorEventsRolled  :=  rollup(sort(RepMinorEvents,seq, bdid),left.bdid=right.bdid and left.seq=right.seq,
                            RollRepDerogs(LEFT,RIGHT));


AddRepContDerogs := join( AddIncarceration ,RepMinorEventsRolled,
                      left.seq=right.seq and
                      left.bdid=right.bdid,
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
  unsigned3  seq := 0;
  unsigned4 historydate;
  unsigned6   bdid := 0;
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
  string50 filingtype_desc := '';
end;

lienrec get_lien_rmsid(AddRepContDerogs L, liensv2.key_liens_bdid R) := transform
  self.seq := L.seq;
  self.historydate := l.historydate;
  self.bdid := L.bdid;
  self.rmsid := R.rmsid;
  self.tmsid := R.tmsid;
  self := [];
end;

rmsids := join(AddRepContDerogs, liensv2.key_liens_bdid,
        left.bdid != 0 and
        keyed(left.bdid = right.p_bdid),
      get_lien_rmsid(LEFT,RIGHT), keep(100));

// with liensV2, all fields we're interested in come from the liens_party_id file except the lien amount and filing description which come from the liens_main file
{lienrec, unsigned4 global_sid, unsigned6 did} get_liens(rmsids L, liensv2.key_liens_party_ID R) := transform
  self.global_sid := R.global_sid;
  self.did := (unsigned6)R.did;
  self.seq := L.seq;
  self.historydate := l.historydate;
  self.bdid := L.bdid;
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
  self.lien_total := 0;  // comes from main
  self.filingtype_desc := '';  // comes from main
  self := [];
end;

liensrecs1_unsuppressed := join(rmsids,  liensv2.key_liens_party_ID,
        keyed(left.rmsid = right.rmsid) and
        keyed(left.tmsid = right.tmsid) and
        left.bdid = (unsigned)right.bdid and  // for cases with multiple debtors, make sure to only include the party records that match on bdid
        right.name_type='D' and
        (unsigned4)right.date_first_seen < (unsigned4)left.historydate,
         get_liens(LEFT,RIGHT),
         atmost( (keyed(left.rmsid=right.rmsid) and keyed(left.tmsid=right.tmsid)), riskwise.max_atmost), keep(100));
liensrecs1 := Suppress.Suppress_ReturnOldLayout(liensrecs1_unsuppressed, mod_access, lienrec);
lienrec get_liens_main(liensrecs1 L, liensv2.key_liens_main_ID R) := transform
  self.lien_total := (integer)R.amount;
  self.filingtype_desc := r.filing_type_desc;
  self.filing_date := if((integer)L.filing_date=0 and (integer)R.filing_date!=0, r.filing_date, l.filing_date);
  self := L;
end;

liensrecs := join(liensrecs1,   liensv2.key_liens_main_ID,
        keyed(left.rmsid = right.rmsid) and
        keyed(left.tmsid = right.tmsid) and
        (integer)right.amount > 0 and
        (unsigned4)right.orig_filing_date < (unsigned4)left.historydate,
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

lrecs_srt_ddp := rollup(sort(liensrecs,seq,-(if (filing_date = '', '0000000', filing_date)), if (def_company ='', 1, 0)),
          left.seq=right.seq and
          left.bdid=right.bdid,
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
                      left.bdid=right.bdid,
                      AddBusnLiensCnts(left,right),
                      left outer);


//ADVO

AdvoKey := Advo.Key_Addr1_history;

withAdvo := join(bestrecs_init, Advo.Key_Addr1_history,

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
          transform({recordof(AdvoKey), unsigned4 seq, unsigned6 Bdid},
                     self.seq := left.seq,
                     self.Bdid := left.Bdid,
                     self := right),
                      left outer,
          atmost(riskwise.max_atmost));

withAdvo1DDVac :=  dedup(sort(withAdvo, seq, Bdid, zip,prim_range, prim_name, addr_suffix, predir, postdir, sec_range, -date_first_seen),
                              seq, Bdid,  zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range  );



AddBusnADVO :=   join( AddBusnLiens ,withAdvo1DDVac  ,
                      left.seq=right.seq and
                      left.bdid=right.bdid,
                      transform(AML.Layouts.AMLBusnAssocLayout,
                                self.AddressVacancyInd := if(right.Address_Vacancy_Indicator = '', 'U', right.Address_Vacancy_Indicator),
                                self := left),
                      left outer);

withAdvo1DDFir :=  dedup(sort(withAdvo, seq, Bdid, zip,prim_range,  prim_name, addr_suffix, predir, postdir, sec_range, date_first_seen)
                              ,seq, Bdid,  zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range  );

AddBusnFrstADVO :=   join( AddBusnADVO ,withAdvo1DDFir  ,
                      left.seq=right.seq and
                      left.Bdid=right.Bdid,
                      transform(AML.Layouts.AMLBusnAssocLayout,
                                self.AdvoFirstSeenDt  := (integer)right.date_first_seen,
                                self := left),
                      left outer);

//end ADVO

//EMPLOYEE COUNT

BusReg := BusReg.key_busreg_company_bdid;   //get emp size

busRegRecs := join(AddBusnFrstADVO, BusReg,
                left.Bdid = right.Bdid and
                right.bdid!=0,
               transform({recordof(BusReg), unsigned4 seq},
                          self.seq := left.seq,
                          self :=  right),
               atmost(Riskwise.max_atmost),
               left outer);

busRegRecsSD := dedup(Sort(busRegRecs, seq, bdid, -dt_last_seen  ), seq, bdid);

AML.Layouts.AMLBusnAssocLayout GetbusnEmpCnt(  AddBusnFrstADVO le, busRegRecsSD ri ) := transform
        self.EmpCount := (unsigned3)ri.emp_size;
        self :=   le;
END;

AddBusnEmpCnt := join(AddBusnFrstADVO, busRegRecsSD,
                left.bdid = right.bdid and
                right.seq= left.seq,
                GetbusnEmpCnt(left,right),
                left outer);

RiskBdidKey := Address_Attributes.key_business_risk_bdid;

AML.Layouts.AMLBusnAssocLayout GetBusnShelf(  AddBusnFrstADVO le, RiskBdidKey ri ) := transform
        self.ShellShelfBusn := (unsigned3)ri.potential_shelf_address;
        self :=   le;
END;

AddBusnShelf := join(AddBusnEmpCnt, RiskBdidKey,
                left.bdid = right.bdid and
                left.bdid!=0,
                GetBusnShelf(left,right),
                atmost(Riskwise.max_atmost),
                left outer);


// crime geolink
crimeGeolink := Address_Attributes.key_crime_geolink;

  GeoCrime := join(AddBusnShelf, crimeGeolink,
    keyed(right.geolink=left.st+left.county+left.geo_blk),
    transform({recordof(crimeGeolink), unsigned4 seq, unsigned6 bdid},

            self.seq := left.seq;
            self.bdid := left.bdid;
            self := right;
            self := [];
    ), left outer,
    ATMOST(keyed(right.geolink=left.st+left.county+left.geo_blk), Riskwise.max_atmost), KEEP(1));

AddGeoCrime  :=  join(AddBusnShelf, GeoCrime,
                        left.seq=right.seq
                        and left.bdid=right.bdid,
                        transform(AML.Layouts.AMLBusnAssocLayout,
                                   self.HighFelonNeighborhood := 100 * right.felon_ratio > 8,
                                   self := left),
                        atmost(Riskwise.max_atmost),
                        left outer);

addHRBusiness :=  join(AddGeoCrime, Address_Attributes.key_business_risk_geolink,
                        keyed(right.geolink=left.st+left.county+left.geo_blk),
                        transform(AML.Layouts.AMLBusnAssocLayout,
                                   Self.HRBusPct :=if(((right.cnt_shell+right.cnt_shelf) / right.cnt_businesses)>= .1, TRUE, FALSE),
                                   self := left),
                        atmost(Riskwise.max_atmost),
                        left outer);




AllBusnRec := AssocBusnRec + addHRBusiness + NoBDIDAdded;


BusnAttrInd := AML.AMLBusnRollAttributes(AllBusnRec);

AML.Layouts.AMLSlimBusnLayout  NNInput(addHRBusiness le) := TRANSFORM
   self.seq            := le.seq ;
   self.historydate    := le.historydate;
   self.account        :=  le.account;
   self.company_name   :=  le.company_name;
   self := [];
END;

BusnRecSlimIds := group(project(addHRBusiness, NNInput(left)), seq);

BusnIndexNews := if(NegNewsFlg, AML.AMLBusnNegNews(BusnRecSlimIds, NegNewsFlg));

AML.Layouts.AMLBusnAssocLayout  AddNNCounts(BusnAttrInd le, BusnIndexNews ri)  := TRANSFORM
  self.BusAMLNegativeNews90    :=   map(
                                    le.BusGeographicIndex = '-1' and NegNewsFlg       => '-1',
                                    le.BusGeographicIndex = '-1' and ~NegNewsFlg     => '',
                                    ri.n_status <> 0                                  =>  '',
                                    ri.days90count > 999                             => '999',
                                    NegNewsFlg                                       => (string)ri.days90count,
                                    '');
  self.BusAMLNegativeNews24   :=  map(
                                    le.BusGeographicIndex = '-1' and NegNewsFlg      => '-1',
                                    le.BusGeographicIndex = '-1' and ~NegNewsFlg     => '',
                                    ri.n_status <> 0                                 =>  '',
                                    ri.months24count > 999                          => '999',
                                    NegNewsFlg                                       => (string)ri.months24count,
                                    '');
  self := le;
END;

BusnNNCounts := join(BusnAttrInd, BusnIndexNews,
                      left.seq = right.seq,
                      AddNNCounts(left, right),
                      left outer);


return BusnNNCounts;

END;
