Import RISK_INDICATORS, ut;

export GetMoveDist( DATASET(risk_indicators.iid_constants.layout_outx) HeaderIn
  													) := FUNCTION

 

distanceZipLayout := Record

	unsigned6 did;
	unsigned4 seq;
	unsigned4 historydate;
	Integer address_history_seq;	
	integer addrs_last36;
	unsigned4 DateFirstSeen;
	string5 chronozip;
	integer  Move1_dist;
	integer  Move2_dist;
	integer  Move3_dist;

	STRING5  addr1_zip;
	STRING5  addr2_zip;
	STRING5  addr3_zip;
	STRING5  addr4_zip;

END;


 ClamAddrSeq := dedup(sort(HeaderIn(address_history_seq not in [255,0] and h.dt_first_seen <> 0), seq, did,address_history_seq, h.prim_name,h.predir, h.prim_range, h.suffix, h.postdir,
																		h.unit_desig, h.sec_range, h.city_name, h.zip, if(h.dt_first_seen = 0, 999999, h.dt_first_seen)),
																		seq, did,address_history_seq, h.prim_name,h.predir, h.prim_range, h.suffix, h.postdir,
																		h.unit_desig, h.sec_range, h.city_name, h.zip, keep(1));
 
 MoversRecs := project(Choosen(ClamAddrSeq, 4),  
												transform(distanceZipLayout,
																	myGetDate := Risk_indicators.iid_constants.myGetDate(left.historydate);
																	addrs3yrs := ut.DaysApart(myGetDate, (string)left.h.dt_first_seen + '01') <= Risk_indicators.iid_constants.threeyears;
																	self.chronozip := If(addrs3yrs, left.h.zip, '0'),
																	self.addrs_last36 := left.addrs_last36,
																	self.DateFirstSeen := left.h.dt_first_seen,
																	self.historydate := left.historydate,
																	self := left, self := []));
 
 
 
 distanceZipLayout GetMoverZips(MoversRecs le, MoversRecs ri, integer c) := TRANSFORM
	self.did   := ri.did; 
	self.seq   := ri. seq;
	self.historydate := le.historydate;
	self.address_history_seq  := ri.address_history_seq;
	self.addrs_last36   := ri.addrs_last36;
	self.chronozip := ri.chronozip;
	self.DateFirstSeen := min(le.DateFirstSeen, ri.DateFirstSeen);
	self.Move1_dist  := 0;
	self.Move2_dist  := 0;
	self.Move3_dist   := 0;
	self.addr1_zip  := if(c = 1, ri.chronozip, le.addr1_zip);
	self.addr2_zip  := if(c = 2, ri.chronozip, le.addr2_zip);
	self.addr3_zip  := if(c = 3, ri.chronozip, le.addr3_zip);
	self.addr4_zip  := if(c = 4, ri.chronozip, le.addr4_zip);

END;
 
 MoversZip := iterate( group(MoversRecs(chronozip <> '0'), seq, did), GetMoverZips(left, right, counter));
 
 SDMoversZip := dedup(sort(MoversZip, -address_history_seq, did), did);

//calculating distance between addresses

distanceZipLayout CalcDist(SDMoversZip le) := TRANSFORM
	SELF.Move1_dist:= IF(le.addr1_zip='' 	OR le.addr2_zip='', 9999,
								Min((INTEGER) ut.zip_Dist(le.addr1_zip, le.addr2_zip), 9998));	
	SELF.Move2_dist:= IF(le.addr2_zip='' OR le.addr3_zip='', 9999,
								Min((INTEGER) ut.zip_Dist(le.addr2_zip, le.addr3_zip), 9998));
	SELF.Move3_dist:= IF(le.addr3_zip='' OR le.addr4_zip='', 9999,
								Min((INTEGER) ut.zip_Dist(le.addr3_zip, le.addr4_zip), 9998));


  Self := le;
END;

MoveDistance := project(SDMoversZip, CalcDist(left));

// output(HeaderIn,named('HeaderIn'));										
// output(ClamAddrSeq,named('ClamAddrSeq'));																
// output(MoversRecs,named('MoversRecs'));										
// output(MoversZip,named('MoversZip'));										
// output(SDMoversZip,named('SDMoversZip'));										
// output(MoveDistance,named('MoveDistance'));										
																
										
RETURN  MoveDistance;

END;
										