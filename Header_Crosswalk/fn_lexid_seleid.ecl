IMPORT dx_Header_Crosswalk;
IMPORT BIPV2_Contacts;
IMPORT IDLExternalLinking;

/*
  - Given a list of BIP @ds_contacts, identifies a 1:Many relationship between lexid and seleid
*/
EXPORT DATASET(dx_Header_Crosswalk.Layouts.lexid_2_seleid) fn_lexid_seleid(
  DATASET(BIPV2_Contacts.Layouts.contact_linkids.layoutOrigFile) ds_contacts
) := FUNCTION

  // Stage 1) Find unique (seleid,lexid) available from contacts key
  ds_contacts_with_did := DEDUP(SORT(ds_contacts(seleid > 0, contact_did > 0), seleid, contact_did), seleid, contact_did);

  ds_available_contacts_did := PROJECT(ds_contacts_with_did, TRANSFORM(dx_Header_Crosswalk.Layouts.lexid_2_seleid,
    SELF.lexid := LEFT.contact_did;
    SELF.seleid := LEFT.seleid;
  ));

  // Stage 2) Append did to records missing contact_did information
  str_pii := 'contact_name.name_suffix, contact_name.fname, contact_name.mname, contact_name.lname, contact_dob,contact_ssn,contact_phone';
  ds_append_input := DEDUP(SORT(ds_contacts(seleid > 0, contact_did = 0), seleid, #EXPAND(str_pii)), seleid, #EXPAND(str_pii));

  IDLExternalLinking.mac_xLinking_on_thor_Boca(
    ds_append_input, contact_did,
    Input_SNAME := contact_name.name_suffix,
    Input_FNAME := contact_name.fname,
    Input_MNAME := contact_name.mname,
    Input_LNAME := contact_name.lname,
    Input_DOB := contact_dob,
    Input_SSN := contact_ssn,
    Input_Phone := contact_phone,
    OutFile := ds_new_contacts_did
  );

  ds_appended_contacts_did := PROJECT(ds_new_contacts_did, TRANSFORM(dx_Header_Crosswalk.Layouts.lexid_2_seleid,
    SKIP(LEFT.contact_did = 0); // Remove records that failed to get a lexid
    SELF.lexid := LEFT.contact_did;
    SELF.seleid := LEFT.seleid;
  ));

  RETURN (+)(ds_available_contacts_did, ds_appended_contacts_did);

END;