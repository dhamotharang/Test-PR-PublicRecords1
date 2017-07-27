import BIPV2;
//from VehicleV2.file_VehicleV2_party;
ds := project(vehicleV2.File_VehicleV2_Party_Building,transform({VehicleV2.Layout_Base_Party , BIPV2.IDlayouts.l_xlink_ids},self:=left));

ds trimSequence(ds l) := transform
	self.sequence_key := trim(l.sequence_key,left,right);
	self := l;
	end;	

export file_VehicleV2_Party_Clean_Sequence_Key := project(ds,trimSequence(left));
  
  
  
			  
  
			  