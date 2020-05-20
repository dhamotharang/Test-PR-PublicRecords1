Import Risk_Indicators, ut, riskwise, Address_Attributes, Easi, Census_Data, ADVO;


export IndAddrAttrib( DATASET(Layouts.LayoutAMLShellV2) idsIN,
                      boolean isFCRA = false
                      ) := FUNCTION

AddrslimLayout := RECORD
  UNSIGNED4 seq;
  UNSIGNED3 historydate;
  UNSIGNED6 DID;
  integer  relatdegree;
  STRING20 fname;
  STRING20 mname;
  STRING20 lname;
  STRING10 prim_range;
  STRING2  predir;
  STRING28 prim_name;
  STRING4  addr_suffix;
  STRING2  postdir;
  STRING10 unit_desig;
  STRING8  sec_range;
  STRING25 city_name;
  STRING2  st;
  STRING5  z5;
  string3  county;
  string7  geo_blk;
  boolean   HRBusPctNeighborhood;
  boolean   HighFelonNeighborhood;
  string1   AddressVacancyInd;
  string3   EasiTotCrime;
  boolean   CountyBordersForgeinJur ;
  boolean   CountyborderOceanForgJur ;
  boolean   CityBorderStation ;
  boolean   CityFerryCrossing ;
  boolean   CityRailStation ;
  boolean   HIDTA ;
  boolean   HIFCA ;
  boolean   IsPrison ;
  unsigned3 estimated_income;
END;

AddrslimLayout NormAddr(idsIN le, INTEGER C) := TRANSFORM
  SELF.seq := le.seq;
  self.did := le.did;
  self.fname := le.fname;
  self.lname := le.lname;
  self.historydate := le.historydate;
  self.relatdegree := le.relatdegree;
  self.prim_range  := CHOOSE(C, le.prim_range, le.AddrHist1_prim_range);
  self.predir  :=   CHOOSE(C,le.predir, le.AddrHist1_predir);
  self.prim_name   :=   CHOOSE(C,le.prim_name,le.AddrHist1_prim_name);
  self.addr_suffix  :=   CHOOSE(C,le.addr_suffix,le.AddrHist1_addr_suffix);
  self.postdir   :=   CHOOSE(C,le.postdir,le.AddrHist1_postdir);
  self.unit_desig   :=  CHOOSE(C,le.unit_desig,le.AddrHist1_unit_desig);
  self.sec_range   :=  CHOOSE(C,le.sec_range,le.AddrHist1_sec_range);
  self.city_name   := CHOOSE(C,le.city_name,le.AddrHist1_city_name);
  self.st    :=  CHOOSE(C,le.st,le.AddrHist1_st);
  self.z5   := CHOOSE(C,le.z5,le.AddrHist1_zip5);
  self.county   := CHOOSE(C,le.county,le.AddrHist1_county);
  self.geo_blk   := CHOOSE(C,le.geo_blk,le.AddrHist1_geo_blk);
  self := [];
END;

NormAddrs :=  NORMALIZE(idsIN,2,NormAddr(LEFT,COUNTER));

SDAddrs := dedup(sort(NormAddrs, seq, did, z5,prim_range,  prim_name, addr_suffix, predir, postdir, sec_range),
                                  seq, did, z5,prim_range,  prim_name, addr_suffix, predir, postdir, sec_range);



//high number of high risk business at geolink

addHRBusiness :=  join(SDAddrs, Address_Attributes.key_business_risk_geolink,
                        keyed(right.geolink=left.st+left.county+left.geo_blk),
                        transform(AddrslimLayout,
                                   Self.HRBusPctNeighborhood :=if(((right.cnt_shell+right.cnt_shelf) / right.cnt_businesses)>= .1, TRUE, FALSE),
                                   self := left),
                        atmost(Riskwise.max_atmost),
                        left outer);

// easi census crime


  easiCensus := join(addHRBusiness, Easi.Key_Easi_Census,
    keyed(right.geolink=left.st+left.county+left.geo_blk),
    transform(AddrslimLayout,
      self.EasiTotCrime := right.totcrime;
            self := left;
      self := [];
    ), left outer,
    ATMOST(keyed(right.geolink=left.st+left.county+left.geo_blk), Riskwise.max_atmost), KEEP(1));



// high crime felony neighborhood
 crimeGeolink := Address_Attributes.key_crime_geolink;

 withGeoCrime := join(easiCensus, crimeGeolink,
    keyed(right.geolink=left.st+left.county+left.geo_blk),
    transform(AddrslimLayout,
            self.seq := left.seq;
            self.did := left.did;
            self.HighFelonNeighborhood := right.felon_ratio > .08;
            FipsAddrtoUse :=  ut.st2FipsCode(StringLib.StringToUpperCase(left.st)) + left.county;
            CityState := StringLib.StringToUpperCase(trim(left.city_name) + ','+ trim(left.st));
            self.CountyBordersForgeinJur  := FipsAddrtoUse in amlconstants.CountyForeignJurisdic;
            self.CountyborderOceanForgJur  := FipsAddrtoUse in amlconstants.CountyBordersOceanForgJur;
            self.CityBorderStation  := CityState in AMLconstants.CityBorderStation;
            self.CityFerryCrossing  := CityState in amlconstants.CityFerryCrossing;
            self.CityRailStation  := CityState in amlconstants.CityRailStation;
            self.HIDTA  := FipsAddrtoUse in AMLConstants.setHIDTA;
            self.HIFCA  := FipsAddrtoUse in AMLConstants.setHIFCA;
            self := left),
    left outer,   ATMOST(keyed(right.geolink=left.st+left.county+left.geo_blk), Riskwise.max_atmost), KEEP(1));





prison1 := join(withGeoCrime, Risk_Indicators.key_HRI_Address_To_SIC,
                              trim(left.z5)!='' and trim(left.prim_name)!='' and
                              keyed(left.z5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and
                              keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
                              keyed(left.sec_range=right.sec_range) AND
                              // check date
                              right.dt_first_seen < left.historydate AND
                              right.sic_code='2225',
                              transform(AddrslimLayout,
                                        self.isprison := right.sic_code='2225',
                                        self := left),left outer,
                              ATMOST(keyed(left.z5=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.addr_suffix=right.suffix) and
                                  keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
                                  keyed(left.sec_range=right.sec_range), RiskWise.max_atmost), keep(1));


// estimated income

EstimateIncome := JOIN(prison1,  Census_Data.Key_Smart_Jury,
                        keyed(LEFT.st = RIGHT.stusab) and
                        keyed(left.county = right.county) and
                        keyed(left.geo_blk[1..6] = right.tract) and
                        keyed(left.geo_blk[7] = right.blkgrp),
                        transform(AddrslimLayout,
                                    self.estimated_income  := (integer)right.income, self := left),
                        atmost(RiskWise.max_atmost), KEEP(1), LEFT OUTER);
ADVOLayout := RECORD

  UNSIGNED4 seq;
  UNSIGNED3 historydate;
  UNSIGNED6 DID;
  boolean   isrelat;
  STRING20 relation;
  STRING5  title := '';
  integer  relatdegree;
  STRING20 fname;
  STRING20 mname;
  STRING20 lname;
  STRING120 street_addr;
  STRING10 prim_range;
  STRING2  predir;
  STRING28 prim_name;
  STRING4  addr_suffix;
  STRING2  postdir;
  STRING10 unit_desig;
  STRING8  sec_range;
  STRING25 city_name;
  STRING2  st;
  STRING5  z5;
  STRING4  zip4;
  STRING10 lat := '';
  STRING11 long := '';
  string3 county := '';
  string7 geo_blk := '';
  string1   AddressVacancyInd;
  integer   dt_first_seen;
END;

withAdvo := join(SDAddrs, Advo.Key_Addr1_history,

          left.z5 != '' and
          left.prim_range != '' and
          keyed(left.z5 = right.zip) and
          keyed(left.prim_range = right.prim_range) and
          keyed(left.prim_name = right.prim_name) and
          keyed(left.addr_suffix = right.addr_suffix) and
          keyed(left.predir = right.predir) and
          keyed(left.postdir = right.postdir) and
          keyed(left.sec_range = right.sec_range)  and
          ((unsigned)RIGHT.date_first_seen < (unsigned)Risk_Indicators.iid_constants.full_history_date(left.historydate)),
          transform(ADVOLayout,
                      self.AddressVacancyInd := right.Address_Vacancy_Indicator,
                      self.dt_first_seen   := (integer)right.date_first_seen,
                      self := left,
                      self := []), left outer,
          atmost(riskwise.max_atmost));

withAdvo1DD :=  dedup(sort(withAdvo, seq, did, z5,prim_range,
                              prim_name, addr_suffix, predir, postdir, sec_range, -dt_first_seen),
                              seq, did,  z5, prim_range, prim_name, addr_suffix, predir, postdir, sec_range  );


AddADVO := join(EstimateIncome, withAdvo1DD,
                left.seq = right.seq and
                left.did = right.did and
                left.prim_name = right.prim_name and
                left.prim_range = right.prim_range and
                left.z5 = right.z5,
                transform(AddrslimLayout,
                            self.AddressVacancyInd  := right.AddressVacancyInd, self := left),
                left outer);

//rollup current and input address

AddrslimLayout ROLLUPADDR(AddADVO le, AddADVO ri) := TRANSFORM

  self.HRBusPctNeighborhood   := le.HRBusPctNeighborhood or ri.HRBusPctNeighborhood;
  self.HighFelonNeighborhood   := le.HighFelonNeighborhood or ri.HighFelonNeighborhood;
  self.AddressVacancyInd   := if(le.AddressVacancyInd = 'Y', le.AddressVacancyInd, ri.AddressVacancyInd);
  self.EasiTotCrime   := (string)max((integer)le.EasiTotCrime, (integer)ri.EasiTotCrime);
  self.CountyBordersForgeinJur :=  le.CountyBordersForgeinJur or ri.CountyBordersForgeinJur;
  self.CountyborderOceanForgJur := le.CountyborderOceanForgJur or ri.CountyborderOceanForgJur;
  self.CityBorderStation := le.CityBorderStation or ri.CityBorderStation;
  self.CityFerryCrossing :=  le.CityFerryCrossing or ri.CityFerryCrossing;
  self.CityRailStation := le.CityRailStation or ri.CityRailStation;
  self.HIDTA := le.HIDTA or ri.HIDTA;
  self.HIFCA := le.HIFCA or ri.HIFCA;
  self.IsPrison := le.IsPrison or ri.IsPrison;
  self.estimated_income:=   Max(le.estimated_income, ri.estimated_income);
  self := le;
END;

rolledAddrRisk := rollup(AddADVO, left.seq = right.seq and
                                    left.did = right.did,
                                    ROLLUPADDR(left,right));

Layouts.LayoutAMLShellV2 GetAMLlayout(idsIN le, rolledAddrRisk ri) := TRANSFORM
//todo check city state and in constants - spaces
  self.HRBusPctNeighborhood   :=  ri.HRBusPctNeighborhood;
  self.HighFelonNeighborhood   :=  ri.HighFelonNeighborhood;
  self.AddressVacancyInd   :=  ri.AddressVacancyInd;
  self.EasiTotCrime   := ri.EasiTotCrime;
  self.CountyBordersForgeinJur :=   ri.CountyBordersForgeinJur;
  self.CountyborderOceanForgJur :=  ri.CountyborderOceanForgJur;
  self.CityBorderStation :=  ri.CityBorderStation;
  self.CityFerryCrossing :=   ri.CityFerryCrossing;
  self.CityRailStation :=  ri.CityRailStation;
  self.HIDTA := ri.HIDTA;
  self.HIFCA := ri.HIFCA;
  self.IsPrison := ri.IsPrison;
  self.estimated_income:= ri.estimated_income;
  self := le;
END;


PrepLayout := join(idsIN, rolledAddrRisk,
                    left.seq = right.seq and
                    left.did = right.did,
                    GetAMLlayout(left, right), left outer);

// output(NormAddrs, named('NormAddrs'));
// output(SDaddrs, named('SDaddrs'));
// output(addHRBusiness, named('addHRBusiness'));
// output(easiCensus, named('easiCensus'));
// output(prison1, named('prison1'));
// output(EstimateIncome, named('EstimateIncome'));
// output(withAdvo, named('withAdvo'));
// output(withAdvo1DD, named('withAdvo1DD'));
// output(AddADVO, named('AddADVO'));
// output(rolledAddrRisk, named('rolledAddrRisk'));

RETURN PrepLayout;

END;
