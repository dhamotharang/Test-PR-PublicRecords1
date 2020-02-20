//former: Gong_Neustar.Key_History_npa_nxx_line
IMPORT $;

rec := $.layouts.i_history_npa_nxx_line;

keyed_fields := RECORD
  rec.npa;
  rec.nxx;
  rec.line;
  rec.current_flag;
  rec.business_flag;
END;

EXPORT key_history_npa_nxx_line (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_history_npa_nxx_line);
