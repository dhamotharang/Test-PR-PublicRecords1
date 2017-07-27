import gong;

export Search_Address(string120 address_v, STRING20 houseNumRange_v, STRING10 houseNum_v, STRING28 streetName_v, DATASET(EDA_VIA_XML.Layout_City_List) city_list_v) := FUNCTION

prim_range_lo := MAP(LENGTH(Stringlib.StringFilter(houseNumRange_v,'-'))<>1 => 0,
										 (INTEGER)Stringlib.StringExtract(Stringlib.StringFindReplace(houseNumRange_v,'-',','),1));
										 
prim_range_hi := MAP(LENGTH(Stringlib.StringFilter(houseNumRange_v,'-'))<>1 => 999999,
										 (INTEGER)Stringlib.StringExtract(Stringlib.StringFindReplace(houseNumRange_v,'-',','),2));

parsed_address := datalib.AddressClean(address_v, 'MIAMI, FL 33162');

prim_range := MAP(TRIM(houseNum_v)<>'' => houseNum_v,
									TRIM(address_v)<>'' => parsed_address[1..10],
									'');
									
prim_name := MAP(TRIM(streetName_v)<>'' => streetName_v,
								 parsed_address[13..40]);

input_rec := RECORD
	string10 prim_range;
	string28 prim_name;
	string25 city;
	string2 state;
END;

input := dataset([{prim_range, prim_name, '', ''}], input_rec);

input_rec mergeCities(EDA_VIA_XML.Layout_City_List l, input_rec r) := TRANSFORM
  SELF.prim_range := r.prim_range;
	SELF.prim_name := r.prim_name;
	SELF.city := l.city;
	SELF.state := l.st;
END;

search_terms := JOIN(city_list_v, input, true, mergeCities(LEFT,RIGHT), LEFT OUTER, ALL);

baseFull := JOIN(search_terms, EDA_VIA_XML.Key_st_city_prim_name_prim_range,
								TRIM(LEFT.prim_range)<>'' AND
								KEYED(LEFT.state=RIGHT.st) AND
								KEYED(LEFT.city=RIGHT.city) AND
								KEYED(LEFT.prim_name=RIGHT.prim_name) AND
								KEYED(LEFT.prim_range=RIGHT.prim_range),
							TRANSFORM(gong.Layout_bscurrent_raw, 
							          self.sequence_number := (string10)right.sequence_number,
							          SELF:=RIGHT),
							LIMIT(0), KEEP(10000)
					);
					
baseRange := JOIN(search_terms, EDA_VIA_XML.Key_st_city_prim_name_prim_range,
								TRIM(LEFT.prim_range)='' AND LENGTH(Stringlib.StringFilter(houseNumRange_v,'-'))=1 AND
								KEYED(LEFT.state=RIGHT.st) AND
								KEYED(LEFT.city=RIGHT.city) AND
								KEYED(LEFT.prim_name=RIGHT.prim_name) AND
								(INTEGER)RIGHT.prim_range BETWEEN prim_range_lo AND prim_range_hi,
							TRANSFORM(gong.Layout_bscurrent_raw, 
							          self.sequence_number := (string10)right.sequence_number,
							          SELF:=RIGHT),
							LIMIT(0), KEEP(10000)
					);
					
baseStCityPrimName := JOIN(search_terms, EDA_VIA_XML.Key_st_city_prim_name_prim_range, 
								TRIM(LEFT.prim_range)='' AND LENGTH(Stringlib.StringFilter(houseNumRange_v,'-'))<>1 AND
								KEYED(LEFT.state=RIGHT.st) AND
								KEYED(LEFT.city=RIGHT.city) AND
								KEYED(LEFT.prim_name=RIGHT.prim_name),
							TRANSFORM(gong.Layout_bscurrent_raw, 
							          self.sequence_number := (string10)right.sequence_number,
							          SELF:=RIGHT),
							LIMIT(0), KEEP(10000)
					);

address_results := baseFull + baseRange + baseStCityPrimName;
							 
EDA_VIA_XML.Layout_Gong_Extended addScore(gong.Layout_bscurrent_raw l) := TRANSFORM
  SELF.score := 100;
	SELF := l;
END;

return PROJECT(address_results, addScore(LEFT));

END;