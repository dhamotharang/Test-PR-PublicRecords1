import versioncontrol;
export Persistnames :=
module
	export UpdateCorp				:= Thor_Cluster + 'persist::Corp2::Update_Corp';
	export UpdateCont				:= Thor_Cluster + 'persist::Corp2::Update_Cont';
	export UpdateContBDID			:= Thor_Cluster + 'persist::Corp2::Update_Cont::BDID';
	export UpdateEvent				:= Thor_Cluster + 'persist::Corp2::Update_Event';
	export UpdateStock				:= Thor_Cluster + 'persist::Corp2::Update_Stock';
	export UpdateAR					:= Thor_Cluster + 'persist::Corp2::Update_AR';
	
	export Corp4_As_Corp2			:= Thor_Cluster + 'persist::Corp2::Corp4AsCorp2';
	export Corp4_As_Corp2_Contacts	:= Thor_Cluster + 'persist::Corp2::Corp4AsCorp2Contacts';

	export BDIDEvent				:= Thor_Cluster + 'persist::Corp2::BDID_Event';

	export dAll_superfilenames :=
	dataset([
	
		 {UpdateCorp}
		,{UpdateEvent}
		,{UpdateCont}
		,{UpdateContBDID}
		,{UpdateStock}
		,{UpdateAR}
		,{Corp4_As_Corp2}
		,{Corp4_As_Corp2_Contacts}
		,{BDIDEvent}
		
	], versioncontrol.Layout_Names);
		
end;