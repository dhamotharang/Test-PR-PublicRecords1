IMPORT Address_Attributes, Business_Header, ut, ADVO, Business_Risk, Risk_indicators, RiskWise, Address, YellowPages, Easi;

EXPORT BusnAddrAttrib(DATASET(Layouts.BusnExecsLayoutV2) BusnIds) := FUNCTION

//Version 2

riskKey := Address_Attributes.key_AML_addr;

DDAddress  :=  dedup(sort(BusnIds, seq,origbdid, prim_range, prim_name, addr_suffix, postdir, z5),seq,origbdid, prim_range, prim_name, addr_suffix, postdir, z5);

RiskLayout := RECORD
	unsigned4	seq := 0;
	unsigned4	historydate;
	unsigned6  OrigBdid;
	unsigned6 	bdid := 0;
	unsigned6 	did := 0;
	boolean    LinkedBusn ;
	boolean   	isExec;
	unsigned2 	score := 0;
	string30	 	account := '';
	STRING120  cnp_name;
	string120 	company_name := '';
	unsigned3 	cmpymatch_score;
	boolean 		cmpymatch;
	string10  	prim_range := '';
	string2   	predir := '';
	string28  	prim_name := '';
	string4   	addr_suffix := '';
	string2   	postdir := '';
	string10  	unit_desig := '';
	string8   	sec_range := '';
	string25  	p_city_name := '';
	string25		v_city_name := '';
	string2   	st := '';
	string5   	z5 := '';
	STRING60  CmpyType;
	STRING10  cnp_phone;
	STRING9 	cnp_fein;
	BOOLEAN		potential_shelf		:= FALSE;
	STRING4		shelf_reason;
	INTEGER4	bizCnt;
	INTEGER4 	hifcaRiskKey;
	INTEGER4	inc_st_loose;
	INTEGER4	inc_st_loose_cnt;
	INTEGER4	trust;
	STRING60	company_org_structure_derived;
	INTEGER4	no_fein;
	INTEGER4 no_fein_cnt;
	INTEGER4 vacant;
	INTEGER4 naics_risk_high;
	INTEGER4 naics_risk_med;
	INTEGER4 naics_risk_low;
	BOOLEAN	potentialNIS			:=	FALSE;
	INTEGER4	storage;
	INTEGER4	priv_post;
	INTEGER4	undel_sec;
	INTEGER4	drop;
  BOOLEAN	potential_remail	:=	FALSE;
	BOOLEAN LooseStateIncorpPct;   //inc_st_loose_cnt / bzn_cnt  when the bzn_cnt > 100
	BOOLEAN NoFeinBusnPct;    //no_fein_cnt / bzn_cnt  when the bzn_cnt > 100


END;


gScore(UNSIGNED1 i) := i BETWEEN Risk_Indicators.iid_constants.min_score AND 100;


RiskLayout  GetRisk(DDAddress le, riskKey ri)  := TRANSFORM
		cmpymatch_score 	:= Business_Risk.CnameScore(le.company_name, ri.cnp_name);
		cmpymatch 		:= gScore(cmpymatch_score);
		self.cmpymatch 		:= cmpymatch;
		self.cmpymatch_score := cmpymatch_score;
		SELF.seq  := le.seq;
		self.origbdid  := le.origbdid;
		self.bdid      :=  le.bdid;
		self.LinkedBusn   := le.LinkedBusn;
		self.isExec   := le.isExec;
		self.historydate := le.historydate;
		self.did   := le.did;
		self.bizCnt := ri.biz_cnt;
		self.hifcaRiskKey := ri.hifca;
		self.CmpyType   := if(ri.trust >= 1 ,  'TRUST', trim(ri.company_org_structure_derived));
		self.no_fein_cnt   := ri.no_fein_cnt;
		self.no_fein := ri.no_fein;
		self.inc_st_loose   :=  ri.inc_st_loose;
	  self.inc_st_loose_cnt   :=  ri.inc_st_loose_cnt;
	  self.potentialNIS			:=	ri.potential_NIS;
	  self.storage    :=  ri.storage;
	  self.priv_post   :=  ri.priv_post;
	  self.undel_sec    :=  ri.undel_sec;
	  self.drop     :=   ri.drop;
    self.potential_remail	:=	ri.potential_remail;
		self.LooseStateIncorpPct := false;
	  self.NoFeinBusnPct  := false;
		self := le;
		self := ri;
END;

with_Risk := join(DDAddress, riskKey,
		KEYED(trim(LEFT.z5) 					= RIGHT.zip) AND
		KEYED(trim(LEFT.prim_range) 	= RIGHT.prim_range) AND
		KEYED(trim(LEFT.prim_name) 		= RIGHT.prim_name) AND
		KEYED(trim(LEFT.addr_suffix) 	= RIGHT.addr_suffix) AND
		KEYED(trim(LEFT.predir) 			= RIGHT.predir) AND
		KEYED(trim(LEFT.postdir)			= RIGHT.postdir) and
		(Business_Risk.CnameScore(left.company_name, right.cnp_name) between Risk_Indicators.iid_constants.min_score and 100) ,
	getRisk(LEFT, RIGHT),
	atmost(KEYED(trim(LEFT.z5) 					= RIGHT.zip) AND
		KEYED(trim(LEFT.prim_range) 	= RIGHT.prim_range) AND
		KEYED(trim(LEFT.prim_name) 		= RIGHT.prim_name) AND
		KEYED(trim(LEFT.addr_suffix) 	= RIGHT.addr_suffix) AND
		KEYED(trim(LEFT.predir) 			= RIGHT.predir) AND
		KEYED(trim(LEFT.postdir)			= RIGHT.postdir),100 ));

// sortwRisk := sort(with_Risk, seq, prim_range, prim_name, addr_suffix, postdir, z5);

GetMaxCnttbl := TABLE(with_Risk, {seq, prim_range,  predir, prim_name, addr_suffix, postdir, z5,
																integer maxbizCnt := Max(group,bizCnt),
																integer maxNofeincnt := Max(group,no_fein_cnt),
																integer maxIncStLooseCnt := Max(group,inc_st_loose_cnt)},
																seq, prim_range, predir, prim_name, addr_suffix, postdir, z5);


	GetRiskSS := ungroup(sort(with_Risk, seq, origbdid, bdid, did, -cmpymatch_score));

	//get business type

	 SortMatchScore :=    dedup(GetRiskSS(CmpyType <> ''), seq,origbdid, bdid, did);  // to get top match score
	 // SortMatchScore :=    dedup(sort(with_Risk(CmpyType <> ''), seq,origbdid, bdid, did, -cmpymatch_score), seq,origbdid, bdid, did);


	 TopMatchScore := join(GetRiskSS(CmpyType <> ''), SortMatchScore,
													left.seq = right.seq and
													left.origbdid = right.origbdid and
													left.bdid = right.bdid and
													left.did = right.did and
													left.cmpymatch_score = right.cmpymatch_score,
													transform(RiskLayout,
																			self := left));

	RiskLayout  GetCmpyType(TopMatchScore le, TopMatchScore ri) := TRANSFORM

		self.CmpyType  := map(le.CmpyType	= 'TRUST' OR RI.CmpyType = 'TRUST'  => 'TRUST',
														le.CmpyType	= 'LIMITED LIABILITY CORPORATION' OR RI.CmpyType = 'LIMITED LIABILITY CORPORATION'   => 'LIMITED LIABILITY CORPORATION',
														le.CmpyType	= 'FOREIGN LLC' OR RI.CmpyType = 'FOREIGN LLC'   => 'FOREIGN LLC',
														le.CmpyType	= 'FOREIGN CORPORATION-NON FOR PROFIT' OR RI.CmpyType = 'FOREIGN CORPORATION-NON FOR PROFIT'   => 'FOREIGN CORPORATION-NON FOR PROFIT',
														le.CmpyType = 'CORPORATION-NON FOR PROFIT' OR RI.CmpyType = 'CORPORATION-NON FOR PROFIT'  => 'CORPORATION-NON FOR PROFIT',
														le.CmpyType =  'CORPORATION-BUSINESS' OR RI.CmpyType = 'CORPORATION-BUSINESS'  => 'CORPORATION-BUSINESS',
														le.CmpyType	= 'FOREIGN CORPORATION' 	 OR RI.CmpyType = 'FOREIGN CORPORATION' 	   => 'FOREIGN CORPORATION' 	,
														le.CmpyType	= 'ASSUMED NAME/DBA' OR RI.CmpyType = 'ASSUMED NAME/DBA'   => 'ASSUMED NAME/DBA',
														le.CmpyType	= 'PROPRIETORSHIP' OR RI.CmpyType = 'PROPRIETORSHIP'   => 'PROPRIETORSHIP',
														le.CmpyType	= 'PROFESSIONAL CORPORATION' OR RI.CmpyType = 'PROFESSIONAL CORPORATION'   => 'PROFESSIONAL CORPORATION',
														le.CmpyType	=  'PROFESSIONAL ASSOCIATION'  OR RI.CmpyType =  'PROFESSIONAL ASSOCIATION'    =>  'PROFESSIONAL ASSOCIATION' ,
														le.CmpyType	= 'LIMITED PARTNERSHIP' OR RI.CmpyType = 'LIMITED PARTNERSHIP'   => 'LIMITED PARTNERSHIP',
														le.CmpyType	= 'LIMITED LIABILITY PARTNERSHIP' OR RI.CmpyType = 'LIMITED LIABILITY PARTNERSHIP'  => 'LIMITED LIABILITY PARTNERSHIP',
														 '');
		self := le;

END;
   RollCmpytype := rollup(TopMatchScore,
													left.seq = right.seq and
													left.OrigBdid = right.OrigBdid and
													left.bdid = right.bdid  and
													left.did = right.did and
													left.cmpymatch_score = right.cmpymatch_score,
													GetCmpyType(left, right));


	RiskLayout  RollAddrRisk(GetRiskSS le, GetRiskSS ri) := TRANSFORM
	  sameBDID := le.bdid = ri.bdid and le.did = ri.did;
		self.cnp_phone := if(le.cnp_phone = '', ri.cnp_phone, le.cnp_phone);
		self.cnp_fein := if(le.cnp_fein = '', ri.cnp_fein, le.cnp_fein);

		self.naics_risk_high := max(le.naics_risk_high,ri.naics_risk_high);
		self.naics_risk_med := max(le.naics_risk_med , ri.naics_risk_med);
		self.naics_risk_low  :=  max(le.naics_risk_low , ri.naics_risk_low);
		self.potential_shelf  :=  le.potential_shelf or ri.potential_shelf;
		self.hifcaRiskKey  :=  max(le.hifcaRiskKey, ri.hifcaRiskKey);
		self.vacant  :=  max(le.vacant , ri.vacant);

		self.bdid := if(~sameBDID, le.bdid, ri.bdid);
		self.seq := if(~sameBDID, le.seq, ri.seq);
		self.origbdid := if(~sameBDID, le.origbdid, ri.origbdid);
		self.LinkedBusn := if(~sameBDID, le.LinkedBusn, ri.LinkedBusn);
		self.isExec := if(~sameBDID, le.isExec, ri.isExec);
	// new fields
		self.inc_st_loose   :=  max(le.inc_st_loose,ri.inc_st_loose);
	  self.potentialNIS			:=	le.potentialNIS or   ri.potentialNIS;
	  self.storage    :=  max(le.storage,ri.storage);
	  self.priv_post   :=  max(le.priv_post, ri.priv_post);
	  self.drop     :=   max(le.drop, ri.drop);
    self.potential_remail	:=	le.potential_remail or ri.potential_remail;
		self.no_fein   := max(le.no_fein, ri.no_fein);
		self := le;
		self := [];
END;

RolledAddrRisk	 :=   rollup(GetRiskSS,
													left.seq = right.seq and
													left.OrigBdid = right.OrigBdid and
													left.bdid = right.bdid  and
													left.did = right.did,
													RollAddrRisk(left, right));

addcmpytype:= join(RolledAddrRisk ,RollCmpytype,
                      left.seq = right.seq and
											left.OrigBdid = right.OrigBdid and
											left.bdid = right.bdid  and
											left.did = right.did,
											transform(RiskLayout,
																	self.CmpyType := right.cmpyType,
																	self := left), left outer);


addAddrMaxCnt := join(addcmpytype ,GetMaxCnttbl,
                      left.seq = right.seq and
											left.z5 = right.z5 and
											left.prim_range = right.prim_range and
											left.prim_name = right.prim_name  and
											left.addr_suffix = right.addr_suffix and
											left.predir = right.predir and
											left.postdir = right.postdir ,
											transform(RiskLayout,
																self.LooseStateIncorpPct := If(right.maxbizCnt > 100 and  round((right.maxIncStLooseCnt/right.maxbizCnt) * 100) >= 25, true, false);
																self.NoFeinBusnPct  := If(right.maxbizCnt > 100 and  round((right.maxNofeincnt/right.maxbizCnt) * 100) >= 75, true, false);
																self := left), left outer);

	CheckSecRange := join(BusnIds(sec_range <> ''), with_Risk(sec_range <> ''),
												(trim(LEFT.z5) 					= RIGHT.z5) AND
												(trim(LEFT.prim_range) 	= RIGHT.prim_range) AND
												(trim(LEFT.prim_name) 		= RIGHT.prim_name) AND
												(trim(LEFT.addr_suffix) 	= RIGHT.addr_suffix) AND
												(trim(LEFT.predir) 			= RIGHT.predir) AND
												(trim(LEFT.postdir)			= RIGHT.postdir) and
												(trim(LEFT.sec_range)		= RIGHT.sec_range) and
												RIGHT.undel_sec = 1,
												transform(RiskLayout,
																self.undel_sec    :=  right.undel_sec,
																self.seq := left.seq ,
																self.origbdid := left.origbdid,
																self.bdid := left.bdid,
																self := right,
																self := left,
																self := []), keep(1));

	AddSecRangeDel := join(addAddrMaxCnt, CheckSecRange,
													left.seq = right.seq and
													left.OrigBdid = right.OrigBdid and
													left.bdid = right.bdid  and
													left.did = right.did,
													transform(RiskLayout,
																self.undel_sec    :=  right.undel_sec,
																self := left), left outer);

Layouts.BusnExecsLayoutV2  AddRisk(BusnIds le, AddSecRangeDel ri) := TRANSFORM
		self.seq  := le.seq;
		self.origbdid  := le.origbdid;
		self.bdid      :=  le.bdid;
		self.LinkedBusn   := le.LinkedBusn;
	  self.isExec   := le.isExec;
		self.busnType  := ri.CmpyType;
		self.AddressVacancyInd := if(ri.vacant > 0, 'Y', 'N');
		self.ShelfBusn := ri.potential_shelf;
		self.NoFein := ri.no_fein > 0 and le.fein = '';
		self.BusnRisklevel  := Map(
														ri.naics_risk_high > 0 => 'HIGH',
														ri.naics_risk_med > 0 =>  'MED',
														ri.naics_risk_low > 0 =>  'LOW',
														'UNK'),
		self.HIFCA  := if(ri.hifcaRiskKey > 0, true, false);
		self.undel_sec    :=  ri.undel_sec;
		self.drop := if(ri.drop > 0, true, false);
		self.priv_post := if(ri.priv_post > 0, true, false);
		self.storage := if(ri.storage > 0, true, false);
		self.potentialNIS := ri.potentialNIS;
		self.busAddrCntLooseIncorp  := ri.LooseStateIncorpPct;
		self.BusAddrCntnoFein := ri.NoFeinBusnPct;
		self.inc_st_loose := ri.inc_st_loose;
		self := le;
END;

AddRiskDtl   := join(BusnIds, AddSecRangeDel,
										left.seq = right.seq and
										left.origbdid = right.origbdid and
										left.bdid = right.bdid,
										AddRisk(left,right), left outer);


//  need to check both input and best for the following items for just input business (10)  other business only have best address appended

//  todo have to check input business (10) best addr vs input addr

BusAddrslimLayout := RECORD
  UNSIGNED4 seq;
	UNSIGNED3 historydate;
	unsigned6   OrigBdid;
	unsigned6 	bdid;
	integer  relatdegree;
	string120 	company_name;
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
	string3 county;
	string7 geo_blk;
	boolean   HRBusPctNeighborhood;
	boolean 	HighFelonNeighborhood;
	string1  	AddressVacancyInd;
	string3		EasiTotCrime;
	boolean   CountyBordersForgeinJur ;
	boolean   CountyborderOceanForgJur ;
	boolean   CityBorderStation ;
	boolean   CityFerryCrossing ;
	boolean   CityRailStation ;
	boolean   HIDTA ;
	boolean   HIFCA ;
	string4   	HRBusnSIC;
	string4   	HRBusnYPNAICS;
	string4   	BusnRisklevel;
	string5    IndustryNAICS;
	string5    FIPsCode;
	boolean    HRBusPct;
END;

BusAddrslimLayout NormAddr(BusnIds le, INTEGER C) := TRANSFORM
	SELF.seq := le.seq;
	self.OrigBdid := le.OrigBdid;
	self.bdid := le.bdid;
	self.company_name := le.company_name;
	cleanedBestaddr := Risk_Indicators.MOD_AddressClean.clean_addr(le.bestAddr, le.bestCity, le.bestState, le.bestZip);
	self.prim_range  := CHOOSE(C, le.prim_range, Address.CleanFields(cleanedBestaddr).Prim_Range);
	self.predir  :=   CHOOSE(C,le.predir, Address.CleanFields(cleanedBestaddr).Predir);
	self.prim_name   :=   CHOOSE(C,le.prim_name,Address.CleanFields(cleanedBestaddr).Prim_Name);
	self.addr_suffix  :=   CHOOSE(C,le.addr_suffix,Address.CleanFields(cleanedBestaddr).Addr_Suffix);
	self.postdir   :=   CHOOSE(C,le.postdir,Address.CleanFields(cleanedBestaddr).Postdir);
	self.unit_desig   :=  CHOOSE(C,le.unit_desig,Address.CleanFields(cleanedBestaddr).Unit_Desig);
	self.sec_range   :=  CHOOSE(C,le.sec_range,Address.CleanFields(cleanedBestaddr).Sec_Range);
	self.city_name   := CHOOSE(C,le.p_city_name,Address.CleanFields(cleanedBestaddr).P_City_Name);
	self.st    :=  CHOOSE(C,le.st,Address.CleanFields(cleanedBestaddr).St);
	self.z5   := CHOOSE(C,le.z5,Address.CleanFields(cleanedBestaddr).Zip);
	self.county   := CHOOSE(C,le.county,Address.CleanFields(cleanedBestaddr).County[3..5]);
	self.geo_blk   := CHOOSE(C,le.geo_blk,Address.CleanFields(cleanedBestaddr).Geo_Blk);
	self := [];
END;

NormAddrs :=  NORMALIZE(BusnIds,2,NormAddr(LEFT,COUNTER));

SDAddrs := dedup(sort(NormAddrs, seq, OrigBdid, bdid, z5,prim_range,	prim_name, addr_suffix, predir, postdir, sec_range),
																	seq, OrigBdid,bdid, z5,prim_range,	prim_name, addr_suffix, predir, postdir, sec_range);

withNaics := join(SDAddrs,  YellowPages.Key_YellowPages_BDID,
												left.bdid != 0 and
												keyed(left.bdid = right.bdid) and
												right.naics_code <> '' and
												(right.naics_code[1..2] in AML.AMLConstants.naics_risk_high or
												 right.naics_code[1..2] in AML.AMLConstants.naics_risk_med or
												 right.naics_code[1..2] in AML.AMLConstants.naics_risk_low ),
												transform(BusAddrslimLayout,
																		self.HRBusnYPNAICS := map(
																															right.naics_code[1..2] in AML.AMLConstants.naics_risk_high or
																															right.naics_code in AML.AMLConstants.naics_highRisk_excep      =>  'HIGH',
																															right.naics_code[1..2] in AML.AMLConstants.naics_risk_med      =>  'MED',
																															right.naics_code[1..2] in AML.AMLConstants.naics_risk_low      =>  'LOW',
																															'UNK'),
																		self.IndustryNAICS := map(
																																right.naics_code in AML.AMLConstants.CIBNAICS      =>  'CIB',
																																right.naics_code in AML.AMLConstants.MSBNAICS      =>  'MSB',
																																right.naics_code in AML.AMLConstants.NBFINAICS     =>  'NBFI',
																																right.naics_code in AML.AMLConstants.CASGAMNAISC   =>  'CAS',
																																right.naics_code in AML.AMLConstants.LEGTRAVNAISC  =>  'LEG',
																																right.naics_code in AML.AMLConstants.AUTONAISC     =>  'AUTO',
																																'OTHER'),
																																self := left),
													atmost(riskwise.max_atmost), LEFT OUTER,keep(1));

withSIC := JOIN(withNaics,Business_header.key_sic_code,
								KEYED(left.bdid = right.bdid) and
								right.sic_code <> '' and
								(right.sic_code[1..4] in AML.AMLConstants.setHRBusCatgSicCds or
								right.sic_code in AML.AMLConstants.setHRBusFullSicCds),
								transform(BusAddrslimLayout,
													self.origBdid := left.origBdid,
													self.seq := left.seq,
                          self.HRBusnSIC := map(right.sic_code[1..4] in AML.AMLConstants.setHRBusCatgSicCds or
																								right.sic_code in AML.AMLConstants.setHRBusFullSicCds  => 'HIGH',
																								right.sic_code <> '' =>  'LOW',
																								'UNK');
													FipsAddrtoUse :=  ut.st2FipsCode(StringLib.StringToUpperCase(left.st)) + left.county;
													CityState := left.city_name + ','+ left.st;
													self.FIPsCode := FipsAddrtoUse,
													self.CountyBordersForgeinJur  := FipsAddrtoUse in amlconstants.CountyForeignJurisdic,
													self.CountyborderOceanForgJur  := FipsAddrtoUse in amlconstants.CountyBordersOceanForgJur,
													self.CityBorderStation  := CityState in AMLconstants.CityBorderStation,
													self.CityFerryCrossing  := CityState in amlconstants.CityFerryCrossing,
													self.CityRailStation  := CityState in amlconstants.CityRailStation,
													self.HIDTA  := FipsAddrtoUse in AMLConstants.setHIDTA,
													self.HIFCA  := FipsAddrtoUse in AMLConstants.setHIFCA,
													self:= left),
								atmost(riskwise.max_atmost),
								left outer, keep(1));



// crime geolink
crimeGeolink := Address_Attributes.key_crime_geolink;

	GeoCrime := join(withSIC, crimeGeolink,
		keyed(right.geolink=left.st+left.county+left.geo_blk),
		transform({recordof(crimeGeolink), unsigned4 seq, unsigned6 bdid},

						self.seq := left.seq;
						self.bdid := left.bdid;
						self := right;
						self := [];
		), left outer,
		ATMOST(keyed(right.geolink=left.st+left.county+left.geo_blk), Riskwise.max_atmost), KEEP(1));

AddGeoCrime	:=  join(withSIC, GeoCrime,
												left.seq=right.seq
												and left.bdid=right.bdid,
                        transform(BusAddrslimLayout,
                              		 self.HighFelonNeighborhood := 100 * right.felon_ratio > 8,  //  check against  .08 todo
																	 self := left),
												atmost(Riskwise.max_atmost),left outer);

addHRBusiness :=  join(AddGeoCrime, Address_Attributes.key_business_risk_geolink,
                        keyed(right.geolink=left.st+left.county+left.geo_blk),
												transform(BusAddrslimLayout,
                              		 Self.HRBusPct :=if(((right.cnt_shell+right.cnt_shelf) / right.cnt_businesses)>= .1, TRUE, FALSE),
																	 self := left),
												atmost(Riskwise.max_atmost),
												left outer, keep(1));

//  add advo

AdvoKey := Advo.Key_Addr1_history;
withAdvo := join(BusnIds, AdvoKey,

					left.z5 != '' and
					left.prim_name != '' and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.addr_suffix = right.addr_suffix) and
					keyed(left.predir = right.predir) and
					keyed(left.postdir = right.postdir) and
					keyed(left.sec_range = right.sec_range)  and
					// vacancy = 'Y'  to filter and reduce recs  todo
					(unsigned4)(RIGHT.date_first_seen) <= (unsigned4)(string8)(left.historydate + '01'),
					transform({recordof(AdvoKey), unsigned4 seq, unsigned6 Bdid},
					           self.seq := left.seq,
										 self.Bdid := left.Bdid,
										 self := right),
											left outer,
					atmost(riskwise.max_atmost),keep(100));


withAdvo1DD :=  dedup(sort(withAdvo, seq, bdid, zip,prim_range,
															prim_name, addr_suffix, predir, postdir, sec_range, -date_first_seen),
															seq, bdid,	zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range	);



withAdvoVac := join(addHRBusiness, withAdvo1DD,
							left.seq=right.seq and left.bdid=right.bdid,
							transform(BusAddrslimLayout,
									self.AddressVacancyInd := if(right.Address_Vacancy_Indicator = '', 'U', right.Address_Vacancy_Indicator),
                  self := left), left outer);

withEasiCensus := join(withAdvoVac, Easi.Key_Easi_Census,
		keyed(right.geolink=left.st+left.county+left.geo_blk),
		transform(BusAddrslimLayout,
      self.EasiTotCrime := right.totcrime;
						self := left;), left outer,
		ATMOST(keyed(right.geolink=left.st+left.county+left.geo_blk), Riskwise.max_atmost), KEEP(1));


BusAddrslimLayout RollAddrs(withEasiCensus le,withEasiCensus ri) := TRANSFORM  // move up in prev tform  todo
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
	SELF.HRBusnSIC  := map(le.HRBusnSIC = 'HIGH' or ri.HRBusnSIC  = 'HIGH'  => 'HIGH',
													le.HRBusnSIC = 'LOW' or ri.HRBusnSIC  = 'LOW'  => 'LOW',
													'UNK');
	self.HRBusnYPNAICS := map(
															le.HRBusnYPNAICS = 'HIGH' OR ri.HRBusnYPNAICS = 'HIGH'   		=>  'HIGH',
															le.HRBusnYPNAICS = 'MED' OR ri.HRBusnYPNAICS = 'MED' 	     	=>  'MED',
															le.HRBusnYPNAICS = 'LOW' OR ri.HRBusnYPNAICS = 'LOW'					=>  'LOW',
															'UNK');
	self.IndustryNAICS := map(
															le.IndustryNAICS = 'CIB' OR ri.IndustryNAICS = 'CIB'  =>  'CIB',
															le.IndustryNAICS = 'MSB' OR ri.IndustryNAICS = 'MSB'  =>  'MSB',
															le.IndustryNAICS = 'NBFI' OR ri.IndustryNAICS = 'NBFI'  =>  'NBFI',
															le.IndustryNAICS = 'CAS' OR ri.IndustryNAICS = 'CAS'  =>  'CAS',
															le.IndustryNAICS = 'LEG' OR ri.IndustryNAICS = 'LEG'  =>  'LEG',
															le.IndustryNAICS = 'AUTO' OR ri.IndustryNAICS = 'AUTO'  =>  'AUTO',
															'OTHER');

	SELF.BusnRisklevel  := MAP(
														LE.BusnRisklevel = 'HIGH' OR ri.BusnRisklevel = 'HIGH' => 'HIGH',
														LE.BusnRisklevel = 'MED' OR ri.BusnRisklevel = 'MED' =>  'MED',
														LE.BusnRisklevel = 'LOW' OR ri.BusnRisklevel = 'LOW'=>  'LOW',
														'UNK'),

	self.HRBusPct  := le.HRBusPct or ri.HRBusPct;
	self := le;
END;


GetHRAreas := rollup(withEasiCensus, left.seq = right.seq and
																			left.bdid = right.bdid and
																			left.origbdid = right.origbdid,
																				RollAddrs(left, right));

addHRdata := join(AddRiskDtl, GetHRAreas,
										left.seq = right.seq and
										left.bdid = right.bdid and
										left.origbdid = right.origbdid,
										transform(	Layouts.BusnExecsLayoutV2,
																self.HRBusPct   :=  right.HRBusPct;
																self.HighFelonNeighborhood   := right.HighFelonNeighborhood;
																self.AddressVacancyInd   := right.AddressVacancyInd;
																self.EasiTotCrime   := right.EasiTotCrime;
																self.CountyBordersForgeinJur :=  right.CountyBordersForgeinJur;
																self.CountyborderOceanForgJur := right.CountyborderOceanForgJur;
																self.CityBorderStation := right.CityBorderStation;
																self.CityFerryCrossing :=  right.CityFerryCrossing;
																self.CityRailStation := right.CityRailStation;
																self.HIDTA := right.HIDTA;
																self.HIFCA := right.HIFCA;
																SELF.HRBusnSIC   := right.HRBusnSIC;
																self.HRBusnYPNAICS  := right.HRBusnYPNAICS;
																self.IndustryNAICS  := right.IndustryNAICS;
																SELF.BusnRisklevel  := right.BusnRisklevel;
																self := left;),
																left outer);


//  highrisk address
Layouts.BusnExecsLayoutV2 hrtrans(addHRdata l, risk_indicators.key_HRI_Address_To_SIC r) := transform
  baddrtype		 := if (L.prim_name = '', '', risk_indicators.iid_constants.dwelltype(L.addr_type));
	self.hriskaddrflag := MAP(baddrtype = 'M' => '3',
															l.prim_name='' OR l.z5='' => '5',
															r.sic_code in ['2310','2300','2220','2280','2320']  => '4',
															'');
	self.dwelltype := Risk_Indicators.iid_constants.dwelltype(L.addr_type);
	self 			:= l;
	self      := [];
END;


AddHRSIC := join(addHRdata, risk_indicators.key_HRI_Address_To_SIC,
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




// output(BusnIds, named('AllBusnaddr'));
// output(with_risk, named('with_risk'));
// output(GetAddrMaxCount, named('GetAddrMaxCount'));
// output(GetRiskSS, named('GetRiskSS'));
// output(SortMatchScore, named('SortMatchScore'));
// output(TOPMatchScore, named('TopMatchScore'));
// output(RollCmpytype, named('RollCmpytype'));
// output(addcmpytype, named('addcmpytype'));
// output(RolledAddrRisk, named('RolledAddrRisk'));
// output(sortwRisk, named('sortwRisk'));
// output(GetAddrMaxCount, named('GetAddrMaxCount'));
// output(GetMaxCnttbl, named('GetMaxCnttbl'));
// output(addAddrMaxCnt, named('addAddrMaxCnt'));
// output(CheckSecRange, named('CheckSecRange'));
// output(AddSecRangeDel, named('AddSecRangeDel'));
// output(AddRiskDtl, named('AddRiskDtl'));
// output(withNaics, named('withNaics'));
// output(withSIC, named('withSIC'));
// output(GeoCrime, named('GeoCrime'));
// output(AddGeoCrime, named('AddGeoCrime'));
// output(withAdvo, named('withAdvo'));
// output(withAdvo1DD, named('withAdvo1DD'));
// output(withAdvoVac, named('withAdvoVac'));
// output(withEasiCensus, named('withEasiCensus'));
// output(GetHRAreas, named('GetHRAreas'));
// output(AddHRSIC, named('AddHRSIC'));


RETURN AddHRSIC;

END;
