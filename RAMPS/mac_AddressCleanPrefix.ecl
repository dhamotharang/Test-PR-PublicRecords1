import Address;

EXPORT mac_AddressCleanPrefix(AddressClean_rec,JobId, InData, InName, InAddress1, InAddress2, InCity, InState, InZip, OutFile) := MACRO

InputData := InData;

AddressClean_rec CleanAddress(InputData l, integer c) := TRANSFORM
			self.seq := c;
			clean_name := Address.CleanPersonFML73(l.InName);
			self.clean_fname := clean_name[6..25];
			self.clean_mname := clean_name[26..45];
			self.clean_lname := clean_name[46..65];
			clean_address := Address.CleanAddress182(l.InAddress1 + ',' + l.InAddress2, l.InCity + ',' + l.InState + ',' + l.InZip);
			self.clean_prim_range := clean_address [1..10];
			self.clean_predir := clean_address [11..12];
			self.clean_prim_name := clean_address [13..40];
			self.clean_suffix := clean_address [41..44];
			self.clean_postdir := clean_address [45..46];
			self.clean_unit_desig := clean_address [47..56];
			self.clean_sec_range := clean_address [57..65];
			self.clean_p_city_name := clean_address [90..114];
			self.clean_st := clean_address [115..116];
			self.clean_zip := clean_address [117..121];
			self.clean_zip4 := clean_address[122..125];
			self.clean_county := clean_address[143..145];
			self.clean_geo_lat := clean_address[146..155];
			self.clean_geo_long := clean_address[156..166];
			self.clean_geo_match := clean_address[178];
			self.clean_geo_blk := clean_address[171..177];
			self.clean_msa := clean_address[167..170];
			//build geolink
			self.clean_geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
			self.clean_error := clean_address[179..182];
			self := l;
			self := [];
	end;

CleanAddresses := project(InputData, CleanAddress(Left, counter));
CountyCodeAppend := JOIN(CleanAddresses, Address.County_Names, left.clean_st=right.state_alpha and left.clean_county=right.county_code, 
                        TRANSFORM(RECORDOF(LEFT), self.clean_county_code := right.state_code + right.county_code, self := LEFT)); 

OutFile := CountyCodeAppend + CountyCodeAppend[1..100];//temp add to test append validation--leeddx

//output(OutFile,,'~thordev_socialthor_50::out::Address_clean::'+JobId, __compressed__, overwrite, named('AddressClean'));

// 

ENDMACRO;

