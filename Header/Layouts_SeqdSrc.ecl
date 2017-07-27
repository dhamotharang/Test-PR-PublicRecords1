import
			ak_perm_fund
			,utilfile
			,vehiclev2
			,bankrupt
			,driversv2
			,gong
			,ln_property
			,LN_Mortgage
			,emerges
			,atf
			,prof_license
			,govdata
			,faa
			,dea
			,watercraft
			,property
			,targus
			,LiensV2
			,ln_propertyv2
			,american_student_list
			,votersv2
			,certegy
			,ExperianCred
			,ExperianIRSG_Build
			,eq_hist
			,TransunionCred
			,BankruptcyV2
			,AlloyMedia_student_list
			;

EXPORT Layouts_SeqdSrc := module

	SHARED lsrc:=header.Layout_Source_ID;

	EXPORT EQ_src_rec:=       header.layout_header_in;
	EXPORT L2_src_rec:={lsrc, liensv2.Layout_as_source};
	EXPORT EN_src_rec:={lsrc, ExperianCred.Layouts.Layout_Out_old};
	EXPORT TN_src_rec:={lsrc, TransunionCred.Layouts.base};
	EXPORT DL_src_rec:={lsrc, driversv2.Layout_Base_withAID};
	EXPORT VH_src_rec:={lsrc, vehicleV2.layout_vehicle_source};
	EXPORT BA_src_rec:={lsrc, string1 ssnMSrc,string9 ssnMatch, BankruptcyV2.layout_bk_source};
	EXPORT FAT_src_rec:={lsrc, LN_Property.Layout_Property_Common_Model_BASE};
	EXPORT FAD_src_rec:={lsrc, LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE};
	EXPORT DE_src_rec:={lsrc, header.Layout_DID_Death_MasterV2_expanded};
	EXPORT DS_src_rec:={lsrc, layout_state_death};
	EXPORT EM_src_rec:={lsrc, emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout};
	EXPORT UT_src_rec:={lsrc, utilfile.layout_util.OLD_Layout_Utility_In};
	EXPORT AK_src_rec:={lsrc, ak_perm_fund.Layout_AK_Common};
	EXPORT ATF_src_rec:={lsrc, ATF.layout_firearms_explosives_in};
	EXPORT PL_src_rec:={lsrc, prof_license.layout_prolic_out_with_AID};
	EXPORT WC_src_rec:={lsrc, govdata.layout_ms_workers_comp_in};
	EXPORT LI_src_rec:={lsrc, Bankrupt.layout_liens};
	EXPORT FR_src_rec:={lsrc, Property.Layout_Fares_Foreclosure};
	EXPORT AM_src_rec:={lsrc, faa.layout_airmen_data_out};
	EXPORT AC_src_rec:={lsrc, faa.layout_aircraft_registration_out};
	EXPORT WA_src_rec:=       watercraft.Layout_Watercraft_Full;
	EXPORT BO_src_rec:={lsrc, emerges.layout_boats_in};
	EXPORT DEA_src_rec:={lsrc, DEA.layout_DEA_In};
	EXPORT WP_src_rec:={lsrc, targus.layout_consumer_out};
	EXPORT SL_src_rec:={lsrc, american_student_list.layout_american_student_base};
	EXPORT VO_src_rec:={lsrc, VotersV2.Layouts_Voters.Layout_Voters_Base};
	EXPORT CY_src_rec:={lsrc, Certegy.layouts.base};
	EXPORT ND_src_rec:={lsrc, Property.Layout_Fares_Foreclosure};
	EXPORT EL_src_rec:={lsrc, ExperianIRSG_Build.Layouts.Layout_Out};
	EXPORT AY_src_rec:={lsrc, AlloyMedia_student_list.layouts.layout_base};

end;