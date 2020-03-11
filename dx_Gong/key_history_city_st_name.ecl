//former: Gong_Neustar.Key_History_City_St_name
IMPORT $;

rec := $.layouts.i_history_city_st_name;

keyed_fields := RECORD
  rec.city_code;
  rec.st;
  rec.dph_name_last;
  rec.name_last;
  rec.p_name_first;
  rec.name_first;
END;

EXPORT key_history_city_st_name (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_history_city_st_name);
