IMPORT BIPV2;
IMPORT BIPV2_Contacts;
IMPORT _Control;
IMPORT Header_Crosswalk;

EXPORT proc_build_lexid_seleid(STRING str_version, BOOLEAN should_promote = TRUE) := FUNCTION

  // Stage 1) Get lexid_seleid dependencies
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(
    DATASET([], BIPV2_Contacts.Layouts.contact_linkids.layoutOrigFile),
    key_contacts, 
    '~foreign::' + _Control.IPAddress.prod_thor_dali + '::thor_data400::key::bipv2::business_header::qa::contact_linkids'
  );

  ds_contacts := PROJECT(PULL(key_contacts), BIPV2_Contacts.Layouts.contact_linkids.layoutOrigFile);

  // Stage 2) Call fn_lexid_seleid
  ds_lexid_seleid := Header_Crosswalk.fn_lexid_seleid(ds_contacts) : INDEPENDENT;

  // Stage 3) Build and promote indexes
  RETURN PARALLEL(
    Header_Crosswalk.mac_build_and_promote(
      ds_lexid_seleid,
      lexid_2_seleid,
      str_version,
      should_promote
    );
    Header_Crosswalk.mac_build_and_promote(
      ds_lexid_seleid,
      seleid_2_lexid,
      str_version,
      should_promote
    );
  );

END;