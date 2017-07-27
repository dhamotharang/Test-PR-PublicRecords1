Import Data_Services, VehicleV2, VehLic, Doxie, ut;

slim_rec := record
		unsigned8 	source_rec_id;
		string30		vehicle_key;
		string15		iteration_key;
		string15		sequence_key;
end;

slim_rec slimFile(VehicleV2.Layout_Base.Party_Base_BIP l) := transform
	self 							:= l;
end;	

Party_Sequence_Key := project(vehicleV2.File_VehicleV2_Party_Building,slimFile(left));

export Key_Vehicle_Source_Rec_ID := index(Party_Sequence_Key, {source_rec_id}, {Party_Sequence_Key},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::VehicleV2::Source_Rec_Id_'+ doxie.Version_SuperKey);