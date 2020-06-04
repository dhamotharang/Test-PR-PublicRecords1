//former: Gong_Neustar.Key_GongScoringAttributes

IMPORT data_services;
IMPORT $;

rec := $.layouts.i_scoring_attributes;

keyed_fields := RECORD
  rec.phone10;
  rec.fsn;
END;


EXPORT key_scoring_attributes (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_scoring_attributes);
