import ut,Data_Services;
  oh_mar_filter := dataset(Data_Services.foreign_prod+ 'thor_200::in::mar_div::oh::marriage',marriage_divorce_v2.Layout_Marriage_OH_In,flat,OPT);

	oh_mar_filter1 := oh_mar_filter( (trim(grooms_last_name) != '' and trim(grooms_first_name)!= '') or 
																	 (trim(brides_last_name) != '' and trim(brides_first_name)!= '')); 		
																							 																						 
	

ds:=File_OH_County_In;

county_city_code_layout :=record
string code;
string city;
end;


county_city_code_layout t_city_county_code(File_OH_County_In le) := transform

self :=le;
end;

county_city_ds := project(ds,t_city_county_code(left));


ds1:=oh_mar_filter1;

add_city_div_layout :=record
Layout_Marriage_OH_In;
string license_issued_county:='';
string groom_residence_county:='';
string bride_residence_county:='';

end;


add_city_div_layout t_get_data_ready(ds1 le) := transform

self.groom_residence_county   := le.grooms_residence[1..2]+'00';
self.bride_residence_county   := le.brides_residence[1..2]+'00';
self.license_issued_county :=  le.county_where_license_issued+'00';

self :=le;
end;

ds_to_be_passed := project(ds1,t_get_data_ready(left));

MAC_OH_City_County_Codes(ds_to_be_passed,county_city_ds,groom_residence_county,groom_residence_county,oh_city_county_codes_ds1);
MAC_OH_City_County_Codes(oh_city_county_codes_ds1,county_city_ds,bride_residence_county,bride_residence_county,oh_city_county_codes_ds2);
MAC_OH_City_County_Codes(oh_city_county_codes_ds2,county_city_ds,license_issued_county,license_issued_county,oh_city_county_codes_ds3);


export File_Marriage_OH_In:=oh_city_county_codes_ds3;			 