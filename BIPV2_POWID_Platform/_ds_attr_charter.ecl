IMPORT MDR;

ds_in := In_POWID;

l_attr_charter := RECORD
	ds_in.powid;
	ds_in.company_inc_state;
	ds_in.company_charter_number;
END;

ds_filt := ds_in(company_inc_state<>'', company_charter_number<>'');
ds_thin := PROJECT(ds_filt, l_attr_charter);
ds_dist := DISTRIBUTE(ds_thin,HASH32(powid));

EXPORT _ds_attr_charter := DEDUP(SORT(ds_dist,RECORD,LOCAL),RECORD,LOCAL);