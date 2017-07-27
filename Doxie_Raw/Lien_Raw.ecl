//============================================================================
// Attribute: Lien_Legacy_Raw. 
// Function to get lienV2 records by did and map them back into Liens V1 format (legacy).
// Return value: Dataset with layout bankrupt.Layout_Liens.
//============================================================================

import ut, doxie, Bankrupt, suppress, LiensV2_Services;

export Lien_Raw(
    dataset(Doxie.layout_references) dids,
    dataset(Doxie.Layout_ref_bdid) bdids,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
    boolean	is_crs = false,
    string20  fname_val = '',
    string20  mname_val = '',
    string20  lname_val = '',
    string2   state_val = '',
    string17  case_number_val = '',
    string120 comp_name_value = '',
    unsigned6 bdid_value = 0,
    string6 ssn_mask_value = 'NONE',
		string1 in_party_type = ''
) := FUNCTION

// KLL -- most of the following swiped from doxie\Liens_Judgments_Records and modified as needed

//***** GET A FLAT VERSION OF THE NEW DATA
mv := LiensV2_Services.liens_raw.moxie_view.by_did (dids, ssn_mask_value, in_party_type, isReport := true);

// Passing in the isReport Value as true, hardcoded, because it is the same implementation for doxie\Liens_Judgments_Records
// this code was taken from that attribute as metioned above.
 
//***** KEEP ONLY THE DEBTORS FOR MY DID AND KEEP ALL CREDITORS
mymv := join (mv(name_type = 'D'), dids, 
                  (unsigned6)left.did = right.did, 
                  transform (recordof(mv), self := left)) +
            mv(name_type = 'C');
 

//***** GENTLY PLACE THE NEW DATA INTO THE OLD LAYOUT
ds_backward := doxie.Fn_LienBackwards(mymv); 

//***** KEEP ONLY THE FIELDS I NEED HERE AND DEDUP
rec := bankrupt.Layout_Liens;
res := dedup(project(ds_backward, rec), all);

srt_f_out := sort(res, whole record);

doxie.MAC_PruneOldSSNs(srt_f_out, srt_f_out_p1, orig_ssn, did);
doxie.MAC_PruneOldSSNs(srt_f_out_p1, srt_f_out_p2, ssn_appended, did);
suppress.MAC_Mask(srt_f_out_p2, out_intm, orig_ssn, blank, true, false);
suppress.MAC_Mask(out_intm, out_mskd, ssn_appended, blank, true, false);

return out_mskd;

END;