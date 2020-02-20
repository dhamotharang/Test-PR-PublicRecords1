//former: Gong_Neustar.Key_History_Wild_name_zip
IMPORT $;

rec := $.layouts.i_history_wild_name_zip;

keyed_fields := RECORD
  rec.name_last;
  rec.st;
  rec.name_first;
  rec.zip5;
END;

EXPORT key_history_wild_name_zip (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_history_wild_name_zip);
