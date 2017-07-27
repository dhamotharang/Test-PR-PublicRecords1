import doxie;
doxie.MAC_Header_Field_Declare()

did := (unsigned6)did_value;
dids := dataset([{did}], doxie.layout_references);
bydid := deathv2_services.raw.get_death_ids.from_dids(dids);



ids := 
	if(StateDeathID_value <> '', dataset([{StateDeathID_value}],deathv2_services.layouts.death_id)) +
	if(did > 0, bydid);

export ReportRecords := deathv2_services.raw.get_report.from_death_ids(ids,ssn_mask_value);