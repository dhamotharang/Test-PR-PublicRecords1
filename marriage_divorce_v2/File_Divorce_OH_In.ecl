import ut,Data_Services;
 oh_div_filter := dataset(Data_Services.foreign_prod+ 'thor_200::in::mar_div::oh::divorce',marriage_divorce_v2.Layout_Divorce_OH_In,flat,OPT);

 oh_div_filter1 := oh_div_filter( (trim(husband_last_name)!=''  and trim(husband_first_name)!='') or 
																						     (trim(wife_first_name) !='')); 


ds:=File_OH_County_In;

county_city_code_layout :=record
string code;
string city;
end;


county_city_code_layout t_city_county_code(File_OH_County_In le) := transform

self :=le;
end;

county_city_ds := project(ds,t_city_county_code(left));


ds1:=oh_div_filter1;

add_city_div_layout :=record
Layout_Divorce_OH_In;
string county_decree:='';
string husband_county:='';
string wife_county:='';

end;


add_city_div_layout t_get_data_ready(ds1 le) := transform

self.husband_county_of_residence   := le.husband_county_of_residence[1..2]+'00';
self.wife_county_of_residence   := le.wife_county_of_residence[1..2]+'00';
self.county_decree :=  le.county_of_decree+'00';

self :=le;
end;

ds_to_be_passed := project(ds1,t_get_data_ready(left));

MAC_OH_City_County_Codes(ds_to_be_passed,county_city_ds,husband_county_of_residence,husband_county,oh_city_county_codes_ds1);
MAC_OH_City_County_Codes(oh_city_county_codes_ds1,county_city_ds,wife_county_of_residence,wife_county,oh_city_county_codes_ds2);
MAC_OH_City_County_Codes(oh_city_county_codes_ds2,county_city_ds,county_decree,county_decree,oh_city_county_codes_ds3);


export File_Divorce_OH_In:=oh_city_county_codes_ds3;			 