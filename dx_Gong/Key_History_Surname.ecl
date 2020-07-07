//former: Gong_Neustar.Key_History_Surname
IMPORT $;

rec := $.layouts.i_history_surname;

keyed_fields := RECORD
  rec.k_name_last;
  rec.k_name_first;
  rec.k_st;
END;

EXPORT key_history_surname (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_history_surname);
