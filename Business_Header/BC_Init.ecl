IMPORT Business_Header_SS,did_add,ut,mdr,idl_header,NID;

EXPORT BC_Init(

	 dataset(Layout_Business_Contact_FULL_new)	pAll_Business_Contacts_Sources	= Business_Sources.business_contacts
	,dataset(Layout_Business_Contact_Full_new)	pBusinessContactsPlus						= Files(,_Dataset().IsDataland).Base.Business_Contacts_Plus.qa
	,string																			pPersistname										= persistnames().BCInit													
	,boolean																		pShouldRecalculatePersist				= true													
	,string																			pFileVersion										= 'built'
	,boolean																		pUseOtherEnvironment						= _Dataset().IsDataland
) :=
function
		
//Rollup within each source to get rid of dups and reduce load on BDIDing
contact_dist := DISTRIBUTE(Filters.Input.Business_Contacts(pAll_Business_Contacts_Sources), HASH(TRIM(ut.CleanCompany(company_name)), TRIM(lname), zip, source));
contact_sort := SORT(contact_dist, ut.CleanCompany(company_name), company_department, company_title, lname, NID.PreferredFirstVersionedStr(fname, NID.version), mname, name_suffix, zip, prim_name, prim_range, source, IF(phone<>0,0,1), LOCAL);
contact_grpd := GROUP(contact_sort, ut.CleanCompany(company_name), company_department, company_title, lname, NID.PreferredFirstVersionedStr(fname, NID.version), mname, name_suffix, zip, prim_name, prim_range, source, LOCAL);

rec_lbcf := Business_Header.Layout_Business_Contact_Full_new;

rec_lbcf InitRollupContacts(rec_lbcf L, rec_lbcf R) := TRANSFORM
SELF.dt_first_seen := ut.EarliestDate(L.dt_first_seen, R.dt_first_seen);
SELF.dt_last_seen := max(L.dt_last_seen, R.dt_last_seen);
SELF.record_type := IF(R.record_type = 'C', R.record_type, L.record_type);
SELF := L;
END;

contact_rolled := GROUP(ROLLUP(contact_grpd, TRUE, InitRollupContacts(LEFT,RIGHT)));

//** Flipping the names that are wrongly cleaned by name cleaner.
ut.mac_flipnames(contact_rolled, fname, mname, lname, contact_flipnames);

Business_Contacts_Init_Filtered := contact_flipnames;

Layout_Business_Contacts_Temp ZeroIDs(Business_Header.Layout_Business_Contact_Full_new L) := TRANSFORM
SELF.bdid := 0;
SELF.did := 0;
SELF.company_fein := if(ValidFEIN(l.company_fein), l.company_fein, 0);  // Zero the FEIN if prefix is invalid
SELF.phone := (unsigned6)ut.CleanPhone((string)l.phone);  // Zero the phone if more than 10-digits
SELF.company_phone := (unsigned6)ut.CleanPhone((string)l.company_phone);  // Zero the companyphone if more than 10-digits
SELF := L;
END;

Business_Contacts_ID_Init := PROJECT(Business_Contacts_Init_Filtered, ZeroIDs(LEFT));

Layout_Business_Contacts_Temp InitPrevious(Layout_Business_Contact_Full_new L) := transform
SELF.bdid := 0;
SELF.did := 0;
SELF.vendor_id := IF(L.source in Set_Source_Vendor_Id_Unique, L.vendor_id, '');
SELF.company_fein := if(ValidFEIN(l.company_fein), l.company_fein, 0);  // Zero the FEIN if prefix is invalid
SELF.phone := (unsigned6)ut.CleanPhone((string)l.phone);  // Zero the phone if more than 10-digits
SELF.company_phone := (unsigned6)ut.CleanPhone((string)l.company_phone);  // Zero the companyphone if more than 10-digits
self.dt_first_seen 				:= if(MDR.sourceTools.SourceisDunn_Bradstreet(l.source) and (integer)l.dt_first_seen 				< 10000000 and (integer)l.dt_first_seen 			!= 0, 0, l.dt_first_seen);
self.dt_last_seen 				:= if(MDR.sourceTools.SourceisDunn_Bradstreet(l.source) and (integer)l.dt_last_seen 				< 10000000 and (integer)l.dt_last_seen 				!= 0, 0, l.dt_last_seen);
SELF := L;
end;

Business_Contacts_Previous := filters.bases.business_contacts(pBusinessContactsPlus);

Business_Contacts_Previous_Init := PROJECT(Business_Contacts_Previous, InitPrevious(LEFT));

Business_Contacts_To_Id := map(Flags.Building.Initialize => Business_Contacts_ID_Init,
							   Flags.Building.NoUpdates	 => Business_Contacts_Previous_Init,
							  Business_Contacts_ID_Init + Business_Contacts_Previous_Init);
							  
//Business_Contacts_To_Id_Dedup := DEDUP(Business_Contacts_To_Id, ALL);
							  
// BDID using the Source Match Macro
Business_Header.MAC_Source_Match(Business_Contacts_To_Id, Business_Contacts_BDID_Init,
                        FALSE, bdid,
                        TRUE, source,
                        TRUE, company_source_group,
                        company_name,
                        company_prim_range, company_prim_name, company_sec_range, company_zip,
                        TRUE, company_phone,
                        TRUE, company_fein,
						TRUE, vendor_id
						,pFileVersion,pUseOtherEnvironment)

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
                                  Business_Contacts_BDID_Rematch
																	,,pFileVersion,pUseOtherEnvironment)

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
                                  Business_Contacts_BDID_Rematch_2
																	,,pFileVersion,pUseOtherEnvironment)
						    
Business_Contacts_BDID_All := Business_Contacts_BDID_Match_2 + Business_Contacts_BDID_Rematch_2;

// Rollup Combined Contacts by BDID, Company, Source
Business_Contacts_Dist := DISTRIBUTE(Business_Contacts_BDID_All, HASH(bdid, TRIM(ut.CleanCompany(company_name)), TRIM(lname), zip));
Business_Contacts_Sort := SORT(Business_Contacts_Dist, bdid, ut.CleanCompany(company_name), company_title,
    lname, NID.PreferredFirstVersionedStr(fname, NID.version), mname, name_suffix, zip, prim_name, prim_range, company_zip, company_prim_name, company_prim_range, source, IF(phone<>0,0,1), if(vendor_id <> '', 0, 1), LOCAL);
Business_Contacts_Grpd := GROUP(Business_Contacts_Sort, bdid, ut.CleanCompany(company_name), company_title,
    lname, NID.PreferredFirstVersionedStr(fname, NID.version), mname, name_suffix, zip, prim_name, prim_range, company_zip, company_prim_name, company_prim_range, source, LOCAL);

Business_Header.Layout_Business_Contacts_Temp RollupContacts(Business_Header.Layout_Business_Contacts_Temp L, Business_Header.Layout_Business_Contacts_Temp R) := TRANSFORM
SELF.dt_first_seen := ut.EarliestDate(L.dt_first_seen, R.dt_first_seen);
SELF.dt_last_seen := max(L.dt_last_seen, R.dt_last_seen);
SELF.company_phone := IF(L.company_phone = 0, R.company_phone, L.company_phone);
SELF.company_fein := IF(L.company_fein = 0, R.company_fein, L.company_fein);
SELF.record_type := IF(R.record_type = 'C', R.record_type, L.record_type);
SELF := L;
END;

Business_Contacts_Rollup := GROUP(ROLLUP(Business_Contacts_Grpd, TRUE, RollupContacts(LEFT,RIGHT)));


ut.MAC_Sequence_Records(Business_Contacts_Rollup, uid, Business_Contacts_Rollup_ID)


bc_rollup_id_persisted := Business_Contacts_Rollup_ID : PERSIST(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, bc_rollup_id_persisted
																										, persists().BCInit
									);
return returndataset;

end;