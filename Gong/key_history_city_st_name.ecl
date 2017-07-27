import doxie, gong, NID;

hist_in := Gong.File_History_Full_Prepped_for_Keys(trim(p_city_name)<>'', name_last<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

hist_out_new_rec := record
		hist_out;
		string25 city_name;
end;

hist_out_new := project(hist_out, transform(hist_out_new_rec, self.city_name:=left.p_city_name, self:=left)) + 
                project(hist_out(p_city_name<>v_city_name), transform(hist_out_new_rec, self.city_name:=left.v_city_name, self:=left));

Export key_history_city_st_name := 
       index(hist_out_new,
			       {unsigned4 city_code := HASH((qstring25)city_name);
	            st,
						  string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
						  name_last,
						  string20 p_name_first := NID.PreferredFirstVersionedStr(name_first, NID.version),
						  name_first},
              {hist_out_new},
		          '~thor_data400::key::gong_history_city_st_name_'  + doxie.Version_SuperKey);
  