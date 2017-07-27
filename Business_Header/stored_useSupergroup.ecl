// Identify whether using a multi-BDID report.
boolean multiBDID := (business_header.stored_bdid_val[1] = '{');
boolean st_use_Supergroup := false : stored('useSupergroup');
boolean bdids_Derived :=  false : stored('bdidsDerived');
export boolean stored_useSupergroup := (not (multiBDID or bdids_derived)) and st_use_Supergroup;
