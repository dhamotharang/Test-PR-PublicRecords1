// DCA: Directory of Corporate Affiliations - Profile Information on Private and Public Companies
// Returns a dataset from the bdid key, with the option to include contacts.
// Contacts are currently rolled into the bdid key from the data build.
// In order to support opt-out suppression a new key was created for contacts.
// This macro replaces the contacts with opt-out compliant data from a suppressable contact key.
// This macro does not append data, it only returns an opt-out compliant dataset in the layout of the key.
IMPORT doxie;

EXPORT get_bdid(ds_in, mod_access = MODULE (doxie.IDataAccess) END,
  bdid_field = 'bdid', add_contacts = FALSE, contact_did_filter = 0) := FUNCTIONMACRO

IMPORT DCA, DCAV2, Suppress, ut;

  // Grab BDID data and remove contacts, they are not opt-out compliant.
  dd_ds_in := DEDUP(SORT(ds_in(bdid_field <> 0), bdid_field), bdid_field);

  ds_bdid_no_contacts := JOIN(dd_ds_in, DCA.Key_DCA_BDID,
    KEYED(LEFT.bdid_field = RIGHT.bdid),
    dx_dca.Transforms.remove_contacts(RIGHT),
    KEEP(ut.limits.MAX_DCA_PER_BDID), LIMIT(0));

  // Grab contacts by matching bdid and enterprise_num, and suppress
  ds_bdid_enterprise_num := PROJECT(ds_bdid_no_contacts,
    {DCA.Layout_DCA_Base_slim.bdid, DCA.Layout_DCA_Base_slim.Enterprise_num});

  dd_ds_bdid_enterprise_num := DEDUP(SORT(ds_bdid_enterprise_num, bdid, enterprise_num),
    bdid, enterprise_num);

  ds_contacts_raw := JOIN(dd_ds_bdid_enterprise_num, DCAV2.Keys().ContactBdid.QA,
    KEYED(LEFT.bdid = RIGHT.bdid) AND
    LEFT.enterprise_num = RIGHT.rawfields.enterprise_num AND
    (contact_did_filter = 0 OR contact_did_filter = RIGHT.did),
    TRANSFORM(RIGHT), KEEP(ut.limits.MAX_DCA_CHILDREN_PER_LEVEL), LIMIT(0));

  ds_contacts_suppressed := Suppress.MAC_SuppressSource(ds_contacts_raw, mod_access);

  // Join contacts against bdid + enterprise num, sorted by newest and deduped
  dd_contacts := DEDUP(SORT(ds_contacts_suppressed,
    bdid, rawfields.enterprise_num, did, -date_vendor_last_reported),
    bdid, rawfields.enterprise_num, did);

  // Keep suppressed contact data in first field.
  // Only keep 10 since there are only 10 fields for these.
  bdid_w_contacts_raw := JOIN(ds_bdid_no_contacts, dd_contacts,
    LEFT.bdid = RIGHT.bdid AND
    LEFT.enterprise_num = RIGHT.rawfields.enterprise_num,
    TRANSFORM(dx_dca.Layouts.dca_bdid_rollup_layout,
      // Populate first contact for rollup.
      ds_contact := DATASET([{
        RIGHT.rawfields.executive.name, RIGHT.rawfields.executive.title, RIGHT.rawfields.executive.code,
        RIGHT.clean_name.title, RIGHT.clean_name.fname, RIGHT.clean_name.mname,
        RIGHT.clean_name.lname, RIGHT.clean_name.name_suffix, RIGHT.clean_name.name_score}],
        dx_dca.Layouts.contact_layout);

      SELF.contacts := ds_contact,
      SELF := LEFT), LEFT OUTER, KEEP(10), LIMIT(0));

  ds_bdid_w_contacts_rolled := ROLLUP(bdid_w_contacts_raw,
    LEFT.bdid = RIGHT.bdid AND LEFT.enterprise_num = RIGHT.enterprise_num, dx_dca.Transforms.rollup_contacts(LEFT, RIGHT));

  // Convert back to original key form, dropping seq_no and filling in the flat contact fields.
  ds_bdid_final := PROJECT(IF(add_contacts,
    ds_bdid_w_contacts_rolled, ds_bdid_no_contacts),
    dx_dca.Transforms.flatten_contacts(LEFT));

  RETURN ds_bdid_final;

ENDMACRO;
