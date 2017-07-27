import gong;

export Filter_By_Address(string120 address_v, STRING20 houseNumRange_v, STRING10 houseNum_v, STRING28 streetName_v, DATASET(EDA_VIA_XML.Layout_Gong_Extended) input_recs) := FUNCTION

prim_range_lo := MAP(LENGTH(Stringlib.StringFilter(houseNumRange_v,'-'))<>1 => 0,
										 (INTEGER)Stringlib.StringExtract(Stringlib.StringFindReplace(houseNumRange_v,'-',','),1));
										 
prim_range_hi := MAP(LENGTH(Stringlib.StringFilter(houseNumRange_v,'-'))<>1 => 999999,
										 (INTEGER)Stringlib.StringExtract(Stringlib.StringFindReplace(houseNumRange_v,'-',','),2));

parsed_address := datalib.AddressClean(address_v, 'MIAMI, FL 33162');

prim_range_v := MAP(TRIM(houseNum_v)<>'' => houseNum_v,
									TRIM(address_v)<>'' => parsed_address[1..10],
									'');
									
prim_name_v := MAP(TRIM(streetName_v)<>'' => streetName_v,
								 TRIM(address_v)<>'' => parsed_address[13..40],
								 '');
								 
return input_recs((TRIM(prim_range_v)='' OR prim_range_v=prim_range) AND
									(TRIM(prim_name_v)='' OR prim_name_v=prim_name) AND
									(LENGTH(Stringlib.StringFilter(houseNumRange_v,'-'))=0 OR (INTEGER)prim_range BETWEEN prim_range_lo AND prim_range_hi));
									
END;