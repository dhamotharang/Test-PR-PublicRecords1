IMPORT DeathV2_Services, doxie, doxie_cbrs, dx_death_master, Suppress, ut;

EXPORT contact_records_prs_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

contact_recs := doxie_cbrs.contact_records_standardized(bdids)(Include_AssociatedPeople_val);

company_title_rec := RECORD
  contact_recs.company_title;
  contact_recs.bdid;
  contact_recs.company_name;
END;

contact_record_base := RECORD
  contact_recs.bdid;
  contact_recs.did;
  contact_recs.dt_last_seen;
  STRING9 ssn;
  contact_recs.fname;
  contact_recs.mname;
  contact_recs.lname;
  contact_recs.name_suffix;
  contact_recs.prim_range;
  contact_recs.predir;
  contact_recs.prim_name;
  contact_recs.addr_suffix;
  contact_recs.postdir;
  contact_recs.unit_desig;
  contact_recs.sec_range;
  contact_recs.city;
  contact_recs.state;
  STRING5 zip;
  STRING4 zip4;
END;

contact_record := RECORD
  contact_record_base OR company_title_rec;
END;

contact_rolled_rec := RECORD
  contact_record_base;
  DATASET(company_title_rec) company_titles {MAXCOUNT(25)};
END;

contacts_w_did_rolled := ROLLUP(GROUP(SORT(contact_recs(did != 0),did),did),GROUP,TRANSFORM(contact_rolled_rec,
  SELF.company_titles := PROJECT(CHOOSEN(DEDUP(SORT(rows(LEFT)(company_title != ''),company_title,bdid),company_title,bdid),25),company_title_rec),
  SELF.dt_last_seen := MAX(rows(LEFT),dt_last_seen),
  SELF.ssn := MAX(rows(LEFT)((UNSIGNED)ssn != 0),ssn),
  SELF := LEFT));

contacts_wo_did_rolled := ROLLUP(GROUP(SORT(contact_recs(did = 0),lname,fname,mname),lname,fname,mname),GROUP,TRANSFORM(contact_rolled_rec,
  SELF.company_titles := PROJECT(CHOOSEN(DEDUP(SORT(rows(LEFT)(company_title != ''),company_title,bdid),company_title,bdid),25),company_title_rec),
  SELF.dt_last_seen := MAX(rows(LEFT),dt_last_seen),
  SELF.ssn := MAX(rows(LEFT)((UNSIGNED)ssn != 0),ssn),
  SELF := LEFT));

contacts_slimmed := contacts_w_did_rolled + contacts_wo_did_rolled;

// Suppress.MAC_Mask(contacts_all_rolled,contacts_slimmed,ssn,null,true,false);

SHARED sorted_contacts := SORT(contacts_slimmed,lname,fname,mname,IF(did != 0,0,1),-dt_last_seen);

doxie_cbrs.mac_Selection_Declare()
                
EXPORT records := CHOOSEN(sorted_contacts,Max_AssociatedPeople_val);
EXPORT records_count := COUNT(sorted_contacts);

END;
