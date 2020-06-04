//former: Gong_Neustar.Key_History_Zip_name
IMPORT $;

rec := $.layouts.i_history_zip_name;

keyed_fields := RECORD
  rec.dph_name_last;
  rec.zip5;
  rec.p_name_first;
  rec.name_last;
  rec.name_first;
END;

EXPORT key_history_zip_name (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_history_zip_name);
