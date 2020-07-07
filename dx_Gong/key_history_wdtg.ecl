//former: Gong_Neustar.Key_wdtgGong
IMPORT $;

rec := $.layouts.i_history_wdtg;

keyed_fields := RECORD
  rec.dph_name_last;
  rec.dt_first_seen;
  rec.zip5;
  rec.p_name_first;
  rec.name_last;
  rec.name_first;
END;

EXPORT key_history_wdtg (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_history_wdtg);
