//former: Gong_Neustar.Key_History_companyname
IMPORT $;

rec := $.layouts.i_history_companyname;

keyed_fields := RECORD
  rec.listed_name_new;
  rec.st;
  rec.p_city_name;
  rec.current_flag;
END;

EXPORT key_history_companyname (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_history_companyname);
