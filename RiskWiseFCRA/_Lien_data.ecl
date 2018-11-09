IMPORT suppress; // formality: sp that MACRO itself would pass syntax check

EXPORT _Lien_data(in_dids, flag_file, liens_main_o, liens_party_o, nss = Suppress.Constants.NonSubjectSuppression.doNothing,
									_history_date = 999999, getDebtorOnly = true, excludeSuits = false, year_limit = 7) := MACRO

  IMPORT liensv2, FCRA, riskwise, doxie, ut, Risk_Indicators, STD;

	_MAX_OVERRIDE_LIMIT := 100;
	_todaysdate := (string) STD.Date.Today();
	
	layout_liens_main  := liensv2.Layout_liens_main_module.layout_liens_main;
  layout_liens_party := liensv2.layout_liens_party;	
	
	// first get the TMSID/RMSIDs for this individual
	liens_slim := JOIN( in_dids, liensv2.key_liens_DID_FCRA,
		left.did!=0 and keyed (Left.did = Right.did),
		transform(recordof(liensv2.key_liens_DID_FCRA), self := right),
		KEEP (100));

	lien_correct_tmsid_rmsid := SET( flag_file(file_id = FCRA.FILE_ID.LIEN), record_id );
	lien_correct_ffid        := SET( flag_file(file_id = FCRA.FILE_ID.LIEN), flag_file_id );

	liens_party := JOIN (liens_slim, liensv2.key_liens_party_id_FCRA, 
					 Left.tmsid<>''
						 AND keyed (Left.tmsid = Right.tmsid)
						 AND keyed (Left.rmsid = Right.rmsid)
						 AND ((left.did=(unsigned)right.did and right.name_type = 'D') OR
									//if debtorOnly is false show more of the plaintiffs which doesn't use a did check
									(~getDebtorOnly and right.name_type = 'C'))
						 AND (string50)right.tmsid + (string50)right.rmsid not in lien_correct_tmsid_rmsid  // old way - exclude corrected records
						 and trim((string)right.persistent_record_id) not in lien_correct_tmsid_rmsid,  // new way - exclude corrected records that match the persistent_record_id
					 transform(layout_liens_party, self := right),
					 ATMOST(keyed (Left.tmsid = Right.tmsid) and keyed (Left.rmsid = Right.rmsid), riskwise.max_atmost));

	party_override := fcra.key_Override_liensv2_party_ffid (keyed (flag_file_id IN lien_correct_ffid));
	
	party_new := PROJECT (CHOOSEN (party_override, _MAX_OVERRIDE_LIMIT), TRANSFORM (layout_liens_party, SELF := Left; Self := []));
	//disclosure is expecting 1 D and 1 C...which is why LNJ liens matches this dedupe
	both_party := DEDUP(SORT((party_new + liens_party), tmsid, rmsid, name_type), tmsid, rmsid, name_type); //don't need to filter by date_first_seen since it's populated with the Orig_Filing_date and that filter is done below

	// all party records known in both_party. use this instead of liens_slim to retrieve main records
	liens_main := JOIN( both_party, liensv2.key_liens_main_id_FCRA, 
					Left.tmsid<>''
						AND right.orig_filing_date<>''
						AND keyed(Left.tmsid = Right.tmsid)
						AND keyed (Left.rmsid = Right.rmsid)
						AND (right.filing_type_desc not in Risk_Indicators.iid_constants.setMechanicsLiens OR NSS<>1) // FILTER OUT MECHANIC LIENS FOR RISKVIEW DISCLOSURE ONLY(NSS=1)
						AND (string50)right.tmsid + (string50)right.rmsid not in lien_correct_tmsid_rmsid  // old way - exclude corrected records
						and trim((string)right.persistent_record_id) not in lien_correct_tmsid_rmsid  // new way - exclude corrected records that match the persistent_record_id
						and (excludeSuits = false OR (right.filing_type_desc not in risk_indicators.iid_constants.setSuitsFCRA)) //filter off suits
						AND (unsigned3)(Right.orig_filing_date[1..6]) < _history_date,
					transform(layout_liens_main, self := right),
					ATMOST(keyed (Left.tmsid = Right.tmsid) and keyed (Left.rmsid = Right.rmsid), riskwise.max_atmost));
						
	main_override := fcra.key_Override_liensv2_main_ffid (keyed (flag_file_id IN lien_correct_ffid));
	main_new := PROJECT (CHOOSEN (main_override, _MAX_OVERRIDE_LIMIT), TRANSFORM (layout_liens_main, SELF := Left; Self := []));
	
	all_liens := DEDUP(SORT((main_new + liens_main), tmsid, rmsid), tmsid, rmsid);
	liens_main_o := sort(all_liens(ut.fn_date_is_ok(_todaysdate, orig_filing_date, year_limit)), -Orig_Filing_date);

	// keep only those party records with an associated main record
	liens_party_o := sort(both_party( tmsid in set(liens_main_o, tmsid)), -date_last_seen, date_First_Seen);
	
// output(liens_slim,named('liens_slim'));
// output(flag_file,named('flag_file'));
// ff_L:=flag_file(file_id = FCRA.FILE_ID.LIEN);
// output(ff_L,named('ff_L'));
// output(lien_correct_tmsid_rmsid,named('lien_correct_tmsid_rmsid'));
// output(lien_correct_ffid,named('lien_correct_ffid'));
// output(liens_party,named('liens_partyyy'));
// output(party_override,named('party_override'));
// output(party_new,named('party_new'));	
// output(both_party,named('both_party'));
// output(liens_main,named('liens_mainnn'));
// output(main_override,named('main_override'));	
// output(main_new,named('main_new'));	
// output(liens_main_o,named('liens_main_o'));
// output(liens_party_o,named('liens_party_o'));

ENDMACRO;