//former: DayBatchEda.Key_gong_phone

IMPORT data_services;
IMPORT $;

rec := $.layouts.i_phone;

keyed_fields := RECORD
  rec.ph7;
  rec.ph3;
  rec.st;
  rec.business_flag;
END;


EXPORT key_phone (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_phone);
