import doxie;

layout_death_master := recordof(doxie.key_death_masterV2_ssa_DID);

export layout_death := RECORD
  boolean is_deceased;
  layout_death_master;
END;