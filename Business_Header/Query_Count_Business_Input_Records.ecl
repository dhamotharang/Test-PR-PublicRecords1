#workunit ('name', 'Count Business Input Records ');

export MAC_CountSubFiles(superfile_name, thecount, outfile) := macro

#uniquename(rec)
%rec% := record
 string filename;
 integer4 mycount;
end;

#uniquename(rec2)
%rec2% := record
 string1 one;
end;

#uniquename(do)
%rec% %do%(%rec2% L, integer c) := transform
self.filename := fileservices.GetSuperFileSubName(superfile_name,c);
self.mycount := thecount;
end;

#uniquename(subnamelist)
%subnamelist% := normalize(dataset([{''}],%rec2%), fileservices.GetSuperFileSubCount(superfile_name),%do%(left,counter));

outfile := %subnamelist%;

endmacro;

MAC_CountSubFiles('~thor_data400::Base::Gong', count(Gong.File_Gong_Dirty), m1);
MAC_CountSubFiles('~thor_data400::Base::Bankrupt_Main', count(Bankrupt.File_BK_main), m2);
MAC_CountSubFiles('~thor_data400::Base::Bankrupt_Search', count(Bankrupt.File_BK_Search), m3);
MAC_CountSubFiles('~thor_data400::Base::MS_Workers', count(govdata.File_MS_Workers_Comp_In), m4);
MAC_CountSubFiles('~thor_data400::in::Prof_Licenses_IN', count(Prof_License.file_prof_license), m5);
MAC_CountSubFiles('~thor_data400::BASE::Business_Header', count(Business_Header.File_Business_Header), m6);
MAC_CountSubFiles('~thor_data400::base::liens', count(Bankrupt.File_Liens_Daily), m7);
MAC_CountSubFiles('~thor_data400::in::dea', count(govdata.File_DEA_In), m8);
MAC_CountSubFiles('~thor_data400::base::sec_bd_info', count(govdata.File_SEC_Broker_Dealer_In), m9);
MAC_CountSubFiles('~thor_data400::BASE::Business_Contacts', count(Business_Header.File_Business_Contacts), m10);
MAC_CountSubFiles('~thor_data400::base::ska', count(busdata.File_SKA_Verified_In), m12);
MAC_CountSubFiles('~thor_data400::base::ska_a', count(busdata.File_SKA_Nixie_In), m13);
MAC_CountSubFiles('~thor_data400::BASE::Corp_Cont_Base', count(Corp.File_Corp_Cont_Base), m14);
MAC_CountSubFiles('~thor_data400::BASE::Corp_Base', count(Corp.File_Corp_Base), m15);
MAC_CountSubFiles('~thor_data400::BASE::atf_firearms_explosives', count(atf.file_firearms_explosives_base), m16);
MAC_CountSubFiles('~thor_data400::OUT::Property_DID', count(property.File_Fares_DID_Out), m17);

mysuperfiles := m1 + m2 + m3 + m4 + m5 + m6 + m7 +  m8 + m9 + m10 + m12 + m13 + m14 + m15 + m16 + m17;

integer superfile_count := sum(mysuperfiles, mycount);

other_count := count(busdata.file_aca_internet_march_success_in(state != '' or state = '')) +
               count(busdata.file_ace_check_serv_in(st != '' or st = '')) +
               count(busdata.file_ace_icsp_in(st != '' or st = '')) +
               count(busdata.file_ace_international_in(st != '' or st = '')) +
               count(busdata.file_card_tech_securtech_in(name_prefix != '' or name_prefix = '')) +
               count(busdata.file_credit_unions(geo_match != '' or geo_match = '')) +
               count(busdata.file_credit_unions(st != '' or st = '')) +
               count(busdata.file_customer_info_system_in(st != '' or st = '')) +
               count(busdata.file_factoring_conference_in(st != '' or st = '')) +
               count(busdata.file_factory_conference_in(st != '' or st = '')) +
               count(busdata.file_ins_fraud_manage_in(st != '' or st = '')) +
               count(busdata.file_las_vegas_recruit_expo_in(st != '' or st = '')) +
               count(busreg.file_busreg_company(bdid != 0 or bdid = 0)) +
               count(busreg.file_busreg_contact(did != 0 or did = 0)) +
               count(dnb.file_dnb_base_plus(bdid != 0 or bdid = 0)) +
               count(dnb.file_dnb_contacts_base_plus(did != 0 or did = 0)) +
               count(domains.file_whois(date_first_seen != '')) +
               count(edgar.file_edgar_company_base(companyname != '' or companyname = '')) +
               count(edgar.file_edgar_contacts_base(did != 0 or did = 0)) +
               count(fbn.file_fbn(bdid != 0 or bdid = 0)) +
               count(govdata.file_ca_sales_tax_in(district_branch != '' or district_branch = '')) +
               count(govdata.file_fdic_in(process_date != '' or process_date = '')) +
               count(govdata.file_fl_fbn_events_in(event_doc_number = '' or event_doc_number != '')) +
               count(govdata.file_fl_fbn_in(fic_fil_doc_num != '' or fic_fil_doc_num = '')) +
               count(govdata.file_fl_non_profit_corp_in(process_date != '' or process_date = '')) +
               count(govdata.file_gov_phones_base(bdid != 0 or bdid = 0)) +
               count(govdata.file_ia_sales_tax_in(permit_nbr != '' or permit_nbr = '')) +
               count(govdata.file_irs_non_profit_in(process_date != '' or process_date = '')) +
               count(govdata.file_or_workers_comp_in(date_first_seen != '' or date_first_seen = '')) +
               count(govdata.file_sec_broker_dealer_in(dt_first_reported != '' or dt_first_reported = '')) +
               count(header.file_eq_employer(did != 0 or did = 0)) +
               count(irs5500.file_irs5500_base(bdid != 0 or bdid = 0)) +
               count(ucc.file_ucc_debtor_master(bdid != 0 or bdid = 0)) +
               count(ucc.file_ucc_secured_master(bdid != 0 or bdid = 0)) +
               count(vickers.file_13d13g_in(form_id != '' or form_id = '')) +
               count(vickers.file_insider_filing_in(form_id != '' or form_id = '')) +
               count(vickers.file_insider_security_in(cusip != '' or cusip = '')) +
               count(yellowpages.file_yellowpages_base(bdid != 0 or bdid = 0)) +
               count(Wither_and_Die.File_Wither_and_Die_In(dt_first_seen != '' or dt_first_seen = '')) +
               count(faa.file_aircraft_registration_out(date_first_seen != '' or date_first_seen = '')) +
			count(DCA.File_DCA_all_In(Enterprise_num != '' or Enterprise_num = '')) + 
			count(DNB.File_DNB_FEIN_In(BUSINESS_NAME != '' or BUSINESS_NAME = ''));
			
integer total_count := superfile_count + other_count;

tbc := output(total_count, named('Total_Business_Input_Records'));

tbc;
