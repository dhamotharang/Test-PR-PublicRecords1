/*2012-05-10T19:28:36Z (Vladimir  Myullyari)
code review: #101904
*/
IMPORT UCCV2, UCCv2_Services, FCRA, doxie, ut;

boolean IsFCRA := true;

// I'd prefer to use a record struct, but there's no any available.
rec_party := recordof (UCCV2.key_rmsid_party (true)); // ~~ UCCV2.layout_UCC_common.layout_party_with_AID;

// returns UCC party and main data by DID
export _UCC_data (dataset (doxie.layout_references) in_dids, 
                  dataset (fcra.Layout_override_flag) flag_file,
                  string1 in_party_type = '') := MODULE

  // UCC data has compound internal id: tmsid + rmsid
  // we also need to ensure that we return records only for the input subject(s)
  shared rec_tmsid_rmsid_did := record
    layouts.didslim.did;
    UCCv2_Services.layout_rmsid;
  end;
  shared t_tmsid := typeof (rec_tmsid_rmsid_did.tmsid);
  shared t_rmsid := typeof (rec_tmsid_rmsid_did.rmsid);

  // get internal IDs
  shared ids := join (in_dids, uccv2.key_did_w_Type (IsFCRA),
                      keyed (left.did = right.did) and
                      keyed (in_party_type='' or right.party_type=in_party_type),
                      transform (rec_tmsid_rmsid_did, self := right),
                      limit (1000, skip));


  // Get parties
  // party's corrections qualifiers
  _party_puids := SET (flag_file (file_id = FCRA.FILE_ID.UCC_PARTY), record_id);
  _party_ffid  := SET (flag_file (file_id = FCRA.FILE_ID.UCC_PARTY), flag_file_id);

  party_data := join (ids, UCCV2.Key_Rmsid_Party (IsFCRA),
                      keyed (left.tmsid = right.tmsid) and
                      keyed (left.rmsid = right.rmsid) and
                      left.did = right.did and
                      // exclude corrected records
                      ((string)right.persistent_record_id not in _party_puids),
                      transform (rec_party, Self := Right),
                      limit (10000, skip));

  // overrides
  party_override := CHOOSEN (fcra.key_override_ucc.party (keyed (flag_file_id IN _party_ffid)), FCRA.compliance.MAX_OVERRIDE_LIMIT);
  // put overrides into same layout, combine main data and overrides; TODO: apply FCRA-filtering
  party_override_st := project (party_override, rec_party);
  shared _party := party_data + party_override_st;

  // note: no pulling as on the regular Roxie query

  // Fetch main records
  // main record's corrections qualifiers
  _main_puids := SET (flag_file (file_id = FCRA.FILE_ID.UCC), record_id);
  _main_ffid  := SET (flag_file (file_id = FCRA.FILE_ID.UCC), flag_file_id);

  // need only tmsids
  party_tmsids := dedup (sort (project (_party, UCCv2_services.layout_rmsid), tmsid), tmsid);
  main_data := join (party_tmsids, UCCV2.Key_Rmsid_Main (IsFCRA),
                     keyed(left.tmsid = right.tmsid) and
                     ((string)right.persistent_record_id not in _main_puids),
                     transform (UCCV2.layout_UCC_common.layout_ucc_new, Self := Right),
                     limit (10000, skip));

  // overrides
  main_override := CHOOSEN (fcra.key_override_ucc.main (keyed (flag_file_id IN _main_ffid)), FCRA.compliance.MAX_OVERRIDE_LIMIT);
  // put overrides into same layout, combine main data and overrides;
  main_override_st := project (main_override, UCCV2.layout_UCC_common.layout_ucc_new);
  EXPORT main := (main_data + main_override_st) (fcra.compliance.ucc.is_ok (ut.GetDate, orig_filing_date));

  // final join is necessary: main file can be filtered by orig_filing_date, which is absent in party file.
  EXPORT party := join (_party, main, 
                        Left.tmsid = Right.tmsid,
                        transform (rec_party, Self := Left),
                        keep (1), limit (0));

END;
