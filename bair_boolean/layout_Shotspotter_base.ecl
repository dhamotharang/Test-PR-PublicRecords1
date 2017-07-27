import bair, BIPV2;
EXPORT layout_Shotspotter_base := record
	bair.layouts.gunop_dbo_shot_incident_Base;
	// STRING2	source;
	//UNSIGNED6	bdid := 0;
	//UNSIGNED6 did := 0;
	// UNSIGNED6 rid := 0;
	// UNSIGNED6 sid := 0;
	BIPV2.IDlayouts.l_xlink_ids;
end;