import bair, BIPV2;
EXPORT layout_vehicle_base := record
	bair.layouts.dbo_event_vehicle_final_Base;
	// STRING2	source;
	//UNSIGNED6	bdid := 0;
	//UNSIGNED6 did := 0;
	// UNSIGNED6 rid := 0;
	// UNSIGNED6 sid := 0;
	BIPV2.IDlayouts.l_xlink_ids;
end;