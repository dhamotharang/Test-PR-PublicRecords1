IMPORT Business_Header_SS, Bankrupt, Gong, ut, UCC, Corp, YellowPages, Domains, FBN, BusReg, DNB, Edgar, IRS5500, govdata, Vickers, DID_Add, Header, header_slimsort, Prof_License, BusData, Wither_and_Die, faa,atf, dca, lobbyists, fcc, experian_business_reports, infousa, fictitious_business_names, vehlic, watercraft, ln_property, ebr;

contact_concat := Gong.Gong_As_Business_Contact +
                          YellowPages.YellowPages_As_Business_Contact +
                          Corp.Corp_As_Business_Contact +
                          DNB.DNB_As_Business_Contact +
                          UCC.UCC_Party_As_Business_Contact +
                          Bankrupt.Bankrupt_As_Business_Contact +
                          BusReg.BusReg_As_Business_Contact +
						  Edgar.Edgar_As_Business_Contact +
                          IRS5500.IRS5500_As_Business_Contact +
                          Domains.Whois_As_Business_Contact +
						  govdata.Gov_Phones_As_Business_Contact +
                          govdata.CA_Sales_Tax_As_Business_Contact +
                          govdata.SEC_Broker_Dealer_As_Business_Contact +
						  govdata.FL_Non_Profit_As_Business_Contact +
						  govdata.MS_Workers_As_Business_Contact +
						  govdata.IRS_Non_Profit_As_Business_Contact +
						  govdata.IA_Sales_Tax_As_Business_Contact +
						  Vickers.Vickers_As_Business_Contact + 
						  Prof_License.Prof_License_As_Business_Contact +
						  govdata.FL_FBN_As_Business_Contact +
						  govdata.DEA_As_Business_Contact +
						  BusData.Accurint_Tradeshow_As_Business_Contact +
						  BusData.SKA_As_Business_Contact +
						  BusData.Credit_Unions_As_Business_Contact +
						  Wither_and_Die.Wither_and_Die_as_Business_Contact +
						  faa.faa_aircraft_reg_as_business_contact +
						  atf.ATF_as_Business_Contact +
						  dca.DCA_as_Business_Contact +
						  lobbyists.Cleaned_Lobbyists_As_Business_Contact +
						  dnb.DNB_FEIN_As_Business_Contact +
						  fcc.FCC_licenses_As_Business_Contact +
						  infousa.ABIUS_Executive_As_Business_Contact +
						  infousa.IDEXEC_As_Business_Contact +
						  infousa.DEADCO_As_Business_Contact + 
						  fictitious_business_names.FBN_as_Business_Contact +
						  vehlic.Vehicle_as_Business_Contact +
						  watercraft.Watercraft_as_Business_Contact +
						  ln_property.LN_Property_as_Business_Contact;
//						  ebr.EBR_As_Business_Contact;
						/* +	govdata.MEWA_As_Business_Contact*/
		
//Rollup within each source to get rid of dups and reduce load on BDIDing
contact_dist := DISTRIBUTE(contact_concat(company_name<>'', lname<>'', not(source in ['AW'] and vendor_id[1..2] in ['OR'])), HASH(TRIM(ut.CleanCompany(company_name)), TRIM(lname), zip, source));
contact_sort := SORT(contact_dist, ut.CleanCompany(company_name), company_department, company_title, lname, Datalib.PreferredFirst(fname), mname, name_suffix, zip, prim_name, prim_range, source, IF(phone<>0,0,1), LOCAL);
contact_grpd := GROUP(contact_sort, ut.CleanCompany(company_name), company_department, company_title, lname, Datalib.PreferredFirst(fname), mname, name_suffix, zip, prim_name, prim_range, source, LOCAL);

rec_lbcf := Business_Header.Layout_Business_Contact_Full;

rec_lbcf InitRollupContacts(rec_lbcf L, rec_lbcf R) := TRANSFORM
SELF.dt_first_seen := ut.EarliestDate(L.dt_first_seen, R.dt_first_seen);
SELF.dt_last_seen := ut.LatestDate(L.dt_last_seen, R.dt_last_seen);
SELF.record_type := IF(R.record_type = 'C', R.record_type, L.record_type);
SELF := L;
END;

contact_rolled := GROUP(ROLLUP(contact_grpd, TRUE, InitRollupContacts(LEFT,RIGHT)));


Business_Contacts_Init_Filtered := contact_rolled;

Layout_Business_Contacts_Temp ZeroIDs(Business_Header.Layout_Business_Contact_Full L) := TRANSFORM
SELF.bdid := 0;
SELF.did := 0;
SELF.company_fein := if(ValidFEIN(l.company_fein), l.company_fein, 0);  // Zero the FEIN if prefix is invalid
SELF := L;
END;

Business_Contacts_ID_Init := PROJECT(Business_Contacts_Init_Filtered, ZeroIDs(LEFT));

Layout_Business_Contacts_Temp InitPrevious(Layout_Business_Contact_Full L) := transform
SELF.bdid := 0;
SELF.did := 0;
SELF.vendor_id := IF(L.source in Set_Source_Vendor_Id_Unique, L.vendor_id, '');
SELF.company_fein := if(ValidFEIN(l.company_fein), l.company_fein, 0);  // Zero the FEIN if prefix is invalid
self.dt_first_seen 				:= if(l.source = 'D' and (integer)l.dt_first_seen 				< 10000000 and (integer)l.dt_first_seen 			!= 0, 0, l.dt_first_seen);
self.dt_last_seen 				:= if(l.source = 'D' and (integer)l.dt_last_seen 				< 10000000 and (integer)l.dt_last_seen 				!= 0, 0, l.dt_last_seen);
SELF := L;
end;

Business_Contacts_Previous := Business_Header.File_Business_Contacts(from_hdr = 'N', BC_Fix_Filter);

Business_Contacts_Previous_Init := PROJECT(Business_Contacts_Previous, InitPrevious(LEFT));

Business_Contacts_To_Id := IF(Business_Header.BH_Init_Flag,
                              Business_Contacts_ID_Init,
							  Business_Contacts_ID_Init + Business_Contacts_Previous_Init);
							  
Business_Contacts_To_Id_Dedup := DEDUP(Business_Contacts_To_Id, ALL);
							  
// BDID using the Source Match Macro
Business_Header.MAC_Source_Match(Business_Contacts_To_Id_Dedup, Business_Contacts_BDID_Init,
                        FALSE, bdid,
                        TRUE, source,
                        TRUE, company_source_group,
                        company_name,
                        company_prim_range, company_prim_name, company_sec_range, company_zip,
                        TRUE, company_phone,
                        TRUE, company_fein,
						TRUE, vendor_id)

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

Business_Contacts_BDID_Match := Business_Contacts_BDID_Init(bdid <> 0);
Business_Contacts_BDID_NoMatch := Business_Contacts_BDID_Init(bdid = 0);


Business_Header_SS.MAC_Add_BDID_Flex(Business_Contacts_BDID_NoMatch,
                                  BDID_Matchset,
                                  company_name,
                                  company_prim_range, company_prim_name, company_zip,
                                  company_sec_range, company_state,
                                  company_phone, company_fein,
                                  bdid, Layout_Business_Contacts_Temp,
                                  FALSE, BDID_score_field,
                                  Business_Contacts_BDID_Rematch)

Business_Contacts_BDID_Rematched := Business_Contacts_BDID_Match + Business_Contacts_BDID_Rematch;

// Try a BDID Match uning the Contact Address and Company Name
Business_Contacts_BDID_Match_2 := Business_Contacts_BDID_Rematched(bdid <> 0);
Business_Contacts_BDID_NoMatch_2 := Business_Contacts_BDID_Rematched(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(Business_Contacts_BDID_NoMatch_2,
                                  BDID_Matchset,
                                  company_name,
                                  prim_range, prim_name, zip,
                                  sec_range, state,
                                  phone, company_fein,
                                  bdid, Layout_Business_Contacts_Temp,
                                  FALSE, BDID_score_field,
                                  Business_Contacts_BDID_Rematch_2)
						    
Business_Contacts_BDID_All := Business_Contacts_BDID_Match_2 + Business_Contacts_BDID_Rematch_2;

// Rollup Combined Contacts by BDID, Company, Source
Business_Contacts_Dist := DISTRIBUTE(Business_Contacts_BDID_All, HASH(bdid, TRIM(ut.CleanCompany(company_name)), TRIM(lname), zip));
Business_Contacts_Sort := SORT(Business_Contacts_Dist, bdid, ut.CleanCompany(company_name), company_title,
    lname, Datalib.PreferredFirst(fname), mname, name_suffix, zip, prim_name, prim_range, company_zip, company_prim_name, company_prim_range, source, IF(phone<>0,0,1), if(vendor_id <> '', 0, 1), LOCAL);
Business_Contacts_Grpd := GROUP(Business_Contacts_Sort, bdid, ut.CleanCompany(company_name), company_title,
    lname, Datalib.PreferredFirst(fname), mname, name_suffix, zip, prim_name, prim_range, company_zip, company_prim_name, company_prim_range, source, LOCAL);

Business_Header.Layout_Business_Contacts_Temp RollupContacts(Business_Header.Layout_Business_Contacts_Temp L, Business_Header.Layout_Business_Contacts_Temp R) := TRANSFORM
SELF.dt_first_seen := ut.EarliestDate(L.dt_first_seen, R.dt_first_seen);
SELF.dt_last_seen := ut.LatestDate(L.dt_last_seen, R.dt_last_seen);
SELF.company_phone := IF(L.company_phone = 0, R.company_phone, L.company_phone);
SELF.company_fein := IF(L.company_fein = 0, R.company_fein, L.company_fein);
SELF.record_type := IF(R.record_type = 'C', R.record_type, L.record_type);
SELF := L;
END;

Business_Contacts_Rollup := GROUP(ROLLUP(Business_Contacts_Grpd, TRUE, RollupContacts(LEFT,RIGHT)));


ut.MAC_Sequence_Records(Business_Contacts_Rollup, uid, Business_Contacts_Rollup_ID)


EXPORT BC_Init := Business_Contacts_Rollup_ID : PERSIST('TEMP::BC_Init');