ds := VehicleV2.file_vehicleV2_party_bid.Bid_IN_Bdid;

recordof(VehicleV2.file_vehicleV2_party) trimSequence(ds l) := transform
	self.sequence_key := trim(l.sequence_key,left,right);
	self := l;
	end;	

export file_VehicleV2_Party_Clean_Sequence_Key_bid := project(ds,trimSequence(left));
  
  
  
			  