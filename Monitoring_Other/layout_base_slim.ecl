export layout_base_slim := record
	     string10  customer_id;       
       string30  record_id;
			 string9  in_ssn;
			 unsigned6 did;
			 unsigned1 did_count;
			 boolean monitoring_prp := false;
			 boolean monitoring_paw := false;
			 qSTRING20 name_first;
			 qSTRING20 name_middle;
			 qSTRING20 name_last;
			 qSTRING5  name_suffix;
end;