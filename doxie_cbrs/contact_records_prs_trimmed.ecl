IMPORT doxie_cbrs;

doxie_cbrs.mac_Selection_Declare()

EXPORT contact_records_prs_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

  outrec := doxie_cbrs.layout_contact.slim_rec_with_titles;
  contact_recs := doxie_cbrs.contact_records_standardized(bdids)(Include_AssociatedPeople_val);
  MAX_TITLES := doxie_cbrs.layout_contact.MAX_TITLE_RECS;

  contacts_w_did_rolled := ROLLUP(GROUP(SORT(contact_recs(did != 0),did),did),GROUP,TRANSFORM(outrec,
    SELF.company_titles := PROJECT(
        CHOOSEN(DEDUP(SORT(rows(LEFT)(company_title != ''),company_title,bdid),company_title,bdid), MAX_TITLES),
      doxie_cbrs.layout_contact.company_title_rec);
    SELF.dt_last_seen := MAX(rows(LEFT),dt_last_seen);
    SELF.ssn := MAX(rows(LEFT)((UNSIGNED)ssn != 0),ssn);
    SELF := LEFT));

  contacts_wo_did_rolled := ROLLUP(GROUP(SORT(contact_recs(did = 0),lname,fname,mname),lname,fname,mname),GROUP,TRANSFORM(outrec,
    SELF.company_titles := PROJECT(
        CHOOSEN(DEDUP(SORT(rows(LEFT)(company_title != ''),company_title,bdid),company_title,bdid), MAX_TITLES),
      doxie_cbrs.layout_contact.company_title_rec);
    SELF.dt_last_seen := MAX(rows(LEFT),dt_last_seen);
    SELF.ssn := MAX(rows(LEFT)((UNSIGNED)ssn != 0),ssn);
    SELF := LEFT));

  contacts_slimmed := contacts_w_did_rolled + contacts_wo_did_rolled;

  // Suppress.MAC_Mask(contacts_all_rolled,contacts_slimmed,ssn,null,true,false);

  SHARED sorted_contacts := SORT(contacts_slimmed,lname,fname,mname,IF(did != 0,0,1),-dt_last_seen);

  EXPORT records := CHOOSEN(sorted_contacts, Max_AssociatedPeople_val);
  EXPORT records_count := COUNT(sorted_contacts);

END;
