IMPORT Watercraft, RiskWise;

EXPORT IndWatercraft(DATASET(Layouts.LayoutAMLShellV2) IndivIds) := FUNCTION

//version 2
watercraftLayout := RECORD
  unsigned6 did;
  unsigned4 seq;
  string watercraft_key;
	string2  state_origin;
  string sequence_key;
	unsigned4 historydate;
	string15 history_flag;
	unsigned4 watercraftCount := 0;
END;
	
WCidKey := Watercraft.key_watercraft_did(false); 
 
watercraftLayout  getWCKey(IndivIds le, WCidKey ri) := TRANSFORM
 	lenDate := length(trim(ri.sequence_key));
	SELF.watercraft_key := ri.watercraft_key;
	self.sequence_key := ri.sequence_key;
	self.did := le.did;
	self.seq := le.seq;
	self.historydate := le.historydate;
	self.state_origin := ri.state_origin;
	self := [];
END;
 
isFCRA := False;
 
WatercraftKeys :=  join(IndivIds, WCidKey,
												 keyed(right.l_did = left.did) and 
												 (unsigned3)(right.sequence_key[1..6]) < left.historydate,
												 getWCKey(left,right), left outer, 
												 atmost(right.l_did=left.did, riskwise.max_atmost));
											
WCDetailskey := watercraft.key_watercraft_sid(false);
											
watercraftLayout  getWCDetails(WatercraftKeys le, WCDetailskey ri) := TRANSFORM
	SELF.watercraft_key := le.watercraft_key;
	self.sequence_key := le.sequence_key;
	self.did := le.did;
	self.seq := le.seq;
	self.historydate := le.historydate;
	self.history_flag :=  map(ri.history_flag =	'' => 'Current',				
														// ri.history_flag ='E' => 'Expired',
														// ri.history_flag ='H' => 'Historical',  //  can remove due to join filter
														'');
	self.watercraftCount := if(ri.history_flag = '' and le.watercraft_key <> '' , 1, 0)	;
	self.state_origin := le.state_origin;

END;


WatercraftDetails :=  join(WatercraftKeys, WCDetailskey,
												 keyed(right.watercraft_key = left.watercraft_key and
												       right.state_origin = left.state_origin)  and
															right.history_flag = '',
												 getWCDetails(left,right), 
												 atmost(right.watercraft_key = left.watercraft_key and right.state_origin = left.state_origin, riskwise.max_atmost));
												 				 
SortWCdetails :=  sort(WatercraftDetails, seq, did, watercraft_key, -sequence_key);

watercraftLayout rollWatercrafts(WatercraftDetails le, WatercraftDetails ri) := TRANSFORM
	SELF.watercraft_key := le.watercraft_key;
	self.sequence_key := le.sequence_key;
	self.did := le.did;
	self.seq := le.seq;
	self.history_flag :=  le.history_flag;			
														
	self.watercraftCount := le.watercraftCount + iF(le.watercraft_key=ri.watercraft_key, 0,	ri.watercraftCount);	
	self.historydate := le.historydate;
	self.state_origin := le.state_origin;

END;

RolledWC :=  rollup(SortWCdetails, left.seq = right.seq and left.did = right.did,
										rollWatercrafts(left, right));
										
	
AddWCCount := join(IndivIds, RolledWC, 
										left.did = right.did and
										left.seq = right.seq,
										transform(Layouts.LayoutAMLShellV2,
															self.WatercraftCount := right.watercraftCount,
															self := left), left outer);
															
// output(IndivIds, named('IndivIds'));
// output(WatercraftKeys, named('WatercraftKeys'));
// output(WatercraftDetails, named('WatercraftDetails'));
// output(SortWCdetails, named('SortWCdetails'));
// output(RolledWC, named('RolledWC'));
// output(AddWCCount, named('AddWCCount'));


RETURN AddWCCount;

END;										