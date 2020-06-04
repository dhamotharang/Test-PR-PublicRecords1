IMPORT BIPV2, BIPV2_Files;
EXPORT _address_properties(DATASET(BIPV2.CommonBase.Layout) ds_in) := MODULE
	
	// Address validity test
	SHARED ds_filt := ds_in(zip4<>'');
	
	// Count INCs per address
	ds_flat_inc := ds_filt(company_charter_number<>'',company_inc_state<>'');
	ds_thin_inc := TABLE(
		ds_flat_inc,
		{zip, prim_name, prim_range, company_charter_number, company_inc_state},
		zip, prim_name, prim_range, company_charter_number, company_inc_state, MERGE);
	EXPORT ds_incs := TABLE(
		ds_thin_inc,
		{zip, prim_name, prim_range, UNSIGNED num_incs:=COUNT(GROUP)},
		zip, prim_name, prim_range, MERGE);
	
	// Count legal names by address
	ds_flat_name := ds_filt(company_name<>'',company_name_type_derived='LEGAL');
	ds_thin_name := TABLE(
		ds_flat_name,
		{zip, prim_name, prim_range, company_name},
		zip, prim_name, prim_range, company_name, MERGE);
	EXPORT ds_legal_names := TABLE(
		ds_thin_name,
		{zip, prim_name, prim_range, UNSIGNED num_legal_names:=COUNT(GROUP)},
		zip, prim_name, prim_range, MERGE);
	
	// Combine all properties by address
	EXPORT ds_combined := JOIN(
		ds_incs, ds_legal_names,
		LEFT.zip=RIGHT.zip AND LEFT.prim_name=RIGHT.prim_name AND LEFT.prim_range=RIGHT.prim_range,
		FULL OUTER, HASH);
	
	// Widen common layout to include address properties
	EXPORT ds_wide := JOIN(
		ds_in, ds_combined,
		LEFT.zip=RIGHT.zip AND LEFT.prim_name=RIGHT.prim_name AND LEFT.prim_range=RIGHT.prim_range,
		TRANSFORM(BIPV2_Files.files_powid().Layout_POWID, SELF.num_incs:=RIGHT.num_incs, SELF.num_legal_names:=RIGHT.num_legal_names, SELF:=LEFT,self := []),
		LEFT OUTER, KEEP(1), HASH);
END;
