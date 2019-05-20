import watercraft, doxie, fcra, ut, Suppress, mdr, STD;

boolean IsFCRA := true;
MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;
nss_const := Suppress.Constants.NonSubjectSuppression;

// NOTE: function is not "batch-safe": if multiple DIDs ever going to be passed as an input,
// then correction records from the FlagFile should be checked for each DID individually.
// Right now there's no need to account for that.

// The above comment may have been stated to handle the unlikely scenario where 2 DIDs are listed as owners of the watercraft but only
// one of them corrected their record. He should be the only one with the corrected record. As long as you join by DID 
// before displaying your output then it will guarantee that only the valid DID will get the corrected record.

EXPORT _watercraft_data (dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file,
                         integer nss = nss_const.doNothing     , unsigned1 year_limit = 0) := MODULE

  // =========== SID -- party's info (aka "owner", or "search", or "main watercraft data") ===========
  
  // get watercrafts' IDs by DID (i.e. all watercrafts associated with a subject)
  key_did := watercraft.key_watercraft_did (true);
  export ids := join (dids, key_did,
                      left.did<>0 and keyed (left.did=right.l_did),
                      transform (recordof (key_did), self := right),
                      KEEP (ut.limits.WATERCRAFT_PER_DID), LIMIT (1000));

  // get owners' info
  key_sid := watercraft.key_watercraft_sid (true);
  rec_owner := recordof (key_sid);

  ffids_sid   := SET (flag_file (file_id = FCRA.FILE_ID.WATERCRAFT), flag_file_id);
  seqkey_sid  := SET (flag_file (file_id = FCRA.FILE_ID.WATERCRAFT), record_id);

  // primitive test for being not a person
  boolean NotAPerson (string did, string bdid, string fein, string company_name) :=
    (did = '') and ((bdid != '') or (fein != '') or (company_name != ''));

  // Transform is capable of applying non-subject suppression
  rec_owner GetOwners (ids L, key_sid R) := function
    boolean IsSubject := (L.l_did = (unsigned6) R.did);
    boolean is_allowed := IsSubject or NotAPerson (R.did, R.bdid, R.fein, R.company_name);
    
    rec_owner mTransf := transform, SKIP ( (nss = nss_const.returnBlank) and ~is_allowed)
        boolean do_blank_nss := ~IsSubject and (nss = nss_const.returnRestrictedDescription);
      
      Self.watercraft_key := L.watercraft_key;
      Self.state_origin   := L.state_origin;
      Self.sequence_key   := L.sequence_key;
      
      Self.lname := if (do_blank_nss, FCRA.Constants.FCRA_Restricted, R.lname);    
      Self := if (~do_blank_nss, R);
    end; 
    return mTransf;
  end;

  owners_raw := join (ids, key_sid,
                      keyed (left.state_origin   = right.state_origin) and
                      keyed (left.watercraft_key = right.watercraft_key) and
                      keyed (left.sequence_key   = right.sequence_key) and
                      (string) right.persistent_record_id not in seqkey_sid // new method
                      // to ensure backwards compatibility (shall be removed soon):
                      and trim(right.watercraft_key)+trim(right.sequence_key) not in seqkey_sid,
                      GetOwners (Left, Right),
                      LIMIT(ut.limits.OWNERS_PER_WATERCRAFT, SKIP));

  owners_over := choosen (FCRA.Key_Override_Watercraft.sid (keyed (flag_file_id in ffids_sid)), MAX_OVERRIDE_LIMIT);
  owners_corrected := owners_raw + PROJECT (owners_over, transform (rec_owner, self := LEFT));
	
	owners1 := sort(owners_corrected, -date_last_seen, -date_first_seen);		
	
	// translate the source code to be the header source code so it can be found in the vendor lookup service
	owners2 := project(owners1, transform(rec_owner, self.source_code := mdr.sourcetools.fWatercraft(left.Source_Code, left.State_Origin), self := left));

	todaysdate := (string) STD.Date.Today();
	//if called from benefitassessment_batchservicefcra, we only want records from the last 7 years
	owners_filtered := owners2(ut.fn_date_is_ok(todaysdate, date_last_seen, year_limit));

	EXPORT owners := if(year_limit=0, owners2, owners_filtered);

  // ================= CID, coastguard data =================
  key_cid := watercraft.key_watercraft_cid (true);
  layout_cid := recordof (key_cid);
  
  ffids_cid     := SET (flag_file(file_id = FCRA.FILE_ID.WATERCRAFT_COASTGUARD), flag_file_id);
  seqkey_cid    := SET (flag_file(file_id = FCRA.FILE_ID.WATERCRAFT_COASTGUARD), record_id);

  cid_raw := join (ids, key_cid,
                   keyed (left.state_origin   = right.state_origin) and
                   keyed (left.watercraft_key = right.watercraft_key) and
                   keyed (left.sequence_key   = right.sequence_key) and
                   (string)right.persistent_record_id not in seqkey_cid // new method
                   // to ensure backwards compatibility (shall be removed soon):
                   and trim(right.watercraft_key)+trim(right.sequence_key) not in seqkey_cid,
                   transform (layout_cid, self := right ),
                   LIMIT (ut.limits.MAX_COASTGUARD_PER_WATERCRAFT, skip));

  cid_over := choosen (FCRA.key_override_watercraft.cid (keyed (flag_file_id in ffids_cid)), MAX_OVERRIDE_LIMIT);
  cid_corrected := cid_raw + PROJECT (cid_over, transform (layout_cid, self := LEFT));

  coastguard1 := sort(cid_corrected, -date_expires, -date_issued);
	// translate the source code to be the header source code so it can be found in the vendor lookup service
	EXPORT coastguard := project(coastguard1, transform(layout_cid, self.source_code := mdr.sourcetools.fWatercraft(left.Source_Code, left.State_Origin), self := left));


  // ================= WID, watercrafts' details =================
  key_wid := watercraft.key_watercraft_wid (true);
  layout_wid := recordof(key_wid);

  ffids_wid  := SET (flag_file (file_id = FCRA.FILE_ID.WATERCRAFT_DETAILS), flag_file_id);
  seqkey_wid := SET (flag_file (file_id = FCRA.FILE_ID.WATERCRAFT_DETAILS), record_id);

  wid_raw := join (ids, key_wid,
                   keyed (left.state_origin   = right.state_origin) and
                   keyed (left.watercraft_key = right.watercraft_key) and
                   keyed (left.sequence_key   = right.sequence_key) and
                   (string)right.persistent_record_id not in seqkey_wid // new method
                   // to ensure backwards compatibility (shall be removed soon):
                   and trim(right.watercraft_key)+trim(right.sequence_key) not in seqkey_wid,
                   transform (layout_wid, self := right),
                   LIMIT (ut.limits.MAX_DETAILS_PER_WATERCRAFT, SKIP));

  wid_over := choosen (FCRA.key_override_watercraft.wid (keyed (flag_file_id in ffids_wid)), MAX_OVERRIDE_LIMIT);
	
	details1 := wid_raw + PROJECT (wid_over, transform (layout_wid, self := LEFT));
	// translate the source code to be the header source code so it can be found in the vendor lookup service
	EXPORT details := project(details1, transform(layout_wid, self.source_code := mdr.sourcetools.fWatercraft(left.Source_Code, left.State_Origin), self := left));

END;

