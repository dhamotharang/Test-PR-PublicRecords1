import location_services, doxie, doxie_ln, doxie_raw, header, ut, Census_Data,
       LN_PropertyV2, DeathV2_Services;


export location_report(DATASET(Doxie_Raw.Layout_address_input) addr_in, 
											 boolean royaltyout = FALSE, 
											 boolean useBusinessIds = FALSE) :=  FUNCTION

doxie.MAC_Selection_Declare();
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
glb_ok := mod_access.isValidGLB();
dppa_ok := mod_access.isValidDPPA();


addrDidsWithInputs := location_services.getDids(addr_in, mod_access.application_type);

didsOnly := PROJECT(addrDidsWithInputs, doxie.layout_references);

doxie.mac_best_records(didsOnly,did,bestrec,dppa_ok,glb_ok,false, mod_access.DataRestrictionMask,include_DOD:=true);

propk := LN_PropertyV2.key_Property_did();

didsFids := RECORD
	layout_did_addr;
	string12  fid;
	string2   src;
END;

didsFids getFids(addrDidsWithInputs l, propk r) := TRANSFORM
	SELF.fid := r.ln_fares_id;
	SELF.src := r.source_code;
	SELF := L;
END;

// need to limit this and keep a subset -- bug #16333
fids := join(addrDidsWithInputs, propk, keyed(left.did = right.s_did) AND
																				RIGHT.source_code[2]='P', getFids(LEFT, RIGHT),
																				keep(200), limit(0));
propAddrFids := dedup(sort(fids,did,fid), RECORD);

propSrchFields := RECORD
	layout_did_addr did_addr;
	LN_PropertyV2.layout_search_building;
END;

propSrchFields getPropSrchFields(propAddrFids l, recordof(LN_PropertyV2.key_search_fid()) r) := TRANSFORM
	SELF.did := l.did;
	self.did_addr := l;
	SELF := r;
END;

withProp := join(propAddrFids, LN_PropertyV2.key_search_fid(), 
                 keyed(left.fid = right.ln_fares_id) and right.source_code_2 = 'P' and
								 LEFT.prim_name = RIGHT.prim_name and 
								 LEFT.prim_range = RIGHT.prim_range and 
								 LEFT.st = RIGHT.st,  
								 getPropSrchFields(LEFT,RIGHT));

withPropD := dedup(sort(withProp, did, -process_date), RECORD);

addrs := join(addrDidsWithInputs,doxie.key_header,
              LEFT.did = RIGHT.s_did,
              transform (header.Layout_Header, Self := RIGHT),
              LIMIT (ut.limits.DID_PER_PERSON, SKIP));
// eliminate any header records with sensitive DIDs or SSNs
header.MAC_GlbClean_Header(addrs, addrs2, , , mod_access);

bestnames := JOIN(withPropD,addrs2,
									 LEFT.did = RIGHT.did and LEFT.fname = RIGHT.fname and 
									 LEFT.lname = RIGHT.lname,
									 transform (propSrchFields, Self := LEFT));
// prefer seller over buyer
bestNamesD := dedup(sort(bestNames, did, -source_code), did);

owners := bestNamesD(source_code[1] = 'O');
sellers := bestNamesD(source_code[1] = 'S');

Layout_Location_slim getJoinedAddrs(addrs2 L) := TRANSFORM
	SELF := L;
END;

joinedAddrs := join(addrs2, addr_in, LEFT.prim_name = RIGHT.prim_name and
                    LEFT.prim_range = RIGHT.prim_range and
										// still need to figure out how tight these matches should be
										//ut.NNEQ(predir, predir_value),
										//ut.NNEQ(postdir, postdir_value),
										LEFT.predir = RIGHT.predir and
										LEFT.postdir = RIGHT.postdir and
										LEFT.sec_range = RIGHT.sec_range and
										LEFT.city_name = RIGHT.city_name and
										LEFT.st = RIGHT.st and
										ut.NNEQ(LEFT.zip, RIGHT.zip) and
										ut.NNEQ(LEFT.suffix, RIGHT.suffix), getJoinedAddrs(LEFT));
addrVars := dedup(sort(joinedAddrs, RECORD), EXCEPT zip4);

addrVarsAsInput := PROJECT(addrVars, doxie_raw.Layout_address_input);

busMod := GetByBDID(addr_in, mod_access.application_type);

busFids := IF(useBusinessIds, GetByBusinessIds(addr_in).GetPropFids(), 
													    busMod.GetPropFids());

deed_out := Location_Services.deed_records(addrVarsAsInput,busFids);

asset_out := Location_Services.asses_records(addrVarsAsInput,busFids);

//get the standard property format for deeds and asses records 
std_property := doxie_ln.make_property_records(asset_out, deed_out, false, bestrec);
//eventually use the stuff that Chad did
//std_property := doxie_ln@property_records;


Layout_Location_slim takeAddrs(propSrchFields L) := TRANSFORM
	SELF.city_name := L.p_city_name;
	SELF := L;
END;

propAddrs := PROJECT(withPropD, takeAddrs(LEFT));

addrVarsCombined := DEDUP(SORT(addrVars + propAddrs, RECORD), EXCEPT zip4);

// can probably just do one project into the Assoc record
Doxie.Layout_Best getBestAddrs(bestrec r) := TRANSFORM
	SELF := r;
END;

bestaddrs := JOIN(addrVars,bestrec,
									 LEFT.prim_name = RIGHT.prim_name and 
									 LEFT.prim_range = RIGHT.prim_range and 
									 LEFT.st = RIGHT.st,
									 getBestAddrs(RIGHT));

headerRecs := header_records(addrDidsWithInputs);

//only want a single header record for the neighbors call that matches the input
//data
header.Layout_Header getHeaderRec(header.Layout_Header L) := TRANSFORM
	SELF := L;
END;

neighborInput := JOIN(headerRecs, addr_in,
                      LEFT.prim_range = RIGHT.prim_range and
											LEFT.prim_name = RIGHT.prim_name and
											LEFT.st = RIGHT.st and
											LEFT.city_name = RIGHT.city_name and
											LEFT.predir = RIGHT.predir and
											LEFT.postdir = RIGHT.postdir and
											LEFT.suffix = RIGHT.suffix and
											LEFT.zip = RIGHT.zip and
											LEFT.sec_range = RIGHT.sec_range, getHeaderRec(LEFT));								

doxie.layout_nbr_targets addTargetSeq(neighborInput L, integer C) := transform
	self.seqTarget := C;
	self := L;
end;
nbrTargets := PROJECT(choosen(neighborInput,1), addTargetSeq(LEFT,COUNTER));

neighbors := doxie.nbr_records(
	nbrTargets,
	'C', // current neighbors only
	Max_Neighborhoods,
	Neighbors_PerAddress,
	Neighbors_Per_NA,
	Neighbor_Recency,
	,,,false,
	mod_access
);

Layout_report.Location_info getLocInfo(withPropD L, Doxie_Raw.Layout_address_input R) := TRANSFORM
	SELF.lat := L.geo_lat;
	SELF.lon := L.geo_long;
	SELF.msa := L.msa;
	SELF.msaDesc := IF(L.msa <>'',ziplib.MSAToCityState(L.msa), '');
	SELF.unit_desig := L.unit_desig;
	SELF := R;
END;

//pick up inputs always, even if withPropD is empty;  app keys off these fields 
//being present always
locInfo := JOIN(withPropD, addr_in, LEFT.prim_name = RIGHT.prim_name, getLocInfo(LEFT,RIGHT),right outer);
bestLocInfo := TOPN(locInfo, 1, lat, lon);  
 
Layout_report.Location_info getCountyName(bestLocInfo l, Census_Data.Key_Fips2County r) := TRANSFORM
		SELF.county := if (l.county <> '', r.county_name, '');
		SELF := l;
END;

bestLocInfoCounty := JOIN(bestLocInfo,Census_Data.Key_Fips2County,
												  KEYED(LEFT.st = RIGHT.state_code and
													LEFT.county[3..5] = RIGHT.county_fips),
													getCountyName(LEFT,RIGHT), LEFT OUTER,
													KEEP (1), LIMIT(0));
												


propInfowithPopulatedcount :=Record
	Layout_report.PropertyInfo;
	std_property.ln_fares_id;
	unsigned1 populated :=0;
END;

emptyRec := DATASET([0], {unsigned1 a});

allAssets := sort (std_property(record_type = 'ASSESSOR', 
																~Doxie.DataRestriction.Fares or ln_fares_id[1] <>'R'),
                   -tax_year, ln_fares_id);

propInfowithPopulatedcount getAssetInfo(allAssets l) := TRANSFORM
	SELF.Tax_Year := l.Tax_Year;
  SELF.Land_Value := l.Land_Value; 
  SELF.Improvement_Value := l.Improvement_Value; 
  SELF.Total_Value := l.Total_Value; 
	SELF.Legal_Description := l.Legal_Description;
	SELF.land_usage := l.land_usage;
	SELF.sale_date := l.sale_date;
	SELF.sale_price := l.sale_price;
	SELF.ln_fares_id :=l.ln_fares_id;
	SELF.populated :=(unsigned1)(Self.Tax_Year <> '') +(unsigned1)(Self.Land_Value<>'')+(unsigned1)(Self.Improvement_Value<>'')+(unsigned1)(Self.Total_value<>'')
	+(unsigned1)(Self.Legal_Description<>'')+(unsigned1)(Self.land_usage<>'')+(unsigned1)(Self.sale_date<>'')+(unsigned1)(Self.sale_price<>'');
  SELF.isFares := l.ln_fares_id[1]='R';
	SELF := [];
END;

propInfowithPopulatedcount rollAssets(propInfowithPopulatedcount L,propInfowithPopulatedcount R) :=
TRANSFORM
	SELF.Tax_Year := if (L.Tax_Year <> '', L.Tax_Year, R.Tax_Year); 
  SELF.Land_Value := if (L.Land_Value <> '', L.Land_Value, R.Land_Value); 
  SELF.Improvement_Value := if (L.Improvement_Value <> '', L.Improvement_Value, R.Improvement_Value); 
  SELF.Total_Value := if (L.Total_Value <> '', L.Total_Value, R.Total_Value); 
	SELF.Legal_Description := if (L.Legal_Description <> '', L.Legal_Description, R.Legal_Description); 
	SELF.land_usage := if (L.land_usage <> '', L.land_usage, R.land_usage);
	SELF.sale_date := if (L.sale_date <> '', L.sale_date, R.sale_date);
  SELF.sale_price := if (L.sale_price <> '', L.sale_price, R.sale_price);
	SELF.ln_fares_id :=l.ln_fares_id;
	SELF.populated :=(unsigned1)(Self.Tax_Year <> '') +(unsigned1)(Self.Land_Value<>'')+(unsigned1)(Self.Improvement_Value<>'')+(unsigned1)(Self.Total_value<>'')
	+(unsigned1)(Self.Legal_Description<>'')+(unsigned1)(Self.land_usage<>'')+(unsigned1)(Self.sale_date<>'')+(unsigned1)(Self.sale_price<>'');
	SELF.isFares := L.isFares OR R.isFares;
	SELF := [];
END;
														
AssessInfo := ROLLUP(PROJECT(allAssets, getAssetInfo(LEFT)), 
														Left.ln_fares_id[1]=right.ln_fares_id[1] AND LEFT.tax_year=RIGHT.tax_year, rollAssets(LEFT,RIGHT));	

AssessInfoFares :=choosen(sort(AssessInfo(ln_fares_id[1] ='R'),-tax_year),1);
AssessInfoNonFares :=choosen(sort(AssessInfo(ln_fares_id[1] <>'R'),-tax_year),1);														

allDeeds := sort (std_property(record_type = 'DEED', 
															 ~Doxie.DataRestriction.Fares or ln_fares_id[1] <>'R'),
                   -sale_date, ln_fares_id);


propInfowithPopulatedcount getDeedInfo(allDeeds l) := TRANSFORM
  SELF.Lender_Name := l.Lender_Name; 
	SELF.Loan_Type := l.Loan_Type;
	SELF.Loan_Amount := l.Loan_Amount; 
	SELF.Loan_Term := l.Loan_Due_Date;
	SELF.sale_date := l.sale_date;
	SELF.sale_price := l.sale_price;
	SELF.ln_fares_id :=l.ln_fares_id;
	SELF.Populated :=(unsigned1)(SELF.Lender_Name <>'')+(unsigned1)(SELF.Loan_Type <>'')+(unsigned1)(SELF.Loan_Amount <>'')+
	(unsigned1)(SELF.Loan_Term <>'')+(unsigned1)(SELF.sale_date <>'')+(unsigned1)(SELF.sale_price <>'');
	SELF.isFares := l.ln_fares_id[1]='R';
	SELF := [];
END;

propInfowithPopulatedcount rollDeeds(propInfowithPopulatedcount L,propInfowithPopulatedcount R) :=
TRANSFORM
  SELF.Lender_Name := if (L.Lender_Name <> '', L.Lender_Name, R.Lender_Name); 
	SELF.Loan_Type := if (L.Loan_Type <> '', L.Loan_Type, R.Loan_Type);
	SELF.Loan_Amount := if (L.Loan_Amount <> '', L.Loan_Amount, R.Loan_Amount); 
	SELF.Loan_Term := if (L.Loan_Term <> '', L.Loan_Term, R.Loan_Term);
	SELF.sale_date := if (L.sale_date <> '', L.sale_date, R.sale_date);
  SELF.sale_price := if (L.sale_price <> '', L.sale_price, R.sale_price);
	SELF.Populated :=(unsigned1)(SELF.Lender_Name <>'')+(unsigned1)(SELF.Loan_Type <>'')+(unsigned1)(SELF.Loan_Amount <>'')+
	(unsigned1)(SELF.Loan_Term <>'')+(unsigned1)(SELF.sale_date <>'')+(unsigned1)(SELF.sale_price <>'');
	SELF.ln_fares_id :=l.ln_fares_id;
	SELF.isFares := L.isFares OR R.isFares;
	SELF := [];
END;

DeedInfo :=ROLLUP(PROJECT(allDeeds, getDeedInfo(LEFT)),
													left.ln_fares_id[1]=right.ln_fares_id[1] AND LEFT.sale_date=RIGHT.sale_date, rollDeeds(LEFT,RIGHT));

DeedInfofares :=choosen(sort(DeedInfo(ln_fares_id[1] ='R'),-sale_date),1);
DeedInfononfares := choosen(sort(DeedInfo(ln_fares_id[1] <>'R'),-sale_date),1);


propInfowithPopulatedcount getProps(propInfowithPopulatedcount L, propInfowithPopulatedcount R) := TRANSFORM
	SELF.Tax_Year := if (L.Tax_Year <> '', L.Tax_Year, R.Tax_Year); 
  SELF.Land_Value := if (L.Land_Value <> '', L.Land_Value, R.Land_Value); 
  SELF.Improvement_Value := if (L.Improvement_Value <> '', L.Improvement_Value, R.Improvement_Value); 
  SELF.Total_Value := if (L.Total_Value <> '', L.Total_Value, R.Total_Value); 
	SELF.Legal_Description := if (L.Legal_Description <> '', L.Legal_Description, R.Legal_Description); 
	SELF.land_usage := if (L.land_usage <> '', L.land_usage, R.land_usage);
  SELF.sale_date := if (L.sale_date <> '', L.sale_date, R.sale_date);
  SELF.sale_price := if (L.sale_price <> '', L.sale_price, R.sale_price);
  SELF.Lender_Name := if (L.Lender_Name <> '', L.Lender_Name, R.Lender_Name); 
	SELF.Loan_Type := if (L.Loan_Type <> '', L.Loan_Type, R.Loan_Type);
	SELF.Loan_Amount := if (L.Loan_Amount <> '', L.Loan_Amount, R.Loan_Amount); 
	SELF.Loan_Term := if (L.Loan_Term <> '', L.Loan_Term, R.Loan_Term);
	SELF.isFares := L.isFares OR R.isFares;
	SELF.Populated :=(unsigned1)(SELF.Lender_Name <>'')+(unsigned1)(SELF.Loan_Type <>'')+(unsigned1)(SELF.Loan_Amount <>'')+
	(unsigned1)(SELF.Loan_Term <>'')+(unsigned1)(SELF.sale_date <>'')+(unsigned1)(SELF.sale_price <>'')
	+(unsigned1)(Self.Tax_Year <> '') +(unsigned1)(Self.Land_Value<>'')+(unsigned1)(Self.Improvement_Value<>'')+(unsigned1)(Self.Total_value<>'')
	+(unsigned1)(Self.Legal_Description<>'')+(unsigned1)(Self.land_usage<>'');
	SELF := [];
END;

// Order is important to prefer sale info from deed over that of assessment
PropInfoFares := ROLLUP(DeedInfofares & AssessInfoFares, true, getProps(LEFT,RIGHT));
PropInfoNonFares := ROLLUP(DeedInfoNonfares & AssessInfoNonFares, true, getProps(LEFT,RIGHT));

allPropVend := project(PropInfoFares + PropInfoNonFares, transform(recordof(propInfowithPopulatedcount), self.vendor_source_flag:=if(left.isFares,'A','B'), self:=left));
allPropinfo := sort(allPropVend,-populated);

Layout_report.ApnRec takeApn(std_property l) := TRANSFORM
  // need to remove interior spaces as well to prevent 'apparent' dups from slipping through
  apn := StringLib.StringCleanSpaces(TRIM(l.fapn,LEFT,RIGHT));
	SELF.apn := IF(apn <> '', apn,SKIP);
END;

// use Fares records for the APN section, if they provide any apns
apns := PROJECT(if(EXISTS(std_property(ln_fares_id[1]='R' and fapn <> '')),
								std_property(ln_fares_id[1]='R'), std_property(ln_fares_id[1]<>'R')), takeApn(LEFT));
								
allApns := DEDUP(SORT(UNGROUP(apns),apn),apn);


// apparently need a no-op transform for join syntax when join type specified
Layout_report.Assoc getAssoc(Layout_report.Assoc L) := TRANSFORM
	SELF := L;
END;

// need to eliminate deceased entities from any of the "current" groupings
// and force them into their respective "previous" groups
death_key := doxie.Key_Death_Masterv2_SSA_Did;
deathparams := DeathV2_Services.IParam.GetRestrictions(mod_access);


Layout_report.Assoc getOwn(propSrchFields L) := TRANSFORM
	SELF := L;
END;

curOwnRes := join(owners, bestrec, left.did<>0 AND left.did = right.did and left.prim_name = right.prim_name
            and left.prim_range = right.prim_range, getOwn(LEFT));
curOwnResAlive := join(curOwnRes, death_key, left.did<>0 AND keyed(left.did = (unsigned6)right.l_did)
												and not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
												getAssoc(LEFT), LEFT ONLY);
curOwnResBest := dedup(sort(curOwnResAlive, lname, fname, record), record);
deadOwnRes := join(curOwnRes, death_key, left.did<>0 AND keyed(left.did = (unsigned6)right.l_did)
										and not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
										getAssoc(LEFT), keep (1), limit(0));
					
curOwn := join(owners, bestRec, left.did<>0 AND left.did = right.did and left.prim_name = right.prim_name
            and left.prim_range = right.prim_range, getOwn(LEFT), LEFT ONLY);
curOwnAlive := join(curOwn, death_key, left.did<>0 AND keyed(left.did = (unsigned6)right.l_did)
											and not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
											getAssoc(LEFT), LEFT ONLY);
curOwnBest := dedup(sort(curOwnAlive, lname, fname, record), record);
deadOwn := join(curOwn, death_key, left.did<>0 AND keyed(left.did = (unsigned6)right.l_did)
											and not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
											getAssoc(LEFT), keep (1), limit(0));

curRes := join(owners, bestAddrs, left.did<>0 AND left.did = right.did and left.prim_name = right.prim_name
            and left.prim_range = right.prim_range, transform (Layout_report.Assoc, Self := RIGHT), RIGHT ONLY);
curResAlive := join(curRes, death_key, left.did<>0 AND keyed(left.did = (unsigned6)right.l_did)
											and not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
											getAssoc(LEFT), LEFT ONLY);
curResBest := dedup(sort(curResAlive, lname, fname, record), record);
deadRes := join(curRes, death_key, left.did<>0 AND keyed(left.did = (unsigned6)right.l_did)
									and not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
									getAssoc(LEFT), keep (1), limit(0));

prevOwn := PROJECT(sellers, getOwn(LEFT));
prevOwnCombined := dedup(sort(prevOwn + deadOwnRes + deadOwn, did), did);
prevOwnBest := sort(prevOwnCombined, lname, fname);
		
// eliminate any header records with sensitive DIDs or SSNs
header.MAC_GlbClean_Header(headerRecs, headerRecs2, , , mod_access);
		
Layout_report.Assoc getPrevRes(headerRecs2 R) := TRANSFORM
	SELF := R;
END;

// all previous residents who aren't currently listed there in best_records					
prevRes := join(headerRecs2, bestAddrs, LEFT.did = RIGHT.did and 
                LEFT.prim_name = RIGHT.prim_name and LEFT.prim_range = RIGHT.prim_range,
								getPrevRes(LEFT), LEFT ONLY);

prevRes2 := dedup(sort(prevRes, did, lname, fname, mname), did);

prevRes3 := join(prevRes2, bestNamesD, left.did = right.did, getAssoc(LEFT), LEFT ONLY);

Layout_report.Assoc getAssocBest(bestrec R) := TRANSFORM
	SELF := R;
END;

prevRes4 := join(prevRes3, bestrec, left.did = right.did, getAssocBest(RIGHT)); 

prevResCombined := dedup(sort(prevRes4 + deadRes,did),did); 
prevResBest := sort(prevResCombined, lname, fname);

best_group := IF(~useBusinessIds, busMod.best_group()); 

Layout_report.BusAssoc getBusAssoc(best_group l) := TRANSFORM
	SELF.company_name := DATASET([{l.company_name}], Layout_report.CompanyName);
	SELF := l;
	SELF := [];
END;

busAssocs := PROJECT(best_group, getBusAssoc(LEFT));

busAssocsWithLinkIds := IF(useBusinessIds, GetByBusinessIds(addr_in).linkIdsInfoOut);

Layout_report.BusAssoc rollBusNames(busAssocs l, busAssocs R) := TRANSFORM
	SELF.group_id := L.group_id;
	SELF.company_name := choosen(L.company_name + R.company_name, consts.max_assocs);
	SELF := [];
END;

busRolled := IF(~useBusinessIds, ROLLUP(sort(busAssocs, group_id),rollBusNames(LEFT,RIGHT),group_id));
/////////////////////////////////
assocMax := consts.max_assocs;

Layout_report.KeyRec getAll(emptyRec l) := TRANSFORM

	return_nothing :=count(bestLocInfoCounty)=0 and count(addrVarsCombined)=0 and count(allApns)=0 and
	count(allPropInfo)=0 and count(neighbors)=0 and count(owners)=0 and count(sellers)=0 and
	count(busrolled)=0;

	SELF.locInfo :=bestLocInfoCounty;
	SELF.addrs := addrVarsCombined;
	SELF.apns := allApns;
  SELF.propInfo := PROJECT(allPropInfo,Layout_report.propertyInfo);
	SELF.neighbors := neighbors;
	SELF.associates.curOwnRes.totCnt := count(curOwnResBest);
	SELF.associates.curOwnRes.a := choosen(curOwnResBest,assocMax);
	SELF.associates.curOwn.totCnt := count(curOwnBest);
	SELF.associates.curOwn.a := choosen(curOwnBest,assocMax);
	SELF.associates.curRes.totCnt := count(curResBest);
	SELF.associates.curRes.a := choosen(curResBest,assocMax);
	SELF.associates.prevOwn.totCnt := count(prevOwnBest);
	SELF.associates.prevOwn.a := choosen(prevOwnBest,assocMax);
	SELF.associates.prevRes.totCnt := count(prevResBest);
	SELF.associates.prevRes.a := choosen(prevResBest,assocMax);
	SELF.associates.other.totCnt := IF(useBusinessIds, count(busAssocsWithLinkIds), count(busRolled));
	// SELF.associates.other.ba := IF(~useBusinessIds, choosen(busRolled,assocMax), DATASET([], Layout_report.BusAssoc));	
	SELF.associates.other.ba := IF(useBusinessIds, choosen(busAssocsWithLinkIds, assocMax), choosen(busRolled,assocMax));	
	//LH
	// SELF.associates.otherWithLinkIds.totCnt := IF(useBusinessIds, count(busAssocsWithLinkIds), 0);
	// SELF.associates.otherWithLinkIds.bali := IF(useBusinessIds, choosen(busAssocsWithLinkIds, assocMax), DATASET([], Layout_report.BusAssocWithLinkIds));
  Self.do_royal := map(return_nothing=TRUE=>2,EXISTS(allPropInfo(isFares))=>1,0);
END;

rpt := PROJECT(emptyRec, getAll(left));

RETURN rpt;

END;
