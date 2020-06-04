//former: Gong_Neustar.Key_History_HHID
IMPORT $;

rec := $.layouts.i_history_hhid;

keyed_fields := RECORD
  rec.s_hhid;
  rec.current_flag;
  rec.business_flag;
END;

EXPORT key_history_hhid (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_history_hhid);