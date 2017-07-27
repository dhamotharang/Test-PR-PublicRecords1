//============================================================================
// Attribute: PL_Raw.  Used by view source service and comp-report.
// Function to get professional license records by did, bdid or license number.  Based on doxie/pl_records.
// Return value: Dataset of layout prof_license.layout_doxie.
//============================================================================

import Doxie, prof_license, ut, suppress,Prof_LicenseV2,codes, fcra;

export PL_Raw(
    dataset(Doxie.layout_references) dids,
	dataset(Doxie.Layout_ref_bdid) bdids,
    string20 li_num = '',
    unsigned4 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
    string6 ssn_mask_value = 'NONE',
    boolean IsFCRA = false,
    dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile
) := FUNCTION

key_did := prof_licenseV2.key_proflic_did (IsFCRA);

// overrides (FCRA-side only):
// generally, main content must be replaced (remove/skip, add) with the content found by IDs in the override key
// flag-file ID links all records for "this" person with proflic IDs, which must be overwritten.
proflic_ffids := SET (flagfile(file_id = FCRA.FILE_ID.PROFLIC), flag_file_id);
proflic_ids   := SET (flagfile(file_id = FCRA.FILE_ID.PROFLIC), record_id);


prof_license.layout_doxie xt(dids L,key_did R) := TRANSFORM
	self.did := (string12) R.did;
	self.source_st_decoded := codes.GENERAL.state_long(r.source_st);
	self.other_license_number := r.previous_license_number;
	self.other_license_type := r.previous_license_type;
	self.uniqueid := 'PL' + trim((string) r.prolic_seq_id,all);
	SELF := R;
END;

did_Fetched_row := join(dids,key_did,
                    keyed(left.did=right.did) and
										// remove ovewritable IDs
										(~IsFCRA or right.prolic_key not in proflic_ids),
                    xt(left,right), ATMOST (ut.limits.PROFLICENSE_PER_DID));

// add corrected records: 
// did-key is the only place where overwritable data is taken from (so far), 
// all fields are the same as in override-key, except prolic_seq_id 
proflic_new := CHOOSEN (FCRA.key_override_proflic_ffid (keyed (flag_file_id in proflic_ffids)), fcra.compliance.MAX_OVERRIDE_LIMIT);

proflic_corrected := project (proflic_new, transform (prof_license.layout_doxie, 
  // same transform as above
  Self.prolic_seq_id := 0,
  Self.source_st_decoded := codes.GENERAL.state_long(Left.source_st),
  Self.other_license_number := Left.previous_license_number,
  Self.other_license_type := Left.previous_license_type,
  Self.uniqueid := '',
  Self := Left));

did_Fetched := if (IsFCRA, did_Fetched_row + proflic_corrected, did_Fetched_row);

								

prof_license.layout_doxie xt2(bdids L,Prof_LicenseV2.Key_Proflic_Bdid R) := TRANSFORM
	self.source_st_decoded := codes.GENERAL.state_long(r.source_st);
	self.other_license_number := r.previous_license_number;
	self.other_license_type := r.previous_license_type;
	self.uniqueid := 'PL' + trim((string) r.prolic_seq_id,all);
	SELF := R;
END;

bdid_fetched := if (IsFCRA, 
                    dataset ([], prof_license.layout_doxie),
                    join(bdids,Prof_LicenseV2.Key_Proflic_Bdid,
                     keyed(left.bdid = right.bd),
                     xt2(LEFT,RIGHT), ATMOST (ut.limits.  PROFLICENSE_PER_BDID)));

by_license := limit (Prof_LicenseV2.Key_Proflic_Licensenum (li_num = s_license_number[1..length(trim(li_num))]),
                     50,FAIL(203,doxie.ErrorCodes(203)));

lnum_fetched := if (IsFCRA, 
                    dataset ([], prof_license.layout_doxie),
                    if (count(did_fetched) = 0 and count(bdid_fetched) = 0 and li_num != '',
                        project(by_license,	transform(prof_license.layout_doxie,
													self.source_st_decoded := codes.GENERAL.state_long(left.source_st),
													self.other_license_number := left.previous_license_number,
													self.other_license_type := left.previous_license_type,
													self.uniqueid := 'PL' + trim((string) left.prolic_seq_id,all),self := Left))));


fetched := dedup(sort(lnum_fetched + bdid_fetched + did_fetched, whole record), whole record);

outFile := sort(fetched,trim(license_number,all), expiration_date)
    (dateVal = 0 OR (unsigned3)(issue_date[1..6]) <= dateVal);

// cannot prune old SSNs on FCRA-side
doxie.MAC_PruneOldSSNs(outfile, outfile_pruned_reg, best_ssn, did);
outfile_pruned := if (IsFCRA, outFile, outfile_pruned_reg);
suppress.MAC_Mask(outFile_pruned, out_mskd, best_ssn, blank, true, false);					       

return out_mskd;
END;
