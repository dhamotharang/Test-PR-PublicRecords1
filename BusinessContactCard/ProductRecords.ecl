
IMPORT AutoStandardI, doxie, doxie_cbrs, iesp, Gong, moxie_phonesplus_server, ut;
			 
// The following module makes available to consuming services all attributes that fulfill 
// the data requirements for BusinessContactCard. These exported attributes may be therefore 
// used in the manner deemed best by whichever service is using them.
EXPORT ProductRecords := MODULE

	// ========================================================================================
	// 
	//                                   SUBJECT COMPANY
	//
	// ========================================================================================
	// For the Subject Company, obtain Best_Info (i.e. Name, Address, Phone) for each BDID. 
	// NOTE: fn_best_information returns only one record, and the group_id in its bdid field, 
	// regardless of what is input.
	EXPORT companyRecords(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in,
												BusinessContactCard.IParam.options in_mod) := function															
		ds_companies_by_acctno := 	BusinessContactCard.Raw.getBusinessHeaderBest(ds_in, in_mod); 															
		// ...and obtain the most recent Corp Key data for each ids to attach for corporate filing status. 
		ds_corp_recs_most_recent_status := BusinessContactCard.Raw.getCorpRecords(ds_in, in_mod);

		ds_companies_with_status := JOIN(ds_companies_by_acctno, ds_corp_recs_most_recent_status,
																		 LEFT.acctno = RIGHT.acctno,
																		 TRANSFORM(BusinessContactCard.Layouts.rec_company_best,
																							 SELF.corp_status_desc := RIGHT.corp_status_desc,
																							 SELF := LEFT),
																		 LEFT OUTER,
																		 LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_RECS_PER_ACCTNO));		
		return ds_companies_with_status;
	end;

	// ========================================================================================
	// 
	//                                   PARENT COMPANY
	//
	// ========================================================================================
	// For the Parent Company, obtain Best_Info (i.e. Name, Address, Phone) for each BDID.
	// NOTE: as above, ultimate_parent_information returns only one record, and the group_id 
	// in its bdid field, regardless of what is input.
	EXPORT parentsRecords(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in,
												BusinessContactCard.IParam.options in_mod) := function
		ds_parents_by_acctno := BusinessContactCard.Raw.getBusinessHeaderParentRecord(ds_in, in_mod);
		return ds_parents_by_acctno;
	end;
	

	// ========================================================================================
	// 
	//                            SUBJECT COMPANY PHONE VARIATIONS
	//
	// ========================================================================================
	// Obtain the Business Header data for that BDID for Phone Variations. Note that 
	// doxie_cbrs.phone_variations_base returns only the fields 'phone' and 'phone_source_id', 
	// so we need to obtain phone variations from within a Transform to ensure they're 
	// associated with their Group_ID/bdid.
	EXPORT phoneVariationsRecords(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in,
																BusinessContactCard.IParam.options in_mod) := function
		ds_phone_variations_company := BusinessContactCard.Raw.getPhoneVariationsRecords(ds_in, in_mod);
		return ds_phone_variations_company;
	end;
	

	// ========================================================================================
	// 
	//                             CONTACTS FOR THE SUBJECT COMPANY
	//
	// ========================================================================================
	// Pull the Business Contacts Key data by BDID (to get Contacts, Executives, DIDs, Titles, 
	// Names & Last Seens). We must rank and sort the contacts by their title. 
	EXPORT contactsRecords(dataset(BusinessContactCard.Layouts.rec_contact) ds_contacts_in,
												 BusinessContactCard.IParam.options in_mod) := function

    mod_access := doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
		UNRANKED_TITLE_VALUE := 100;
																				
		ds_contacts_ranked := JOIN(ds_contacts_in, doxie_cbrs.executive_titles,
															 LEFT.company_title = RIGHT.stored_title,
															 TRANSFORM(BusinessContactCard.Layouts.rec_contact,
																				 SELF.title_rank := RIGHT.title_rank,
																				 SELF            := LEFT),
															 LEFT OUTER);
		
		ds_contacts := PROJECT(ds_contacts_ranked, 
													TRANSFORM(BusinessContactCard.Layouts.rec_contact,
																		SELF.title_rank := IF( LEFT.title_rank = 0, UNRANKED_TITLE_VALUE, LEFT.title_rank ),
																		SELF.is_exec    := IF( LEFT.title_rank = 0, FALSE, TRUE ),
																		SELF            := LEFT));
																										 
		just_dids := DEDUP(SORT(PROJECT( ds_contacts_in, doxie.layout_references ), did), did);
		
		// Get the home address for each Contact and join it to the list of Contacts.
		doxie.layout_best best_records := doxie.best_records(just_dids, modAccess := mod_access);
		
		ds_contacts_with_home_address := JOIN( ds_contacts, best_records,
																					 LEFT.did = RIGHT.did,
																					 TRANSFORM(BusinessContactCard.Layouts.rec_contact, 
																										 SELF.did   := LEFT.did,
																										 SELF.lname := LEFT.lname,
																										 SELF.fname := LEFT.fname,
																										 SELF.mname := LEFT.mname,
																										 SELF.title := LEFT.title,
																										 SELF.phone := (UNSIGNED6)LEFT.phone,
																										 SELF.zip   := (UNSIGNED3)LEFT.zip,
																										 SELF.zip4  := (UNSIGNED2)LEFT.zip4,
																										 SELF       := RIGHT, 
																										 SELF       := LEFT),
																					 LEFT OUTER,
																					 LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_CONTACTS_PER_REC));
		return ds_contacts_with_home_address;
	end;
	
	// ========================================================================================
	// 
	//                           EDA (GONG) PHONE RECORDS FOR CONTACTS
	//
	// ========================================================================================
	// Obtain the most recent EDA/Gong phone number for each Contact.
	EXPORT gongRecords(dataset(BusinessContactCard.Layouts.rec_ids_did_in) ds_in) := FUNCTION
		gong_records_acctno_no_timezone := JOIN( ds_in, Gong.key_did,
																							KEYED(LEFT.did = RIGHT.l_did),
																							TRANSFORM(BusinessContactCard.Layouts.rec_gong_records_acctno,
																								SELF.acctno      := LEFT.acctno,
																								SELF.group_id    := LEFT.group_id,
																								SELF.did         := LEFT.did,
																								SELF.county_name := '';
																								SELF             := RIGHT),
																							INNER, LIMIT(iesp.constants.BR.MaxPhonesHistorical, SKIP) );

		// Add timezone
		ut.getTimeZone(gong_records_acctno_no_timezone, phone10, TimeZone, gong_records_acctno);
		return gong_records_acctno;
	end; 

	// ========================================================================================
	// 
	//                           PHONESPLUS RECORDS FOR CONTACTS
	//
	// ========================================================================================
	// Obtain most recent PhonesPlus phone number for each Contact.
	EXPORT phonesPlusRecords(dataset(BusinessContactCard.Layouts.rec_ids_did_in) ds_in) := FUNCTION
		just_dids := DEDUP(SORT(PROJECT( ds_in, doxie.layout_references ), did), did);
		// TODO: Use constants, proper input params.
		pplus_recs := moxie_phonesplus_server.phonesplus_did_records (
				dids                  := just_dids,
				max_count_value       := iesp.Constants.BR.MaxPhones, 
				score_threshold_value := AutoStandardI.DefaultModule().scorethreshold, // no default value
				glb_value             := 0,
				dppa_value            := 0,
				min_confidencescore   := 11, // 11 is the parameter default value
				is_roxie              := TRUE
				).w_timezoneSeenDt;
		
		pplus_recs_deduped := DEDUP(SORT(pplus_recs, did, -last_seen), did);
		
		phonesplus_records_acctno := JOIN(ds_in, pplus_recs_deduped,
																			LEFT.did = (UNSIGNED6)RIGHT.did,
																			TRANSFORM(BusinessContactCard.Layouts.rec_phonesplus_acctno,
																				SELF.acctno   := LEFT.acctno,
																				SELF.group_id := LEFT.group_id,
																				SELF          := RIGHT),
																			LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_PHONESPLUS_PER_REC) );		
		return phonesplus_records_acctno;
	END;
	
END;                          
															