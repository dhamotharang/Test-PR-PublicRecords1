//former: Gong.key_surname_count

IMPORT data_services;
IMPORT $;

rec := $.layouts.i_surname_count;

keyed_fields := RECORD
  rec.name_last;
END;


EXPORT key_surname_count (integer data_category = 0) :=
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_surname_count);
