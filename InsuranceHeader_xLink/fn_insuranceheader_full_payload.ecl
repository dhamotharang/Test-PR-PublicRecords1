IMPORT Doxie;
IMPORT Header;
IMPORT IDL_Header;
IMPORT LocationID_xLink;

// Generate BOCA InsuranceHeader Payload from @ds_boca_prekey and @ds_alpha_header.
EXPORT DATASET(InsuranceHeader_xLink.layout_insuranceheader_payload) fn_insuranceheader_full_payload(DATASET(RECORDOF(Doxie.header_pre_keybuild)) ds_boca_prekey, DATASET(IDL_Header.Layout_Header_Link) ds_alpha_header) := FUNCTION

  // Stage 1) Pre-process @ds_boca_header
  ds_boca_header_preprocessed := header.fn_persistent_record_ID(ds_boca_prekey);

  // Stage 2) Pre-process @ds_alpha_header
  ds_alpha_header_preprocessed := ds_alpha_header(
    src[1..3]='ADL'
  );

  // Stage 3) Add Metadata and remaining fields.
  ds_payload := PROJECT(ds_boca_header_preprocessed, TRANSFORM(InsuranceHeader_xLink.layout_insuranceheader_payload,
    // Hardcoded metadata, check c00d5a8568bf9c3caee5524e276cf07dfc303974
    SELF.DT_EFFECTIVE_FIRST := 20160101;
    SELF.DT_EFFECTIVE_LAST := 0;

		SELF.locid := 0;

    SELF := LEFT;
  ));
	
	// Stage 4) Add LocationID
	LocationID_xLink.Append(ds_payload,
		prim_range, 
		predir,
		prim_name,
		suffix,
		postdir,
		sec_range,
		city_name,
		st,
		zip,
	ds_payload_locid);

  // Stage 5) Apply suppression
  RETURN header.fn_suppress_ccpa(ds_payload_locid, suppressIt := TRUE);

END;