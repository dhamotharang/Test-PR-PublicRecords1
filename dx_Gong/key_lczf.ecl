//former: DayBatchEda.Key_gong_batch_lczf
IMPORT $;

rec := $.layouts.i_lczf;

keyed_fields := RECORD
  rec.name_last;
  rec.p_city_name;
  rec.z5;
  rec.name_first;
END;

EXPORT key_lczf (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_lczf);
