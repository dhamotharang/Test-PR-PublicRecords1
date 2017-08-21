IMPORT Doxie, RiskWise, ut, risk_indicators, MDR, header_quick, easi;

EXPORT getAge(DATASET(ProfileBooster.Layouts.Layout_PB_Slim) PBslim, BOOLEAN onThor) := FUNCTION

//search header by DID to pick up DOB and calculate age and also append HHID to each rec	
	ProfileBooster.Layouts.Layout_PB_Slim_header getHeader(PBslim le, Doxie.Key_Header ri) := transform
		age									:= if(ri.dob = 0, 0, risk_indicators.years_apart((unsigned)le.HistoryDate, (unsigned)ri.dob));
		self.age						:= age;		
		self.HHID						:= ri.HHID;
		self.dt_first_seen	:= ri.dt_first_seen;
		self.dt_last_seen		:= ri.dt_last_seen;
		self.geoLink				:= if(ri.st<>'' and ri.county<>'' and ri.geo_blk<>'', ri.st + ri.county + ri.geo_blk, '');
		self.med_hhinc			:= 0;
		self								:= le;
	end;
	
	withHeader_ROXIE := join(PBslim, Doxie.Key_Header,	
										left.DID2 <> 0 and
										keyed(left.DID2 = right.s_DID) and
										right.src in MDR.sourcetools.set_Marketing_header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
									getHeader(left, right), left outer, keep(ut.limits.HEADER_PER_DID), atmost(RiskWise.max_atmost));	
	withHeader_THOR := join(distribute(PBslim(did2<>0), did2), 
													distribute(pull(Doxie.Key_Header(dt_first_seen<>0 and src in MDR.sourcetools.set_Marketing_header)), s_did),	
										left.DID2 = right.s_DID and
										right.dt_first_seen < left.historydate,
									getHeader(left, right), left outer, keep(ut.limits.HEADER_PER_DID),  local);

	withHeader := if(onThor, withHeader_thor, withHeader_roxie);

	ProfileBooster.Layouts.Layout_PB_Slim_header getQHeader(PBslim le, header_quick.key_DID ri) := transform
		age									:= if(ri.dob = 0, 0, risk_indicators.years_apart((unsigned)le.HistoryDate, (unsigned)ri.dob));
		self.age						:= age;				
		self.HHID						:= 0;	//quick header does not have HHID so just default to 0	
		self.dt_first_seen	:= ri.dt_first_seen;
		self.dt_last_seen		:= ri.dt_last_seen;
		self.geoLink				:= if(ri.st<>'' and ri.county<>'' and ri.geo_blk<>'', ri.st + ri.county + ri.geo_blk, '');
		self.med_hhinc			:= 0;
		self								:= le;
	end;
	
	withQHeader_roxie := join(PBslim, header_quick.key_DID,		
										left.DID2 <> 0 and
										keyed(left.DID2 = right.DID) and
										right.src in MDR.sourcetools.set_Marketing_header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
										getQHeader(left, right), keep(200), ATMOST(RiskWise.max_atmost));

	withQHeader_thor := join(distribute(PBslim(did2<>0), did2), 
														distribute(pull(header_quick.key_DID(dt_first_seen<>0 and src in MDR.sourcetools.set_Marketing_header)), did),		
										left.DID2 = right.DID and
										right.dt_first_seen < left.historydate,
										getQHeader(left, right), keep(200), local);

	withQHeader := if(onThor, withQHeader_thor, withQHeader_roxie);
	
//sort header records by seq and DID2
	sortHeader_roxie := sort(withHeader + withQHeader, seq, DID2, -dt_last_seen, -dt_first_seen);  //sort most recent first to get the most recent geoLink in the rollup below
	sortHeader_thor := sort(distribute((withHeader_thor + withQHeader_thor), hash(seq)), seq, DID2, -dt_last_seen, -dt_first_seen, local);  //sort most recent first to get the most recent geoLink in the rollup below
	sortHeader := if(onThor, sortHeader_thor, sortHeader_roxie);

//rollup to keep the age and HHID from whichever record has it populated 
  ProfileBooster.Layouts.Layout_PB_Slim_header rollHeader(ProfileBooster.Layouts.Layout_PB_Slim_header le, ProfileBooster.Layouts.Layout_PB_Slim_header ri) := transform
		self.age					:= if(le.age <> 0, le.age, ri.age);		
		self.HHID					:= if(le.HHID <> 0, le.HHID, ri.HHID);			
		self.geoLink			:= le.geoLink;			
		self							:= le;
	end;
	
  rolledHeader := rollup(sortHeader, rollHeader(left,right), seq, DID2);

	withCensus_roxie := join(rolledHeader, Easi.Key_Easi_Census,
								keyed(right.geolink=left.geoLInk) and 
								left.geoLink <> '',
								transform(ProfileBooster.Layouts.Layout_PB_Slim_header, 
									self.med_hhinc	:= (integer)right.med_hhinc,
									self 						:= left), ATMOST(Riskwise.max_atmost), KEEP(1));	
									
	withCensus_thor1 := join(distribute(rolledHeader(geolink<>''), hash64(geolink)), 
													distribute(pull(Easi.Key_Easi_Census), hash64(geolink)),
								right.geolink=left.geoLInk,
								transform(ProfileBooster.Layouts.Layout_PB_Slim_header, 
									self.med_hhinc	:= (integer)right.med_hhinc,
									self 						:= left), ATMOST(Riskwise.max_atmost), KEEP(1), local);
	withCensus_thor := withCensus_thor1 + rolledheader(geolink=''); // add back the records where geolink=''
	withCensus := ungroup(if(onThor, withCensus_thor, withCensus_roxie));
	

	
// output(withHeader, named('withHeader'));
// output(withQHeader, named('withQHeader'));
// output(sortHeader, named('sortHeader'));
// output(rolledHeader, named('rolledHeader'));
// output(withCensus, named('withCensus'));

RETURN withCensus;

END;										