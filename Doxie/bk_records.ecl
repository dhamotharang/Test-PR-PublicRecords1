import doxie, business_header, Doxie_Raw, FCRA, bankrupt;

//pull from the main and search bankruptcy files

EXPORT bk_records (
  DATASET (doxie.layout_references) dids,
	string1 in_party_type = '',
	boolean isReport = false) := FUNCTION

business_header.doxie_mac_field_declare();

string7 cnum := CaseNumber_value;
string5  ccode := '' : stored('CourtCode');

// bdids are not used for fcra-purposes (always empty: fcra is about a person)
bdids := if (comp_name_value != '' or fein_value != 0, 
                      business_header.doxie_get_bdids(TRUE), dataset ([], Doxie.Layout_ref_bdid) +
                  dataset([{(integer)bdid_value}], Doxie.Layout_ref_bdid) (bdid != 0));

raw := Doxie_Raw.bk_raw (dids, bdids,
    cnum, ccode, dateVal, dppa_purpose, glb_purpose, ssn_mask_value, in_party_type, isReport);
			
RETURN raw;
END;