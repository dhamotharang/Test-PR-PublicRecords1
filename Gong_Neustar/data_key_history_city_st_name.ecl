IMPORT $, dx_Gong, gong, NID;

hist_in := $.File_History_Full_Prepped_for_Keys(trim(p_city_name)<>'', name_last<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

hist_out_new_rec := record
  hist_out;
  string25 city_name;
end;

hist_out_new := project(hist_out, transform(hist_out_new_rec, self.city_name:=left.p_city_name, self:=left)) + 
                project(hist_out(p_city_name<>v_city_name), transform(hist_out_new_rec, self.city_name:=left.v_city_name, self:=left));

EXPORT data_key_history_city_st_name := 
          PROJECT(hist_out_new, TRANSFORM(dx_Gong.layouts.i_history_city_st_name, 
                                          SELF.city_code := HASH((qstring25)LEFT.city_name),
                                          SELF.dph_name_last := metaphonelib.DMetaPhone1(LEFT.name_last),
                                          SELF.p_name_first := NID.PreferredFirstVersionedStr(LEFT.name_first, NID.version),
                                          SELF := LEFT));