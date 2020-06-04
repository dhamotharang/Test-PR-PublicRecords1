//former: Gong_Neustar.key_cn
IMPORT $;

rec := $.layouts.i_cn;

keyed_fields := RECORD
  rec.dph_cn;
  rec.cn;
  rec.st;
  rec.p_city_name;
  rec.v_city_name;
  rec.z5;
END;


EXPORT key_cn (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_cn);