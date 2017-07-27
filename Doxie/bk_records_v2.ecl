// Used as a part of a bigger reports

import doxie, business_header, Doxie_Raw;

//pull from the main and search bankruptcy files

EXPORT bk_records_v2 (
  DATASET (doxie.layout_references) dids, 
  DATASET (Doxie.layout_ref_bdid) ds_bdids = DATASET ([], Doxie.layout_ref_bdid),
	string1 in_party_type = '') := FUNCTION

business_header.doxie_mac_field_declare(, false);

// bdids are not used for fcra-purposes (always empty: fcra is about a person)
non_fcra_bdids := if (comp_name_value != '' or fein_value != 0, 
                      business_header.doxie_get_bdids(TRUE), dataset ([], Doxie.Layout_ref_bdid) +
                  dataset([{(integer)bdid_value}], Doxie.Layout_ref_bdid) (bdid != 0));

bdids := IF (EXISTS (ds_bdids), ds_bdids, non_fcra_bdids);
             
raw := Doxie_Raw.bkV2_raw (dids, bdids, , dateVal, ssn_mask_value, in_party_type);
			
RETURN raw;
END;
