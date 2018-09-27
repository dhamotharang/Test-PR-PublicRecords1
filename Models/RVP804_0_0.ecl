/*  Modelers Notes
************************************************************************************
* RVP804.0.0                       Version 01                                BY PK *
*                               Project ID:  ????                       09/05/2008 *
************************************************************************************

************************************************************************************
* Returns the following fields - RVP804                                            *
************************************************************************************

************************************************************************************
* Changes Made Since Previous Revision (Insert Comments Here)                      *
* Inserted RiskView Parameters                                         9-12-08  PK *
* Modified AVM Code                                                    9-24-08  PK *
************************************************************************************
*/

import risk_indicators, ut, std, riskview;

export RVP804_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	// Process Model into Layout
temp := record
	layout_modelout;
	
	#if(Risk_Indicators.iid_constants.validation_debug)
		Risk_Indicators.Layout_Boca_Shell clam;	
		
		real	Mod_Capped_a	;
		real	voter_level 	;
		real	ams_hit 	;
		real	source_pos_weak 	;
		real	derog_level_m 	;
		real	prop_mod 	;
		real	ssns_per_adl_c_m 	;
		real	addrs_per_ssn_c_m 	;
		real	per_addr_tree_m 	;
		real	per_ssn_tree_m 	;
		real	avm_mod 	;
		real	phones_per_adl_c6_m 	;
		real	ssns_per_addr_c6_m 	;
		real	age_code_m 	;
		real	phnprob2_m 	;
		real	time_since_mod 	;
		real	nap_tree 	;
		real	Mod_Capped_m	;
		// real	ams_hit 	;  // already part of the mod_capped_a variables
		real	pos_sec_ver_flag3 	;
		real	derog_flag 	;
		real	phn_mod 	;
		real	agecode_m 	;
		real	prop_mod2 	;
		real	avm_mod_m 	;
		real	velo_mod2 	;
		real	velo_c6_mod 	;
	#end
end;


	temp doModel( clam le ) := TRANSFORM
		
		// variables
		out_addr_status									:=	le.address_validation.error_codes;
		nas_summary                     :=  le.iid.nas_summary;
		nap_summary                     :=  le.iid.nap_summary;
		nap_status                      :=  le.iid.nap_status;
		rc_hriskphoneflag               :=  le.iid.hriskphoneflag;
		rc_hphonetypeflag               :=  le.iid.hphonetypeflag;
		rc_hphonevalflag                :=  le.iid.hphonevalflag;
		rc_phonezipflag                 :=  le.iid.phonezipflag;
		rc_hriskaddrflag                :=  le.iid.hriskaddrflag;
		rc_decsflag                     :=  le.ssn_verification.validation.deceased;
		rc_ssndobflag                   :=  le.iid.socsdobflag;
		rc_pwssndobflag                 :=  le.iid.PWsocsdobflag;
		rc_dwelltype                    :=  trim(le.address_validation.dwelling_type);
		rc_bansflag                     :=  le.iid.bansflag;
		rc_sources                      :=  le.iid.sources;
		rc_phoneaddr_phonecount         :=  le.iid.phoneaddr_phonecount;
		rc_hrisksic                     :=  le.iid.hrisksic;
		rc_hrisksicphone                :=  le.iid.hrisksicphone;
		rc_disthphoneaddr               :=  le.iid.disthphoneaddr;
		rc_ziptypeflag                  :=  le.address_validation.zip_type;
		adl_EQ_first_seen								:=	le.source_verification.adl_EQfs_first_seen;
		adl_PR_first_seen								:=	le.source_verification.adl_PR_first_seen;
		adl_V_first_seen								:=	le.source_verification.adl_V_first_seen;
		adl_EM_first_seen								:=	le.source_verification.adl_EM_first_seen;
		lname_sources                   :=  StringLib.StringToUppercase(trim(le.Source_Verification.lastnamesources));
		addr_sources                    :=  StringLib.StringToUppercase(trim(le.Source_Verification.addrsources));
		voter_avail											:=	le.Available_Sources.voter;
		addrpop                         :=  le.input_validation.address;
		ssnlength                       :=  le.input_validation.ssn_length;
		hphnpop                         :=  le.input_validation.homephone;
		age															:=	le.Name_Verification.age;
		Add1_lres                       :=  le.lres;
		add1_avm_land_use               :=  le.AVM.Input_Address_Information.avm_land_use_code;
		add1_avm_recording_date					:=  le.AVM.Input_Address_Information.avm_recording_date	;
		add1_avm_assessed_value_year		:=  le.AVM.Input_Address_Information.avm_assessed_value_year;
		add1_avm_sales_price						:=  le.AVM.Input_Address_Information.avm_sales_price;
		add1_avm_tax_assessed_valuation :=  le.AVM.Input_Address_Information.avm_tax_assessment_valuation;
		add1_avm_hedonic_valuation			:=  le.AVM.Input_Address_Information.avm_hedonic_valuation;
		add1_avm_automated_valuation		:=  le.AVM.Input_Address_Information.avm_automated_valuation;
		add1_avm_med_fips								:=  le.AVM.Input_Address_Information.avm_median_fips_level;
		add1_avm_med_geo11							:=  le.AVM.Input_Address_Information.avm_median_geo11_level;
		add1_avm_med_geo12							:=  le.AVM.Input_Address_Information.avm_median_geo12_level;
		add1_applicant_owned            :=  le.address_verification.input_address_information.applicant_owned;
		add1_occupant_owned             :=  le.address_verification.input_address_information.occupant_owned;
		add1_family_owned               :=  le.address_verification.input_address_information.family_owned;
		add1_family_sold								:=	le.Address_Verification.input_address_information.family_sold;
		add1_applicant_sold							:=	le.Address_Verification.input_address_information.applicant_sold;
		add1_naprop                     :=  le.address_verification.input_address_information.naprop;
		add1_purchase_date							:=  le.address_verification.input_address_information.purchase_date;
		add1_purchase_amount						:=  le.address_verification.input_address_information.purchase_amount;
		add1_mortgage_amount						:=  le.address_verification.input_address_information.mortgage_amount;
		add1_assessed_amount						:=  le.address_verification.input_address_information.assessed_amount;
		add1_date_first_seen            :=  le.address_verification.input_address_information.date_first_seen;
		property_owned_total            :=  le.address_verification.owned.property_total;
		property_owned_purchase_count		:=	le.address_verification.owned.property_owned_purchase_count;
		property_owned_assessed_count		:=	le.address_verification.owned.property_owned_assessed_count;
		property_sold_total             :=  le.address_verification.sold.property_total;
		property_sold_purchase_count		:=	le.Address_Verification.sold.property_owned_purchase_count;
		property_sold_assessed_count		:=	le.Address_Verification.sold.property_owned_assessed_count;
		Add2_lres                       :=  le.lres2;
		add2_naprop                     :=  le.address_verification.address_history_1.naprop;
		add2_date_first_seen						:=  le.address_verification.address_history_1.date_first_seen;
		add2_pop												:=  le.addrPop2;
		add3_pop												:=  le.addrPop3;
		addrs_5yr                       :=  le.other_address_info.addrs_last_5years;
		addrs_15yr                      :=  le.other_address_info.addrs_last_15years;
		nameperssn_count                :=  le.SSN_Verification.NamePerSSN_count;
		bk_sourced											:=	le.SSN_Verification.bk_sourced;
		ssns_per_adl                    :=  le.velocity_counters.ssns_per_adl;
		adlperssn_count                 :=  le.SSN_Verification.adlPerSSN_count;
		addrs_per_ssn                   :=  le.velocity_counters.addrs_per_ssn;
		adls_per_addr                   :=  le.velocity_counters.adls_per_addr;
		ssns_per_addr                   :=  le.velocity_counters.ssns_per_addr;
		phones_per_addr                 :=  le.velocity_counters.phones_per_addr;
		adls_per_phone                  :=  le.velocity_counters.adls_per_phone;
		addrs_per_adl_c6                :=  le.velocity_counters.addrs_per_adl_created_6months;
		phones_per_adl_c6               :=  le.velocity_counters.phones_per_adl_created_6months;
		addrs_per_ssn_c6								:=	le.velocity_counters.addrs_per_ssn_created_6months;
		ssns_per_addr_c6                :=  le.velocity_counters.ssns_per_addr_created_6months;
		phones_per_addr_c6              :=  le.velocity_counters.phones_per_addr_created_6months;
		adls_per_phone_c6               :=  le.velocity_counters.adls_per_phone_created_6months;
		bankrupt                        :=  le.bjl.bankrupt;
		bk_recent_count                 :=  le.bjl.bk_recent_count;
		liens_recent_unreleased_count   :=  le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct  :=  le.bjl.liens_historical_unreleased_count;
		criminal_count                  :=  le.bjl.criminal_count;
		watercraft_count								:=	le.watercraft.watercraft_count;
		ams_file_type										:=	trim(le.student.file_type);
		prof_license_flag               :=  le.professional_license.professional_license_flag;
		archive_date										:= if(le.historydate=999999, (unsigned3)((STRING)Std.Date.Today())[1..6], le.historydate);


//  ************************************************************************************
//  * Code Starts Here                                                                 *
//  ************************************************************************************

		// common variables
		isThinFileModel := StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'EQ', 1) >= 1;
		sysyear := (integer)((STRING)archive_date)[1..4];
		sysmth  := (integer)((STRING)archive_date)[5..7];
		dwelling_type := rc_dwelltype;
		error_codes := out_addr_status;		
		
		ssnpop := if((integer)ssnlength > 0, 1, 0);		
		
		phone_zip_mismatch := if(rc_phonezipflag = '1', 1, 0);
		
		distance := rc_disthphoneaddr;		
		
		disconnected := if(rc_hriskphoneflag = '5', 1, 0);
		
		hr_phone := if(rc_hriskphoneflag = '6', 1, 0);
	
		phn_corrections := if(rc_hrisksicphone = '2225', 1, 0);
		
		deceased := if((integer)rc_decsflag = 1, 1, 0);
		
		pnotpot := if( rc_hphonetypeflag[1] in ['0','Z'], 0, 1);
	
		phninval2 := if(rc_hphonevalflag = '0', 1, 0);
								
		hr_phone_flag := if(rc_hphonevalflag = '3', 1, 0);
		
		aptflag := if(rc_dwelltype = 'A', 1, 0);
		
		bkflag := if(rc_bansflag in ['1', '2'], 1, 0);
		
		addzippobox := if(rc_hriskaddrflag = '1', 1, 0);

		zippobox := if(rc_ziptypeflag = '1', 1, 0);

    // Verification
		source_AM_tot := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'AM', 1) >= 1 );
		source_AR_tot := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'AR', 1) >= 1 );
		source_BA_tot := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'BA', 1) >= 1 );
		source_CG_tot := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'CG', 1) >= 1 );
		source_DA_tot := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'DA', 1) >= 1 );
		source_DS_tot := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'DS', 1) >= 1 );
		source_EB_tot := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'EB', 1) >= 1 );
		source_L2_tot := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'L2', 1) >= 1 );
		source_LI_tot := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'LI', 1) >= 1 );
		source_P_tot  := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'P ', 1) >= 1 );
		source_PL_tot := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'PL', 1) >= 1 );
		source_W_tot  := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'W ', 1) >= 1 );
		source_EM_lst := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(lname_sources),'EM', 1) >= 1 );
		source_VO_lst := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(lname_sources),'VO', 1) >= 1 );
		source_EM_VO_lst := if(source_EM_lst=1 or source_VO_lst=1, 1, 0);
		source_EM_add := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(addr_sources),'EM', 1) >= 1 );
		source_VO_add := (integer)(StringLib.StringFind(StringLib.StringToUpperCase(addr_sources),'VO', 1) >= 1 );
		source_EM_VO_add := if(source_EM_add=1 or source_VO_add=1, 1, 0);
		                
		/* Nap Summary */
		verlst_p := (integer)(nap_summary in [2,5,7,8,9,11,12]);
		veradd_p := (integer)(nap_summary in [3,5,6,8,10,11,12]);	
		verphn_p := (integer)(nap_summary in [4,6,7,9,10,11,12]);	
		contrary_phone := (integer)(nap_summary = 1);

		
		voter_level := Map(voter_avail and source_EM_VO_lst=1 and source_EM_VO_add=1 => 1,
											 voter_avail and ( source_EM_VO_lst=1 or source_EM_VO_add=1 ) => 0,
											 voter_avail => -1,
											 0);
		
		prof_license_flag2 := if(prof_license_flag or source_PL_tot=1, 1, 0);
		
		ams_hit := if( length(ams_file_type) = 0, 0, 1);
					
		Source_Pos_Weak := max(source_AM_tot,
													source_AR_tot,
													source_CG_tot,
													source_EB_tot,
													prof_license_flag2,
													source_W_tot);
													
													
		lien_flag := if(liens_historical_unreleased_ct > 0 or liens_recent_unreleased_count > 0 or
											 source_L2_tot > 0 or source_LI_tot > 0, 1, 0 );
		
		bankrupt2 := if(source_BA_tot > 0 or (integer)bankrupt > 0 or (integer)bk_sourced > 0 or bkflag > 0 or bk_recent_count > 0, 1, 0);
		
		deceased2 := if(source_DS_tot > 0 or deceased > 0, 1, 0);
												
		crim_flag := if(criminal_count > 0, 1, 0);
		
		derog_flag := max( source_DA_tot, lien_flag, bankrupt2, deceased2, crim_flag );
		
		derog_level := Map(lien_flag > 0 or crim_flag > 0 => 2,
											 derog_flag > 0 => 1,
											 0);


		derog_level_m := Map(derog_level = 0 => 0.171248058,
												 derog_level = 1 => 0.1929012346,
												 0.4198113208);	
		
		property_sourced := if(source_P_tot > 0 or add1_naprop >= 3, 1, 0);
		
		pos_sec_ver_flag3 := sum( source_W_tot, source_AM_tot, prof_license_flag2 );	
		
		since_add1_date_first_seen_a := sysyear - (integer)((STRING)add1_date_first_seen)[1..4];
		since_add2_date_first_seen_a := sysyear - (integer)((STRING)add2_date_first_seen)[1..4];

		since_add1_date_first_seen := if(since_add1_date_first_seen_a > 2000, -9999, since_add1_date_first_seen_a);
		since_add2_date_first_seen := if(since_add2_date_first_seen_a > 2000, -9999, since_add2_date_first_seen_a);


		since_add1_date_first_seen_level := Map(since_add1_date_first_seen = -9999 => 1,
																						since_add1_date_first_seen = 0 => 0,
																						since_add1_date_first_seen = 1 => 1,
																						since_add1_date_first_seen <= 3 => 2,
																						3);

		since_add2_date_first_seen_level := Map(since_add2_date_first_seen = -9999 => 3,
																						since_add2_date_first_seen <= 0 => 0,
																						since_add2_date_first_seen <= 2 => 1,
																						since_add2_date_first_seen <= 3 => 2,
																						3);		


		add1_owned_level := Map(add1_applicant_owned and add1_family_owned => 4,
														add1_applicant_owned => 3,
														add1_family_owned and ~add1_applicant_sold and ~add1_family_sold => 2,
														add1_family_owned => 1,
														0);
													
		
		
		addrs_15_risk_level := Map(add2_pop and add3_pop and addrs_15yr >= 4 => 0,
															 add2_pop and add3_pop and addrs_15yr >= 2 => 2,
															 add2_pop and add3_pop => 3,
															 add2_pop and addrs_15yr >= 2 => 1,
															 add2_pop and addrs_15yr >= 1 => 2,
															 add2_pop => 3,
															 addrs_15yr = 1 => 0,
															 1);		
		
	
		addrs_15_risk_level_m := Map(addrs_15_risk_level = 0 => 0.1493518576,
																 addrs_15_risk_level = 1 => 0.1614033512,
																 addrs_15_risk_level = 2 => 0.1876956956,
																 0.2281741509);


		since_add1_date_first_seen_lvl_m := Map(since_add1_date_first_seen_level = 0 => 0.2119427368,
																						since_add1_date_first_seen_level = 1 => 0.1891818674,
																						since_add1_date_first_seen_level = 2 => 0.1531725717,
																						0.1046558869);


		since_add2_date_first_seen_lvl_m := Map(since_add2_date_first_seen_level = 0 => 0.2340214932,
																						since_add2_date_first_seen_level = 1 => 0.1985977053,
																						since_add2_date_first_seen_level = 2 => 0.1751213057,
																						0.1571234735);		
		


		// Nap Tree
		nap_tree1 := Map(contrary_phone=1 => -1,
										 verlst_p=1 and veradd_p=1 and verphn_p=1 => 4,
										 verlst_p=1 and verphn_p=1 => 3,
										 sum( verlst_p, veradd_p, verphn_p ) = 2 => 2,
										 sum( verlst_p, veradd_p, verphn_p ) = 1 => 1,
										 0);
		
		nap_tree1_m := Map(nap_tree1 = -1 => 0.2583333333,
											 nap_tree1 = 0 => 0.218537865,
											 nap_tree1 = 1 => 0.2066601371,
											 nap_tree1 = 2 => 0.1712172263,
											 nap_tree1 = 3 => 0.1503267974,
											 0.0869215121);		
		
		
		nap_tree2 := Map(verphn_p=1 and verlst_p=1 and veradd_p=1 and rc_phoneaddr_phonecount >0 => 4,
										 verphn_p=1 and verlst_p=1 => 3,
										 verphn_p=1 and veradd_p=1 => 2,
										 verlst_p=1 and veradd_p=1 => 1,
										 ~hphnpop => -1,
										 0);
		
		nap_tree2_m := Map(nap_tree2 = -1 => 0.184995015,
											 nap_tree2 = 0 => 0.2235052605,
											 nap_tree2 = 1 => 0.1700323724,
											 nap_tree2 = 2 => 0.1305441963,
											 nap_tree2 = 3 => 0.0979418027,
											 0.0633769452);				
		
		nap_tree := if(isThinFileModel, nap_tree1_m, nap_tree2_m);
		
		
		// AVM
		avm_hit := if((integer)add1_avm_land_use > 0, 1, 0);
		
		add1_avm_recording_year := (integer)add1_avm_recording_date[1..4];	
		
/*  avm_sysyear := 2007;           /* For Archive    */
		avm_sysyear := sysyear;         /* For Production */


		since_add1_avm_recording_year_tmp := if(add1_avm_recording_year > 0, avm_sysyear - add1_avm_recording_year, -9999);
		since_add1_avm_recording_year := if(since_add1_avm_recording_year_tmp > 30, 30, since_add1_avm_recording_year_tmp);	
		
		add1_avm_sales_price_c_tmp         := 20000 * roundup( (real)add1_avm_sales_price            / 20000 );
		add1_avm_ta_valuation_c_tmp        := 20000 * roundup( add1_avm_tax_assessed_valuation / 20000 );
		add1_avm_hedonic_valuation_c_tmp   := 20000 * roundup( add1_avm_hedonic_valuation      / 20000 );
		add1_avm_automated_valuation_c_tmp := 20000 * roundup( add1_avm_automated_valuation    / 20000 );		
		
		add1_avm_sales_price_c  := if(add1_avm_sales_price_c_tmp > 700000, 700000, add1_avm_sales_price_c_tmp);
		add1_avm_ta_valuation_c := if(add1_avm_ta_valuation_c_tmp > 700000, 700000, add1_avm_ta_valuation_c_tmp);
		add1_avm_hedonic_valuation_c := if(add1_avm_hedonic_valuation_c_tmp > 700000, 700000, add1_avm_hedonic_valuation_c_tmp);
		add1_avm_automated_valuation_c := if(add1_avm_automated_valuation_c_tmp > 700000, 700000, add1_avm_automated_valuation_c_tmp);
		
		
		add1_avm_med := Map(add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
												add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
												add1_avm_med_fips);		
								
								
								
// START OF UN-COMMON								

     /* Property */

			add1_purchase_amount_c_tmp := 20000 * roundup( add1_purchase_amount / 20000 );
			add1_assessed_amount_c_tmp := 20000 * roundup( add1_assessed_amount / 20000 );

			add1_purchase_amount_c :=  if(add1_purchase_amount_c_tmp > 600000, 600000, add1_purchase_amount_c_tmp);
			add1_assessed_amount_c :=  if(add1_assessed_amount_c_tmp > 600000, 600000, add1_assessed_amount_c_tmp);

			add1_purchase_amount_c_level :=  map(add1_purchase_amount_c in [0, 80000] => 1,
																					add1_purchase_amount_c <= 60000 => 0,
																					add1_purchase_amount_c <= 140000 => 2,
																					add1_purchase_amount_c <= 220000 => 3,
																																							4);			
																					
			add1_assessed_amount_c_level :=  map(add1_assessed_amount_c = 0       => 2,
																					 add1_assessed_amount_c <= 60000  => 0,
																					 add1_assessed_amount_c <= 100000 => 1,
																					 add1_assessed_amount_c <= 120000 => 2,
																					 add1_assessed_amount_c <= 200000 => 3,
																					 add1_assessed_amount_c <= 360000 => 4,
																																							 5);	
																																							 
			add1_naprop_level :=  map(add1_naprop = 4 => 2,
																add1_naprop = 3 => 1,
																add1_naprop = 0 => 0,
																									-1);

			naprop_tree :=  map((add1_naprop_level = 2) and (add2_naprop = 4)        => 9,
													(add1_naprop_level = 2) and ((integer)add2_pop = 0)           => 8,
													add1_naprop_level = 2                                => 7,
													(add1_naprop_level = 1) and (add2_naprop in [3, 4])  => 6,
													(add1_naprop_level = 1) and ((integer)add2_pop = 0)           => 7,
													(add1_naprop_level = 1) and (add2_naprop = 1)        => 4,
													add1_naprop_level = 1                                => 5,
													(add1_naprop_level = 0) and (add2_naprop in [3, 4])  => 5,
													(add1_naprop_level = 0) and ((integer)add2_pop = 0)           => 3,
													(add1_naprop_level = 0) and (add2_naprop = 1)        => 1,
													add1_naprop_level = 0                                => 2,
													(add1_naprop_level = -1) and (add2_naprop in [3, 4]) => 4,
													(add1_naprop_level = -1) and (add2_naprop = 1)       => 0,
																																									2);
																																									
																																									
			prop_tree :=  map(naprop_tree <= 4                               => naprop_tree,
												(naprop_tree <= 5) and (add1_owned_level <= 1) => 5,
												naprop_tree <= 5                               => 6,
												naprop_tree <= 6                               => 7,
												(naprop_tree <= 7) and (add1_owned_level <= 1) => 7,
												(naprop_tree <= 7) and (add1_owned_level <= 3) => 8,
												naprop_tree <= 7                               => 9,
												(naprop_tree <= 8) and (add1_owned_level <= 3) => 9,
												naprop_tree <= 8                               => 10,
												(naprop_tree <= 9) and (add1_owned_level <= 1) => 9,
																																					11);


			add1_purchase_amount_c_level_m :=  map(add1_purchase_amount_c_level = 0 => 0.2153291253,
																						 add1_purchase_amount_c_level = 1 => 0.185341937,
																						 add1_purchase_amount_c_level = 2 => 0.1558308707,
																						 add1_purchase_amount_c_level = 3 => 0.1302366789,
																																								 0.1116584565);
																																			 
			add1_assessed_amount_c_level_m :=  map(add1_assessed_amount_c_level = 0 => 0.3093093093,
																						 add1_assessed_amount_c_level = 1 => 0.2091310751,
																						 add1_assessed_amount_c_level = 2 => 0.1805457672,
																						 add1_assessed_amount_c_level = 3 => 0.132576644,
																						 add1_assessed_amount_c_level = 4 => 0.1046037736,
																																								 0.0915460065);


			prop_tree_m :=  map(prop_tree = 0  => 0.2629246677,
													prop_tree = 1  => 0.2295252999,
													prop_tree = 2  => 0.2221669486,
													prop_tree = 3  => 0.199154334,
													prop_tree = 4  => 0.1771771772,
													prop_tree = 5  => 0.1540926304,
													prop_tree = 6  => 0.1423709586,
													prop_tree = 7  => 0.1317715959,
													prop_tree = 8  => 0.101857364,
													prop_tree = 9  => 0.0823144105,
													prop_tree = 10 => 0.0571507454,
																						0.0444444444);
																	

 /* Time Since */


			mth_since_adl_EQ_first_seen := if((integer)((STRING)adl_EQ_first_seen)[5..6] > 0 and (integer)((STRING)adl_EQ_first_seen)[1..4] > 0,
																			round((ut.DaysApart((string4)sysyear+(string2)sysmth+'01', 
																				((STRING)adl_EQ_first_seen)[1..4] + ((STRING)adl_EQ_first_seen)[5..6] + '01')) * ( 12 / 365.25 )), -9999 /*NULL*/);					
			
			mth_since_adl_PR_first_seen := if((integer)((STRING)adl_PR_first_seen)[5..6] > 0 and (integer)((STRING)adl_PR_first_seen)[1..4] > 0,
																			round((ut.DaysApart((string4)sysyear+(string2)sysmth+'01', 
																				((STRING)adl_PR_first_seen)[1..4] + ((STRING)adl_PR_first_seen)[5..6] + '01')) * ( 12 / 365.25 )), -9999 /*NULL*/);					
																			
			mth_since_adl_V_first_seen  := if((integer)((STRING)adl_V_first_seen)[5..6] > 0 and (integer)((STRING)adl_V_first_seen)[1..4] > 0,
																			round((ut.DaysApart((string4)sysyear+(string2)sysmth+'01', 
																				((STRING)adl_V_first_seen)[1..4] + ((STRING)adl_V_first_seen)[5..6] + '01')) * ( 12 / 365.25 )), -9999 /*NULL*/);					

			mth_since_adl_EM_first_seen := if((integer)((STRING)adl_EM_first_seen)[5..6] > 0 and (integer)((STRING)adl_EM_first_seen)[1..4] > 0,
																			round((ut.DaysApart((string4)sysyear+(string2)sysmth+'01', 
																				((STRING)adl_EM_first_seen)[1..4] + ((STRING)adl_EM_first_seen)[5..6] + '01')) * ( 12 / 365.25 )), -9999 /*NULL*/);					
																			
																			

			mth_since_adl_eq_first_seen_code :=  map(mth_since_adl_eq_first_seen <= 1  => 0,
																							 mth_since_adl_eq_first_seen <= 7  => 1,
																							 mth_since_adl_eq_first_seen <= 19 => 2,
																							 mth_since_adl_eq_first_seen <= 43 => 3,
																																										4);

			mth_since_adl_pr_first_seen_code :=  map(mth_since_adl_pr_first_seen <= 1   => 0,
																							 mth_since_adl_pr_first_seen <= 8   => 1,
																							 mth_since_adl_pr_first_seen <= 20  => 2,
																							 mth_since_adl_pr_first_seen <= 36  => 3,
																							 mth_since_adl_pr_first_seen <= 170 => 4,
																																										 5);

			mth_since_adl_v_first_seen_code :=  map(mth_since_adl_v_first_seen = -9999 => -1,
																							mth_since_adl_v_first_seen <= 5  => 0,
																							mth_since_adl_v_first_seen <= 15 => 1,
																							mth_since_adl_v_first_seen <= 29 => 2,
																							mth_since_adl_v_first_seen <= 50 => 3,
																																									4);

			mth_since_adl_em_first_seen_code :=  map(mth_since_adl_em_first_seen <= 8  => 0,
																							 mth_since_adl_em_first_seen <= 17 => 1,
																							 mth_since_adl_em_first_seen <= 96 => 2,
																																										3);


			mth_since_adl_eq_first_seen_m :=  map(mth_since_adl_eq_first_seen_code = 0 => 0.1839538125,
																						mth_since_adl_eq_first_seen_code = 1 => 0.2108701333,
																						mth_since_adl_eq_first_seen_code = 2 => 0.1822678456,
																						mth_since_adl_eq_first_seen_code = 3 => 0.1636028543,
																																										0.1382779367);

			mth_since_adl_pr_first_seen_m :=  map(mth_since_adl_pr_first_seen_code = 0 => 0.1787466765,
																						mth_since_adl_pr_first_seen_code = 1 => 0.1274601687,
																						mth_since_adl_pr_first_seen_code = 2 => 0.1040383299,
																						mth_since_adl_pr_first_seen_code = 3 => 0.0939440994,
																						mth_since_adl_pr_first_seen_code = 4 => 0.0674846626,
																																										0.019047619);

			mth_since_adl_v_first_seen_m :=  map(mth_since_adl_v_first_seen_code = -1 => 0.1723296436,
																					 mth_since_adl_v_first_seen_code = 0  => 0.2250361795,
																					 mth_since_adl_v_first_seen_code = 1  => 0.2160224439,
																					 mth_since_adl_v_first_seen_code = 2  => 0.1784460053,
																					 mth_since_adl_v_first_seen_code = 3  => 0.1294214423,
																																									 0.0666666667);

			mth_since_adl_em_first_seen_m :=  map(mth_since_adl_em_first_seen_code = 0 => 0.1798639654,
																						mth_since_adl_em_first_seen_code = 1 => 0.171107028,
																						mth_since_adl_em_first_seen_code = 2 => 0.1394454564,
																																										0.0526315789);



 /* FP - Derog */

	 /* Address */

			distflag :=  map((addrpop and hphnpop and (distance = 0))    => 0,
											 (addrpop and hphnpop and (distance < 9999)) => 1,
											 (addrpop and hphnpop and (distance = 9999)) => 9999,
																																									-9);


	 /* Phone */


			 disconnect_flag_tmp1 := Map(trim(nap_status) = 'C' and disconnected = 0 => 0,
															trim(nap_status) = 'D' or disconnected = 1  => 2,
															1);

			 risky_phone_tmp1 := if(hr_phone_flag = 1 or hr_phone = 1 or phn_corrections = 1, 1, 0);

			 pnotpot_flag_tmp1            := 1 * pnotpot;
			 phninval2_flag_tmp1          := 1 * phninval2;
			 phone_zip_mismatch_flag_tmp1 := 1 * phone_zip_mismatch;



			 phnprob_tmp1 := if(disconnect_flag_tmp1 = 0 and ( phninval2_flag_tmp1=1 or phone_zip_mismatch_flag_tmp1=1 or 
														pnotpot_flag_tmp1=1 or risky_phone_tmp1=1 or ( distflag > 0 ) ), 
														0.5, disconnect_flag_tmp1);

			 phnprob2_tmp1 := Map(phnprob_tmp1 = 0.5 and ( adls_per_phone_c6 > 0 ) => 2,
													 phnprob_tmp1 = 0 and ( adls_per_phone_c6 > 0 ) => 0.5,
													 phnprob_tmp1);


			disconnect_flag         := if(hphnpop, disconnect_flag_tmp1, -9);
			risky_phone             := if(hphnpop, risky_phone_tmp1, -9);
			pnotpot_flag            := if(hphnpop, pnotpot_flag_tmp1, -9);
			phninval2_flag          := if(hphnpop, phninval2_flag_tmp1, -9);
			phone_zip_mismatch_flag := if(hphnpop, phone_zip_mismatch_flag_tmp1, -9);
			phnprob                 := if(hphnpop, phnprob_tmp1, -9);
			phnprob2                := if(hphnpop, phnprob2_tmp1, -9);
																														 

			
			phnprob2_m :=  map(phnprob2 = -9  => 0.2025872142,
												 phnprob2 = 0   => 0.091727166,
												 phnprob2 = 0.5 => 0.1486277114,
												 phnprob2 = 1   => 0.2053973013,
																					 0.2362225097);					



 /* Age */


			age_code :=  map(age <= 22 => 0,
											 age <= 23 => 1,
											 age <= 47 => 2,
											 age <= 50 => 3,
											 age <= 53 => 4,
											 age <= 62 => 5,
																		6);

			age_code_m :=  map(age_code = 0 => 0.1832930368,
												 age_code = 1 => 0.1602909483,
												 age_code = 2 => 0.143867047,
												 age_code = 3 => 0.0805970149,
												 age_code = 4 => 0.0581655481,
												 age_code = 5 => 0.0311614731,
																				 0.0180555556);




 /* AVM */


			since_add1_avm_rec_year_code :=  map(avm_hit = 0                         => -1,
																					 since_add1_avm_recording_year = -9999   => -2,
																					 since_add1_avm_recording_year <= 0  => 0,
																					 since_add1_avm_recording_year <= 1  => 1,
																					 since_add1_avm_recording_year <= 11 => 2,
																					 since_add1_avm_recording_year <= 18 => 3,
																																									4);

			add1_avm_sales_price_code :=  map(avm_hit = 0                      => -1,
																				add1_avm_sales_price_c = 0       => -2,
																				add1_avm_sales_price_c <= 20000  => 0,
																				add1_avm_sales_price_c <= 60000  => 1,
																				add1_avm_sales_price_c <= 80000  => 2,
																				add1_avm_sales_price_c <= 140000 => 3,
																				add1_avm_sales_price_c <= 160000 => 4,
																				add1_avm_sales_price_c <= 280000 => 5,
																																						6);

			add1_avm_ta_valuation_code :=  map(avm_hit = 0                       => -1,
																				 add1_avm_ta_valuation_c = 0       => -2,
																				 add1_avm_ta_valuation_c <= 60000  => 0,
																				 add1_avm_ta_valuation_c <= 80000  => 1,
																				 add1_avm_ta_valuation_c <= 100000 => 2,
																				 add1_avm_ta_valuation_c <= 120000 => 3,
																				 add1_avm_ta_valuation_c <= 140000 => 4,
																				 add1_avm_ta_valuation_c <= 160000 => 5,
																				 add1_avm_ta_valuation_c <= 200000 => 6,
																				 add1_avm_ta_valuation_c <= 420000 => 7,
																																							8);


			add1_avm_auto_valuation_code :=  map(avm_hit = 0                              => -1,
																					 add1_avm_automated_valuation_c = 0       => -2,
																					 add1_avm_automated_valuation_c <= 40000  => 0,
																					 add1_avm_automated_valuation_c <= 60000  => 1,
																					 add1_avm_automated_valuation_c <= 80000  => 2,
																					 add1_avm_automated_valuation_c <= 100000 => 3,
																					 add1_avm_automated_valuation_c <= 160000 => 4,
																					 add1_avm_automated_valuation_c <= 240000 => 5,
																					 add1_avm_automated_valuation_c <= 500000 => 6,
																																											 7);




			add1_avm_med_fips_c_tmp  := 20000 * roundup(add1_avm_med_fips  / 20000);
			add1_avm_med_geo11_c_tmp := 20000 * roundup(add1_avm_med_geo11 / 20000);
			add1_avm_med_geo12_c_tmp := 20000 * roundup(add1_avm_med_geo12 / 20000);

			add1_avm_med_fips_c := if(add1_avm_med_fips_c_tmp > 700000, 700000, add1_avm_med_fips_c_tmp);
			add1_avm_med_geo11_c := if(add1_avm_med_geo11_c_tmp > 700000, 700000, add1_avm_med_geo11_c_tmp);
			add1_avm_med_geo12_c := if(add1_avm_med_geo12_c_tmp > 700000, 700000, add1_avm_med_geo12_c_tmp);


			add1_avm_med_code :=  map(avm_hit = 0            => -1,
																add1_avm_med = 0       => -1,
																add1_avm_med <= 40000  => 0,
																add1_avm_med <= 60000  => 1,
																add1_avm_med <= 80000  => 2,
																add1_avm_med <= 100000 => 3,
																add1_avm_med <= 120000 => 4,
																add1_avm_med <= 140000 => 5,
																add1_avm_med <= 260000 => 6,
																add1_avm_med <= 500000 => 7,
																													8);
			


			avm_tree :=  map(since_add1_avm_rec_year_code = -2                                        => -2,
											 since_add1_avm_rec_year_code = -1                                        => -1,
											 (since_add1_avm_rec_year_code <= 0) and (add1_avm_sales_price_code <= 4) => 0,
											 (since_add1_avm_rec_year_code <= 0) and (add1_avm_sales_price_code <= 5) => 1,
											 since_add1_avm_rec_year_code <= 0                                        => 2,
											 (since_add1_avm_rec_year_code <= 1) and (add1_avm_sales_price_code <= 3) => 0,
											 (since_add1_avm_rec_year_code <= 1) and (add1_avm_sales_price_code <= 5) => 1,
											 since_add1_avm_rec_year_code <= 1                                        => 3,
											 (since_add1_avm_rec_year_code <= 2) and (add1_avm_sales_price_code <= 1) => 0,
											 (since_add1_avm_rec_year_code <= 2) and (add1_avm_sales_price_code <= 2) => 1,
											 (since_add1_avm_rec_year_code <= 2) and (add1_avm_sales_price_code <= 3) => 3,
											 (since_add1_avm_rec_year_code <= 2) and (add1_avm_sales_price_code <= 4) => 4,
											 (since_add1_avm_rec_year_code <= 2) and (add1_avm_sales_price_code <= 5) => 5,
											 since_add1_avm_rec_year_code <= 2                                        => 6,
											 (since_add1_avm_rec_year_code <= 3) and (add1_avm_sales_price_code <= 1) => 3,
											 (since_add1_avm_rec_year_code <= 3) and (add1_avm_sales_price_code <= 2) => 4,
											 (since_add1_avm_rec_year_code <= 3) and (add1_avm_sales_price_code <= 4) => 6,
											 (since_add1_avm_rec_year_code <= 3) and (add1_avm_sales_price_code <= 5) => 7,
											 since_add1_avm_rec_year_code <= 3                                        => 8,
											 (since_add1_avm_rec_year_code <= 4) and (add1_avm_sales_price_code <= 0) => 3,
											 (since_add1_avm_rec_year_code <= 4) and (add1_avm_sales_price_code <= 1) => 6,
											 (since_add1_avm_rec_year_code <= 4) and (add1_avm_sales_price_code <= 5) => 7,
																																																	 8);



			add1_avm_ta_valuation_code_m :=  map(add1_avm_ta_valuation_code = -2 => 0.1571656246,
																					 add1_avm_ta_valuation_code = -1 => 0.1943750797,
																					 add1_avm_ta_valuation_code = 0  => 0.3285802852,
																					 add1_avm_ta_valuation_code = 1  => 0.2421991085,
																					 add1_avm_ta_valuation_code = 2  => 0.2224909311,
																					 add1_avm_ta_valuation_code = 3  => 0.1605714286,
																					 add1_avm_ta_valuation_code = 4  => 0.1538461538,
																					 add1_avm_ta_valuation_code = 5  => 0.142557652,
																					 add1_avm_ta_valuation_code = 6  => 0.1378763867,
																					 add1_avm_ta_valuation_code = 7  => 0.122513089,
																																							0.1075824717);

			add1_avm_auto_valuation_code_m :=  map(add1_avm_auto_valuation_code = -1 => 0.1943750797,
																						 add1_avm_auto_valuation_code = 0  => 0.355952381,
																						 add1_avm_auto_valuation_code = 1  => 0.2911283376,
																						 add1_avm_auto_valuation_code = 2  => 0.2473846154,
																						 add1_avm_auto_valuation_code = 3  => 0.2195242815,
																						 add1_avm_auto_valuation_code = 4  => 0.1555815998,
																						 add1_avm_auto_valuation_code = 5  => 0.1397725968,
																						 add1_avm_auto_valuation_code = 6  => 0.1280118541,
																																									0.0923410405);

			add1_avm_med_code_m :=  map(add1_avm_med_code = -1 => 0.1943750797,
																	add1_avm_med_code = 0  => 0.3885350318,
																	add1_avm_med_code = 1  => 0.3147368421,
																	add1_avm_med_code = 2  => 0.2461077844,
																	add1_avm_med_code = 3  => 0.1982799809,
																	add1_avm_med_code = 4  => 0.1750556793,
																	add1_avm_med_code = 5  => 0.1534309946,
																	add1_avm_med_code = 6  => 0.1396253602,
																	add1_avm_med_code = 7  => 0.1314102564,
																														0.0889711064);


			avm_tree_m :=  map(avm_tree = -2 => 0.1310013717,
												 avm_tree = -1 => 0.1943750797,
												 avm_tree = 0  => 0.2595996062,
												 avm_tree = 1  => 0.2122641509,
												 avm_tree = 2  => 0.2085308057,
												 avm_tree = 3  => 0.176727909,
												 avm_tree = 4  => 0.1576330184,
												 avm_tree = 5  => 0.136261456,
												 avm_tree = 6  => 0.1099911058,
												 avm_tree = 7  => 0.0644901249,
																					0.0226537217);



 /* Velocity */


			ssns_per_adl_c_tmp := (real)ssns_per_adl;
			ssns_per_adl_c :=  if(ssns_per_adl_c_tmp > 2, 2, ssns_per_adl_c_tmp);

			adlperssn_count_c_tmp := (real)adlperssn_count;
			adlperssn_count_c :=  if(adlperssn_count_c_tmp > 3, 3, adlperssn_count_c_tmp);

			addrs_per_ssn_c :=  map(addrs_per_ssn = 1 => 0,
															addrs_per_ssn = 0 => 1,
															addrs_per_ssn = 2 => 2,
																									 3);

			nameperssn_count_c :=  if(ssnpop = 0, -1, (real)nameperssn_count);


				 
			adls_per_addr_c_tmp := map(adls_per_addr in [3, 4, 5]              => 0,
																adls_per_addr in [6]                    => 1,
																adls_per_addr in [2, 7]                 => 2,
																adls_per_addr in [8]                    => 3,
																adls_per_addr in [0, 1, 10, 11, 12, 13] => 4,
																adls_per_addr <= 22                     => 5,
																																					 6);						 


			ssns_per_addr_c__tmp := map(ssns_per_addr = 4        => 0,
																ssns_per_addr in [3, 5]  => 1,
																ssns_per_addr in [6]     => 2,
																ssns_per_addr in [2, 7]  => 3,
																ssns_per_addr in [8]     => 4,
																ssns_per_addr in [9, 10] => 5,
																ssns_per_addr in [11]    => 6,
																ssns_per_addr <= 23      => 7,
																														8);						 

			
			adls_per_addr_c := if(aptflag = 0, adls_per_addr_c_tmp, 5);
			ssns_per_addr_c := if(aptflag = 0, ssns_per_addr_c__tmp, 6.5);


			per_addr_tree :=  map((adls_per_addr_c <= 0) and (ssns_per_addr_c <= 0)   => 0,
														(adls_per_addr_c <= 0) and (ssns_per_addr_c <= 2)   => 1,
														adls_per_addr_c <= 0                                => 2,
														(adls_per_addr_c <= 1) and (ssns_per_addr_c <= 4)   => 2,
														adls_per_addr_c <= 1                                => 3,
														(adls_per_addr_c <= 2) and (ssns_per_addr_c <= 3)   => 3,
														adls_per_addr_c <= 2                                => 5,
														(adls_per_addr_c <= 3) and (ssns_per_addr_c <= 4)   => 4,
														adls_per_addr_c <= 3                                => 5,
														(adls_per_addr_c <= 4) and (ssns_per_addr_c <= 5)   => 5,
														(adls_per_addr_c <= 4) and (ssns_per_addr_c <= 6)   => 6,
														adls_per_addr_c <= 4                                => 7,
														(adls_per_addr_c <= 5) and (ssns_per_addr_c <= 6)   => 5,
														(adls_per_addr_c <= 5) and (ssns_per_addr_c <= 6.5) => 7,
														(adls_per_addr_c <= 5) and (ssns_per_addr_c <= 7)   => 8,
														adls_per_addr_c <= 5                                => 9,
																																									 9);


			per_ssn_tree :=  if((adlperssn_count_c = 3) and (nameperssn_count_c >= 2), 4, adlperssn_count_c);


			ssns_per_adl_c_m :=  map(ssns_per_adl_c = 0 => 0.1518255844,
															 ssns_per_adl_c = 1 => 0.171988986,
																											 0.2259806708);

			addrs_per_ssn_c_m :=  map(addrs_per_ssn_c = 0 => 0.1116255577,
																addrs_per_ssn_c = 1 => 0.156518345,
																addrs_per_ssn_c = 2 => 0.1656259292,
																											 0.210556026);

			per_addr_tree_m :=  map(per_addr_tree = 0 => 0.1091231702,
															per_addr_tree = 1 => 0.1142857143,
															per_addr_tree = 2 => 0.1249190939,
															per_addr_tree = 3 => 0.1307658515,
															per_addr_tree = 4 => 0.1446510505,
															per_addr_tree = 5 => 0.1553509781,
															per_addr_tree = 6 => 0.171789065,
															per_addr_tree = 7 => 0.2044449089,
															per_addr_tree = 8 => 0.2229505476,
																									 0.2636111966);

			per_ssn_tree_m :=  map(per_ssn_tree = 0 => 0.1563223715,
														 per_ssn_tree = 1 => 0.1628344248,
														 per_ssn_tree = 2 => 0.1918160799,
														 per_ssn_tree = 3 => 0.2035911975,
																								 0.2339832869);





 /* Velocity - C6 */

			phones_per_adl_c6_c_tmp := (real)phones_per_adl_c6;
			phones_per_adl_c6_c :=  if(phones_per_adl_c6_c_tmp > 2, 2, phones_per_adl_c6_c_tmp);


			ssns_per_addr_c6_c_t := (real)ssns_per_addr_c6;
			ssns_per_addr_c6_c_tmp1 := if(ssns_per_addr_c6_c_t > 5, 5, ssns_per_addr_c6_c_t);


			ssns_per_addr_c6_c_tmp2 := Map(ssns_per_addr_c6 = 0 			=> 10,
																		 ssns_per_addr_c6 in [1,2]  => 11,
																																	 12);

			ssns_per_addr_c6_c := if(aptflag = 0, ssns_per_addr_c6_c_tmp1, ssns_per_addr_c6_c_tmp2);
			
			
			phones_per_adl_c6_m :=  map(phones_per_adl_c6_c = 0 => 0.1703640293,
																	phones_per_adl_c6_c = 1 => 0.2698535081,
																															 0.3232323232);


			ssns_per_addr_c6_m :=  map(ssns_per_addr_c6_c = 0  => 0.136842771,
																 ssns_per_addr_c6_c = 1  => 0.1899245301,
																 ssns_per_addr_c6_c = 2  => 0.2180048662,
																 ssns_per_addr_c6_c = 3  => 0.2475646624,
																 ssns_per_addr_c6_c = 4  => 0.2686567164,
																 ssns_per_addr_c6_c = 5  => 0.288863109,
																 ssns_per_addr_c6_c = 10 => 0.1926734474,
																 ssns_per_addr_c6_c = 11 => 0.2377210216,
																 0.2573696145);



 /* Models */

			prop_mod_tmp := -5.828953131 +
					(source_p_tot * -0.476738135) +
					(addrs_15_risk_level_m * 1.7558091699) +
					(since_add1_date_first_seen_lvl_m * 5.3273129486) +
					(since_add2_date_first_seen_lvl_m * 1.2811777104) +
					(add1_purchase_amount_c_level_m * 3.7171467141) +
					(add1_assessed_amount_c_level_m * 5.5676969851) +
					(prop_tree_m * 6.3181943104);


			prop_mod := (100 * (exp(prop_mod_tmp) / (1 + exp(prop_mod_tmp))));


			avm_mod_tmp := -3.400425282 +
					(add1_avm_ta_valuation_code_m * 1.5549699351) +
					(add1_avm_auto_valuation_code_m * 1.9617376838) +
					(add1_avm_med_code_m * 2.0195385014) +
					(avm_tree_m * 4.8473240388);

			avm_mod := (100 * (exp(avm_mod_tmp) / (1 + exp(avm_mod_tmp))));


			time_since_mod_tmp := -6.136385692 +
					(mth_since_adl_eq_first_seen_m * 5.4421592591) +
					(mth_since_adl_pr_first_seen_m * 8.7387413857) +
					(mth_since_adl_v_first_seen_m * 4.9215278613) +
					(mth_since_adl_em_first_seen_m * 7.1416618618);

			time_since_mod := (100 * (exp(time_since_mod_tmp) / (1 + exp(time_since_mod_tmp))));



      base  := 703;  
      odds  := 1 / 21;
      point := -40;



			thin_mod8_tmp1 := -9.55173552 +
					(voter_level * 0.03133381) +
					(ams_hit * -0.171436953) +
					(source_pos_weak * -0.481516459) +
					(derog_level_m * 4.6415263117) +
					(prop_mod * 0.0327352959) +
					(ssns_per_adl_c_m * 5.2760294046) +
					(addrs_per_ssn_c_m * 3.3164274607) +
					(per_addr_tree_m * 3.7889635701) +
					(per_ssn_tree_m * 3.0378615842) +
					(avm_mod * 0.0367017837) +
					(phones_per_adl_c6_m * 4.1504685526) +
					(ssns_per_addr_c6_m * 1.1878037631) +
					(age_code_m * 5.7334959528) +
					(phnprob2_m * 1.4459623894) +
					(time_since_mod * 0.0314343694) +
					(nap_tree * 2.9018980388);
					
			thin_mod8_tmp2 := (exp(thin_mod8_tmp1 )) / (1+exp(thin_mod8_tmp1 ));
			thin_mod8 := (integer)(point*(log(thin_mod8_tmp2/(1-thin_mod8_tmp2)) - log(odds))/log(2) + base);


			Mod_Capped_a := min(900,max(501,thin_mod8));
			
			

//     end;                        /* Of Thin_File_Model */
//**********************************************************************************************************************************
//**********************************************************************************************************************************
//**********************************************************************************************************************************
//**********************************************************************************************************************************
//**********************************************************************************************************************************		 
//     else do;                    /* No_File_Model      */


 /* FP - Derog */

			hr_phone_flag2       := if(~hphnpop, -1, hr_phone_flag);
			hr_phone2            := if(~hphnpop, -1, hr_phone);
			phone_zip_mismatch2  := if(~hphnpop, -1, phone_zip_mismatch); 

			phzip_hr := if(~hphnpop, -1, if(( hr_phone_flag2=1 ) or ( hr_phone2=1 ) or ( phone_zip_mismatch2=1 ), 1, 0));

			
			
			phzip_hr_m :=  map(phzip_hr = -1 => 0.1785385656,
												 phzip_hr = 0  => 0.0925292345,
																					0.135501355);



 /* Address */

			rural_po_flag :=  if((trim(trim(dwelling_type, LEFT), LEFT, RIGHT) in ['E', 'R']) or zippobox=1, 1, 0);


			ec1 := ((string)trim(trim(error_codes, LEFT), LEFT, RIGHT))[1..1];
			ec4 := ((string)trim(trim(error_codes, LEFT), LEFT, RIGHT))[4..4];

			unit_changed :=  if((ec1 = 'S') and (ec4 != '0'), 1, 0);

			cassprob :=  map(trim(trim(error_codes, LEFT), LEFT, RIGHT) = 'E412' => 2,
											 (ec1 = 'E') or unit_changed =1                        => 1,
																																							0);

			addprob :=  map(aptflag = 1       => 4,
											cassprob = 2      => 3,
											cassprob = 1      => 2,
											rural_po_flag =1  => 1,
																			     0);

			addprob_m :=  map(addprob = 0 => 0.1198388106,
												addprob = 1 => 0.1420434318,
												addprob = 2 => 0.1750972763,
												addprob = 3 => 0.214511041,
																			 0.2484092975);




 /* Age */

			agecode :=  map(age = 0   => 2,
											age <= 20 => 0,
											age <= 24 => 1,
											age <= 25 => 2,
											age <= 28 => 3,
											age <= 52 => 4,
											age <= 63 => 5,
																	 6);

			agecode_m :=  map(agecode = 0 => 0.0836717592,
												agecode = 1 => 0.1225607112,
												agecode = 2 => 0.153369206,
												agecode = 3 => 0.1878497202,
												agecode = 4 => 0.2109614207,
												agecode = 5 => 0.145175064,
																			 0.0892255892);



 /* AVM */



			since_add1_avm_rec_year_code_2 :=  map(avm_hit = 0                         => -1,
																						 since_add1_avm_recording_year = -9999   => -2,
																						 since_add1_avm_recording_year <= 1  => 0,
																						 since_add1_avm_recording_year <= 2  => 1,
																						 since_add1_avm_recording_year <= 4  => 2,
																						 since_add1_avm_recording_year <= 10 => 3,
																						 since_add1_avm_recording_year <= 13 => 4,
																						 since_add1_avm_recording_year <= 29 => 5,
																																										6);


			since_add1_avm_assessed_value := if((integer)add1_avm_assessed_value_year > 0, 
																							avm_sysyear - (integer)add1_avm_assessed_value_year, -9999);

			since_add1_avm_assessed_val_code :=  map(avm_hit = 0                             => -1,
																							 since_add1_avm_assessed_value = -9999   => -2,
																							 since_add1_avm_assessed_value = 0       => 0,
																							 since_add1_avm_assessed_value = 1       => 1,
																							 since_add1_avm_assessed_value in [2, 3] => 2,
																																											  	3);


			add1_avm_sales_price_code_2 :=  map(avm_hit = 0                      => -1,
																					add1_avm_sales_price_c = 0       => -2,
																					add1_avm_sales_price_c <= 20000  => 0,
																					add1_avm_sales_price_c <= 40000  => 1,
																					add1_avm_sales_price_c <= 60000  => 2,
																					add1_avm_sales_price_c <= 100000 => 3,
																					add1_avm_sales_price_c <= 140000 => 4,
																					add1_avm_sales_price_c <= 160000 => 5,
																					add1_avm_sales_price_c <= 400000 => 6,
																																							7);

			add1_avm_ta_valuation_code_2 :=  map(avm_hit = 0                       => -1,
																					 add1_avm_ta_valuation_c = 0       => -2,
																					 add1_avm_ta_valuation_c <= 40000  => 0,
																					 add1_avm_ta_valuation_c <= 60000  => 1,
																					 add1_avm_ta_valuation_c <= 80000  => 2,
																					 add1_avm_ta_valuation_c <= 100000 => 3,
																					 add1_avm_ta_valuation_c <= 120000 => 4,
																					 add1_avm_ta_valuation_c <= 140000 => 5,
																					 add1_avm_ta_valuation_c <= 160000 => 6,
																					 add1_avm_ta_valuation_c <= 180000 => 7,
																					 add1_avm_ta_valuation_c <= 240000 => 8,
																					 add1_avm_ta_valuation_c <= 380000 => 9,
																					 add1_avm_ta_valuation_c <= 620000 => 10,
																																								11);


			add1_avm_hed_valuation_code :=  map(avm_hit = 0                            => -1,
																					add1_avm_hedonic_valuation_c = 0       => -2,
																					add1_avm_hedonic_valuation_c <= 40000  => 0,
																					add1_avm_hedonic_valuation_c <= 60000  => 1,
																					add1_avm_hedonic_valuation_c <= 80000  => 2,
																					add1_avm_hedonic_valuation_c <= 100000 => 3,
																					add1_avm_hedonic_valuation_c <= 120000 => 4,
																					add1_avm_hedonic_valuation_c <= 140000 => 5,
																					add1_avm_hedonic_valuation_c <= 260000 => 6,
																					add1_avm_hedonic_valuation_c <= 480000 => 7,
																																										8);

			add1_avm_auto_valuation_code_2 :=  map(avm_hit = 0                              => -1,
																						 add1_avm_automated_valuation_c = 0       => -2,
																						 add1_avm_automated_valuation_c <= 40000  => 0,
																						 add1_avm_automated_valuation_c <= 60000  => 1,
																						 add1_avm_automated_valuation_c <= 80000  => 2,
																						 add1_avm_automated_valuation_c <= 100000 => 3,
																						 add1_avm_automated_valuation_c <= 120000 => 4,
																						 add1_avm_automated_valuation_c <= 140000 => 5,
																						 add1_avm_automated_valuation_c <= 180000 => 6,
																						 add1_avm_automated_valuation_c <= 260000 => 7,
																						 add1_avm_automated_valuation_c <= 360000 => 8,
																						 add1_avm_automated_valuation_c <= 520000 => 9,
																																												 10);


			add1_avm_med_code_2 :=  map(avm_hit = 0            => -1,
																	add1_avm_med = 0       => -1,
																	add1_avm_med <= 40000  => 0,
																	add1_avm_med <= 60000  => 1,
																	add1_avm_med <= 80000  => 2,
																	add1_avm_med <= 100000 => 3,
																	add1_avm_med <= 120000 => 4,
																	add1_avm_med <= 140000 => 5,
																	add1_avm_med <= 340000 => 6,
																	add1_avm_med <= 520000 => 7,
																														8);


			since_add1_avm_rec_year_code_m :=  map(since_add1_avm_rec_year_code_2 = -2 => 0.1035424532,
																						 since_add1_avm_rec_year_code_2 = -1 => 0.160684952,
																						 since_add1_avm_rec_year_code_2 = 0  => 0.1569638909,
																						 since_add1_avm_rec_year_code_2 = 1  => 0.1304926764,
																						 since_add1_avm_rec_year_code_2 = 2  => 0.1233097231,
																						 since_add1_avm_rec_year_code_2 = 3  => 0.1147942869,
																						 since_add1_avm_rec_year_code_2 = 4  => 0.101146325,
																						 since_add1_avm_rec_year_code_2 = 5  => 0.0642498205,
																																										0.1432748538);

			since_add1_avm_assessed_val_m :=  map(since_add1_avm_assessed_val_code = -2 => 0.1309872923,
																						since_add1_avm_assessed_val_code = -1 => 0.160684952,
																						since_add1_avm_assessed_val_code = 0  => 0.0771799629,
																						since_add1_avm_assessed_val_code = 1  => 0.0980402743,
																						since_add1_avm_assessed_val_code = 2  => 0.1247821541,
																																										 0.1299011251);


			add1_avm_sales_price_code_m :=  map(add1_avm_sales_price_code_2 = -2 => 0.1047497561,
																					add1_avm_sales_price_code_2 = -1 => 0.160684952,
																					add1_avm_sales_price_code_2 = 0  => 0.1831626849,
																					add1_avm_sales_price_code_2 = 1  => 0.1724137931,
																					add1_avm_sales_price_code_2 = 2  => 0.1505257333,
																					add1_avm_sales_price_code_2 = 3  => 0.1304929735,
																					add1_avm_sales_price_code_2 = 4  => 0.0978934325,
																					add1_avm_sales_price_code_2 = 5  => 0.0831509847,
																					add1_avm_sales_price_code_2 = 6  => 0.075095057,
																																							0.0691906005);

			add1_avm_ta_valuation_code_m_2 :=  map(add1_avm_ta_valuation_code_2 = -2 => 0.1273864913,
																						 add1_avm_ta_valuation_code_2 = -1 => 0.160684952,
																						 add1_avm_ta_valuation_code_2 = 0  => 0.3394018205,
																						 add1_avm_ta_valuation_code_2 = 1  => 0.295991778,
																						 add1_avm_ta_valuation_code_2 = 2  => 0.2051630435,
																						 add1_avm_ta_valuation_code_2 = 3  => 0.1480380499,
																						 add1_avm_ta_valuation_code_2 = 4  => 0.1215351812,
																						 add1_avm_ta_valuation_code_2 = 5  => 0.1018387553,
																						 add1_avm_ta_valuation_code_2 = 6  => 0.0947911779,
																						 add1_avm_ta_valuation_code_2 = 7  => 0.0850951374,
																						 add1_avm_ta_valuation_code_2 = 8  => 0.0793846154,
																						 add1_avm_ta_valuation_code_2 = 9  => 0.0679073732,
																						 add1_avm_ta_valuation_code_2 = 10 => 0.0582035928,
																																									0.0389429764);


			add1_avm_hed_valuation_code_m :=  map(add1_avm_hed_valuation_code = -2 => 0.1171342527,
																						add1_avm_hed_valuation_code = -1 => 0.160684952,
																						add1_avm_hed_valuation_code = 0  => 0.3837837838,
																						add1_avm_hed_valuation_code = 1  => 0.2752293578,
																						add1_avm_hed_valuation_code = 2  => 0.2342586324,
																						add1_avm_hed_valuation_code = 3  => 0.156613171,
																						add1_avm_hed_valuation_code = 4  => 0.1147994467,
																						add1_avm_hed_valuation_code = 5  => 0.0992995468,
																						add1_avm_hed_valuation_code = 6  => 0.0887909936,
																						add1_avm_hed_valuation_code = 7  => 0.0690667688,
																																								0.0351925631);

			add1_avm_auto_valuation_code_m_2 :=  map(add1_avm_auto_valuation_code_2 = -1 => 0.160684952,
																							 add1_avm_auto_valuation_code_2 = 0  => 0.33401222,
																							 add1_avm_auto_valuation_code_2 = 1  => 0.2855917667,
																							 add1_avm_auto_valuation_code_2 = 2  => 0.2025389498,
																							 add1_avm_auto_valuation_code_2 = 3  => 0.1447178003,
																							 add1_avm_auto_valuation_code_2 = 4  => 0.1277802006,
																							 add1_avm_auto_valuation_code_2 = 5  => 0.105006105,
																							 add1_avm_auto_valuation_code_2 = 6  => 0.0949208993,
																							 add1_avm_auto_valuation_code_2 = 7  => 0.084919874,
																							 add1_avm_auto_valuation_code_2 = 8  => 0.0778631285,
																							 add1_avm_auto_valuation_code_2 = 9  => 0.0663507109,
																																											0.0491850157);


			add1_avm_med_code_m_2 :=  map(add1_avm_med_code_2 = -1 => 0.160684952,
																		add1_avm_med_code_2 = 0  => 0.3850174216,
																		add1_avm_med_code_2 = 1  => 0.3090246126,
																		add1_avm_med_code_2 = 2  => 0.1878172589,
																		add1_avm_med_code_2 = 3  => 0.1426690079,
																		add1_avm_med_code_2 = 4  => 0.1164437451,
																		add1_avm_med_code_2 = 5  => 0.1015678255,
																		add1_avm_med_code_2 = 6  => 0.0888826344,
																		add1_avm_med_code_2 = 7  => 0.0733524355,
																																0.0363196126);



			avm_mod_m_tmp1 := -5.527822406 +
					(since_add1_avm_rec_year_code_m * 11.19770896) +
					(since_add1_avm_assessed_val_m * 7.0626505444) +
					(add1_avm_sales_price_code_m * 4.4836629019) +
					(add1_avm_ta_valuation_code_m_2 * 2.1855979164) +
					(add1_avm_hed_valuation_code_m * 2.3953305181) +
					(add1_avm_auto_valuation_code_m_2 * 1.5964451054) +
					(add1_avm_med_code_m_2 * 1.9204616235);
			 ;
			avm_mod_m_tmp2 := 100 * (exp(avm_mod_m_tmp1 )) / (1+exp(avm_mod_m_tmp1 ));

			avm_mod_m := if(avm_hit=1, avm_mod_m_tmp2, 16.07);
			
			
			
 /* Velocity */

			addrs_per_ssn_code :=  map(ssnpop = 0              => -1,
																 addrs_per_ssn = 1       => 0,
																 addrs_per_ssn in [0, 2] => 1,
																														2);


 
			ssn_per_addr_code__tmp1 := map(ssns_per_addr in [3, 4, 5] => 0,
																	ssns_per_addr = 6          => 1,
																	ssns_per_addr = 2          => 2,
																	ssns_per_addr in [0, 1]    => 8,
																	ssns_per_addr = 7          => 3,
																	ssns_per_addr in [8, 9]    => 4,
																	ssns_per_addr = 10         => 5,
																	ssns_per_addr = 11         => 6,
																	ssns_per_addr = 12         => 7,
																	ssns_per_addr = 13         => 9,
																	ssns_per_addr = 14         => 10,
																	ssns_per_addr = 15         => 11,
																	ssns_per_addr = 16         => 12,
																	ssns_per_addr = 17         => 13,
																	ssns_per_addr <= 19        => 14,
																	ssns_per_addr <= 21        => 15,
																	ssns_per_addr <= 26        => 16,
																																17);	
																																
			phone_per_addr_code__tmp1 := map(phones_per_addr = 1 => 0, 
																		phones_per_addr = 0 => 1, 
																		phones_per_addr = 2 => 2, 
																		phones_per_addr = 3 => 3, 
																													 4);																															
																								

			ssn_per_addr_code   := if(aptflag = 0, ssn_per_addr_code__tmp1, -1);
			phone_per_addr_code := if(aptflag = 0, phone_per_addr_code__tmp1, -1);

				 
			adl_per_phone_code_tmp1 := map(adls_per_phone = 2 => 0, 
																	 adls_per_phone = 1 => 1, 
																	 adls_per_phone = 0 => 2, 
																												 3);
				 
			adl_per_phone_code := if(hphnpop, adl_per_phone_code_tmp1, -1);



			addrs_per_ssn_code_m :=  map(addrs_per_ssn_code = -1 => 0.1275319402,
																	 addrs_per_ssn_code = 0  => 0.1258023107,
																	 addrs_per_ssn_code = 1  => 0.1720399429,
																															0.1943989816);

			ssn_per_addr_code_m :=  map(ssn_per_addr_code = -1 => 0.2484092975,
																	ssn_per_addr_code = 0  => 0.0718512257,
																	ssn_per_addr_code = 1  => 0.0874411303,
																	ssn_per_addr_code = 2  => 0.0939274792,
																	ssn_per_addr_code = 3  => 0.0970030147,
																	ssn_per_addr_code = 4  => 0.1095222619,
																	ssn_per_addr_code = 5  => 0.1283707865,
																	ssn_per_addr_code = 6  => 0.1395812562,
																	ssn_per_addr_code = 7  => 0.1513598739,
																	ssn_per_addr_code = 8  => 0.1569230769,
																	ssn_per_addr_code = 9  => 0.1615023474,
																	ssn_per_addr_code = 10 => 0.1708825183,
																	ssn_per_addr_code = 11 => 0.1808510638,
																	ssn_per_addr_code = 12 => 0.1862244898,
																	ssn_per_addr_code = 13 => 0.1982335623,
																	ssn_per_addr_code = 14 => 0.2176829268,
																	ssn_per_addr_code = 15 => 0.2387543253,
																	ssn_per_addr_code = 16 => 0.2427807487,
																														0.2512100678);


			phone_per_addr_code_m :=  map(phone_per_addr_code = -1 => 0.2484092975,
																		phone_per_addr_code = 0  => 0.1003356864,
																		phone_per_addr_code = 1  => 0.1387746567,
																		phone_per_addr_code = 2  => 0.1416329675,
																		phone_per_addr_code = 3  => 0.2100764732,
																																0.2459893048);

			adl_per_phone_code_m :=  map(adl_per_phone_code = -1 => 0.1785385656,
																	 adl_per_phone_code = 0  => 0.0620588235,
																	 adl_per_phone_code = 1  => 0.083358244,
																	 adl_per_phone_code = 2  => 0.1408163265,
																															0.1034482759);



			 velo_mod2_apt := -2.481689028
									+ (addrs_per_ssn_code_m  * 4.6770429526)
									+ (adl_per_phone_code_m  * 4.6897457226);
			 ;
			 velo_mod2_tmp1 := 100 * (exp(velo_mod2_apt )) / (1+exp(velo_mod2_apt ));



			 velo_mod2_noapt := -5.576307876
										+ (addrs_per_ssn_code_m  * 6.2841449404)
										+ (ssn_per_addr_code_m  * 6.7213449555)
										+ (phone_per_addr_code_m  * 4.0444149955)
										+ (adl_per_phone_code_m  * 7.6867849847)
										+ (addprob_m  * 2.4264293974);
			 ;
			 velo_mod2_tmp2 := 100 * (exp(velo_mod2_noapt )) / (1+exp(velo_mod2_noapt ));

			 velo_mod2 := if(aptflag = 1, velo_mod2_tmp1, velo_mod2_tmp2);


 /* Velocity - C6 */

			addrs_per_adl_c6_code :=  map(addrs_per_adl_c6 >= 2 => 2,
																		addrs_per_adl_c6 = 1  => 1,
																														 0);

			phones_per_adl_c6_flag :=  if(phones_per_adl_c6 > 0, 1, 0);

			addrs_per_ssn_c6_flag :=  if(addrs_per_ssn_c6 > 0, 1, 0);

			ssns_per_addr_c6_code :=  map(ssns_per_addr_c6 = 1 => 0,
																		ssns_per_addr_c6 = 2 => 1,
																		ssns_per_addr_c6 = 0 => 2,
																		ssns_per_addr_c6 = 3 => 3,
																														4);

			phones_per_addr_c6_code :=  map(phones_per_addr_c6 = 0 => 0,
																			phones_per_addr_c6 = 1 => 1,
																																2);

			addrs_per_adl_c6_code_m :=  map(addrs_per_adl_c6_code = 0 => 0.1258179359,
																			addrs_per_adl_c6_code = 1 => 0.1494033969,
																																	 0.1784869976);

			ssns_per_addr_c6_code_m :=  map(ssns_per_addr_c6_code = 0 => 0.1001610738,
																			ssns_per_addr_c6_code = 1 => 0.1593418489,
																			ssns_per_addr_c6_code = 2 => 0.1634956827,
																			ssns_per_addr_c6_code = 3 => 0.1964715317,
																																	 0.2269883825);

			phones_per_addr_c6_code_m :=  map(phones_per_addr_c6_code = 0 => 0.118527563,
																				phones_per_addr_c6_code = 1 => 0.2169327252,
																																			 0.2675050014);


			velo_c6_mod_tmp := -4.177357248 +
					(phones_per_adl_c6_flag * 0.915557039) +
					(addrs_per_ssn_c6_flag * 0.4751031592) +
					(addrs_per_adl_c6_code_m * 4.6540690405) +
					(ssns_per_addr_c6_code_m * 6.9371925691) +
					(phones_per_addr_c6_code_m * 5.0170105909);
			
			velo_c6_mod := 100 * (exp(velo_c6_mod_tmp )) / (1+exp(velo_c6_mod_tmp ));


	/* Property */

			add1_purchase_year := (integer)((string)add1_purchase_date)[1..4];

			since_add1_purchase_tmp := (sysyear - add1_purchase_year);


			since_add1_purchase := if(since_add1_purchase_tmp > 2000, -9999, since_add1_purchase_tmp);


			since_add1_purchase_flag :=  map(since_add1_purchase >= 6 => 1,
																			 since_add1_purchase >= 0 => 0,
																																		 -1);

			add1_purchase_amount_code :=  map(add1_purchase_amount <= 60000  => 0,
																	add1_purchase_amount <= 100000 => 1,
																	add1_purchase_amount <= 140000 => 2,
																	add1_purchase_amount <= 240000 => 3,
																																		4);

			add1_mortgage_amount_code :=  map(add1_mortgage_amount <= 20000  => 0,
																				add1_mortgage_amount <= 80000  => 1,
																				add1_mortgage_amount <= 140000 => 2,
																																					3);

			ltv_tmp1 :=  map((add1_purchase_amount = 0) and (add1_mortgage_amount = 0) => -3000,
												add1_purchase_amount = 0 => (-2000 - (100 * add1_mortgage_amount_code)),
												add1_mortgage_amount = 0 => (-1000 - (100 * add1_purchase_amount_code)),
																					(100 * (add1_mortgage_amount / add1_purchase_amount)));
																					
			ltv_tmp2 := min(200, (10 * ( roundup( ltv_tmp1 / 10 ))));

			ltv :=  map(ltv_tmp2 = -1400       						 => -1300,
									 ltv_tmp2 < 0        						   => ltv_tmp2,
									 ltv_tmp2 >= 0 and ltv_tmp2 <= 70  => 70,
									 ltv_tmp2 = 80      						   => 80,
									 ltv_tmp2 = 90    						     => 90,
																												100);
																												

			add1_assessed_amount_code :=  map(add1_assessed_amount <= 80000  => 0,
																				add1_assessed_amount <= 120000 => 1,
																				add1_assessed_amount <= 180000 => 2,
																																					3);



			property_owned_total_x :=  if(property_owned_total > 0, 1, 0);

			property_sold_total_x :=  if(property_sold_total > 0, 1, 0);

			property_owned_purchase_count_x :=  if(property_owned_purchase_count > 0, 1, 0);

			property_owned_assessed_count_x :=  if(property_owned_assessed_count > 0, 1, 0);

			property_sold_purchase_count_x :=  if(property_sold_purchase_count > 0, 1, 0);

			property_sold_assessed_count_x :=  if(property_sold_assessed_count > 0, 1, 0);


			prop_hit := max(property_owned_total_x, 
											property_sold_total_x, 
											property_owned_purchase_count_x, 
											property_owned_assessed_count_x, 
											property_sold_purchase_count_x, 
											property_sold_assessed_count_x);



			add1_lres_risk :=  if((add1_lres <= 8) or (add1_lres >= 70), 1, 0);
			add2_lres_risk :=  if(add2_lres >= 1 and add2_lres <= 8, 1, 0);


			add1_naprop_level_2 :=  map(add1_naprop in [3, 4] => 1,
																	add1_naprop in [1, 2] => -1,
																													 0);

			add1_owned_tree :=  map(add1_family_owned and add1_applicant_owned  => 4,
															add1_family_owned and add1_occupant_owned   => 3,
															add1_family_owned                           => 2,
															add1_applicant_owned or add1_occupant_owned => 1,
																																						 0);

			naprop_level2 :=  map((add1_naprop_level_2 = -1) and (add1_owned_tree = 0)      => 0,
														add1_naprop_level_2 = -1                                  => 1,
														add1_naprop_level_2 = 0                                   => 2,
														(add1_naprop_level_2 = 1) and (add1_owned_tree in [0, 1]) => 3,
														(add1_naprop_level_2 = 1) and (add1_owned_tree = 2)       => 4,
														(add1_naprop_level_2 = 1) and (add1_owned_tree = 3)       => 5,
																																												 6);


			addrs_5yr_code :=  map(addrs_5yr = 0 => 0,
														 addrs_5yr = 1 => 1,
																							2);

			addrs_15yr_code :=  map(addrs_15yr = 0 => 0,
															addrs_15yr = 1 => 1,
																								2);



			add1_assessed_amount_code_m :=  map(add1_assessed_amount_code = 0 => 0.1571112181,
																					add1_assessed_amount_code = 1 => 0.1301501733,
																					add1_assessed_amount_code = 2 => 0.0889985896,
																																					 0.067694741);

			since_add1_purchase_flag_m :=  map(since_add1_purchase_flag = -1 => 0.1380967089,
																				 since_add1_purchase_flag = 0  => 0.1246932515,
																																					0.1168713873);


			addrs_5yr_code_m :=  map(addrs_5yr_code = 0 => 0.1304775805,
															 addrs_5yr_code = 1 => 0.1439218082,
																										 0.1773367478);

			addrs_15yr_code_m :=  map(addrs_15yr_code = 0 => 0.1308606211,
																addrs_15yr_code = 1 => 0.1418824353,
																											 0.1745475773);


			naprop_level2_m :=  map(naprop_level2 = 0 => 0.2447626624,
															naprop_level2 = 1 => 0.2036784741,
															naprop_level2 = 2 => 0.1843317972,
															naprop_level2 = 3 => 0.0940325497,
															naprop_level2 = 4 => 0.0746945899,
															naprop_level2 = 5 => 0.0679303644,
																									 0.0577994429);


			ltv_m :=  map(ltv = -3000 => 0.1593007598,
										 ltv = -2300 => 0.0808897877,
										 ltv = -2200 => 0.1010665312,
										 ltv = -2100 => 0.1157894737,
										 ltv = -2000 => 0.1333333333,
										 ltv = -1300 => 0.063534279,
										 ltv = -1200 => 0.0775812892,
										 ltv = -1100 => 0.0926249563,
										 ltv = -1000 => 0.1683930943,
										 ltv = 70    => 0.066161469,
										 ltv = 80    => 0.0837385197,
										 ltv = 90    => 0.1005859375,
																		 0.1326047359);



			prop_mod_sourced := -1.967073932
										+ Add1_lres_risk  * 0.1663106476
										+ add1_assessed_amount_code_m  * 5.2445942944
										+ since_add1_purchase_flag_m  * -27.76217011
										+ addrs_5yr_code_m  * 11.541707201
										+ ltv_m  * 6.3609224284
			;
			prop_mod2_tmp1 := 100 * (exp(prop_mod_sourced )) / (1+exp(prop_mod_sourced ));




			prop_mod_notsourced := -2.266540431
											+ Add1_lres_risk  * 0.2554401134
											+ Add2_lres_risk  * 0.3443032782
											+ prop_hit  * -0.694671876
											+ add1_assessed_amount_code_m  * 4.836770149
											+ since_add1_purchase_flag_m  * -21.38145658
											+ addrs_15yr_code_m  * 3.8280952021
											+ naprop_level2_m  * 8.8102743946
											+ ltv_m  * 4.4780341647
			;
			prop_mod2_tmp2 := 100 * (exp(prop_mod_notsourced )) / (1+exp(prop_mod_notsourced ));

			prop_mod2 := if(property_sourced = 1, prop_mod2_tmp1, prop_mod2_tmp2);

			phn_mod_tmp1 := 18.5;
			
			phn_mod_tmp2 := -3.338755182
											+ nap_tree2_m  * 9.2074368999
											+ phzip_hr_m  * 1.057162471 ;
											
			phn_mod_tmp3 := 100 * (exp(phn_mod_tmp2 )) / (1+exp(phn_mod_tmp2 ));
			phn_mod := if(nap_tree2 = -1, phn_mod_tmp1, phn_mod_tmp3);


			base_m  := 703;                          /* RiskView Parameters */
			odds_m  := 1 / 21;
			point_m := -40;
			
			mod6_tmp1 := -4.907315571 +
					(ams_hit * -0.289788561) +
					(pos_sec_ver_flag3 * -0.905062531) +
					(derog_flag * 0.6096228271) +
					(phn_mod * 0.0449834931) +
					(agecode_m * 1.8891119573) +
					(prop_mod2 * 0.0494704156) +
					(avm_mod_m * 0.0423241013) +
					(velo_mod2 * 0.0307448391) +
					(velo_c6_mod * 0.0255963159);
			;
			mod6_tmp2 := (exp(mod6_tmp1 )) / (1+exp(mod6_tmp1 ));
			mod6 := (integer)(point_m*(log(mod6_tmp2/(1-mod6_tmp2)) - log(odds_m))/log(2) + base_m);
			
			Mod_Capped_m := min(900,max(501,Mod6));


//     end;                        /* Of No_File_Model   */


		 Mod_Capped_tmp1 := if(isThinFileModel, Mod_Capped_a, Mod_Capped_m);

		 
  /* Overrides       */

     ov_ssndead       := ( (integer)ssnlength > 0 and rc_decsflag );
     ov_ssnprior      := ( rc_ssndobflag = '1' or rc_pwssndobflag = '1' );
     ov_criminal_flag := ( criminal_count > 0 );
     ov_corrections   := ( rc_hrisksic = '2225' );



  /* NoContent */

			lname_gong_sourced := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);
			address_gong_sourced := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);

		 _source_tot_EM := StringLib.StringFind(StringLib.StringToUpperCase(rc_sources), 'EM', 1) >=1;
		 _source_tot_VO := StringLib.StringFind(StringLib.StringToUpperCase(rc_sources), 'VO', 1) >=1;
		 _source_tot_EM_VO := _source_tot_EM or _source_tot_VO;
		 _source_tot_EB := StringLib.StringFind(StringLib.StringToUpperCase(rc_sources), 'EB', 1) >=1;
	   _source_tot_L2 := StringLib.StringFind(StringLib.StringToUpperCase(rc_sources), 'L2', 1) >=1;
	 	 _source_tot_P :=  StringLib.StringFind(StringLib.StringToUpperCase(rc_sources), 'P ', 1) >=1;
		 _source_tot_V :=  StringLib.StringFind(StringLib.StringToUpperCase(rc_sources), 'V ', 1) >=1;
		 _source_tot_W :=  StringLib.StringFind(StringLib.StringToUpperCase(rc_sources), 'W ', 1) >=1;
		 _source_tot_WP := StringLib.StringFind(StringLib.StringToUpperCase(rc_sources), 'WP', 1) >=1;
		 
		 notsourced_gong := (~lname_gong_sourced and ~address_gong_sourced); 
		 notsourced_EM := (~_source_tot_em_vo);
		 notsourced_P := (~_source_tot_p);
		 notsourced_V := (~_source_tot_v);
		 notsourced_WP := (~_source_tot_wp);
		 notSourced_GEMPV := (notsourced_gong and (notsourced_em and (notsourced_p and notsourced_v)));
		 criminal_flag := (criminal_count > 0);
		 watercraft_flag := (watercraft_count > 0);
		 watercraft_source_flag := (_source_tot_eb or _source_tot_w);

     noContent2 := (
            notSourced_GEMPV                                           /* not sourced from nap,voter,property,vehicle  */
        and add1_naprop<3                                              /* last name and address not on property record */
        and ~prof_license_flag                                        /* no professional license */
        and add1_avm_land_use=''                                        /* avm value not available */			
        and ams_hit = 0                                  								/* American student file nohit */
        and ~criminal_flag                                            /* no criminal record */
        and liens_historical_unreleased_ct=0 and ~_source_tot_L2      /* no lien record */
        and bankrupt=false                                            /* no bankcrupcy */
        and ~watercraft_source_flag and watercraft_count=0            /* no watercraft */
             );
     Mod_Capped_tmp2 := if(( Mod_Capped_tmp1>630 ) and (ov_ssndead or ov_ssnprior or ov_criminal_flag or ov_corrections ), 
															630, Mod_Capped_tmp1);

     Mod_Capped := Map(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) => 222,
												noContent2 => 222,
												Mod_Capped_tmp2);


     RVP804 := Mod_Capped;
		
		// No reason codes
	
		// Score
		self.score := intformat(RVP804,3,1);

		self.seq := le.seq;	
		
#if(Risk_Indicators.iid_constants.validation_debug)	
		self.clam := le;
		self.Mod_Capped_a	:= 	Mod_Capped_a	;
		self.voter_level 	:= 	voter_level 	;
		self.ams_hit 	:= 	ams_hit 	;
		self.source_pos_weak 	:= 	source_pos_weak 	;
		self.derog_level_m 	:= 	derog_level_m 	;
		self.prop_mod 	:= 	prop_mod 	;
		self.ssns_per_adl_c_m 	:= 	ssns_per_adl_c_m 	;
		self.addrs_per_ssn_c_m 	:= 	addrs_per_ssn_c_m 	;
		self.per_addr_tree_m 	:= 	per_addr_tree_m 	;
		self.per_ssn_tree_m 	:= 	per_ssn_tree_m 	;
		self.avm_mod 	:= 	avm_mod 	;
		self.phones_per_adl_c6_m 	:= 	phones_per_adl_c6_m 	;
		self.ssns_per_addr_c6_m 	:= 	ssns_per_addr_c6_m 	;
		self.age_code_m 	:= 	age_code_m 	;
		self.phnprob2_m 	:= 	phnprob2_m 	;
		self.time_since_mod 	:= 	time_since_mod 	;
		self.nap_tree 	:= 	nap_tree 	;
		self.Mod_Capped_m	:= 	Mod_Capped_m	;
		// self.ams_hit 	:= 	ams_hit 	;
		self.pos_sec_ver_flag3 	:= 	pos_sec_ver_flag3 	;
		self.derog_flag 	:= 	derog_flag 	;
		self.phn_mod 	:= 	phn_mod 	;
		self.agecode_m 	:= 	agecode_m 	;
		self.prop_mod2 	:= 	prop_mod2 	;
		self.avm_mod_m 	:= 	avm_mod_m 	;
		self.velo_mod2 	:= 	velo_mod2 	;
		self.velo_c6_mod 	:= 	velo_c6_mod 	;

#end

		self := [];
		

	END;


	final := project(clam, DoModel(left));

	RETURN (final);

END;		
		
		
		
		