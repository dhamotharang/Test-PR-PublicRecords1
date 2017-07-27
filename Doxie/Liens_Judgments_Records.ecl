IMPORT doxie, doxie_crs, LiensV2_Services;

// FCRA: non-FCRA attribute.

EXPORT Liens_Judgments_Records (
  DATASET (doxie.layout_references) dids, 
  string1 in_party_type = ''
	) := FUNCTION

  // GET A FLAT VERSION OF THE NEW DATA
  doxie.MAC_Header_Field_Declare();

  mv := LiensV2_Services.liens_raw.moxie_view.by_did (dids, ssn_mask_value, in_party_type, true);
 
  // KEEP ONLY THE DEBTORS FOR MY DID AND KEEP ALL CREDITORS
  mymv := join (mv(name_type = 'D'), dids, 
                (unsigned6)left.did = right.did, 
                TRANSFORM (RECORDOF(mv), self := left)) +
          mv(name_type = 'C');
 

  // GENTLY PLACE THE NEW DATA INTO THE OLD LAYOUT
  ds_backward := doxie.Fn_LienBackwards(mymv); 

  // KEEP ONLY THE FIELDS I NEED HERE AND DEDUP
  rec := doxie_crs.layout_Liens_Judgments_records;
  res := DEDUP(PROJECT(ds_backward, rec), all);

  RETURN IF (JudgmentLienVersion in [0,1], res);
END;