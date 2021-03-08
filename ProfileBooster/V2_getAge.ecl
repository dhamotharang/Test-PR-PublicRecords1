IMPORT ProfileBooster, _Control, Doxie, RiskWise, ut, risk_indicators, MDR, header_quick, easi, Suppress;
onThor := _Control.Environment.OnThor;

EXPORT V2_getAge(DATASET(ProfileBooster.V2_Layouts.Layout_PB2_Slim) PBslim, 
							  doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

//search header by DID to pick up DOB and calculate age and also append HHID to each rec	
	{ProfileBooster.V2_Layouts.Layout_PB2_Slim_header, UNSIGNED4 global_sid} getHeader(PBslim le, Doxie.Key_Header ri) := transform
		self.global_sid 					:= ri.global_sid;
		age									:= if(ri.dob = 0 or ri.src=mdr.sourceTools.src_TUCS_Ptrack, 0, risk_indicators.years_apart((unsigned)risk_indicators.iid_constants.myGetDate(le.historydate), (unsigned)ri.dob));
		self.age						:= age;		
		self.HHID						:= ri.HHID;
		self.dt_first_seen	:= ri.dt_first_seen;
		self.dt_last_seen		:= ri.dt_last_seen;
		self.geoLink				:= if(ri.st<>'' and ri.county<>'' and ri.geo_blk<>'', ri.st + ri.county + ri.geo_blk, '');
		self.med_hhinc			:= 0;
		self								:= le;
	end;
	
	withHeader_ROXIE_unsuppressed := join(PBslim, Doxie.Key_Header,	
										left.DID2 <> 0 and
										keyed(left.DID2 = right.s_DID) and										
                    right.src in MDR.sourcetools.set_Marketing_Header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
									getHeader(left, right), left outer, keep(ut.limits.HEADER_PER_DID), atmost(RiskWise.max_atmost));	
									
withHeader_ROXIE_flagged := Suppress.MAC_FlagSuppressedSource(withHeader_ROXIE_unsuppressed, mod_access);

withHeader_ROXIE := PROJECT(withHeader_ROXIE_flagged, TRANSFORM(ProfileBooster.V2_Layouts.Layout_PB2_Slim_header, 
		self.age						:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.age);		
		self.HHID						:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.HHID);		
		self.dt_first_seen	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_first_seen);		
		self.dt_last_seen		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_last_seen);		
		self.geoLink				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.geoLink);		
		SELF := LEFT;
)); 

	withHeader_THOR_unsuppressed := join(distribute(PBslim(did2<>0), did2), 
													distribute(pull(Doxie.Key_Header(dt_first_seen<>0 AND src IN MDR.sourcetools.set_Marketing_Header)), s_did),	
										left.DID2 = right.s_DID and
										right.dt_first_seen < left.historydate,
									getHeader(left, right), left outer, keep(ut.limits.HEADER_PER_DID),  local);

withHeader_THOR_flagged := Suppress.MAC_FlagSuppressedSource(withHeader_THOR_unsuppressed, mod_access);

withHeader_THOR := PROJECT(withHeader_THOR_flagged, TRANSFORM(ProfileBooster.V2_Layouts.Layout_PB2_Slim_header, 
		self.age						:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.age);		
		self.HHID						:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.HHID);		
		self.dt_first_seen	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_first_seen);		
		self.dt_last_seen		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.dt_last_seen);		
		self.geoLink				:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.geoLink);		
		SELF := LEFT;
)); 

  #IF(onThor)
    withHeader := withHeader_thor;
  #ELSE
    withHeader := withHeader_roxie;
  #END

	{ProfileBooster.V2_Layouts.Layout_PB2_Slim_header, UNSIGNED4 global_sid} getQHeader(PBslim le, header_quick.key_DID ri) := transform
		self.global_sid			:= ri.global_sid;
		age									:= if(ri.dob = 0 or ri.src=mdr.sourceTools.src_TUCS_Ptrack, 0, risk_indicators.years_apart((unsigned)risk_indicators.iid_constants.myGetDate(le.historydate), (unsigned)ri.dob));
		self.age						:= age;				
		self.HHID						:= 0;	//quick header does not have HHID so just default to 0	
		self.dt_first_seen	:= ri.dt_first_seen;
		self.dt_last_seen		:= ri.dt_last_seen;
		self.geoLink				:= if(ri.st<>'' and ri.county<>'' and ri.geo_blk<>'', ri.st + ri.county + ri.geo_blk, '');
		self.med_hhinc			:= 0;
		self								:= le;
	end;
	
	withQHeader_roxie_unsuppressed := join(PBslim, header_quick.key_DID,		
										left.DID2 <> 0 and
										keyed(left.DID2 = right.DID) and
										right.src in MDR.sourcetools.set_Marketing_Header and
										right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate,
										getQHeader(left, right), keep(200), ATMOST(RiskWise.max_atmost));

	withQHeader_roxie := Suppress.Suppress_ReturnOldLayout(withQHeader_roxie_unsuppressed, mod_access, ProfileBooster.V2_Layouts.Layout_PB2_Slim_header);
	
	withQHeader_thor_unsuppressed := join(distribute(PBslim(did2<>0), did2), 
														distribute(pull(header_quick.key_DID(dt_first_seen<>0 and src in MDR.sourcetools.set_Marketing_Header)), did),		
										left.DID2 = right.DID and
										right.dt_first_seen < left.historydate,
										getQHeader(left, right), keep(200), local);

	withQHeader_thor := Suppress.Suppress_ReturnOldLayout(withQHeader_thor_unsuppressed, mod_access, ProfileBooster.V2_Layouts.Layout_PB2_Slim_header);


	#IF(onThor)
    withQHeader := withQHeader_thor;
  #ELSE
    withQHeader := withQHeader_roxie;
  #END


//sort header records by seq and DID2
	sortHeader := sort(withHeader + withQHeader, seq, DID2, -dt_last_seen, -dt_first_seen);  //sort most recent first to get the most recent geoLink in the rollup below

//rollup to keep the age and HHID from whichever record has it populated 
  ProfileBooster.V2_Layouts.Layout_PB2_Slim_header rollHeader(ProfileBooster.V2_Layouts.Layout_PB2_Slim_header le, ProfileBooster.V2_Layouts.Layout_PB2_Slim_header ri) := transform
		self.age					:= if(le.age <> 0, le.age, ri.age);		
		self.HHID					:= if(le.HHID <> 0, le.HHID, ri.HHID);			
		self.geoLink			:= le.geoLink;			
		self							:= le;
	end;
	
  rolledHeader := rollup(sortHeader, rollHeader(left,right), seq, DID2);

	withCensus_roxie := join(rolledHeader, Easi.Key_Easi_Census,
								keyed(right.geolink=left.geoLInk) and 
								left.geoLink <> '',
								transform(ProfileBooster.V2_Layouts.Layout_PB2_Slim_header,
									self.med_hhinc	:= (integer)right.med_hhinc,
									self 						:= left), ATMOST(Riskwise.max_atmost), KEEP(1));	
									
	withCensus_thor := join(distribute(rolledHeader, hash64(geolink)), 
													distribute(pull(Easi.Key_Easi_Census), hash64(geolink)),
								right.geolink=left.geoLInk and 
								left.geoLink <> '',
								transform(ProfileBooster.V2_Layouts.Layout_PB2_Slim_header, 
									self.med_hhinc	:= (integer)right.med_hhinc,
									self 						:= left), ATMOST(Riskwise.max_atmost), KEEP(1), local);
	
  #IF(onThor)
    withCensus := ungroup(withCensus_thor);
  #ELSE
    withCensus := ungroup(withCensus_roxie);
  #END
	
// output(withHeader, named('withHeader'));
// output(withQHeader, named('withQHeader'));
// output(sortHeader, named('sortHeader'));
// output(rolledHeader, named('rolledHeader'));
// output(withCensus, named('withCensus'));

RETURN withCensus;

END;										