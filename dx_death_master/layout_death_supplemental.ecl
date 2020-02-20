import death_master;

layout_death_master_supplemental := recordof(death_master.key_death_id_supplemental_ssa);

export layout_death_supplemental := RECORD
  layout_death_master_supplemental;
END;