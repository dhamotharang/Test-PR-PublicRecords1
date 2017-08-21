export base_files := module
//
import ut,doxie_files,doxie_build,lib_stringlib;
import did_add,  didville;
import address;
import Header_Slimsort;
import DMA;
//
import header;
import header_quick;
import risk_indicators;
import watchdog;
import utilfile;
import marriage_divorce_v2;
import bankruptcyv2;
import bankruptcyv3;
import liensv2;
import Marketing_Best;
import driversv2, prof_licensev2,faa;
import corrections;
import patriot;
import emerges;
import property,ln_propertyv2;
import gong;
import daybatchpcnsr;
import dnb,corp2,business_header;
import uccv2,votersv2,vehiclev2;
import sexoffender;
import phonesplus,cellphone;
import watercraft;
import domains;
import atf;
import dea;
import faa;
import flaccidents;
//
import paw;
import yellowpages;
import bbb2;
import busreg;
import ebr;
import globalwatchlists;
import fbn;
import fbnv2;
import business_header_bdl2;
//
import official_records; //jayant
import civil_court;      //jayant
//
layout_demo_data_dids := record
unsigned6 did;
end;
export file_demo_data_dids := dataset('~thor_200::base::demo_data_dids',layout_demo_data_dids,flat);
//
layout_demo_data_bdids := record
unsigned6 bdid;
end;
export file_demo_data_bdids := dataset('~thor_200::base::demo_data_bdids',layout_demo_data_bdids,flat);	
//	
export file_lookups := doxie_files.file_lookups;
//
export file_base_AddressSicCode_built:= business_header.files().base.AddressSicCode.built((integer)zip<>0);
export file_base_AddressSicCode2_built :=  business_header.files().base.AddressSicCode2.built((integer)zip<>0);
export file_HRI_Address_Sic := risk_indicators.File_HRI_Address_Sic((integer)zip<>0);
//
export file_bankruptcy_search := BankruptcyV2.file_bankruptcy_search;
export file_bankruptcy_main := BankruptcyV2.file_bankruptcy_main;
//
export file_bankruptcy_search_v3 := BankruptcyV2.file_bankruptcy_search_v3;
export file_bankruptcy_main_v3 := BankruptcyV2.file_bankruptcy_main_v3;
//
export file_headers := header.File_Headers;
export file_header_quick  := header_quick.file_header_quick;
export file_relatives :=header.file_relatives;
//
export file_util := UtilFile.file_util_daily;
//
export file_watchdog_best := watchdog.file_best;
//
export File_Business_Header_Base := business_header.File_Business_Header_Base; 
export file_business_contacts_plus := business_header.file_business_contacts;
export file_business_header_best := business_header.File_Business_Header_Best;
export file_business_relatives := business_header.file_business_relatives;
export file_business_relatives_group := business_header.File_Business_Relatives_Group;
//
export file_proflic_base := Prof_LicenseV2.File_Proflic_Base_Tiers;
//
//export file_marketing_best_restricted := Marketing_Best.File_Marketing_Best_Restricted;				   
//export file_marketing_best_all := Marketing_Best.File_Marketing_Best_All;				   
//export file_equifax_base := marketing_best.file_equifax_base;
//export file_marketing_title_restricted := Marketing_Best.File_Marketing_Title_Restricted;	
//export file_marketing_title_all := Marketing_Best.File_Marketing_Title_All;				   
//
export file_corpdata := corp2.Files().Base.Corp.built;
export file_contdata := corp2.Files().Base.Cont.built;
export file_eventdata := corp2.Files().Base.Events.built; 
export file_stockdata := corp2.Files().Base.Stock.built; 
export file_ardata := corp2.Files().Base.AR.built;
//
export file_fbnv2_business := fbnv2.File_FBN_Business_Base;
export file_fbnv2_contact  := fbnv2.File_FBN_Contact_Base;

export file_bdl2_base := business_header_bdl2.File_BDL2_Base;


export file_did_death_masterv2 := header.File_Did_Death_MasterV2;
// no did! file_death_master_supplemental := header.file_death_master_supplemental;
//
export file_dl_searchv2 := dataset('~thor_data400::base::DL2::DLSearch_PUBLIC', DriversV2.Layout_Drivers, flat);
//
// used the following since the reference in the main repository had "BUILDING" which wasn't filled.
//
export file_offenders_keybuilding := dataset('~thor_Data400::base::Corrections_Offenders_' + 'public' + '_BUILT',corrections.layout_Offender,flat);
export file_offenses_keybuilding := dataset('~thor_data400::base::corrections_offenses_' + 'public' + '_BUILT',corrections.layout_offense,flat);
export file_courtoffenses_keybuilding := dataset('~thor_Data400::base::corrections_court_offenses_' + 'public' + '_BUILT',corrections.layout_courtoffenses,flat);
export file_activity_keybuilding := dataset('~thor_data400::base::corrections_Activity_' + 'public' + '_BUILT',corrections.layout_activity,flat);
export file_punishment_keybuilding := dataset('~thor_Data400::base::corrections_punishment_' + 'public' + '_BUILT',corrections.Layout_CrimPunishment,flat);
//
export file_ccw_base := emerges.file_ccw_base;
export file_voters_base := emerges.file_voters_base;
export file_votersv2_base := votersv2.File_Voters_Base;
export file_hvccw_base := emerges.file_hvccw_base;
//
export file_aircraft_registration := faa.file_aircraft_registration_out;
export file_airmen_certificate := faa.file_airmen_certificate_out;
export file_airmen_data_out := faa.file_airmen_data_out;
export faa_aircraft_info := dataset('~thor_data400::base::faa_aircraft_info_in',faa.layout_aircraft_info,flat);
//
export file_foreclosure := property.file_foreclosure;
export file_foreclosure2 := property.file_foreclosure_normalized;	// new "base file" from autokey/roxie migration

//
export file_gongbase := gong.file_gongbase;
export file_gonghist := gong.file_history;
//
// not sure we need this gong_file_history := gong.File_History;
//
export file_liens_main := liensv2.file_liens_main;
export file_liens_party := liensv2.file_liens_party;
//
export file_ln_propertyv2_file_search_did   := ln_propertyv2.File_Search_DID;
export file_ln_propertyv2_file_deed 		:= ln_propertyv2.File_Deed;
export file_ln_propertyv2_file_assessment   := ln_propertyv2.File_Assessment;
export file_ln_propertyv2_file_addl_fares_deed	:= ln_propertyv2.File_addl_fares_deed;
export file_ln_propertyv2_file_addl_fares_tax	:= ln_propertyv2.File_addl_fares_tax;
export file_ln_propertyv2_file_addl_legal		:= ln_propertyv2.File_addl_legal;
//
export file_mar_div_search := marriage_divorce_v2.file_mar_div_search;
export file_mar_div_base := marriage_divorce_v2.file_mar_div_base;
//
export file_uccv2_main_base 	:= uccv2.File_UCC_Main_Base;
export file_uccv2_party_base	:= uccv2.File_UCC_Party_Base;
export file_uccv2_party_name	:= uccv2.File_UCC_Party_Name;
//
export file_official_records_party_base := official_records.File_base_party;
export file_official_records_document_base := official_records.File_base_Document;
//
export file_civil_court_matter_base := civil_court.File_Moxie_Matter_Prod;
export file_civil_court_party_base  := civil_court.File_Moxie_Party_Prod;

//
export file_vehiclev2_main 		:= vehiclev2.file_VehicleV2_Main;
export file_vehiclev2_party		:= vehiclev2.file_VehicleV2_party;
//
export file_so_main		:= sexoffender.file_Main;
export file_so_offenses	:= sexoffender.File_Offenses;
//
export file_phonesplus_base := phonesplus.file_phonesplus_base;
export file_qsent_base := phonesplus.file_qsent_base;
export file_neustar := cellphone.fileNeuStar;
//
export file_watercraft_base_coastguard := watercraft.File_Base_Coastguard_Dev;
export file_watercraft_base_search := watercraft.file_base_search_dev;
export file_watercraft_base_main := watercraft.file_base_main_dev;
//
export file_whois_base := domains.File_Whois_Base;
//
export file_atf_firearms_explosives_base := atf.file_firearms_explosives_base;
//
export file_dea_doxie	:= dataset('~thor_data400::base::dea',{dea.layout_dea_out_base},flat);	 //for autokeys reference?
export file_dea_modified := DEA.File_DEA_Modified;		// for another reference?
//
export file_faa_aircraft_registration := faa.file_aircraft_registration_out;
export file_faa_airmen_data := faa.file_airmen_data_out;
export file_faa_airmen_certificate := faa.file_airmen_certificate_out;

export file_fl_crash0 := flaccidents.basefile_flcrash0;
export file_fl_crash1 := flaccidents.basefile_flcrash1;
export file_fl_crash2v := flaccidents.basefile_flcrash2v;
export file_fl_crash3v := flaccidents.basefile_flcrash3v;
export file_fl_crash4 := flaccidents.basefile_flcrash4;
export file_fl_crash5 := flaccidents.basefile_flcrash5;
export file_fl_crash6 := flaccidents.basefile_flcrash6;
export file_fl_crash7 := flaccidents.basefile_flcrash7;
export file_fl_crash8 := flaccidents.basefile_flcrash8;
export file_fl_crash_did := flaccidents.basefile_flcrash_did;

export file_paw := paw.File_Base;
//
// round 3 starts here
//
export file_patriot 	:= patriot.File_Patriot;
export key_did_patriot 	:= pull (patriot.key_did_patriot_file);
export key_bdid_patriot := pull (patriot.key_bdid_patriot_file);
//build note: patriot.mac_spray_and_build('192.168.0.39','/data_999/sanctions/out/old/sanctions_all.d00','20071102',,false);
//
export file_yellow_pages:= yellowpages.File_YellowPages_Base_yp;		// a persist???
//build note:	yellowpages.Proc_Build_All (after spray)
//
export file_bbb2_nonmember:= bbb2.Files().Base.NonMember.Built;
export file_bbb2_member   := bbb2.Files().Base.Member.Built;
//build note: BBB2.proc_build_all('20081103','/thor_back5/bbb/build/20081103').all;
//
export File_BusReg_Company := busreg.File_BusReg_Company;
export File_BusReg_Contact := busreg.File_BusReg_Contact;
//build note: BusReg.Proc_Build_All('20081010', '/bus_reg_3210').all;
//
export file_dnb_base := dnb.File_DNB_Base;
export file_dnb_contacts_base := dnb.File_DNB_Contacts_Base;
//build note: DNB.Proc_Build_All(_Control.ipaddress.edata10,'/dnb_02/','20081009').all;
//
export file_ebr_0010 := ebr.File_0010_Header_Base;
export file_ebr_1000 := ebr.File_1000_Executive_Summary_Base;
export file_ebr_2000 := ebr.File_2000_Trade_Base;
export file_ebr_2015 := ebr.File_2015_Trade_Payment_Totals_Base;
export file_ebr_2025 := ebr.File_2025_Trade_Quarterly_Averages_Base;
export file_ebr_4010 := ebr.File_4010_Bankruptcy_Base;
export file_ebr_4020 := ebr.File_4020_Tax_Liens_Base;
export file_ebr_4030 := ebr.File_4030_Judgement_Base;
export file_ebr_4035 := ebr.File_4035_Attachment_Lien_Base;
export file_ebr_4040 := ebr.File_4040_Bulk_Transfers_Base;
export file_ebr_4500 := ebr.File_4500_Collateral_Accounts_Base;
export file_ebr_4510 := ebr.File_4510_UCC_Filings_Base;
export file_ebr_5000 := ebr.File_5000_Bank_Details_Base;
export file_ebr_5600 := ebr.File_5600_Demographic_Data_Base;
export file_ebr_5610 := ebr.File_5610_Demographic_Data_Base;
export file_ebr_6000 := ebr.File_6000_Inquiries_Base;
export file_ebr_6500 := ebr.File_6500_Government_Trade_Base;
export file_ebr_6510 := ebr.File_6510_Government_Debarred_Contractor_Base;
export file_ebr_7000 := ebr.File_7000_SNP_Parent_Name_Address_Base;
export file_ebr_7010 := ebr.File_7010_SNP_Data_Base;
//build note: EBR.Proc_Build_All('20081022');
//
export file_pcnsr:= DayBatchPCNSR.File_PCNSR;
//build note: DayBatchPCNSR.proc_build_keys('20081014a');

export file_globalwatchlists := globalwatchlists.File_GlobalWatchLists;


end;