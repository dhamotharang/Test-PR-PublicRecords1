IMPORT Watercraft, RiskWise;

EXPORT BusnWatercraft(DATASET(Layouts.BusnLayoutV2) BusnIds) := FUNCTION

//version 2
watercraftLayout := RECORD
  unsigned6 bdid;
  unsigned4 seq;
  string watercraft_key;
	string2  state_origin;
  string sequence_key;
	unsigned4 historydate;
	string15 history_flag;
	unsigned4 watercraftCount := 0;
END;
	
 
 
watercraftLayout  getWCKey(busnids le, Watercraft.key_watercraft_bdid ri) := TRANSFORM
 	lenDate := length(trim(ri.sequence_key));
	seqDate := if(lenDate=8,ri.sequence_key, if(lenDate=6, ri.sequence_key+'31', ''));
	SELF.watercraft_key := ri.watercraft_key;
	self.sequence_key := ri.sequence_key;
	self.bdid := le.OrigBdid;
	self.seq := le.seq;
	self.historydate := le.historydate;
	self.state_origin := ri.state_origin;
	self := [];
END;
 
isFCRA := False;
 
WatercraftKeys :=  join(busnids, Watercraft.key_watercraft_bdid,
												 keyed(right.l_bdid = left.OrigBdid) and 
												 (unsigned3)(right.sequence_key[1..6]) < left.historydate,
												 getWCKey(left,right), left outer, 
												 atmost(right.l_bdid=left.origbdid, riskwise.max_atmost));
											
Watercraftkey := watercraft.key_watercraft_sid(false);
											
watercraftLayout  getWCDetails(WatercraftKeys le, Watercraftkey ri) := TRANSFORM
	SELF.watercraft_key := le.watercraft_key;
	self.sequence_key := le.sequence_key;
	self.bdid := le.Bdid;
	self.seq := le.seq;
	self.historydate := le.historydate;
	self.history_flag :=  map(ri.history_flag =	'' => 'Current',				
														// ri.history_flag ='E' => 'Expired',
														// ri.history_flag ='H' => 'Historical',
														'');
	self.watercraftCount := if(ri.history_flag = '' and le.watercraft_key <> '', 1, 0)	;
	self.state_origin := le.state_origin;

END;


WatercraftDetails :=  join(WatercraftKeys, watercraft.key_watercraft_sid(false),
												 keyed(right.watercraft_key = left.watercraft_key and
												       right.state_origin = left.state_origin) and
												 right.history_flag = '' 
												 and right.sequence_key = left.sequence_key,
												 getWCDetails(left,right), 
												 atmost(right.watercraft_key = left.watercraft_key and right.state_origin = left.state_origin, 
												 riskwise.max_atmost));
												 
												 
SortWCdetails :=  sort(WatercraftDetails, seq, bdid, watercraft_key, -sequence_key);

watercraftLayout rollWatercrafts(WatercraftDetails le, WatercraftDetails ri) := TRANSFORM
sameWCK := le.watercraft_key=ri.watercraft_key;
	SELF.watercraft_key := ri.watercraft_key;
	self.sequence_key := ri.sequence_key;
	self.bdid := le.Bdid;
	self.seq := le.seq;
	self.history_flag :=  if(le.history_flag = 'Current' ,	le.history_flag, ri.history_flag);			
														
	self.watercraftCount := le.watercraftCount + iF(sameWCK,  0,	ri.watercraftCount);	
	self.historydate := le.historydate;
	self.state_origin := le.state_origin;

END;

RolledWC :=  rollup(SortWCdetails, left.seq = right.seq and left.bdid = right.bdid,
										rollWatercrafts(left, right));
										
	
AddWCCount := join(BusnIds, RolledWC, left.origbdid = right.bdid and
										left.seq = right.seq,
										transform(Layouts.BusnLayoutV2,
															self.WatercraftCount := right.watercraftCount,
															self := left), left outer);
															
// output(BusnIds, named('BusnIds'));
// output(WatercraftKeys, named('WatercraftKeys'));
// output(WatercraftDetails, named('WatercraftDetails'));
// output(SortWCdetails, named('SortWCdetails'));
// output(RolledWC, named('RolledWC'));
// output(AddWCCount, named('AddWCCount'));


RETURN AddWCCount;

END;										