myrec := record
  unsigned6 did; 
  unsigned2 sex_cnt;
  unsigned2 crim_cnt;
  unsigned2 ccw_cnt;
  unsigned2 head_cnt;
  unsigned2 veh_cnt;
  unsigned2 dl_cnt;
  unsigned2 rel_count;
  unsigned2 fire_count;
  unsigned2 faa_count;
  unsigned2 vess_count;
  unsigned2 prof_count;
  unsigned2 bus_count;
  unsigned2 prop_count;
  unsigned2 bk_count;
  unsigned2 prop_asses_count;
  unsigned2 prop_deeds_count;
  unsigned2 paw_count;
  unsigned2 bc_count;
end;

export File_Lookups := dataset('~thor_data400::base::doxie_lookups',myrec,flat);
