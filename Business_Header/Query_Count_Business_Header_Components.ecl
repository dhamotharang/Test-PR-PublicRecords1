import ebr,lobbyists,watercraft,dca,fcc,YellowPages,govdata,lib_fileservices, bbb2, ln_property;
////////////////////////////////////////////////////////////////////////////////////
// -- Record Layouts used in process
////////////////////////////////////////////////////////////////////////////////////
inforecord := lib_fileservices.FsLogicalFileInfoRecord;
namerecord := lib_fileservices.FsLogicalFileNameRecord;

////////////////////////////////////////////////////////////////////////////////////
// -- Get list of filenames of the sub files contained in the superfiles
// -- used in the business header build
////////////////////////////////////////////////////////////////////////////////////
m1 := fileservices.SuperFileContents('~thor_data400::base::atf_firearms_explosives', true);
m2 := fileservices.SuperFileContents('~thor_data400::base::bankrupt_main', true);
m3 := fileservices.SuperFileContents('~thor_data400::base::bankrupt_search', true);
m4 := fileservices.SuperFileContents(BBB2.Filenames.Input.Member.Used, true);
m61 := fileservices.SuperFileContents(BBB2.Filenames.Input.NonMember.Used, true);
m5 := fileservices.SuperFileContents(bbb2.Filenames.Base.Member.QA, true);
m62 := fileservices.SuperFileContents(bbb2.Filenames.Base.NonMember.QA, true);
m6 := fileservices.SuperFileContents('~thor_data400::base::bh_super_group', true);
m7 := fileservices.SuperFileContents('~thor_data400::base::business_contacts', true);
m8 := fileservices.SuperFileContents('~thor_data400::base::business_header', true);
m9 := fileservices.SuperFileContents('~thor_data400::base::business_relatives', true);
m10 := fileservices.SuperFileContents('~thor_data400::base::business_relatives_group', true);
m11 := fileservices.SuperFileContents('~thor_data400::base::busreg_company', true);
m12 := fileservices.SuperFileContents('~thor_data400::base::busreg_contact', true);
m13 := fileservices.SuperFileContents('~thor_data400::base::ca_sales_tax_bdid', true);
m14 := fileservices.SuperFileContents('~thor_data400::base::corp_base', true);
m15 := fileservices.SuperFileContents('~thor_data400::base::corp_cont_base', true);
m16 := fileservices.SuperFileContents('~thor_data400::base::credit_unions', true);
m17 := fileservices.SuperFileContents('~thor_data400::base::dea', true);
m18 := fileservices.SuperFileContents('~thor_data400::base::dnb_companies', true);
m19 := fileservices.SuperFileContents('~thor_data400::base::dnb_contacts', true);
m20 := fileservices.SuperFileContents('~thor_data400::base::edgar_company', true);
m21 := fileservices.SuperFileContents('~thor_data400::base::edgar_contacts', true);
m22 := fileservices.SuperFileContents('~thor_data400::base::faa_aircraft_reg_built', true);
m23 := fileservices.SuperFileContents('~thor_data400::base::gong', true);
m24 := fileservices.SuperFileContents('~thor_data400::base::gong_history', true);
m25 := fileservices.SuperFileContents('~thor_data400::base::gov_phones', true);
m26 := fileservices.SuperFileContents('~thor_data400::base::govdata_fdic_bdid', true);
m27 := fileservices.SuperFileContents('~thor_data400::base::irs5500', true);
m28 := fileservices.SuperFileContents('~thor_data400::base::irs_nonprofit', true);
m29 := fileservices.SuperFileContents('~thor_data400::base::liens', true);
//m30 := fileservices.SuperFileContents('~thor_data400::base::ln_propassessheader_building', true);
//m31 := fileservices.SuperFileContents('~thor_data400::base::ln_propdeedheader_building', true);
m32 := fileservices.SuperFileContents('~thor_data400::base::ms_workers', true);
m33 := fileservices.SuperFileContents('~thor_data400::base::ms_workers_comp', true);
m34 := fileservices.SuperFileContents('~thor_data400::base::or_workers_comp', true);
m35 := fileservices.SuperFileContents('~thor_data400::base::prof_licenses', true);
m36 := fileservices.SuperFileContents(ln_property.fileNames.builtAssessor, true);
m37 := fileservices.SuperFileContents(ln_property.fileNames.builtDeeds, true);
m38 := fileservices.SuperFileContents(ln_property.filenames.builtSearch, true);
m39 := fileservices.SuperFileContents('~thor_data400::base::sec_bd_info', true);
m40 := fileservices.SuperFileContents('~thor_data400::base::sec_broker_dealer', true);
m41 := fileservices.SuperFileContents('~thor_data400::base::ska', true);
m42 := fileservices.SuperFileContents('~thor_data400::base::ska_a', true);
m43 := fileservices.SuperFileContents('~thor_data400::base::ska_nixie', true);
m44 := fileservices.SuperFileContents('~thor_data400::base::ska_verified', true);
m45 := fileservices.SuperFileContents('~thor_data400::base::ucc_event_wexp', true);
m46 := fileservices.SuperFileContents('~thor_data400::base::ucc_party_wexp', true);
m47 := fileservices.SuperFileContents('~thor_data400::base::vickers_13d13g_base', true);
m48 := fileservices.SuperFileContents('~thor_data400::base::vickers_insider_filing_base', true);
m49 := fileservices.SuperFileContents('~thor_data400::base::whois', true);
m50 := fileservices.SuperFileContents(yellowpages.Filenames.Base.QA, true);
m51 := fileservices.SuperFileContents('~thor_data400::in::dea', true);
m52 := fileservices.SuperFileContents(ebr.FileName_0010_Header_Base, true);
m53 := fileservices.SuperFileContents(ebr.FileName_0010_Header_In + '_father', true);
m54 := fileservices.SuperFileContents(ebr.FileName_5610_Demographic_Data_Base, true);
m55 := fileservices.SuperFileContents(ebr.FileName_5610_Demographic_Data_In + '_father', true);
m56 := fileservices.SuperFileContents('~thor_data400::base::vehicles_prod', true);
m57 := fileservices.SuperFileContents('~thor_data400::in::abius_combined_data', true);
m58 := fileservices.SuperFileContents('~thor_data400::in::infousa_deadco', true);
m59 := fileservices.SuperFileContents('~thor_data400::in::infousa_idexec', true);
m60 := fileservices.SuperFileContents(yellowpages.Filenames.Input.Used, true);

Update_superfiles_list :=  
	  m1  + m2  + m3  + m4  + m5  + m6  + m7  + m8  + m9  + m10 
	+ m11 + m12 + m13 + m14 + m15 + m16 + m17 + m18 + m19 + m20 
	+ m21 + m22 + m23 + m24 + m25 + m26 + m27 + m28 + m29 //+ m30
/*	+ m31*/ + m32 + m33 + m34 + m35 + m36 + m37 + m38 + m39 + m40
	+ m41 + m42 + m43 + m44 + m45 + m46 + m47 + m48 + m49 + m50
	+ m51 + m52 + m53 + m54 + m55 + m56 + m57 + m58 + m59 + m60
	+ m61 + m62;

////////////////////////////////////////////////////////////////////////////////////
// -- Get the thor clusters that the lobbyist and watercraft files are on
// -- removing the '~' from the beginning because fileservices.LogicalFileList 
// -- does not work with the '~'
////////////////////////////////////////////////////////////////////////////////////
lobby_thor := lobbyists.lobbyist_thor_cluster[2..];
water_cluster := watercraft.cluster[2..];

////////////////////////////////////////////////////////////////////////////////////
// -- Inline dataset of the filenames of the regular files
// -- used in the business header build
////////////////////////////////////////////////////////////////////////////////////
Update_logical_files_list := DATASET([
('thor_data400::in::aca_internet_march_success_20040629'),
('thor_data400::in::ace_check_serv_20040629'),
('thor_data400::in::ace_icsp_20040629'),
('thor_data400::in::ace_international_20040629'),
('thor_data400::in::card_tech_securtech_20040629'),
('thor_data400::in::customer_info_system_20040629'),
('thor_data400::in::factoring_conference_20040629'),
('thor_data400::in::factory_conference_20040629'),
('thor_data400::in::ins_fraud_manage_20040629'),
('thor_data400::in::las_vegas_recruit_expo_20040629'),
(trim(DCA.Filename_DCA_All_In[2..])),	//doesnt work for some reason
('thor_data400::in::dnb_fein_20060330'),
(trim(FCC.Filename_FCC_Licenses_In[2..])),	//doesnt work for some reason
('thor_data400::in::fl_fbn_events_20060117'),
('thor_data400::in::fl_fbn_events_20060209'),
('thor_data400::in::fl_fbn_20060117'),
('thor_data400::in::fl_fbn_20060209'),
('thor_data400::in::ia_sales_tax_' + govdata.IA_Sales_Tax_File_Date),
('thor_data400::in::infousa_fbn_new'),
('thor_data400::in::non_profit_orgs_clean_20030412'),

('thor_data400::in::vickers_insider_security_20060405'),
('thor_data400::in::vickers_insider_security_20060405_2'),
('thor_data400::in::vickers_insider_filing_20060405'),
('thor_data400::in::vickers_insider_filing_20060405_2'),
('thor_data400::in::vickers_13d13g_20060405'),
('thor_data400::in::vickers_13d13g_20060405_2'),

('thor_data400::in::who_is_20040504'),
('thor_data400::in::wither_and_die_20050214'),
('thor_data400::in::wither_and_die_20050314'),
('thor_data400::out::macro_clean_contactnames'),
(lobby_thor + '::in::lobbyists_va_2005'),
(lobby_thor + '::in::lobbyists::hi_20050405_initial'),
(lobby_thor + '::in::lobbyists::id_1992_2005_lobbyist'),
(lobby_thor + '::in::lobbyists::ia_2004'),
(lobby_thor + '::in::lobbyists::ia_2003'),
(lobby_thor + '::in::lobbyists::ia_2002'),
(lobby_thor + '::in::lobbyists::me_20050307_initial.csv'),
(lobby_thor + '::in::lobbyists_or_20050207_lobbyist_mod.csv'),
(lobby_thor + '::in::lobbyists::ri_20050217_full_report_entity.csv'),
(lobby_thor + '::in::lobbyists::sd_20050308_initial.csv'),
(lobby_thor + '::in::wv_20050209.lobby_names.csv'),
(lobby_thor + '::in::lobbyists::mo_2000_2005'),
(lobby_thor + '::in::lobbyists::ga_20050307_initial.csv'),
(lobby_thor + '::in::lobbyists::mn_20050203'),
(lobby_thor + '::in::lobbyists::nv_20050413_initial_mod.csv'),
(lobby_thor + '::in::tn_lobbyists_2001.csv'),
(lobby_thor + '::in::tn_lobbyists_2002.csv'),
(lobby_thor + '::in::tn_lobbyists_2003.csv'),
(lobby_thor + '::in::tn_lobbyists_2004.csv'),
(lobby_thor + '::in::tn_lobbyists_2005.csv'),
(lobby_thor + '::in::lobbyists::ny_20050308_initial_mod.csv'),
(lobby_thor + '::in::lobbyists::nh_20050324_initial.csv'),
(lobby_thor + '::in::lobbyists::oh_20050202_initial.csv'),
(lobby_thor + '::in::lobbyists::nc_20050307_initial.csv'),
(lobby_thor + '::in::lobbyists::nj_20050216_request_1999_2005.csv'),
(lobby_thor + '::in::lobbyists::ky_20050202_all_eal_mailing_list.csv'),
(lobby_thor + '::in::lobbyists_ms_20050321_initial.csv'),
(lobby_thor + '::in::lobbyists_dc_20050412_initial.csv'),
(lobby_thor + '::in::lobbyists_in_20050408_initial_mod.csv'),
(lobby_thor + '::in::lobbyists_wy_20050413_initial.csv'),
(lobby_thor + '::in::lobbyists_mt_2000_2002_irr_lb_pr1.csv'),
(lobby_thor + '::in::lobbyists_mt_2003_2004_irr_lb_pr1.csv'),
(lobby_thor + '::in::lobbyists_mt_2005_2006_irr_lb_pr1.csv'),
(lobby_thor + '::in::lobbyists_tx_lobted97.csv'),
(lobby_thor + '::in::lobbyists_tx_lobted98.csv'),
(lobby_thor + '::in::lobbyists_tx_lobted99.csv'),
(lobby_thor + '::in::lobbyists_tx_lobted00.csv'),
(lobby_thor + '::in::lobbyists_tx_lobcon01.csv'),
(lobby_thor + '::in::lobbyists_tx_lobcon02.csv'),
(lobby_thor + '::in::lobbyists_tx_lobcon03.csv'),
(lobby_thor + '::in::lobbyists_tx_lobcon04.csv'),
(lobby_thor + '::in::lobbyists_tx_lobcon05.csv'),
(lobby_thor + '::in::lobbyists_ak_2005_lobdir.csv'),
(lobby_thor + '::in::lobbyists_ar_20050131_sep13.csv'),
(lobby_thor + '::in::lobbyist_vt_employer_listing_3_30_2005_csv'),
(lobby_thor + '::in::lobbyists_fl_20050412_llob.txt'),
(lobby_thor + '::in::lobbyist_ok_20050201_loblist1-31-05.csv'),
(lobby_thor + '::in::lobbyists_ma_20050411_initial_csv'),
(lobby_thor + '::in::lobbyists_al_12_03_04.csv'),
(lobby_thor + '::in::lobbyists_al_5_05_05.csv'),
(lobby_thor + '::in::lobbyists_az_lobexport_1.csv'),
(lobby_thor + '::in::lobbyists_ca_20050624_lobbyists.csv'),
(lobby_thor + '::in::lobbyists_co_curr_lobby.csv'),
(lobby_thor + '::in::lobbyists_la_20050819_alllobs.csv'),
(water_cluster + 'base::watercraft_search_' + watercraft.version_production) // no superfile yet
], namerecord);

////////////////////////////////////////////////////////////////////////////////////
// -- Get file information for filenames
////////////////////////////////////////////////////////////////////////////////////
inforecord getinfo(namerecord l) := 
transform
	self := fileservices.LogicalFileList(l.name)[1];
end;


fileinfosuper := project(Update_superfiles_list, getinfo(left));
fileinfological := project(Update_logical_files_list, getinfo(left));

export Query_Count_Business_Header_Components := sequential(output(sort(fileinfosuper + fileinfological,name),named('Business_Header_Input_File_List'),all));