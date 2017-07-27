IMPORT  address, ut, header_slimsort, did_add, didville,watchdog;
ds := DATASET('~thor400::base::transunion_PTrak', Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut, FLAT);
ds2 := ds(TRIM(Name,all) <> ',');
ut.mac_sf_buildprocess(ds2, '~thor400::base::transunion_PTrak', build_transunionPTrak_base, 2,,TRUE);
export Temp_superfile:= build_transunionPTrak_base;



