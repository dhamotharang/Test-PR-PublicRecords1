// formely: Address.Key_CityStChance
IMPORT $;

rec := $.layout_header;

// keyed_fields := RECORD
//   rec.city_name;
// END;

payload := RECORD
  rec.st;
	unsigned2 percent_chance;
END;

EXPORT key_CityStChance (integer data_category = 0) := 
         INDEX ({rec.city_name}, payload, $.names().i_CityStChance);
