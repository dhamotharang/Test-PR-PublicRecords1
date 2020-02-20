//was once Layout_Source_Key
import ak_perm_fund,atf,bankrupt,bankruptcyv2_services,Drivers,DriversV2_services,emerges,govdata,prof_license,ln_property,ln_mortgage,
    property,utilfile,vehlic,dea,faa,watercraft, Doxie, Doxie_Raw,
	Doxie_crs, LN_TU, liensv2_services, DEAV2_Services,vehiclev2_services
	, LN_PropertyV2_Services, FBNV2_services, ExperianCred, VotersV2_Services,TransunionCred;

export Layout_HeaderSource := record
 header.layout_Source_ID;
 dataset(ak_perm_fund.Layout_AK_Common) ak_child;
 dataset(atf.layout_firearms_explosives_in) atf_child; 
 dataset(Doxie.layout_bk_output) bk_child;
 dataset(bankruptcyv2_services.layouts.layout_rollup) bk_V2_child;
 dataset(bankrupt.layout_liens) lien_child;
 dataset(liensv2_services.layout_lien_rollup) lien_V2_child;
 dataset(drivers.layout_dl) dl_child;
 dataset(DriversV2_Services.layouts.result_rolled) dl2_child;
 dataset(emerges.layout_emerge_in) emerge_child;
 dataset(govdata.layout_ms_workers_comp_in) mswork_child;
 dataset(Doxie_Raw.layout_death_Raw) death_child;
 dataset(layout_state_death) state_death_child;
 dataset(prof_license.layout_proflic_out) proflic_child;
 dataset(LN_Property.Layout_Property_Common_Model_BASE) asses_child;
 dataset(LN_PropertyV2_Services.layouts.out_widest)	asses2_child;
 dataset(ln_mortgage.Layout_Deed_Mortgage_Common_Model_Base) deeds_child;
 dataset(LN_PropertyV2_Services.layouts.out_widest)	deeds2_child;
 dataset(utilfile.layout_utility_in) util_child;
 dataset(Doxie.Layout_VehicleSearch) veh_child;
 dataset(vehiclev2_services.Layout_Report) veh_v2_child;
 dataset(header.Layout_Eq_src_dates) eq_child; //138824 
 dataset(ExperianCred.Layouts.Layout_SourceDoc) en_child;
 dataset(Property.Layout_Fares_Foreclosure_Ex_Sids) for_child; 
 dataset(Property.Layout_Fares_Foreclosure_Ex_Sids) nod_child; 
 dataset(DEA.layout_DEA_In) dea_child;
 dataset(DEAV2_Services.assorted_layouts.Layout_Output) dea_v2_child;
 dataset(faa.layout_aircraft_registration_out_slim) airc_child;
 dataset(faa.layout_airmen_data_out) airm_child;
 dataset(watercraft.Layout_Watercraft_Full) watercraft_child;
 dataset(emerges.Layout_Boats_In) boater_child;
 dataset(doxie_raw.layout_header_raw) finder_child;
 dataset(LN_TU.Layout_In_Header_All) tu_child;
 dataset(TransunionCred.Layouts.base) tn_child;
 dataset(doxie_raw.layout_targus_raw) targ_child;
 dataset(FBNV2_services.Layout_FBN_Report) FBNv2_child;
 dataset(VotersV2_Services.layouts.SourceOutput) voters_v2_child;
end;