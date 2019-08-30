import doxie;

layout_death_master := recordof(doxie.key_death_masterV2_ssa_DID);

export layout_death := RECORD
  boolean is_deceased;
  layout_death_master.did;
  layout_death_master.glb_flag;
  layout_death_master.dod8;
  layout_death_master.global_sid;
  layout_death_master.record_sid;
  // fields below are needed in fewer places.
  layout_death_master.dob8;
  layout_death_master.fname;
  layout_death_master.mname;
  layout_death_master.lname;
  layout_death_master.ssn;
  layout_death_master.county_name;
  layout_death_master.state;
  layout_death_master.vorp_code;
  layout_death_master.src;
  layout_death_master.state_death_id;
END;