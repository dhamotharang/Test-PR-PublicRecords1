import VehicleV2;

export Layout_Base_Party_BIP
 :=
  record
	VehicleV2.Layout_Base_Party;
	unsigned8				source_rec_id := 0;	 	//Added for BIP project
  end
 ;