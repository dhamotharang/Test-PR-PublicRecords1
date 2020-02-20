
IMPORT FAA, RiskWise, AML;

EXPORT IndAircraft(DATASET(Layouts.LayoutAMLShellV2) IndivIds) := FUNCTION

//version 2
ACIdsKey := faa.key_aircraft_did(false);
ACDetailsKey := faa.key_aircraft_id(false);


LayoutAircraft := record
  unsigned6 aircraftid;
  string8 n_number;          
  unsigned6 did;
  unsigned4 seq;
  unsigned3 historydate;
  string8 datefirstseen;
  // string8 	CurrentFlag;   //used for testing
	unsigned3 aircraftCount := 0;

END;
	
	
	
LayoutAircraft	addAircraftIDs(IndivIds le, ACIdsKey ri) := transform
      self.aircraftid := ri.aircraft_id;
      self.n_number := ri.n_number;
			self.did := le.did;
			self.seq := le.seq;
			self.historydate := le.historydate;
      self := [];
	end; 
	

ACIds := join(IndivIds, ACIdsKey,
							Keyed(left.did = right.did),
							addAircraftIDs(left,right), left outer,
							atmost(riskwise.max_atmost));
							

LayoutAircraft	addAircraftDetails(ACIds le, ACDetailsKey ri) := transform
      self.aircraftid := le.aircraftid;
      self.n_number := le.n_number;
      // self.CurrentFlag := ri.current_flag;
			self.aircraftCount := if(ri.current_flag = 'A' and trim(le.n_number)!='',	1, 0);
			self.datefirstseen := if(ri.date_first_seen='', '999999', ri.date_first_seen);
			self := le;
			self := [];
			
	end;
	
	
ACDetails := join(ACIds, ACDetailsKey,
							Keyed(left.aircraftid = right.aircraft_id) and
							right.current_flag = 'A',
							addAircraftDetails(left,right),
							atmost(riskwise.max_atmost));
							
						
SortACdetails :=  sort(ACDetails, seq, did, aircraftid, -datefirstseen);

LayoutAircraft rollaircrafts(ACDetails le, ACDetails ri) := TRANSFORM
	SELF.aircraftid := le.aircraftid;
	self.n_number := le.n_number;
	self.did := le.did;
	self.seq := le.seq;
	// self.CurrentFlag :=  if(le.CurrentFlag = 'A',	le.CurrentFlag, ri.CurrentFlag);			
														
	self.aircraftCount := le.aircraftCount + if(le.n_number=ri.n_number, 0 , ri.aircraftCount);	
	self.historydate := le.historydate;
		self.datefirstseen := ri.datefirstseen;

END;

RolledAC :=  rollup(SortACdetails, left.seq = right.seq and left.did = right.did,
										rollaircrafts(left, right));
										
	
AddWCCount := join(IndivIds, RolledAC, 
										left.seq = right.seq and
										left.did = right.did,
										transform(Layouts.LayoutAMLShellV2,
															self.AirCraftCount := right.aircraftCount,
															self := left), left outer);
															

// output(ACIds, named('ACIds'));
// output(SortACdetails, named('SortACdetails'));
// output(RolledAC, named('RolledAC'));

RETURN AddWCCount;

END;																	