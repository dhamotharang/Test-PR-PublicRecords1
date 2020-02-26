//former: DayBatchEda.Key_gong_batch_czsslf
IMPORT $;

rec := $.layouts.i_czsslf;

keyed_fields := RECORD
  rec.p_city_name;
  rec.z5;
  rec.prim_name;
  rec.prim_range;
  rec.name_last;
  rec.name_first;
END;

EXPORT key_czsslf (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_czsslf);