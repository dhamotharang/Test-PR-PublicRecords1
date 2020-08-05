import Business_Risk, Business_Header_SS, ut,
       Risk_indicators, doxie, Gateway, AML;

EXPORT GetAMLAttribBusnV2(DATASET(Business_Risk.Layout_Input) indata,
                                  $.IParam.IAml mod_aml,
                                  DATASET (Gateway.Layouts.Config) gateways,
                                  string UseXG5Flag = '2',
                                  boolean IncludeNews = TRUE) := FUNCTION

// define synonyms for convenience -- until we're able to pass mod_access all the way.
mod_access := PROJECT(mod_aml, doxie.IDataAccess);
string DataRestriction := mod_access.DataRestrictionMask;

appends := 'BEST_ALL';
verify := 'BEST_ALL';
thresh_num := 0;
bdids_to_keep := 1;

isFCRA := false;
gScore(UNSIGNED1 i) := i BETWEEN Risk_Indicators.iid_constants.min_score AND 100;
gaScore(UNSIGNED1 i) := i BETWEEN Risk_Indicators.iid_constants.min_addrscore AND 100;
gnScore(UNSIGNED1 I) := i BETWEEN Risk_Indicators.iid_constants.min_numscore AND 100;
tscore(UNSIGNED1 i) := IF(i>100,0,i);
unsigned tmax2(unsigned i1, unsigned i2) := map(i1 > 100 => if (i2 > 100, 0, i2),
                     i2 > 100 => if (i1 > 100, 0, i1),
                     i1 > i2 => i1,
                     i2);

glb_ok := mod_access.isValidGlb();
dppa_ok := mod_access.isValidDppa();

UseXG5 := Map(UseXG5Flag = '1'                   => '1',
              ~IncludeNews                       => '0',
              UseXG5Flag = '2' and IncludeNews   => '2',
                                                 '0');

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

Layouts.AMLBusnAssocLayout addBDID(bdidAppendAll le, indata ri)  := Transform
  self.bdid      := le.bdid;
  self.fein      := if(trim(ri.fein)='' or ri.fein='0',le.fein , ri.fein);
  self           := ri;
  self           := [];
END;

bdidAdded := join(bdidAppendAll(bdid<>0), indata, left.seq=right.seq,
             addBDID(left,right), left outer);

NoBDIDAdded := join(bdidAppendAll(bdid=0), indata, left.seq=right.seq,
             addBDID(left,right), left outer);

Layouts.BusnLayoutV2 intoOutLayout(bdidAdded l, bdidbest r) := transform
  self.origbdid      := r.bdid;
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
  myGetDate := if(l.historydate = 999999, ((STRING)Std.Date.Today())[1..6], ((STRING)l.historydate)[1..6]);
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


BDIDbestrecs := join(bdidAdded(bdid!=0), bdidbest,
                      left.seq=right.seq,
                      intoOutLayout(left, right), left outer);
//Relatdegree means:
// 10 - business inquired
// 20 - linked business
// 30 - execs at business(10),
// 40 - execs at linked business (20)
// 50 = bdids related to execs (30,40)  aka related businesses
//60  = parents to 30,40
//70  = relatives to 30,40

//  located in AML.Constants
// SubjBusnDegree := 10;
// LnkdBusnDegree  := 20;
// execSubjBsnDegree := 30;
// execsLnkdBusnDegree  := 40;
// relatedbusnDegree  := 50;
// ExecParentsdegree  := 60;
// execRelativesDegree  := 70;


GetLinkedBusn := GetLinkedBusnExecs(BDIDbestrecs, mod_access);  //Layouts.BusnLayoutV2  in     Layouts.BusnExecsLayoutV2 = out


LinkCount :=   GetLinkedBusn(RelatDegree in [AMLConstants.LnkdBusnDegree, AMLConstants.relatedBusnDegree]);  //remove after testing
AllBusnExecs := GetLinkedBusn(RelatDegree in [AMLConstants.execSubjBsnDegree, AMLConstants.execsLnkdBusnDegree]);
ExecCount := count(AllBusnExecs);
BusnExecCount := count(AllBusnExecs(RelatDegree = AMLConstants.execSubjBsnDegree));  //Just exes for Busn sent in

BusnRecs := GetLinkedBusn(RelatDegree = AMLConstants.SubjBusnDegree);  // just for testing

ALLBusn  :=   dedup(sort(GetLinkedBusn(RelatDegree in [AMLConstants.SubjBusnDegree,AMLConstants.LnkdBusnDegree,AMLConstants.relatedBusnDegree]), seq, origbdid, bdid, relatdegree), seq, origbdid, bdid);   //looses linked exec records


GetAddrRisk  := BusnAddrAttrib(ALLBusn);

// add Linked business info

GetLinkedhdr := getLinkedBusnHdr(GetAddrRisk(relatdegree in [AMLConstants.LnkdBusnDegree,AMLConstants.relatedBusnDegree]), mod_access);

// need to join back to GetLinkedBusn(RelatDegree in [10,20,50])  that were deduped above
addBusnAddr :=    Join(GetLinkedBusn, GetAddrRisk,
                      left.seq = right.seq and
                      left.bdid = right.bdid,
                      transform(Layouts.BusnExecsLayoutV2,
                                self.seq := left.seq ,
                                self.origbdid := left.origbdid,
                                self.bdid := left.bdid,
                                self.did := left.did,
                                self.relatdegree := left.relatdegree,
                                self.historydate := left.historydate,
                                self.relatdid := left.relatdid,
                                self.linkedbusn := left.linkedbusn,
                                self.isexec  := left.isexec,
                                self.score  := left.score,
                                self.AddressVacancyInd  := right.AddressVacancyInd,
                                self.HRBusPct   := right.HRBusPct,
                                self.HighFelonNeighborhood  := right.HighFelonNeighborhood,
                                self.HRBusnSIC   := right.HRBusnSIC,
                                self.HRBusnYPNAICS   := right.HRBusnYPNAICS,
                                self.IndustryNAICS := right.IndustryNAICS,
                                self.busnType  := right.busnType,
                                self.ShelfBusn := right.ShelfBusn ,
                                self.NoFein := right.NoFein and trim(right.bestfein) = '',
                                self.BusnRisklevel  := right.BusnRisklevel,
                                self.EasiTotCrime := right.EasiTotCrime,
                                self.CountyBordersForgeinJur  := right.CountyBordersForgeinJur,
                                self.CountyborderOceanForgJur := right.CountyborderOceanForgJur,
                                self.CityBorderStation := right.CityBorderStation,
                                self.CityFerryCrossing := right.CityFerryCrossing,
                                self.CityRailStation := right.CityRailStation,
                                self.undel_sec    :=  right.undel_sec,
                                self.drop := right.drop,
                                self.potential_remail  :=  right.potential_remail;
                                self.priv_post := right.priv_post,
                                self.storage := right.storage,
                                self.potentialNIS := right.potentialNIS,
                                self.inc_st_loose := right.inc_st_loose,
                                self.busAddrCntLooseIncorp := right.busAddrCntLooseIncorp,
                                self.BusAddrCntnoFein := right.BusAddrCntnoFein,
                                self.hriskaddrflag := right.hriskaddrflag,
                                self.dwelltype := right.dwelltype,
                                self := right,
                                self := left), left outer);



AddLnkBusnhdr := join(addBusnAddr, GetLinkedhdr,
                    left.seq = right.seq and
                    left.origbdid = right.origbdid and
                    left.bdid = right.bdid and
                    left.relatdegree = right.relatdegree,
                    transform(Layouts.BusnExecsLayoutV2,
                              self.srccount := right.srccount,
                              self.CreditSrcCnt := right.CreditSrcCnt,
                              self.BusnHdrDtFirstNonCredit := right.BusnHdrDtFirstNonCredit,
                              self.ShellHdrSrcCnt := right.ShellHdrSrcCnt,
                              self := left),
                              left outer);

Layouts.AMLDerogsLayoutV2  PregexecDerog(AllBusnExecs le) := TRANSFORM
  self.seq  := le.seq;
  self.historydate := le.historydate;
  self.origbdid   := le.bdid;
  self.origdid    := le.did;
  self.LinkedBusn := le.linkedbusn;
  self.did        := le.did;
  self.relatdegree := le.relatdegree;
  self.isexec := le.isexec;
  self := [];
END;
ExecDerogPrep  := project(AddLnkBusnhdr(relatdegree in [AMLConstants.execSubjBsnDegree,AMLConstants.execsLnkdBusnDegree]), PregexecDerog(left));
DDExecDerogPrep  := dedup(sort(ExecDerogPrep,seq, did, relatdegree), seq, did);
GetExecCrim := AML.IndAllLegalEvents((DDExecDerogPrep),isFCRA, mod_access);



ExecIDSOnly := project(AddLnkBusnhdr(relatdegree in [AMLConstants.execSubjBsnDegree,AMLConstants.execsLnkdBusnDegree]), transform(RISK_INDICATORS.Layout_Boca_Shell_ids,
                                    self.seq    := left.seq;
                                    self.historydate := left.historydate;
                                    self.did     := left.did;
                                    self.isrelat  := left.linkedbusn;
                                    self := [];));

GetDegree :=   AML.AMLStudent(group(ExecIDSOnly, seq), mod_access);   //RISK_INDICATORS.Layout_Boca_Shell_ids


layouts.AMLExecLayoutV2  PrepExecslayout(GetLinkedBusn le) := TRANSFORM
   self.seq :=   le.seq;
   self.historydate := le.historydate;
   self.origdid  := le.did;
   self.origBdid  := le.origbdid;
   self.bdid :=  le.bdid;
   self.Assocdid  := le.did;
   self.Relatdid := le.did;
   self.LinkedBusn   := le.LinkedBusn;
   self.RelatDegree := le.relatdegree;
   self.IsExec    := le.IsExec;
   self := le;
   self := [];

END;

SDDIDs  := dedup(sort(AddLnkBusnhdr(relatdegree in [AMLConstants.execSubjBsnDegree,AMLConstants.execsLnkdBusnDegree]), did), did);

prepprofLic := project(SDDIDs, PrepExecslayout(left));

GetProfLic := AML.IndProfLic(prepprofLic(relatdegree in [AMLConstants.execSubjBsnDegree,AMLConstants.execsLnkdBusnDegree]), mod_access, isFCRA);  //Layouts.AMLExecLayoutV2          TESTED

Layouts.BusnLayoutV2 PrepBdidSOS(GetAddrRisk le) := TRANSFORM
  self.seq :=  le.seq;
  self.historydate  := le.historydate;
  self.OrigBdid  := le.OrigBdid;
  self.LinkedBdid  := if(le.relatdegree = AMLConstants.SubjBusnDegree, le.origbdid, le.bdid);
  // self.LinkedBusncount := 0;
  self.BusnRelatDegree := le.RelatDegree;  // 10 - business inquire 20 - linked business  30 - execs at business(10), 40 - execs at linked business, 50 = bdids related to execs
  // self.score := 0;
  self.account := le.account;
  self.company_name := le.company_name;
  self.prim_range := le.prim_range;
  self.predir := le.predir;
  self.prim_name :=  le.prim_name;
  self.addr_suffix :=  le.addr_suffix;
  self.postdir := le.postdir;
  self.unit_desig := le.unit_desig;
  self.sec_range := le.sec_range;
  self.p_city_name := le.p_city_name;
  self.st := le.st;
  self.z5 := le.z5;
  self.zip4 := le.zip4;
  self.lat := le.lat;
  self.long := le.long;
  self.addr_type := le.addr_type;
  self.addr_status := le.addr_status;
  self.county := le.county;
  self.geo_blk := le.addr_suffix;
  self.dwelltype := le.dwelltype;
  self.fein := le.fein;
  self.phone10 := le.phone10;
  self := [];
END;


prepSOS := project(GetAddrRisk, PrepBdidSOS(left));

GetBusnSOS := BusnSOSDetails(prepSOS); //Layouts.BusnLayoutV2         TESTED

GetBusnHeader := BusnHeaderRecs(BDIDbestrecs, mod_access);  //Layouts.BusnLayoutV2          TESTED

GetBusnLiens :=  BusnLiens(BDIDbestrecs, mod_access);  //Layouts.BusnLayoutV2             TESTED

GetBusnWatercraft := BusnWatercraft(BDIDbestrecs);  //Layouts.BusnLayoutV2             TESTED

GetBusnAircraft  := BusnAircraft(BDIDbestrecs);   //Layouts.BusnLayoutV2              TESTED

GetBusnProperty := BusnProperty(BDIDbestrecs);  //Layouts.BusnLayoutV2               TESTED

CheckSSNmatch :=  BusnFeinSSN(AddLnkBusnhdr(relatdegree = AMLConstants.execSubjBsnDegree), DataRestriction, mod_access.glb);    //Layouts.BusnExecsLayoutV2


// add busn detail

 GetBusnLayout :=  join(BDIDbestrecs, addBusnAddr(relatdegree = AMLConstants.SubjBusnDegree),
                      left.seq = right.seq and
                      left.origbdid = right.origbdid,
                      transform(Layouts.BusnLayoutV2,
                            FipsCodetoUse :=  ut.st2FipsCode(StringLib.StringToUpperCase(left.st)) + left.county;
                            self.AddressVacancyInd  := right.AddressVacancyInd,
                            self.HRBusPct   := right.HRBusPct,
                            self.HighFelonNeighborhood  := right.HighFelonNeighborhood,
                            self.HRBusnSIC   := right.HRBusnSIC,
                            self.HRBusnYPNAICS   := right.HRBusnYPNAICS,
                            self.IndustryNAICS   := right.IndustryNAICS,
                            self.busnType  := right.busnType,
                            self.ShelfBusn := right.ShelfBusn ,
                            self.NoFein := right.NoFein,
                            self.BusnRisklevel  := right.BusnRisklevel,
                            self.FIPsCode  :=  FipsCodetoUse,
                            self.CountyBordersForgeinJur  := right.CountyBordersForgeinJur,
                            self.CountyborderOceanForgJur := right.CountyborderOceanForgJur,
                            self.CityBorderStation := right.CityBorderStation,
                            self.CityFerryCrossing := right.CityFerryCrossing,
                            self.CityRailStation := right.CityRailStation,
                            self.HIDTA := right.HIDTA,
                            self.HIFCA := right.HIFCA,
                            self.EasiTotCrime := right.EasiTotCrime,
                            self.undel_sec    :=  right.undel_sec,
                            self.drop := right.drop,
                            self.potential_remail  :=  right.potential_remail;
                            self.priv_post := right.priv_post,
                            self.storage := right.storage,
                            self.potentialNIS := right.potentialNIS,
                            self.inc_st_loose := right.inc_st_loose,
                            self.busAddrCntLooseIncorp := right.busAddrCntLooseIncorp,
                            self.BusAddrCntnoFein := right.BusAddrCntnoFein,
                            self.hriskaddrflag := right.hriskaddrflag,
                            self.dwelltype := right.dwelltype,
                            self := left));




 addBusnSOS :=  join(GetBusnLayout, GetBusnSOS(BusnRelatDegree = AMLConstants.SubjBusnDegree),
                  left.seq = right.seq and
                  left.origbdid = right.origbdid,
                  transform(Layouts.BusnLayoutV2,
                            self.sosfirstreported := right.sosfirstreported,
                            self.soslastreported := right.soslastreported,
                            self.lastreinstatdate := right.lastreinstatdate,
                            self.lastdissolveddate := right.lastdissolveddate,
                            self.contactchangesos := right.contactchangesos,
                            self.BusnNameChangeSOS := right.BusnNameChangeSOS,
                            self.addresschangesos := right.addresschangesos,
                            self.corpstatecount := right.corpstatecount,
                            self.sosaddrlocationcount := right.sosaddrlocationcount,
                            self.lastcorpstatus := right.lastcorpstatus,
                            self.NoSOSFiling  := right.NoSOSFiling,
                            self.RApotentialNIS := right.RApotentialNIS,
                            self.RAShelfBusn := right.RAShelfBusn,
                            self.HasCurrRA := right.HasCurrRA,
                            self.BusRegHit := right.BusRegHit,
                            self := left
                            ),left outer);

AddBusnHdr := join(addBusnSOS, GetBusnHeader,
                  left.seq = right.seq and
                  left.origbdid = right.origbdid,
                  transform(Layouts.BusnLayoutV2,
                  self.srcCount  := right.srcCount,
                  self.BusnHdrDtFirstSeen  := right.BusnHdrDtFirstSeen,
                  self.BusnHdrDtLastSeen   := right.BusnHdrDtLastSeen,
                  self.HDAddrCount := right.HDAddrCount,
                  self.FirstSeenInputAddr := right.FirstSeenInputAddr,
                  self.HDStateCount := right.HDStateCount,
                  self.BusnHdrDtFirstNonCredit := right.BusnHdrDtFirstNonCredit,
                  self.ShellHdrSrcCnt := right.ShellHdrSrcCnt,
                  self.CreditSrcCnt := right.CreditSrcCnt,
                  self := left),left outer);



AddBusnLiens := join(AddBusnHdr, GetBusnLiens,
                  left.seq = right.seq and
                  left.origbdid = right.origbdid,
                  transform(Layouts.BusnLayoutV2,
                  self.UnreleasedLienCount  := right.UnreleasedLienCount,
                  self.ReleasedLienCount  := right.ReleasedLienCount,
                  self.UnreleasedLienCount12  := right.UnreleasedLienCount12,
                  self.ReleasedLienCount12  := right.ReleasedLienCount12,
                  self := left),left outer);

GetBusnShellScore    := BusnShellShelfScore(  AddBusnLiens);



addBusnShellScore := join(AddBusnLiens, GetBusnShellScore,
                          left.seq = right.seq and
                          left.origbdid = right.origbdid,
                          transform(Layouts.BusnLayoutV2,
                                      self.ShellIndCount := right.ShellIndCount,
                                      self.ShellBusnIndvalues := right.ShellBusnIndvalues,
                                      self := left), left outer);


//GetExecCrim  for exec legal  relatdegree = 30

ExecDerogsSlimLayout := RECORD
    unsigned4    seq := 0;
    UNSIGNED3    historydate;
    unsigned6   origdid;
    unsigned6   origbdid;
    integer      RelatDegree;
    unsigned2   potentialSOcnt;
    unsigned2   EverIncarcerCnt;
    unsigned2   CurrIncarcerCnt;
    unsigned2   CurrParoleCnt;
    unsigned2   liensUnreleasedCnt;
    unsigned2   liensUnreleasedCnt12;
    unsigned2   liensReleasedCnt;
    unsigned2   liensReleasedCnt12;
    unsigned2   FelonyCount1yr;
    unsigned2   FelonyCount3yr;
    unsigned2   FelonyCount;
    unsigned2   nonfelonycriminalCount;
    unsigned2   nonfelonycriminalcount12;
END;

ExecDerogsSlimLayout PrepExecDerogCnts(GetExecCrim le)   := TRANSFORM
         self.potentialSOcnt  := if(le.potentialSO, 1, 0);
         self.EverIncarcerCnt  := if(le.EverIncarcer, 1, 0) ;
         self.CurrIncarcerCnt  := if(le.CurrIncarcer, 1, 0);
         self.CurrParoleCnt  := if(le.CurrParole, 1, 0);
         self  := le;
END;

ExecDerogCntsPrep := sort(project(GetExecCrim(relatdegree = AMLConstants.execSubjBsnDegree), PrepExecDerogCnts(left)), seq, origbdid);


//Roll exec crime
ExecDerogsSlimLayout  RollExecLegal(ExecDerogCntsPrep le, ExecDerogCntsPrep ri) := TRANSFORM
         self.potentialSOcnt  := le.potentialSOcnt + ri.potentialSOcnt;
         self.EverIncarcerCnt  := le.EverIncarcerCnt + ri.EverIncarcerCnt;
         self.CurrIncarcerCnt  := le.CurrIncarcerCnt + ri.CurrIncarcerCnt;
         self.CurrParoleCnt  := le.CurrParoleCnt + ri.CurrParoleCnt;
         self.liensUnreleasedCnt  := le.liensUnreleasedCnt + ri.liensUnreleasedCnt;
         self.liensUnreleasedCnt12   := le.liensUnreleasedCnt12 + ri.liensUnreleasedCnt12;
         self.liensReleasedCnt   := le.liensReleasedCnt + ri.liensReleasedCnt;
         self.liensReleasedCnt12   := le.liensReleasedCnt12 + ri.liensReleasedCnt12;
         self.FelonyCount1yr  := le.FelonyCount1yr + ri.FelonyCount1yr;
         self.FelonyCount3yr  := le.FelonyCount3yr + ri.FelonyCount3yr;
         self.FelonyCount   := le.FelonyCount + ri.FelonyCount;
         self.nonfelonycriminalCount  := le.nonfelonycriminalCount + ri.nonfelonycriminalCount;
         self.nonfelonycriminalcount12  := le.nonfelonycriminalcount12 + ri.nonfelonycriminalcount12;
         self := le;
END;

ExecDerogsRolled := rollup(ExecDerogCntsPrep, RollExecLegal(left,right), seq, origbdid);

AddExecDerogs  := join(addBusnShellScore,ExecDerogsRolled,
                      left.seq = right.seq and
                      left.origbdid = right.origbdid,
                      transform(Layouts.BusnLayoutV2,
                          self.ExecLienscount  := right.liensUnreleasedCnt +  right.liensReleasedCnt;
                          self.ExecLienscount12  := right.liensUnreleasedCnt12 + right.liensReleasedCnt12;
                          self.ExecFelonyCnt := right.FelonyCount;
                          self.ExecFelony3yr := right.FelonyCount3yr;
                          self.ExecFelonyCnt3plus := right.FelonyCount - right.FelonyCount3yr;
                          self.ExecIncarceratedCnt := right.CurrIncarcerCnt;
                          self.ExecParoleCnt := right.CurrParoleCnt;
                          self.ExecEverIncarCnt := right.EverIncarcerCnt;
                          self.ExecSOCnt  := right.potentialSOcnt;
                          self.ExecnonfelonyCount  := right.nonfelonycriminalCount;
                          self.Execnonfelonycount12  := right.nonfelonycriminalcount12;
                          self := left), left outer);

AddWatercraft := join(AddExecDerogs, GetBusnWatercraft,
                      left.seq = right.seq and
                      left.origbdid = right.origbdid,
                      transform(Layouts.BusnLayoutV2,
                      self.watercraftcount := right.watercraftcount,
                      self := left), left outer);

AddAircraft := join(AddWatercraft,GetBusnAircraft,
                      left.seq = right.seq and
                      left.origbdid = right.origbdid,
                      transform(Layouts.BusnLayoutV2,
                      self.aircraftcount := right.aircraftcount,
                      self := left), left outer);

AddProperty := join(AddAircraft,GetBusnProperty,
                      left.seq = right.seq and
                      left.origbdid = right.origbdid,
                      transform(Layouts.BusnLayoutV2,
                      self.PropTaxValue  := right.PropTaxValue,
                      self.CurrPropOwnedCount := right.currpropownedcount,
                      self.CountSoldProp := right.countsoldprop,
                      self.CountOwnProp := right.countownprop,
                      self := left), left outer);

//Roll SSN match Exec

SlimExecsSSNLayout := RECORD
    unsigned4    seq := 0;
    UNSIGNED3    historydate;
    unsigned6   did;
    unsigned6   origbdid;
    integer      RelatDegree;
    unsigned2   ExecSNNMatchCnt;
END;

SlimExecsSSNLayout PrepExecSSNCnts(CheckSSNmatch le)   := TRANSFORM
         self.ExecSNNMatchCnt  := if(le.IndSSNMatch, 1, 0);
         self  := le;
END;

ExecSSNCntsPrep := sort(project(CheckSSNmatch, PrepExecSSNCnts(left)), seq, origbdid);


SlimExecsSSNLayout  RollExecSSN(ExecSSNCntsPrep le, ExecSSNCntsPrep ri) := TRANSFORM  //Layouts.BusnExecsLayoutV2
         self.ExecSNNMatchCnt  := le.ExecSNNMatchCnt + ri.ExecSNNMatchCnt;
         self := le;
END;

ExecSSNMatchRolled := rollup(ExecSSNCntsPrep, RollExecSSN(left,right), seq, origbdid);


AddSSNMatch := join(AddProperty,ExecSSNMatchRolled,
                      left.seq = right.seq and
                      left.origbdid = right.origbdid,
                      transform(Layouts.BusnLayoutV2,
                      self.ExecSNNMatch := if(right.ExecSNNMatchCnt > 0 , true, false),
                      self := left), left outer);



//exec ssn info

Layouts.RelatLayoutV2 PrepExecPUSSN(GetLinkedBusn le) := TRANSFORM
  self.seq     := le.seq;
  self.historydate := le.historydate;
  self.origdid  := le.did;
  self.subjectdid  := le.did;
  self.relatDID  :=  if(le.relatdegree in [AMLConstants.execSubjBsnDegree,AMLConstants.execsLnkdBusnDegree], le.did, le.relatdid);
  self.isrelat  :=  true;
  self.relation  := map(
                    le.relatdegree = AMLConstants.ExecParentsdegree => 'EXECPARENT',
                    le.relatdegree = AMLConstants.execRelativesDegree => 'EXECRELAT',
                    le.relatdegree = AMLConstants.execSubjBsnDegree => 'EXECS',
                    le.relatdegree = AMLConstants.execsLnkdBusnDegree => 'LINKEDEXECS',
                    '');
  self.RelatDegree  := le.relatdegree;
  self := [];
END;

ExecSSNPrep := project(AddLnkBusnhdr(relatdegree in [AMLConstants.execSubjBsnDegree,AMLConstants.execsLnkdBusnDegree,AMLConstants.ExecParentsdegree,AMLConstants.execRelativesDegree]), PrepExecPUSSN(left));

// SDExecSSNPrep := dedup(sort(ExecSSNPrep, seq, relatdid, relatdegree),seq, relatdid);  //not used


// need relatives, assoc exec, execs parents to go in
GetSSNFlags := $.SSNData(ExecSSNPrep, mod_aml, isFCRA, TRUE);  //Layouts.RelatLayoutV2  IsBusn = parm



GetHeader := $.IndGetHeader(GetSSNFlags, mod_aml, isFCRA);

// determine relatives citizenship index  for relatives

GetRelatCitizenKRI  :=  GetRelatResidencyKRI(GetHeader(relatdegree = AMLConstants.execSubjBsnDegree)) ;

AddCitizenKRI  :=  join(AddLnkBusnhdr(relatdegree = AMLConstants.execSubjBsnDegree), GetRelatCitizenKRI,
                        left.seq = right.seq and
                        left.did = right.origdid,
                        transform(Layouts.BusnExecsLayoutV2,
                                  self.ResidencyKRI := right.ResidencyRisk,
                                  self := left), left outer);

RolledCitzKRI  := RollBusnResidencyKRI(AddCitizenKRI);

//  Add exec info
AddExecCrim  := join(AddLnkBusnhdr(relatdegree in [AMLConstants.execSubjBsnDegree,AMLConstants.execsLnkdBusnDegree]), GetExecCrim,
                     left.seq = right.seq and
                     left.did = right.did and
                     left.did = right.origdid and
                     left.relatdegree = right.relatdegree and
                     left.bdid = right.origbdid,
                     transform(Layouts.BusnExecsLayoutV2,
                                self.ExecLienscount  := right.liensUnreleasedCnt + right.liensUnreleasedCnt12 + right.liensReleasedCnt + right.liensReleasedCnt12;
                                self.ExecFelonyCnt := 0;
                                self.ExecFelony1yr := right.FelonyCount1yr;
                                self.ExecFelony3yr := right.FelonyCount3yr;
                                self.ExecFelonyCnt3plus := right.FelonyCount - right.FelonyCount3yr;
                                self.ExecCurrIncarCnt := if(right.CurrIncarcer, 1,0);
                                self.ExecEverIncarCnt := if(right.EverIncarcer, 1, 0);
                                self.ExecParoleCnt := if(right.CurrParole, 1, 0);
                                self.ExecPotentialSO := if(right.potentialSO, 1, 0);
                                self.ExecNONFelonyCnt12 := right.nonfelonycriminalcount12;
                                self.ExecNONFelonyCnt := right.nonfelonycriminalCount;
                                self := left),
                      left outer);


AddExecDegree :=   join(AddExecCrim,  GetDegree,
                       left.seq = right.seq and
                       left.did = right.did,
                       transform(Layouts.BusnExecsLayoutV2,
                                 self.ExecHRDegree := right.hrdegreefield,
                                 self := left),
                       left outer);


AddexecProfLic := join(AddExecDegree, GetProfLic,
                       left.seq = right.seq and
                       left.did = right.did,
                       transform(Layouts.BusnExecsLayoutV2,
                                 self.ExecHRProfLic := right.hrproflicprov,
                                 self := left),
                       left outer);




LinkedIds := ungroup(AddLnkBusnhdr(relatdegree not in [AMLConstants.execSubjBsnDegree,AMLConstants.execsLnkdBusnDegree,AMLConstants.ExecParentsdegree,AMLConstants.execRelativesDegree])  + AddexecProfLic);

LinkedBusnCount := count(LinkedIds(relatdegree in [AMLConstants.LnkdBusnDegree, AMLConstants.relatedbusnDegree]));

// add SOS for Linked Business

AddLnkdSOS := join(LinkedIds, GetBusnSOS(BusnRelatDegree <> AMLConstants.SubjBusnDegree),
                    left.seq = right.seq and
                    left.origbdid = right.origbdid and
                    left.bdid = right.LinkedBdid,
                    transform(Layouts.BusnExecsLayoutV2,
                                self.RApotentialNIS := right.RApotentialNIS,
                                self.RAShelfBusn := right.RAShelfBusn,
                                self.HasCurrRA := right.HasCurrRA,
                                self.sosfirstreported := right.sosfirstreported,
                                self.BusRegHit := right.BusRegHit,
                                self := left), left outer);

// add linked business shell score

GetLnkdShellScore :=   LnkdBusnShellScore(AddLnkdSOS(relatdegree in [AMLConstants.LnkdBusnDegree, AMLConstants.relatedbusnDegree]));


AddLnkdShellScore := join(AddLnkdSOS, GetLnkdShellScore,
                          left.seq = right.seq and
                          left.origbdid = right.origbdid and
                          left.bdid = right.bdid and
                          left.relatdegree = right.relatdegree and
                          left.did = right.did and
                          left.relatdid = right.relatdid,
                          transform(Layouts.BusnExecsLayoutV2,
                                      self.ShellIndCount           := right.ShellIndCount,
                                      self.ShellBusnIndvalues     := right.ShellBusnIndvalues,
                                      self := left), left outer);

GetLinkNtwKRI := getBusnLinkedNwtKRI(AddLnkdShellScore);


ExecsNetwprep :=   ungroup(AddLnkdShellScore(relatdegree = AMLConstants.relatedbusnDegree) + AddexecProfLic(relatdegree = AMLConstants.execSubjBsnDegree));

GetExecOffKRI := getBusnExecOffNetwKRI(ExecsNetwprep);

GetMainKRIs := AML.GetBusnKRIs(AddSSNMatch);


AddCitzKRI := join(GetMainKRIs, RolledCitzKRI,
                  left.seq = right.seq and
                  left.origbdid = right.origbdid,
                  TRANSFORM(Layouts.BusnLayoutV2,
                          self.BusExecOfficersResidencyRisk := if(right.FinalResidencyKRI = '' , '1', right.FinalResidencyKRI),
                          self := left), left outer);

AddLinkNtwKRI := join(AddCitzKRI, GetLinkNtwKRI,
                  left.seq = right.seq and
                  left.origbdid = right.origbdid,
                  TRANSFORM(Layouts.BusnLayoutV2,
                          self.BusLinkedBusRisk := if(right.BusLinkedBusRisk = '' , '1',right.BusLinkedBusRisk),
                          self := left), left outer);

AddExecOffKRI := join(AddLinkNtwKRI, GetExecOffKRI,
                  left.seq = right.seq and
                  left.origbdid = right.origbdid,
                  TRANSFORM(Layouts.BusnLayoutV2,
                          self.BusExecOfficersRisk := if(right.BusExecOfficersRisk = '' , '1', right.BusExecOfficersRisk),
                          self := left), left outer);


Layouts.AMLRiskProfileInput  PrepNews(AddExecOffKRI le)  := TRANSFORM
  self.seq                  := le.seq;
  self.did                  := 0;
  self.bdid                 :=   le.OrigBdid;
  self.historydate          := le.historydate;
  self.firstName            := '';
  self.middleName           := '';
  self.lastName             := '';
  self.DOB                  := '';
  self.company_name         := le.company_name;
  self.prim_range           :=  le.prim_range;
  self.predir               := le.predir;
  self.prim_name            := le.prim_name;
  self.addr_suffix          := le.addr_suffix;
  self.postdir              := le.postdir;
  self.unit_desig           := le.unit_desig;
  self.sec_range            := le.sec_range;
  self.city_name            := le.p_city_name;
  self.state                :=  le.st;
  self.z5                   := le.z5;
  self := [];
END;

PrepNewsBusn := project(AddExecOffKRI, PrepNews(left));

Layouts.AMLRiskProfileInput  PrepNewsExec(GetHeader le)  := TRANSFORM
  self.seq                  := le.seq;
  self.did                  := le.relatdid;
  self.bdid                 :=  0;    // le.OrigBdid;
  self.historydate          := le.historydate;
  self.firstName            := le.relatfname;
  self.middleName           := '';
  self.lastName             := le.relatlname;
  self.DOB                  := le.dob;
  self.company_name         := '';
  self.prim_range           :=  le.prim_range;
  self.predir               := le.predir;
  self.prim_name            := le.prim_name;
  self.addr_suffix          := le.suffix;
  self.postdir              := le.postdir;
  self.unit_desig           := le.unit_desig;
  self.sec_range            := le.sec_range;
  self.city_name            := le.city_name;
  self.state                :=  le.st;
  self.z5                   := le.zip;
  self := [];
END;

PrepNewsBusnExec := project(GetHeader(relatdegree = AMLConstants.execSubjBsnDegree), PrepNewsExec(left));

allnewsentities := sort(PrepNewsBusnExec + PrepNewsBusn, seq);

BusnNewsProfile := AML.BusnGetNewsProfile(allnewsentities, UseXG5, IncludeNews, Gateways);

AddBusnNewsProfile := join(AddExecOffKRI,BusnNewsProfile,
                        left.seq = right.seq and
                        left.OrigBdid = right.bdid,
                        transform(Layouts.BusnLayoutV2,
                                    self.BusHighRiskNewsProfiles := if(right.BusHighRiskNewsProfiles = '', '0', right.BusHighRiskNewsProfiles),
                                    self.BusHighRiskNewsProfileType := if(right.BusHighRiskNewsProfileType = '', '0', right.BusHighRiskNewsProfileType),
                                   self := left), left outer);


Layouts.BusnLayoutV2  NoBDIDs(NoBDIDAdded le) := TRANSFORM
  SELF.seq                           := le.seq;
  SELF.historydate                   := le.historydate;
  SELF.BusHighValueAssets            := '-1';
  SELF.BusAccessToFunds              := '-1';
  SELF.BusGeographicRisk             := '-1';
  SELF.BusValidityRisk               := '-1';
  SELF.BusStabilityRisk              := '-1';
  SELF.BusIndustryRisk               := '-1';
  SELF.BusShellShelfRisk             := '-1';
  SELF.BusStructureType              := '-1';
  SELF.BusSOSAgeRange                := '-1';
  SELF.BusPublicRecordAgeRange       := '-1';
  SELF.BusMatchLevel                 := '-1';
  SELF.BusLegalEvents                := '-1';
  SELF.BusHighRiskNewsProfiles       := '-1';
  SELF.BusHighRiskNewsProfileType    := '-1';
  SELF.BusLinkedBusRisk              := '-1';
  SELF.BusExecOfficersRisk           := '-1';
  SELF.BusExecOfficersResidencyRisk  := '-1';
  SELF := LE;
  SELF := [];
END;

NoBDIDKRI := project(NoBDIDAdded, NoBDIDs(left));



Busnout := ungroup(AddBusnNewsProfile + NoBDIDKRI);


 // Busnout := ungroup(GetLnkdShellScore);

// output(indata, named('indata'));
// output(BDIDbestrecs, named('BDIDbestrecs'));
// output(NoBDIDAdded, named('NoBDIDAdded'));
// output(bdidAdded, named('bdidAdded'));

// output(GetLinkedBusn, named('GetLinkedBusn'));
// output(ExecCount, named('ExecCount'));
// output(BusnExecCount, named('BusnExecCount'));
// output(LinkCount, named('LinkCount'));
// output(LinkedBusnCount, named('LinkedBusnCount'));
// output(LinkedBusnwAddr, named('LinkedBusnwAddr'));
// output(AllBusnExecs, named('AllBusnExecs'));
// output(BusnRecs, named('BusnRecs'));

// output(ALLBusn, named('ALLBusn'));
// output(GetAddrRisk, named('GetAddrRisk'));

// output(GetLinkedhdr, named('GetLinkedhdr'));
// output(addBusnAddr, named('addBusnAddr'));


// output(AddLnkBusnhdr, named('AddLnkBusnhdr'));
// output(prepSOS, named('prepSOS'));
// output(GetBusnSOS, named('GetBusnSOS'));

// output(GetBusnHeader, named('GetBusnHeader'));
// output(GetBusnLiens, named('GetBusnLiens'));
// output(GetBusnWatercraft, named('GetBusnWatercraft'));
// output(GetBusnAircraft, named('GetBusnAircraft'));
// output(GetBusnProperty, named('GetBusnProperty'));
// output(ExecDerogPrep, named('ExecDerogPrep'));
// output(DDExecDerogPrep, named('DDExecDerogPrep'));
// output(GetExecCrim, named('GetExecCrim'));
// output(GetDegree, named('GetDegree'));
// output(prepprofLic, named('prepprofLic'));
// output(GetprofLic, named('GetprofLic'));
// output(CheckSSNmatch, named('CheckSSNmatch'));
// output(GetBusnLayout, named('GetBusnLayout'));
// output(addBusnSOS, named('addBusnSOS'));
// output(AddBusnHdr, named('AddBusnHdr'));
// output(AddBusnLiens, named('AddBusnLiens'));
// output(GetBusnShellScore, named('GetBusnShellScore'));
// output(addBusnShellScore, named('addBusnShellScore'));

// output(ExecDerogCntsPrep, named('ExecDerogCntsPrep'));
// output(ExecDerogsRolled, named('ExecDerogsRolled'));
// output(AddExecDerogs, named('AddExecDerogs'));
// output(AddWatercraft, named('AddWatercraft'));
// output(AddAircraft, named('AddAircraft'));
// output(AddProperty, named('AddProperty'));
// output(ExecSSNCntsPrep, named('ExecSSNCntsPrep'));
// output(ExecSSNMatchRolled, named('ExecSSNMatchRolled'));
// output(AddSSNMatch, named('AddSSNMatch'));
// output(ExecSSNPrep, named('ExecSSNPrep'));
// output(GetSSNFlags, named('GetSSNFlags'));
// output(GetHeader, named('GetHeader'));
// output(GetRelatCitizenKRI, named('GetRelatCitizenKRI'));
// output(AddCitizenKRI, named('AddCitizenKRI'));
// output(RolledCitzKRI, named('RolledCitzKRI'));
// output(AddExecCrim, named('AddExecCrim'));
// output(AddExecDegree, named('AddExecDegree'));
// output(AddexecProfLic, named('AddexecProfLic'));

// output(LinkedIds, named('LinkedIds'));
// output(AddLnkdSOS, named('AddLnkdSOS'));
// output(GetLnkdShellScore, named('GetLnkdShellScore'));
// output(AddLnkdShellScore, named('AddLnkdShellScore'));

// output(AddLnkBusnhdr, named('AddLnkBusnhdr'));
// output(GetLinkNtwKRI, named('GetLinkNtwKRI'));
// output(ExecsNetwprep, named('ExecsNetwprep'));
// output(AddSSNMatch, named('AddSSNMatch'));
// output(GetMainKRIs, named('GetMainKRIs'));
// output(AddCitzKRI, named('AddCitzKRI'));
// output(AddLinkNtwKRI, named('AddLinkNtwKRI'));
// output(AddExecOffKRI, named('AddExecOffKRI'));
// output(PrepNewsBusn, named('PrepNewsBusn'));
// output(PrepNewsBusnExec, named('PrepNewsBusnExec'));
// output(allnewsentities, named('allnewsentities'));
// output(BusnNewsProfile, named('BusnNewsProfile'));
// output(SortNewProf, named('SortNewProf'));
// output(RollBusnNewsProf, named('RollBusnNewsProf'));

return Busnout;


END;
