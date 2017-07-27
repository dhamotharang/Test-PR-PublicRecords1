import ak_perm_fund,atf,bankrupt,drivers,emerges,govdata,prof_license,ln_property,ln_mortgage,
    property,utilfile,vehlic,dea,faa,watercraft, Doxie, Doxie_Raw,
	Doxie_crs, LN_TU;

export Layout_Source_Key := record
 header.layout_Source_ID;
 dataset(ak_perm_fund.Layout_AK_Common) ak_child;
 dataset(atf.layout_firearms_explosives_in) atf_child; 
 dataset(bankrupt.Layout_BK_Source) bk_child;
 dataset(bankrupt.layout_liens) lien_child;
 dataset(drivers.layout_dl) dl_child;
 dataset(emerges.layout_emerge_in) emerge_child;
 dataset(govdata.layout_ms_workers_comp_in) mswork_child;
 dataset(layout_death_master) death_child;
 dataset(layout_state_death) state_death_child;
 dataset(prof_license.layout_proflic_out) proflic_child;
 dataset(LN_Property.Layout_Property_Common_Model_BASE) asses_child;
 dataset(ln_mortgage.Layout_Deed_Mortgage_Common_Model_Base) deeds_child;
 dataset(utilfile.layout_utility_in) util_child;
 dataset(vehlic.Layout_Vehicles) veh_child;
 dataset(header.Layout_Eq_src) eq_child;
 dataset(Property.Layout_Fares_Foreclosure) for_child; 
 dataset(DEA.layout_DEA_In) dea_child;
 dataset(faa.layout_aircraft_registration_out) airc_child;
 dataset(faa.layout_airmen_data_out) airm_child;
 dataset(watercraft.Layout_Watercraft_Source) watercraft_child;
 dataset(emerges.Layout_Boats_In) boater_child;
 dataset(header.Layout_Header) finder_child;
 dataset(LN_TU.Layout_In_Header_All) tu_child;
end;

