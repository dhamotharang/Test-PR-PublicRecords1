import crim;

export layout_events_seq := record
	unsigned2	seq;
	crim.Layout_Crim_Events;
	varstring suspended_status_mapped;
	varstring agency_id_mapped;
end;
