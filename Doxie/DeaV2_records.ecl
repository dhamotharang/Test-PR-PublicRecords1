import doxie, business_header, doxie_raw, doxie_cbrs;

//pull from the main and search DEAV2 files

EXPORT DeaV2_records (DATASET (Doxie.layout_references) dids) := FUNCTION

  // I'm not making [bdid] as an input parameter, since I hope to get rid of business search here all together.
  business_header.doxie_mac_field_declare(, false);
  // replace with doxie.MAC_Header_Field_Declare (, false), when and if business search is disabled

  bdids := if (comp_name_value != '' or fein_value != 0, 
               business_header.doxie_get_bdids(TRUE),
		           dataset([{(integer)bdid_value}],doxie_cbrs.layout_references) (bdid != 0));

  raw := doxie_raw.DeaV2_raw(dids,bdids,,dppa_purpose, glb_purpose, ssn_mask_val, application_type_value);
	
  RETURN raw;
END;
