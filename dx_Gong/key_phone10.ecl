//former: DayBatchEda.Key_gong_phone

IMPORT data_services;
IMPORT $;

rec := $.layouts.i_phone10;


EXPORT key_phone10 (integer data_category = 0) := 
         INDEX ({rec.phone10}, {rec}, $.names().i_phone10);
