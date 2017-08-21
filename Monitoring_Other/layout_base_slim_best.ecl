import watchdog, monitoring_other;

export layout_base_slim_best := record
    string10  customer_id;       
    string30  record_id;
		string9  in_ssn;
		unsigned1 did_count;
		boolean monitoring_prp := false;
		boolean monitoring_paw := false;
    layout_did_deed_paw;
		qSTRING20 name_first;
		qSTRING20 name_middle;
		qSTRING20 name_last;
	  qSTRING5  name_suffix;
end;