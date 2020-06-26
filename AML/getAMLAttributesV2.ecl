
import Risk_Indicators, iesp, doxie, Gateway, Address, AML;

EXPORT getAMLattributesV2 (DATASET(Risk_Indicators.Layout_Input) iid_prep,
                                            $.IParam.IAml mod_aml,
                                            DATASET (Gateway.Layouts.Config) gateways,
                                            string UseXG5Flag = '2',
                                            boolean IncludeNews = TRUE) := FUNCTION

  // define synonyms for convenience -- until we're able to pass mod_access all the way.
  mod_access := PROJECT(mod_aml, doxie.IDataAccess);
  string DataRestrictionMask := mod_access.DataRestrictionMask;
  unsigned1 dppa := mod_access.dppa;
  unsigned1 glba := mod_access.glb;

  boolean   isFCRA              := false;
  boolean   isUtility           := false;  //userIn.industryClass = 'UTILI';
  boolean   require2ele         := false;
  boolean   isLn                := false;
  boolean   includeRelativeInfo := false;
  boolean   doDL                := false;
  boolean   doVehicle           := false;
  boolean   doDerogs            := false;
  boolean   ofacOnly            := false;
  boolean   suppressNearDups    := false;
  boolean   fromBIID            := false;
  boolean   excludeWatchlists   := false;
  boolean   fromIT1O            := false;
  unsigned3 LastSeenThreshold := risk_indicators.iid_constants.oneyear;
  unsigned1 OFACVersion         := 0;
  real      watchlist_threshold := 0.84;
  boolean   usedobFilter        := false;
  integer2  dob_radius          := -1;
  boolean   includeOfac         := false;
  boolean   includeAddWatchlists:= false;
  boolean   nugen               := false;
  boolean   doScore             := false;
  boolean   runSSNCodes         := true;
  boolean   runBestAddr         := true;
  boolean   runChronoPhone      := false;
  boolean   runAreaCodeSplit    := false;
  boolean   allowCellPhones     := false;
  string10  ExactMatchLevel     := Risk_Indicators.iid_constants.default_ExactMatchLevel;
  string10  CustomDataFilter    := '';
  boolean   IncludeDLverification := false;
  DOBMatchOptions               := dataset([], risk_indicators.layouts.layout_dob_match_options);
  unsigned2 EverOccupant_PastMonths := 0;
  unsigned4 EverOccupant_StartDate  := 99999999;
  unsigned1 AppendBest          := 0;  // search the best file
  unsigned8 BSOptions           :=  0; // risk_indicators.iid_constants.BSOptions.IsAML;
  watchlists_request            := dataset([], iesp.share.t_StringArrayItem);
  boolean   RemoveFares         := if(DataRestrictionMask[1]='1', true, false);

  UseXG5 := Map(UseXG5Flag = '1'                  => '1',
                ~IncludeNews                      => '0',
                UseXG5Flag = '2' and IncludeNews  => '2',
                                                  '0');

  unique_dids := dedup(sort(project(iid_prep(did <> 0),transform(doxie.layout_references,self:=left)), did), did);

  // get best info from same function we use in the collection shell
  bestData := risk_indicators.collection_shell_mod.getBestCleaned(unique_dids,
                                                                    DataRestrictionMask,
                                                                    GLBA,
                                                                    clean_address:=true); //  clean address,



  bestappended := join(iid_prep, bestData, left.did<>0 and left.did=right.did,
                            TRANSFORM(Risk_Indicators.Layout_Input,

                                      self.fname              := If(trim(left.fname) = '' ,  right.fname,left.fname),
                                      self.mname              := If(trim(left.mname) = '',   right.mname, left.mname),
                                      self.lname              := If(trim(left.lname) = '',  right.lname, left.lname),
                                      self.suffix              := If(trim(left.suffix) = '',   right.name_suffix, left.suffix),

                                      self.in_streetAddress   := If(trim(left.in_streetaddress) = '', right.street_addr, left.in_streetaddress),
                                      self.in_city            := if(trim(left.in_city) = '', right.city_name, left.in_city),
                                      self.in_state           := if(trim(left.in_state) = '',  right.st, left.in_state);
                                      self.in_zipCode         := if(trim(left.in_zipCode) = '',  right.zip, left.in_zipCode);

                                      self.prim_range         := if(trim(left.prim_range) = '', right.prim_range, left.prim_range);
                                      self.predir             := if(trim(left.predir) = '',  right.predir, left.predir),
                                      self.prim_name          := if(trim(left.prim_name) = '',  right.prim_name, left.prim_name),
                                      self.addr_suffix        := if(trim(left.addr_suffix) = '', right.suffix, left.addr_suffix),
                                      self.postdir            := if(trim(left.postdir) = '',  right.postdir, left.postdir),
                                      self.unit_desig         := if(trim(left.unit_desig) = '',   right.unit_desig, left.unit_desig),
                                      self.sec_range          := if(trim(left.sec_range) = '',  right.sec_range, left.sec_range),
                                      self.p_city_name        := if(trim(left.p_city_name) = '',   right.city_name, left.p_city_name),
                                      self.st                 := if(trim(left.st) = '',  right.st, left.st),
                                      self.z5                 := if(trim(left.z5) = '',   right.zip, left.z5),
                                      self.zip4               := if(trim(left.zip4) = '',   right.zip4, left.zip4),
                                      self.county             := if(trim(left.county) = '',  right.county, left.county ),
                                      self.geo_blk            := if(trim(left.geo_blk) = '',  right.geo_blk,left.geo_blk),

                                      self.addr_type          := if(trim(left.addr_type) = '',  right.addr_type,left.addr_type),
                                      self.addr_status        := if(trim(left.addr_status) = '',   right.addr_status, left.addr_status),

                                      self.ssn                := if(trim(left.ssn) = '',   right.ssn, left.ssn),
                                      self.phone10            := if(trim(left.phone10) = '',   right.phone, left.phone10),
                                      self       := left,
                                      self       := []),
                                       left outer, keep(1));

  // for batch queries, dedup the input to reduce searching
bestappended_deduped := dedup(sort(ungroup(bestappended + iid_prep(did = 0)),
  historydate, fname, mname, lname, suffix, ssn, dob, phone10,  in_streetAddress, in_city, in_state, in_zipcode,  seq),
  historydate, fname, mname, lname, suffix, ssn, dob, phone10,  in_streetAddress, in_city, in_state, in_zipcode);

seq_map := join( bestappended, bestappended_deduped,
  left.historydate=right.historydate
    and left.fname=right.fname
    and left.mname=right.mname
    and left.lname=right.lname
    and left.suffix=right.suffix
    and left.ssn=right.ssn
    and left.dob=right.dob
    and left.phone10=right.phone10
    and left.in_streetAddress=right.in_streetAddress
    and left.in_city=right.in_city
    and left.in_state=right.in_state
    and left.in_zipcode=right.in_zipcode,
  transform( {unsigned input_seq, unsigned deduped_seq}, self.input_seq := left.seq, self.deduped_seq := right.seq ), keep(1) );



  with_DID := risk_indicators.iid_getDID_prepOutput(bestappended_deduped, dppa, GLBA, isFCRA, mod_aml.bs_version, DataRestrictionMask, AppendBest, Gateways, BSOptions, mod_access);
  // Dedup records with > 1 DID by Score
  DedupWithDID := DEDUP(SORT(ungroup(with_DID(DID <> 0)), seq, -score, DID), seq);
  // Dedup records with > 1 DID = 0 by Score
  DedupNoDID := DEDUP(SORT(ungroup(with_DID(DID = 0)), seq, -score, DID), seq);
  // Dedup records where Individual has a DID and No DID Record, keeping the non-zero DID
  dedupALLDIDs := DEDUP(SORT((DedupWithDID + DedupNoDID), seq, -DID), seq);

  preIID := group(dedupALLDIDs(DID <> 0), seq);

risk_indicators.Layout_Output  CleanInputAddr(preIID le) := TRANSFORM

    self.seq            := le.seq;
    self.historydate    := le.historydate;
    self.DID            := le.did;
    self.fname          := le.fname;
    self.mname          := le.mname;
    self.lname          := le.lname;
      city_st_line:= Address.Addr2FromComponents(le.in_city, le.in_state, le.in_zipcode);
      clean_a2 := address.CleanAddress182(le.in_streetaddress, city_st_line);
    // clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(le.in_streetaddress, le.in_city, le.in_state, le.in_zipcode);
    self.prim_range      := Address.CleanFields(clean_a2).Prim_Range;
    self.predir          := Address.CleanFields(clean_a2).Predir;
    self.prim_name       := Address.CleanFields(clean_a2).Prim_Name;
    self.addr_suffix     := Address.CleanFields(clean_a2).Addr_Suffix;
    self.postdir         := Address.CleanFields(clean_a2).Postdir;
    self.unit_desig      := Address.CleanFields(clean_a2).Unit_Desig;
    self.sec_range       := Address.CleanFields(clean_a2).Sec_Range;
    self.p_city_name     := Address.CleanFields(clean_a2).v_City_Name; //clean_a2[90..114];
    self.st              := Address.CleanFields(clean_a2).St;  //clean_a2[115..116];
    self.z5              := Address.CleanFields(clean_a2).Zip; // clean_a2[117..121];
    self.county          := Address.CleanFields(clean_a2).County[3..5];
    self.geo_blk         := Address.CleanFields(clean_a2).Geo_Blk;
    self := le;
END;


  CleanAddrIID := project(preIID, CleanInputAddr(left));

  IID := AML.AMLcommonFunction( CleanAddrIID, mod_aml,
                                 suppressNearDups,
                                   isFCRA,
                                   runSSNCodes,  runBestAddr,
                                   ExactMatchLevel,
                                   CustomDataFilter,
                                   DOBMatchOptions,
                                   EverOccupant_PastMonths,
                                   EverOccupant_StartDate,
                                   LastSeenThreshold
                                   );



NoDIDRecs := dedupALLDIDs(DID = 0);



GetProperty := AML.IndProperty(ungroup(IID(did <> 0)),DataRestrictionMask);


Addproperty :=  join(IID, GetProperty,
                    left.seq = right.seq ,
                    transform(Layouts.LayoutAMLShellV2,
                              self.propertyCount := right.owned.property_total;
                              self := left), left outer);

GetWatercraft := AML.IndWatercraft(Addproperty, mod_access);

getAircraft :=   AML.IndAircraft(GetWatercraft);


GetAddrAttrib :=       AML.IndAddrAttrib(getAircraft, isFCRA);



// Individuals who are Busn executives,  other execs at same busn and their parents  output  AMLExecLayoutV2
// 0 degrees = individual themself
// 1 - 1st degree relatives to 0
// 2  - parents of 1  changed to 10 for all parents
//10 parents of 1
//  exec degrees  50 - individual Exec themself
//  exec degrees  52 - Assoc Execs
//  exec degrees  56 - Assoc Exec parent
//  exec degrees  57 - Assoc Exec Relative
//  99 -  no clue who this person is or how they got in here


GetBusnExes := AML.IndGetBusnAssoc(ungroup(IID), mod_access);

busnexec := GetBusnExes(relatdegree in[50,52]);

NoExecs := if(count(busnexec(relatdegree = 50)) = 0, true, false);
NoExecsAssoc := if(count(busnexec(relatdegree = 52)) = 0, true, false);
busnexecparents := GetBusnExes(relatdegree = 56);
busnexecRelatives := GetBusnExes(relatdegree = 57);
busnexecAssoc := GetBusnExes(relatdegree = 52);

// output(busnexecparents, named('busnexecparents'));
// output(busnexecAssoc, named('busnexecAssoc'));


Layouts.BusnExecsLayoutV2 PrepAddrRisk(busnexec le)  := TRANSFORM
  self.seq := le.seq;
  self.historydate  := le.historydate;
  self.OrigBdid   := le.Bdid;
  self.bdid :=  le.bdid;
  self.did := le.origdid;
  self.LinkedBusn := true;   //set all to true because we have no busn address for indiv attribs
  self.isExec := le.isExec;
  self.RelatDegree := le.relatdegree;
  self.z5  := le.z5;
  self.prim_range  := le.prim_range;
  self.prim_name  := le.prim_name;
  self.addr_suffix  := le.addr_suffix;
  self.predir  := le.predir;
  self.postdir  := le.postdir;
  self.unit_desig  := le.unit_desig;
  self.company_name := le.company_name;
  self.sec_range := le.sec_range;
  self.fein := le.fein;
  self.p_city_name := le.p_city_name;
  self.county  := le.County;
  self.geo_blk := le.geo_blk;
  self := le;

  self := [];
END;

ExecBDIDsDD := dedup(sort(busnexec, seq, BDID), seq, bdid);

PrepBusnRisk  := project(ExecBDIDsDD, PrepAddrRisk(left));

GetBusnRiskCds  :=  BusnAddrAttrib(PrepBusnRisk);  //Layouts.BusnExecsLayoutV2


getbusnHeader :=  getLinkedBusnHdr(GetBusnRiskCds);



Layouts.BusnLayoutV2 PrepBdidSOS(GetBusnRiskCds le) := TRANSFORM
  self.seq :=  le.seq;
  self.historydate  := le.historydate;
  self.OrigBdid  := le.bdid;
  self.LinkedBdid  :=  le.bdid;
  self.BusnRelatDegree := le.RelatDegree;
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


prepSOS := project(GetBusnRiskCds, PrepBdidSOS(left));

GetBusnSOS := BusnSOSDetails(prepSOS); //Layouts.BusnLayoutV2

// GetLnkdShellScore :=   LnkdBusnShellScore(AddLnkBusnhdr(relatdegree in [20, 50]));



PrepIndivProfLic := project(IID,
                            transform(Layouts.AMLExecLayoutV2,
                                      self.origdid := left.did,
                                      self.seq := left.seq,
                                      self.historydate := left.historydate,
                                      self.RelatDegree := left.RelatDegree,
                                      self.Assocdid  := left.did,
                                      // self.isexec := left.isexec,
                                      self := left,
                                      self := []));

PrepProfLic  :=   dedup(sort(busnexec + PrepIndivProfLic, seq, assocdid), seq, assocdid);

GetProfLic  := AML.IndProfLic(PrepProfLic, mod_access, isFCRA);


//Relatives, indiv and execs section
  GetRelatives :=  GetIndRelatives(ungroup(IID));

Layouts.AMLDerogsLayoutV2  PregDerog(Layouts.RelatLayoutV2 le) := TRANSFORM
  self.seq            := le.seq;
  self.historydate    := le.historyDate;
  self.DID            := le.relatdid;  // need to send in origdid also
  self.isrelat        := le.isrelat;
  self.origdid        := le.origdid;
  self.RelatDegree    := le.relatdegree;
  self := le;
  self := [];
END;

// relatives
RelatDerogPrep  := project(GetRelatives, PregDerog(left));

DDRelatDerogPrep := dedup(sort(RelatDerogPrep(relatdegree <= 1), seq, did, relatdegree), seq, did);

// execs
Layouts.AMLDerogsLayoutV2  PregexecDerog(GetBusnExes le) := TRANSFORM
  self.seq  := le.seq;
  self.historydate := le.historydate;
  self.origdid   := le.origdid;
  self.origbdid   := le.origbdid;
  self.LinkedBusn := le.linkedbusn;
  self.isexec   := le.isexec;
  self.did        := le.Assocdid;
  self.RelatDegree  := le.relatdegree;
  self := [];
END;
ExecDerogPrep  := project(GetBusnExes(isexec and relatdegree = 52), PregexecDerog(left));

DDExecDerogPrep := dedup(sort(ExecDerogPrep, seq, did), seq, did);

//  need relatives and execs
GetRelatAMLCrim := AML.IndAllLegalEvents((DDRelatDerogPrep + DDExecDerogPrep),isFCRA, mod_access);


// relatives, assoc exec, exec relatives and individual
Layouts.RelatLayoutV2 PrepExecPUSSN(busnexecparents le) := TRANSFORM
  self.seq     := le.seq;
  self.historydate := le.historydate;
  self.origdid  := le.origdid;
  self.subjectdid  := le.Assocdid;
  self.relatDID  :=  le.relatdid;
  self.isrelat  :=  TRUE;
  self.relation  := map(
                    le.relatdegree = 56 => 'EXECPARENT',
                    le.relatdegree = 57 => 'EXECRELAT',
                    le.relatdegree = 52 => 'EXECASSOC',
                    'STRANGER');
  self.RelatDegree  := le.relatdegree;
  self := [];
END;

ExecSSNPrep := project(busnexecparents + busnexecRelatives + busnexecAssoc, PrepExecPUSSN(left));

SSNIDS := GetRelatives + ExecSSNPrep;

// need indiv, relatives, assoc exec, execs parents to go in
GetSSNFlags := AML.SSNData(SSNIDS, mod_aml, isFCRA, FALSE);  //Layouts.RelatLayoutV2 IsBusn = False

GetHeader := AML.IndGetHeader(GetSSNFlags, mod_aml, isFCRA);  //Layouts.RelatLayoutV2




NoParents := GetHeader(relatdegree ~in [10,56]);

// determine relatives citizenship index  for relatives

GetRelatCitizenKRI  :=  GetRelatResidencyKRI(NoParents);


//add derogs to relatives

AddRelatDerogs := join(GetRelatCitizenKRI,GetRelatAMLCrim,
                        left.seq = right.seq and
                        left.origdid = right.origdid and
                        left.relatDID = right.did,
                        transform(Layouts.RelatLayoutV2,
                                  self.CurrIncarcer := right.CurrIncarcer,
                                  self.EverIncarcer := right.EverIncarcer,
                                  self.potentialSO := right.potentialSO,
                                  self.CurrParole   := right.CurrParole,
                                  self.liensUnreleasedCnt  := right.liensUnreleasedCnt,
                                  self.liensUnreleasedCnt12 := right.liensUnreleasedCnt12,
                                  self.liensReleasedCnt   := right.liensReleasedCnt,
                                  self.liensReleasedCnt12 := right.liensReleasedCnt12,
                                  self.Felony1yr    := right.FelonyCount1yr,
                                  self.FelonyCount3yr := right.FelonyCount3yr,
                                  self.FelonyCount  := right.FelonyCount,
                                  self.nonfelonycriminalCount := right.nonfelonycriminalCount,
                                  self.nonfelonycriminalcount12  := right.nonfelonycriminalcount12,
                                  self := left),
                                  left outer);



// AML.IndGetPersonalNetwKRI

GetpersonalNtwKRI := AML.IndGetPersonalNetwKRI(AddRelatDerogs(relatdegree between 1 and 50));

GetRelatKRIs  := rollRelativesKRIs(GetpersonalNtwKRI);


// send all busn execs and indiv to amlstudent   RISK_INDICATORS.Layout_Boca_Shell_ids)

RISK_INDICATORS.Layout_Boca_Shell_ids PrepStudentIndiv(GetRelatives le) := TRANSFORM
    self.seq   := le.seq;
    self.historydate := (unsigned3)le.historydate;
    self.did  := le.origdid;
    self := [];
END;


PrepStudentIndivIDS := ungroup(project(GetRelatives(relatdegree = 0), PrepStudentIndiv(left)));


RISK_INDICATORS.Layout_Boca_Shell_ids PrepStudentExecs(busnexec le) := TRANSFORM
    self.seq   := le.seq;
    self.historydate := le.historydate;
    self.did  := le.Assocdid;
    self := [];
END;

PrepStudentExecIDS := ungroup(project(busnexec (relatdegree in [50,52]), PrepStudentExecs(left)));

StudentIDs := dedup(sort(PrepStudentExecIDS + PrepStudentIndivIDS, seq,did), seq,did);

GetStudentDegree := ungroup(AMLStudent(grouped(StudentIDs, seq, did), mod_access));

AddStudentDegree := join(AddRelatDerogs(relatdegree = 0), GetStudentDegree,
                        left.seq = right.seq and
                        left.relatDID = right.did and
                        left.origdid = right.did,
                        transform(Layouts.RelatLayoutV2,
                                 self.HRDegree := right.HRDegreeField,
                                 self := left), left outer);

addProfLic  :=  join(AddStudentDegree, GetProfLic,
                        left.seq = right.seq and
                        left.relatDID = right.did and
                        left.origdid = right.did,
                        transform(Layouts.RelatLayoutV2,
                                  self.HRProfServProv :=  right.HRProfLicProv,
                                  self.ProfLic := right.professional_license_flag,
                                  self := left), left outer);



Layouts.LayoutAMLShellV2  prepIndivLayout(GetAddrAttrib le, addproflic ri) := TRANSFORM
  self.seq  :=    le.seq  ;
      self.historydate  :=    le.historydate  ;
      self.DID  :=    le.DID  ;
      self.isrelat  :=    le.isrelat  ;
      self.relation  :=    le.relation  ;
      self.title  :=    le.title  ;
      self.relatdegree  :=    le.relatdegree  ;
      self.fname  :=    le.fname  ;
      self.mname  :=    le.mname  ;
      self.lname  :=    le.lname  ;
      self.in_streetAddress  :=    le.in_streetAddress  ;
      self.in_city  :=    le.in_city  ;
      self.in_state  :=    le.in_state  ;
      self.in_zipCode  :=    le.in_zipCode  ;
      self.in_country  :=    le.in_country  ;
      self.suffix  :=    le.suffix  ;
      self.street_addr  :=    le.street_addr  ;
      self.prim_range  :=    le.prim_range  ;
      self.predir  :=    le.predir  ;
      self.prim_name  :=    le.prim_name  ;
      self.addr_suffix  :=    le.addr_suffix  ;
      self.postdir  :=    le.postdir  ;
      self.unit_desig  :=    le.unit_desig  ;
      self.sec_range  :=    le.sec_range  ;
      self.city_name  :=    le.city_name  ;
      self.st  :=    le.st  ;
      self.z5  :=    le.z5  ;
      self.zip4  :=    le.zip4  ;
      self.lat :=    le.lat   ;
      self.long := le.long   ;
      self.county := le.county   ;
      self.geo_blk := le.geo_blk   ;
      self.addr_type  :=    le.addr_type  ;
      self.addr_status  :=    le.addr_status  ;
      self.country  :=    le.country  ;
      self.ssn  :=    le.ssn  ;
      self.dob  :=    le.dob  ;
      self.age  :=    le.age  ;
      self.currAddrFirstSeenDt  := le.currAddrFirstSeenDt;
      self.EarliestAddrFirstSeenDt := le.EarliestAddrFirstSeenDt;
      self.AddrHist1_HR_Address  :=    le.AddrHist1_HR_Address  ;
      self.AddrHist1_prim_range  :=    le.AddrHist1_prim_range  ;
      self.AddrHist1_predir  :=    le.AddrHist1_predir  ;
      self.AddrHist1_prim_name  :=    le.AddrHist1_prim_name  ;
      self.AddrHist1_addr_suffix  :=    le.AddrHist1_addr_suffix  ;
      self.AddrHist1_postdir  :=    le.AddrHist1_postdir  ;
      self.AddrHist1_unit_desig  :=    le.AddrHist1_unit_desig  ;
      self.AddrHist1_sec_range  :=    le.AddrHist1_sec_range  ;
      self.AddrHist1_city_name  :=    le.AddrHist1_city_name  ;
      self.AddrHist1_st  :=    le.AddrHist1_st  ;
      self.AddrHist1_zip5  :=    le.AddrHist1_zip5  ;
      self.AddrHist1_county  :=    le.AddrHist1_county  ;
      self.AddrHist1_geo_blk  :=    le.AddrHist1_geo_blk  ;
      self.AddrHist1_dt_first_seen  :=    le.AddrHist1_dt_first_seen  ;
      self.AddrHist1_dt_last_seen  :=    le.AddrHist1_dt_last_seen  ;
      self.AddrHist2_HR_Address  :=    le.AddrHist2_HR_Address  ;
      self.AddrHist2_prim_range  :=    le.AddrHist2_prim_range  ;
      self.AddrHist2_predir  :=    le.AddrHist2_predir  ;
      self.AddrHist2_prim_name  :=    le.AddrHist2_prim_name  ;
      self.AddrHist2_addr_suffix  :=    le.AddrHist2_addr_suffix  ;
      self.AddrHist2_postdir  :=    le.AddrHist2_postdir  ;
      self.AddrHist2_unit_desig  :=    le.AddrHist2_unit_desig  ;
      self.AddrHist2_sec_range  :=    le.AddrHist2_sec_range  ;
      self.AddrHist2_city_name  :=    le.AddrHist2_city_name  ;
      self.AddrHist2_st  :=    le.AddrHist2_st  ;
      self.AddrHist2_zip5  :=    le.AddrHist2_zip5  ;
      self.AddrHist2_county  :=    le.AddrHist2_county  ;
      self.AddrHist2_geo_blk  :=    le.AddrHist2_geo_blk  ;
      self.AddrHist2_dt_first_seen  :=    le.AddrHist2_dt_first_seen  ;
      self.AddrHist2_dt_last_seen  :=    le.AddrHist2_dt_last_seen  ;
      self.AddrHistory  :=    le.AddrHistory  ;
      self.PrevAddrHistory  :=    le.PrevAddrHistory  ;

      self.addrs_last36  :=    le.addrs_last36  ;
      self.Move1_dist  :=    le.Move1_dist  ;
      self.Move2_dist  :=    le.Move2_dist  ;
      self.Move3_dist  :=    le.Move3_dist  ;
      self.Move4_dist  :=    le.Move4_dist  ;
      self.Felony1yr  :=    ri.Felony1yr  ;
      self.FelonyCount3yr  :=    ri.FelonyCount3yr  ;
      self.FelonyCount  :=    ri.FelonyCount  ;
      self.nonfelonycriminalCount  :=    ri.nonfelonycriminalCount  ;
      self.nonfelonycriminalcount12  :=    ri.nonfelonycriminalcount12  ;
      self.liensUnreleasedCnt  :=    ri.liensUnreleasedCnt  ;
      self.liensUnreleasedCnt12  :=    ri.liensUnreleasedCnt12  ;
      self.liensReleasedCnt  :=    ri.liensReleasedCnt  ;
      self.liensReleasedCnt12  :=    ri.liensReleasedCnt12  ;
      self.potentialSO      :=    ri.potentialSO      ;
      self.IsPrison         :=    le.IsPrison         ;
      self.CurrIncarcer     :=    ri.CurrIncarcer     ;
      self.EverIncarcer     :=    ri.EverIncarcer     ;
      self.CurrParole    :=    ri.CurrParole    ;
      self.IsExec      :=    le.IsExec ;
      self.HRDegree       :=    ri.HRDegree       ;
      self.HRProfServProv     :=    ri.HRProfServProv     ;
      self.ProfLic     :=    ri.ProfLic     ;
      self.ADLScore  :=    le.ADLScore  ;
      self.propertyCount  :=    le.propertyCount  ;
      self.watercraftCount  :=    le.watercraftCount  ;
      self.AirCraftCount  :=    le.AirCraftCount  ;
      self.deceased      :=    le.deceased      ;
      self.deceasedDate  :=    le.deceasedDate  ;
      self.validSSN      :=    le.validSSN      ;
      self.NoSSN     :=        le.NoSSN     ;
      self.socllowissue  :=    le.socllowissue  ;
      self.soclhighissue  :=    le.soclhighissue  ;
      self.SSNMultiIdentites :=    le.SSNMultiIdentites  ;
      self.VoterSrc      :=    le.VoterSrc   ;
      self.IsVoter   := le.IsVoter;
      self.EverITIN       :=    le.EverITIN       ;
      self.EverNon_US_SSN      :=    le.EverNon_US_SSN      ;
      self.ParentLowIssueDt  :=    ri.ParentLowIssueDt  ;
      self.AssocParentcnt  :=    ri.AssocParentcnt  ;
      self.ParentNoSSN  :=    ri.ParentNoSSN  ;
      self.ParentValidSSN  :=    ri.ParentValidSSN  ;
      self.ParentHasITIN  :=    ri.ParentHasITIN  ;
      self.ParentNONUSSSN  :=    ri.ParentNONUSSSN  ;
      self.ParentVoter  :=    ri.ParentVoter  ;
      self.ParentVoterSrc  :=    ri.ParentVoterSrc  ;
      self.estimated_income      :=    le.estimated_income  ;
      self.HRTransientCommericalAddr     :=    le.HRTransientCommericalAddr     ;
      self.EasiTotCrime  :=    le.EasiTotCrime  ;
      self.HRBusPctNeighborhood     :=    le.HRBusPctNeighborhood     ;
      self.AddressVacancyInd  :=    le.AddressVacancyInd  ;
      self.HighFelonNeighborhood     :=    le.HighFelonNeighborhood     ;
      self.ssns_per_adl  :=    le.SSNs_Per_ADL  ;
      self.adls_per_ssn  :=   le.adls_per_ssn  ;
      self.HdrFirstSeenDate  :=    le.HdrFirstSeenDate  ;
      self.HdrLastSeenDate  :=    le.HdrLastSeenDate  ;
      self.CountyBordersForgeinJur     :=   le.CountyBordersForgeinJur     ;
      self.CountyborderOceanForgJur    :=    le.CountyborderOceanForgJur    ;
      self.CityBorderStation     :=    le.CityBorderStation     ;
      self.CityFerryCrossing     :=    le.CityFerryCrossing     ;
      self.CityRailStation     :=    le.CityRailStation     ;
      self.HIDTA    :=    le.HIDTA    ;
      self.HIFCA    :=    le.HIFCA    ;
      self.IndHighValueAssets  :=    ''  ;
      self.IndAccesstoFunds  :=    ''    ;
      self.IndGeographicRisk  :=    ''    ;
      self.IndMobility  :=    ''    ;
      self.IndLegalEvents  :=    ''    ;
      self.IndAgeRange  :=    ''    ;
      self.IndIdentityRisk  :=    ''    ;
      self.IndResidencyRisk  :=    ''    ;
      self.IndMatchLevel  :=    ''    ;
      self.IndPersonalAssocRisk  :=    ''    ;
      self.IndAssocResidencyRisk  :=    ''    ;
      self.IndProfessionalRisk  :=    ''    ;
      self.IndBusExecOffAssocRisk  :=    ''    ;
      self.IndHighRiskNewsProfiles   :=    ''    ;
      self.IndHighRiskNewsProfileType   :=    ''    ;
      self := [];

END;


prepIndiv := join(GetAddrAttrib(relatdegree = 0), addproflic,
                  left.did = right.origdid and
                  left.seq = right.seq and
                  left.did = right.relatDID,
                  prepIndivLayout(left, right),
                  left outer);


// get busn shell score


Addexecbusnhdr := join(GetBusnRiskCds, getbusnHeader,
                        left.bdid = right.bdid and
                        left.seq  = right.seq,
                        transform(Layouts.BusnExecsLayoutV2,
                              self.srccount := right.srccount,
                              self.CreditSrcCnt := right.CreditSrcCnt,
                              self.BusnHdrDtFirstNonCredit := right.BusnHdrDtFirstNonCredit,
                              self.ShellHdrSrcCnt := right.ShellHdrSrcCnt,
                              self.noFein := if(left.noFein and left.Fein = '', true, false);
                              self := left),
                              left outer);

AddexecSOS := join(Addexecbusnhdr, GetBusnSOS,
                    left.seq = right.seq and
                    left.bdid = right.LinkedBdid,
                    transform(Layouts.BusnExecsLayoutV2,
                                self.RApotentialNIS := right.RApotentialNIS,
                                self.RAShelfBusn := right.RAShelfBusn,
                                self.HasCurrRA := right.HasCurrRA,
                                self.sosfirstreported := right.sosfirstreported,
                                self.BusRegHit := right.BusRegHit,
                                self := left), left outer);

GetLnkdShellScore :=   LnkdBusnShellScore(AddexecSOS(relatdegree in [52, 50]));

addShellScore := join(GetBusnRiskCds, GetLnkdShellScore,
                          left.bdid = right.bdid and
                          left.seq  = right.seq,
                          transform(Layouts.BusnExecsLayoutV2,
                                      self.ShellIndCount := right.ShellIndCount,
                                      self.ShellBusnIndvalues := right.ShellBusnIndvalues,
                                      self := left), left outer);


// need to add Indv Exec busn risk
slimIndvExecsLayout := RECORD
  unsigned4   seq;
  UNSIGNED3   historydate;
  unsigned6   DID;
  unsigned6   bdid;
  boolean     isexec;
  unsigned2   relatdegree;
  unsigned2   HRBusnCnt   := 0;
  unsigned2   ShellIndCount  := 0;
end;

slimIndvExecsLayout  ExecsCount(busnexec le, addShellScore ri) := TRANSFORM

  SELF.seq  := le.seq;
  SELF.historydate  := le.historydate;
  SELF.DID  := le.origdid;
  SELF.isexec  := le.isexec;
  SELF.BDID := le.bdid;
  SELF.relatdegree := LE.relatdegree;
  SELF.HRBusnCnt  := if(ri.HRBusnSIC = 'HIGH' or ri.BusnRisklevel = 'HIGH' or ri.HRBusnYPNAICS = 'HIGH', 1,0);
  SELF.ShellIndCount  := ri.ShellIndCount;
END;


IndExecRisk := join(busnexec(relatdegree = 50), addShellScore,
                    left.bdid = right.bdid and
                    left.seq  = right.seq,
                    ExecsCount(left, right), left outer);


slimIndvExecsLayout  RollExecsCount(IndExecRisk le, IndExecRisk ri) := TRANSFORM
  sameBdid := le.bdid = ri.bdid;
  SELF.seq  := le.seq;
  SELF.historydate  := le.historydate;
  SELF.DID            := le.did;
  SELF.isexec          := le.isexec;
  SELF.relatdegree := LE.relatdegree;
  SELF.HRBusnCnt    := le.HRBusnCnt + ri.HRBusnCnt;
  SELF.ShellIndCount  := max(le.ShellIndCount,ri.ShellIndCount);
  SELF.bdid := if(sameBdid, le.bdid, ri.bdid);
  SELF := LE;
END;


rolledIndvExecCnt := rollup(sort(IndExecRisk, seq, did), RollExecsCount(left, right), seq, did);

AddIndBusnRisk := join(prepIndiv, rolledIndvExecCnt,
                      left.seq = right.seq and
                      left.did = right.did,
                      transform(Layouts.LayoutAMLShellV2,
                                  self.HRBusnCount  :=  right.HRBusnCnt,
                                  self.ShellIndCount  :=  right.ShellIndCount,
                                  self.isexec := right.isexec,
                                  self := left), left outer);

getindivKRIs  := GetIndKRIs(AddIndBusnRisk);


AddRelatKRI  :=  join(getindivKRIs, GetRelatKRIs,
                      left.seq = right.seq and
                      left.did = right.origdid,
                      transform(Layouts.LayoutAMLShellV2,
                                self.IndAssocResidencyRisk := Map(
                                                                right.ResidencyKRI9 > 0  => '9',
                                                                right.ResidencyKRI8 > 0 => '8',
                                                                right.ResidencyKRI7 > 0  => '7',
                                                                right.ResidencyKRI6 > 0  => '6',
                                                                right.ResidencyKRI5 > 0  => '5',
                                                                right.ResidencyKRI4 > 0  => '4',
                                                                right.ResidencyKRI3 > 0  => '3',
                                                                right.ResidencyKRI2 + right.ResidencyKRI1 > 0  => '2',
                                                                right.ResidencyKRI9 + right.ResidencyKRI8 + right.ResidencyKRI7 +right.ResidencyKRI6 + right.ResidencyKRI5 +
                                                                right.ResidencyKRI4 + right.ResidencyKRI3 + right.ResidencyKRI1 + right.ResidencyKRI2 = 0 and
                                                                count(NoParents(relatdegree <> 0)) = 0                                                      => '1',
                                                                 '0'),
                                self.IndPersonalAssocRisk := Map(
                                                                right.PersnlKRI9 >= 1  => '9',
                                                                right.PersnlKRI8 >= 1 => '8',
                                                                right.PersnlKRI7 >= 1 => '7',
                                                                right.PersnlKRI6 >= 1 => '6',
                                                                right.PersnlKRI5 >= 1 => '5',
                                                                right.PersnlKRI4 >  1 => '4',
                                                                right.PersnlKRI4 =  1 => '3',  //  check for KRI4 here because 3/4 have the same logic so there never should be a 3, just the count of how many relatives have it
                                                                right.PersnlKRI2 >= 1 => '2',
                                                                right.PersnlKRI9 + right.PersnlKRI8 + right.PersnlKRI7 + right.PersnlKRI6 + right.PersnlKRI5 +
                                                                right.PersnlKRI4 + right.PersnlKRI3 +right.PersnlKRI2 = 0  and
                                                                count(NoParents(relatdegree <> 0)) > 0                               => '1',
                                                                 '0'),
                                self := left,
                                self := []),
                        left outer);

//  add  execs data

AddexecBusnRiskCds  := join(busnexec(relatdegree = 52), addShellScore,
                        left.bdid = right.bdid and
                        left.seq = right.seq,
                        transform(Layouts.AMLExecLayoutV2,
                                  self.BusnRisklevel  :=  right.BusnRisklevel,
                                  self.HRBusnSIC  :=  right.HRBusnSIC,
                                  self.ShellIndCount  :=  right.ShellIndCount,
                                  self.Shelfbusn  := right.ShelfBusn,
                                  self.HRBusnYPNAICS  := right.HRBusnYPNAICS,
                                  self := left), left outer);


addexecProfLic  :=  join(AddexecBusnRiskCds, GetProfLic,
                        left.seq = right.seq and
                        left.Assocdid = right.did,
                        transform(Layouts.AMLExecLayoutV2,
                                  self.HRProfServProv :=  right.HRProfLicProv,
                                  self.profLic := right.professional_license_flag,
                                  self := left), left outer);


AddExecDerogs := join(addexecProfLic,GetRelatAMLCrim(isexec),
                        left.seq = right.seq and
                        left.origbdid = right.origbdid and
                        left.Assocdid = right.did,
                        transform(Layouts.AMLExecLayoutV2,
                                  self.Felony1yr    := right.FelonyCount1yr,
                                  self.CurrIncarcer := right.CurrIncarcer,
                                  self.EverIncarcer := right.EverIncarcer,
                                  self.potentialSO := right.potentialSO,
                                  self := left),
                                  left outer);


AddExecDegree := join(AddExecDerogs, GetStudentDegree,
                  left.seq = right.seq and
                  left.Assocdid = right.did,
                  transform(Layouts.AMLExecLayoutV2,
                            self.HRDegree := right.HRDegreeField,
                            self := left), left outer);

//do not include individual exec  just assoc'd execs
GetBusnExecAsocKRI  := ungroup(IndBusnExecNetwKRI(AddExecDegree(relatdegree = 52)));

RolledBusnExecKRI := rollBusnExecKRIs(GetBusnExecAsocKRI);

AddBusnAssocKRI := join(AddRelatKRI,RolledBusnExecKRI,
                        left.seq = right.seq and
                        left.did = right.origdid,
                        transform(Layouts.LayoutAMLShellV2,
                                  self.IndBusExecOffAssocRisk := Map(
                                                                      ~left.isexec                                     => '1',
                                                                      left.isexec and right.BusExecOfficersKRI9 >= 1  => '9',
                                                                      left.isexec and right.BusExecOfficersKRI8 >= 1  => '8',
                                                                      left.isexec and right.BusExecOfficersKRI7 >= 1  => '7',
                                                                      left.isexec and right.BusExecOfficersKRI6 >= 1  => '6',
                                                                      left.isexec and right.BusExecOfficersKRI5 >= 1  => '5',
                                                                      left.isexec and right.BusExecOfficersKRI4 >= 1  => '4',
                                                                      left.isexec and right.BusExecOfficersKRI3 >= 1  => '3',
                                                                      left.isexec                                       => '2',
                                                                      '0');,
                                  self := left),
                                  left outer);



Layouts.AMLRiskProfileInput  PrepNews(AddBusnAssocKRI le)  := TRANSFORM
  self.seq     := le.seq;
  self.did      := le.did;
  self.bdid   := 0;
  self.historydate    := le.historydate;
  self.firstName        := le.fname;
  self.middleName       := le.mname;
  self.lastName         := le.lname;
  self.DOB              := le.dob;
  self.company_name      := '';
  self.state             := le.in_state;
  self := [];
END;

PrepNewsInd := project(AddBusnAssocKRI, PrepNews(left));

IndNewProfile := AML.GetNewsProfile(PrepNewsInd, UseXG5, IncludeNews, gateways);


AddIndNewsProfile := join(AddBusnAssocKRI,IndNewProfile,
                        left.seq = right.seq and
                        left.did = right.did,
                        transform(Layouts.LayoutAMLShellV2,
                                   self.IndHighRiskNewsProfiles := right.IndHighRiskNewsProfiles,
                                   self.IndHighRiskNewsProfileType := right.IndHighRiskNewsProfileType,
                                   self.XG5Return := right.XG5Return,
                                   self := left), left outer);

Layouts.LayoutAMLShellV2 PrepNoDIDs(NoDIDRecs le)  := TRANSFORM
  SELF.IndHighValueAssets        :=  '-1';
  SELF.IndAccessToFunds          :=  '-1';
  SELF.IndGeographicRisk         :=  '-1';
  SELF.IndMobility               :=  '-1';
  SELF.IndLegalEvents            :=  '-1';
  SELF.IndHighRiskNewsProfiles   :=  '-1';
  SELF.IndHighRiskNewsProfileType  :=  '-1';
  SELF.IndAgeRange               :=  '-1';
  SELF.IndIdentityRisk           :=  '-1';
  SELF.IndResidencyRisk          :=  '-1';
  SELF.IndMatchLevel             :=  '-1';
  SELF.IndPersonalAssocRisk      :=  '-1';
  SELF.IndAssocResidencyRisk     :=  '-1';
  SELF.IndProfessionalRisk       :=  '-1';
  SELF.IndBusExecOffAssocRisk    :=  '-1';
  // SELF.dob    := (string)le.reported_dob;
  self.fname          := le.fname;
  self.mname          := le.mname;
  self.lname          := le.lname;

  self.isrelat        := false;
  self.relation          := 'self';
  self.title             := le.title;
  self.in_streetAddress  := le.in_streetaddress;
  self.in_city             := le.in_city;
  self.in_state           := le.in_state;
  self.in_zipCode          := le.in_zipcode;
  self.in_country         := le.in_country;
  self.age := '';
  self.dob := '';
  self.socllowissue := 0;
  self.soclhighissue := 0;
  SELF := LE;
  SELF := [];
END;

NoDIDKRIs  := project(NoDIDRecs, PrepNoDIDs(left));

KRIsOut := ungroup(AddIndNewsProfile + NoDIDKRIs);



// join the results back to the original input so that every record on input has a response populated
full_response := join( seq_map, KRIsOut, left.deduped_seq=right.seq, transform(AML.Layouts.LayoutAMLShellV2, self.seq := left.input_seq, self := right ), keep(1) );

//Testing

// output(gateways, named('gateways'));
  // output(seq_map, named('seq_map'));
  // output(bestappended, named('bestappended'));
  // output(with_DID, named('with_DID'));
  // output(DedupWithDid, named('DedupWithDid'));
  // output(DedupNoDID, named('DedupNoDID'));
  // output(dedupALLDIDs, named('dedupALLDIDs'));
  // output(preiid, named('preiid'));
  // output(CleanAddrIID, named('CleanAddrIID'));
  // output(iid, named('iid'));

  // output(clam, named('clam'));

  // output(GetAddrAttrib, named('GetAddrAttrib'));

  // output(GetBusnExes, named('GetBusnExes'));
  // output(busnexec, named('allExecs'));
  // output(busnexecparents, named('busnexecparents'));
  // output(PrepBusnRisk, named('PrepBusnRisk'));
  // output(GetBusnRiskCds, named('GetBusnRiskCds'));
  // output(getbusnHeader, named('getbusnHeader'));
  // output(prepSOS, named('prepSOS'));
  // output(GetBusnSOS, named('GetBusnSOS'));
  // output(PrepIndivProfLic, named('PrepIndivProfLic'));
  // output(GetProfLic, named('GetProfLic'));
  // output(GetRelatives, named('GetRelatives'));
  // output(DDRelatDerogPrep, named('DDRelatDerogPrep'));
  // output(ExecDerogPrep, named('ExecDerogPrep'));
  // output(DDExecDerogPrep, named('DDExecDerogPrep'));
  // output(GetRelatAMLCrim, named('GetRelatAMLCrim'));
  // output(GetProperty, named('GetProperty'));

  // output(NoParents, named('NoParents'));

  // output(SSNIDS, named('SSNIDS'));
  // output(GetSSNFlags, named('GetSSNFlags'));
  // output(GetHeader, named('GetHeader'));

  // output(GetRelatCitizenKRI, named('GetRelatCitizenKRI'));
  // output(AddRelatDerogs, named('AddRelatDerogs'));
  // output(AddStudentDegree, named('AddStudentDegree'));
  // output(addProfLic, named('addProfLic'));
  // output(GetpersonalNtwKRI, named('GetpersonalNtwKRI'));
  // output(GetRelatKRIs, named('GetRelatKRIs'));
  // output(AddRelatKRI, named('AddRelatKRI'));
  // output(prepIndiv, named('prepIndiv'));

   // output(AddIndBusnRisk, named('AddIndBusnRisk'));
  // output(getindivKRIs, named('getindivKRIs'));


  // output(PrepStudentExecIDS, named('PrepStudentExecIDS'));
  // output(GetStudentDegree, named('GetStudentDegree'));
  // output(AddexecBusnRiskCds, named('AddexecBusnRiskCds'));
  // output(addexecProfLic, named('addexecProfLic'));
  // output(AddExecDerogs, named('AddExecDerogs'));
  // output(AddExecDegree, named('AddExecDegree'));

  // output(GetBusnExecAsocKRI, named('GetBusnExecAsocKRI'));
  // output(RolledBusnExecKRI, named('RolledBusnExecKRI'));
  // output(BusnExecKRI, named('BusnExecKRI'));
  // output(PrepNewsInd, named('PrepNewsInd'));
  // output(IndNewProfile, named('IndNewProfile'));
  // output(AddexecSOS, named('AddexecSOS'));
  // output(Addexecbusnhdr, named('Addexecbusnhdr'));
  // output(GetLnkdShellScore, named('GetLnkdShellScore'));
  // output(addShellScore, named('addShellScore'));
  // output(IndExecRisk, named('IndExecRisk'));
  // output(rolledIndvExecCnt, named('rolledIndvExecCnt'));

  return full_response;

END;
