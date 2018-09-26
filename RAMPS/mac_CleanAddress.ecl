import Address;

EXPORT mac_CleanAddress(JobId, InData, InAddress1, InAddress2, InCity, InState, InZip, OutFile) := MACRO

InputData := InData;

AddressClean_rec := RECORD
  recordof(InputData);
	//cleaned input address
	INTEGER   SEQ;
	STRING10 	clean_prim_range;
	STRING2  	clean_predir;
	STRING28 	clean_prim_name;
	STRING4  	clean_suffix;
	STRING2  	clean_postdir;
	STRING10 	clean_unit_desig;
	STRING8  	clean_sec_range;
	STRING25 	clean_p_city_name;
	STRING2  	clean_st;
	STRING5  	clean_zip;
	STRING4  	clean_zip4;
	STRING10 	clean_geo_lat;
	STRING11 	clean_geo_long;
	STRING7	 	clean_geo_blk;
	STRING5	 	clean_county;
	STRING5	 	clean_county_code;
	STRING4  	clean_msa;
	STRING1	 	clean_geo_match;
	STRING12	clean_geolink;
	STRING4   clean_error;
END;

AddressClean_rec CleanAddress(InputData l, INTEGER c) := TRANSFORM
			SELF.seq := c;
			clean_address := Address.CleanAddress182(l.InAddress1 + ',' + l.InAddress2, l.InCity + ',' + l.InState + ',' + l.InZip);
			SELF.clean_prim_range := clean_address [1..10];
			SELF.clean_predir := clean_address [11..12];
			SELF.clean_prim_name := clean_address [13..40];
			SELF.clean_suffix := clean_address [41..44];
			SELF.clean_postdir := clean_address [45..46];
			SELF.clean_unit_desig := clean_address [47..56];
			SELF.clean_sec_range := clean_address [57..65];
			SELF.clean_p_city_name := clean_address [90..114];
			SELF.clean_st := clean_address [115..116];
			SELF.clean_zip := clean_address [117..121];
			SELF.clean_zip4 := clean_address[122..125];
			SELF.clean_county := clean_address[143..145];
			SELF.clean_geo_lat := clean_address[146..155];
			SELF.clean_geo_long := clean_address[156..166];
			SELF.clean_geo_match := clean_address[178];
			SELF.clean_geo_blk := clean_address[171..177];
			SELF.clean_msa := clean_address[167..170];
			//build geolink
			SELF.clean_geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
			SELF.clean_error := clean_address[179..182];
			SELF := l;
			SELF := [];
	END;

CleanAddresses := PROJECT(InputData, CleanAddress(LEFT, COUNTER));
CountyCodeAppend := JOIN(CleanAddresses, Address.County_Names, LEFT.clean_st=RIGHT.state_alpha AND LEFT.clean_county=RIGHT.county_code, 
                        TRANSFORM(RECORDOF(LEFT), SELF.clean_county_code := RIGHT.state_code + RIGHT.county_code, SELF := LEFT)); 

OutFile := CountyCodeAppend;

ENDMACRO;