orphan_candi_rec := RECORD
  string20 datagroup{xpath('Datagroup')};
  string12 lexid{xpath('LexId')};
  string recid_;
  boolean issuppressed_;
  boolean isoverride_;
  boolean isoverwritten_;
 END;

orphan_candidates := dataset('~thor_data400::persist::override_orphan_candidates', orphan_candi_rec, flat);

Overrides.MAC_read_override_base('Proflic_Mari',ProfLicenseMariRecIDs,flag_file_id,did,persistent_record_id);

override_base_rec := RECORD
  string20 datagroup;
  string20 flag_file_id;
  string12 did;
  string100 recid;
  string100 recid1;
  string100 recid2;
  string100 recid3;
  string100 recid4;
 END;
 
override_base := dataset('~thor_data400::persist::override_basefileIDs',override_base_rec, flat);

orphans_ds := ProfLicenseMariRecIDs((unsigned)did in [6152711847, 1963729999]);
//orphans_ds;
//overrides.payload_Keys.proflic_mari((unsigned)s_did in [6152711847, 1963729999]);

//orphans_ds;
overrides.mac_orphans_evaluate(proflic_mari,'mari',orphans_ds,dsout_mari,,did,persistent_record_id,,,,fname,lname,bus_prim_range, bus_prim_name, bus_zip5);
//dsout_mari;
FCRA.File_flag(FILE_ID = fcra.FILE_ID.MARI and record_id = '17044840745217544246');