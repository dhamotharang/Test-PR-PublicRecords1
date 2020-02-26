//former: Gong_Neustar.key_cn_to_company
IMPORT $;

rec := $.layouts.i_cn_to_company;

keyed_fields := RECORD
  rec.listed_name;
  rec.st;
  rec.p_city_name;
  rec.z5;
  rec.phone10;
END;

EXPORT key_cn_to_company (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, $.names().i_cn_to_company);