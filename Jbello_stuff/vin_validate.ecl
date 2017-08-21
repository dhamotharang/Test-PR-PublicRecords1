r0	:=	record
	string25 vin_input;
	string1 veh_type;
	string5 ncic_make;
	string2 model_year_yy;
	string17 vin;
	string20 vin_error_status;
	string1 vin_pattern_indicator;
	string17 vin_pattern;
	string1 bypass_code;
	string3 car_series;
	string5 car_orig_base_list_price;
	string4 car_shipping_wt;
	string6 car_orig_tire_size;
	string8 car_wheel_base;
	string2 car_body_style;
	string3 car_cid;
	string2 car_cylinders;
	string1 car_carburetion;
	string1 car_fuel_code;
	string9 car_filler;
	string1 vp_restraint;
	string4 vp_abbrev_make_name;
	string2 vp_year;
	string3 vp_series;
	string3 vp_model;
	string1 vp_air_conditioning;
	string1 vp_power_steering;
	string1 vp_power_brakes;
	string1 vp_power_windows;
	string1 vp_tilt_wheel;
	string1 vp_roof;
	string1 vp_optional_roof1;
	string1 vp_optional_roof2;
	string1 vp_radio;
	string1 vp_optional_radio1;
	string1 vp_optional_radio2;
	string1 vp_transmission;
	string1 vp_optional_transmission1;
	string1 vp_optional_transmission2;
	string1 vp_anti_lock_brakes;
	string1 vp_front_wheel_drive;
	string1 vp_four_wheel_drive;
	string1 vp_security_system;
	string1 vp_daytime_running_lights;
	string99 vp_reserved;
	string25 vp_series_name;
	string4 model_year;
	string3 vina_series;
	string3 vina_model;
	string2 vina_body_style;
	string36 make_description;
	string25 model_description;
	string25 series_description;
	string25 body_style_description;
	string2 number_of_cylinders;
	string4 engine_size;
	string1 fuel_code;
	string1 cr;
end;
/*


ds_0_1 := dataset('~thor_data400::in::vina_info_thiscycle',r0,flat);
r0_1 := record
	string1 source:='',
	ds_0_1,
end;
r0_1 t_r0_1(ds_0_1 l) := transform
	self.source := 'E';
	self := l;
end;
ds_0 := project(ds_0_1,t_r0_1(left));



ds_0_2 := dataset('~thor_data400::temp::vina_info_thiscycle_d00',r0,flat);
r0_2 := record
	string1 source:='',
	ds_0_2,
end;
r0_2 t_r0_2(ds_0_2 l) := transform
	self.source := 'A';
	self := l;
end;
ds_00 := project(ds_0_2,t_r0_2(left));



ds_1_0:=ds_0 + ds_00;
// ds_1_1:=sort(ds_1_0,vin_input);
// ds_1_2:=dedup(ds_1_1,record,local);
ds_1:=dedup(sort(distribute(ds_1_0,hash(vin_input)),vin_input,local),record,local);

//////////////
	r_1_normed	:= record
		string22	vin_input,
		string45	field,
		string45	val,
	end;

	r_1_normed NormIt(ds_1 L, integer C)	:= transform
		self		:=	L;
		self.field	:=	map(
							C=1=>'vin_input'
							,C=2=>'veh_type'
							,C=3=>'ncic_make'
							,C=4=>'model_year_yy'
							,C=5=>'vin'
							,C=6=>'vin_error_status'
							,C=7=>'vin_pattern_indicator'
							,C=8=>'vin_pattern'
							,C=9=>'bypass_code'
							,C=10=>'car_series'
							,C=11=>'car_orig_base_list_price'
							,C=12=>'car_shipping_wt'
							,C=13=>'car_orig_tire_size'
							,C=14=>'car_wheel_base'
							,C=15=>'car_body_style'
							,C=16=>'car_cid'
							,C=17=>'car_cylinders'
							,C=18=>'car_carburetion'
							,C=19=>'car_fuel_code'
							,C=20=>'car_filler'
							,C=21=>'vp_restraint'
							,C=22=>'vp_abbrev_make_name'
							,C=23=>'vp_year'
							,C=24=>'vp_series'
							,C=25=>'vp_model'
							,C=26=>'vp_air_conditioning'
							,C=27=>'vp_power_steering'
							,C=28=>'vp_power_brakes'
							,C=29=>'vp_power_windows'
							,C=30=>'vp_tilt_wheel'
							,C=31=>'vp_roof'
							,C=32=>'vp_optional_roof1'
							,C=33=>'vp_optional_roof2'
							,C=34=>'vp_radio'
							,C=35=>'vp_optional_radio1'
							,C=36=>'vp_optional_radio2'
							,C=37=>'vp_transmission'
							,C=38=>'vp_optional_transmission1'
							,C=39=>'vp_optional_transmission2'
							,C=40=>'vp_anti_lock_brakes'
							,C=41=>'vp_front_wheel_drive'
							,C=42=>'vp_four_wheel_drive'
							,C=43=>'vp_security_system'
							,C=44=>'vp_daytime_running_lights'
							,C=45=>'vp_reserved'
							,C=46=>'vp_series_name'
							,C=47=>'model_year'
							,C=48=>'vina_series'
							,C=49=>'vina_model'
							,C=50=>'vina_body_style'
							,C=51=>'make_description'
							,C=52=>'model_description'
							,C=53=>'series_description'
							,C=54=>'body_style_description'
							,C=55=>'number_of_cylinders'
							,C=56=>'engine_size'
							,C=57=>'fuel_code'
							,C=58=>'cr'

							,''
							);
		self.val	:=	map(
							C=1=>l.vin_input
							,C=2=>l.veh_type
							,C=3=>l.ncic_make
							,C=4=>l.model_year_yy
							,C=5=>l.vin
							,C=6=>l.vin_error_status
							,C=7=>l.vin_pattern_indicator
							,C=8=>l.vin_pattern
							,C=9=>l.bypass_code
							,C=10=>l.car_series
							,C=11=>l.car_orig_base_list_price
							,C=12=>l.car_shipping_wt
							,C=13=>l.car_orig_tire_size
							,C=14=>l.car_wheel_base
							,C=15=>l.car_body_style
							,C=16=>l.car_cid
							,C=17=>l.car_cylinders
							,C=18=>l.car_carburetion
							,C=19=>l.car_fuel_code
							,C=20=>l.car_filler
							,C=21=>l.vp_restraint
							,C=22=>l.vp_abbrev_make_name
							,C=23=>l.vp_year
							,C=24=>l.vp_series
							,C=25=>l.vp_model
							,C=26=>l.vp_air_conditioning
							,C=27=>l.vp_power_steering
							,C=28=>l.vp_power_brakes
							,C=29=>l.vp_power_windows
							,C=30=>l.vp_tilt_wheel
							,C=31=>l.vp_roof
							,C=32=>l.vp_optional_roof1
							,C=33=>l.vp_optional_roof2
							,C=34=>l.vp_radio
							,C=35=>l.vp_optional_radio1
							,C=36=>l.vp_optional_radio2
							,C=37=>l.vp_transmission
							,C=38=>l.vp_optional_transmission1
							,C=39=>l.vp_optional_transmission2
							,C=40=>l.vp_anti_lock_brakes
							,C=41=>l.vp_front_wheel_drive
							,C=42=>l.vp_four_wheel_drive
							,C=43=>l.vp_security_system
							,C=44=>l.vp_daytime_running_lights
							,C=45=>l.vp_reserved
							,C=46=>l.vp_series_name
							,C=47=>l.model_year
							,C=48=>l.vina_series
							,C=49=>l.vina_model
							,C=50=>l.vina_body_style
							,C=51=>l.make_description
							,C=52=>l.model_description
							,C=53=>l.series_description
							,C=54=>l.body_style_description
							,C=55=>l.number_of_cylinders
							,C=56=>l.engine_size
							,C=57=>l.fuel_code
							,C=58=>l.cr
							,''
							);
	end;


	ds_1_normed:=distribute(
							normalize(
									ds_1
									,58
									,NormIt(left,counter))
														(
														// YYYYMM<>''
														)
							,hash(vin_input)
					)
					;

ds_2 := dedup(sort(ds_1_normed,vin_input,field,local),record,local);
////////////////
r3 := record
	ds_2.vin_input,
	ds_2.field,
	cnt:=count(group),
end;

ds_3:=table(ds_2,r3,vin_input,field,local);
/////////////////////
r4 := record
	string22	vin_input,
	string45	field,
	string45	val,
end;

r4 j_fld(ds_3 l, ds_2 r) := transform
	self:=r;
	self:=l;
end;

ds_4 := join(ds_3(cnt>1), ds_2
				,	left.vin_input=right.vin_input
				and	left.field=right.field
				,j_fld(left,right)
				,left outer
				,local
				)
				 // : persist('~thor_data400::persist::jbello_temp')
				;
////////////////
ds_5 := dedup(ds_4,vin_input,field,local);
///////////////
r6 := record
	ds_5.vin_input,
	cnt:=count(group),
end;

ds_6_0:=table(ds_5,r6,vin_input,local);
// ds_6_1:=sort(ds_6_0,vin_input,local);
// ds_6_2:=dedup(ds_6_1,vin_input,local);
ds_6:=dedup(sort(distribute(ds_6_0,hash(vin_input)),vin_input,local),vin_input,local);
//////////////
r7 := record
	ds_6.cnt,
	ds_1,
end;

r7 j_cmp(ds_1 l, ds_6 r) := transform
	self:=r;
	self:=l;
end;

ds_7_0 := join(ds_1, ds_6
				,left.vin_input=right.vin_input
				,j_cmp(left,right)
				,lookup
				,local
				)
				: persist('~thor_data400::persist::jbello_temp')
				;

ds_7 := sort(ds_7_0,vin_input,source,local);

output(choosen(ds_7,1000));

*/

//##########################################

ds_0_1 := dedup(sort(distribute(dataset('~thor_data400::in::vina_info_thiscycle',r0,flat),hash(vin_input)),vin_input,local),vin_input,local);
r0_1 := record
	string1 source:='',
	ds_0_1.vin_input,
end;
r0_1 t_r0_1(ds_0_1 l) := transform
	self.source := 'E';
	self := l;
end;
ds_0 := project(ds_0_1,t_r0_1(left),local);



ds_0_2 := dedup(sort(distribute(dataset('~thor_data400::temp::vina_info_thiscycle_d00',r0,flat),hash(vin_input)),vin_input,local),vin_input,local);
r0_2 := record
	string1 source:='',
	ds_0_2.vin_input,
end;
r0_2 t_r0_2(ds_0_2 l) := transform
	self.source := 'A';
	self := l;
end;
ds_00 := project(ds_0_2,t_r0_2(left),local);


r1 := record
	vin_A:=ds_00.vin_input,
	vin_E:=ds_0.vin_input,
end;

r1 j_cmp(ds_00 l, ds_0 r) := transform
	self.vin_A:=l.vin_input;
	self.vin_E:=r.vin_input;
end;

ds_1 := join(ds_00, ds_0
				,left.vin_input=right.vin_input
				,j_cmp(left,right)
				,full only
				,local
				)
				: persist('~thor_data400::persist::jbello_temp0')
				;

r2 := record
	ds_0_2;
end;
r2 j_cmp2(ds_0_2 l, ds_1 r) := transform
	self:=l;
end;
ds_2 := join(ds_0_2, ds_1(vin_a<>'')
				,left.vin_input=right.vin_a
				,j_cmp2(left,right)
				,local
				,lookup
				)
				: persist('~thor_data400::persist::jbello_temp1')
				;

output(ds_1(vin_A=''));
output(ds_1(vin_E=''));
output(ds_2);

//##########################################


// ds_0_1 := distribute(dataset('~thor_data400::in::flcrashs_20070919',r0,flat),hash(accident_nbr));
// r0_1 := record
	// string1 source:='',
	// ds_0_1,
// end;
// r0_1 t_r0_1(ds_0_1 l) := transform
	// self.source := 'E';
	// self := l;
// end;
// ds_0 := project(ds_0_1,t_r0_1(left),local);



// ds_0_2 := distribute(dataset('~thor_data400::in::flcrashs.d00',r0,flat),hash(accident_nbr));
// r0_2 := record
	// string1 source:='',
	// ds_0_2,
// end;
// r0_2 t_r0_2(ds_0_2 l) := transform
	// self.source := 'A';
	// self := l;
// end;
// ds_00 := project(ds_0_2(accident_date[1..4]='2006'),t_r0_2(left),local);


// r1 := record
	// ds_00;
// end;

// r1 j_cmp(ds_00 l, ds_0 r) := transform
	// self:=l;
// end;

// ds_1 := join(ds_00, ds_0
				// ,left.accident_nbr=right.accident_nbr
				// ,j_cmp(left,right)
				// ,right only
				// ,local
				// )
				
				// : persist('~thor_data400::persist::jbello_temp1')
				// ;

// output(ds_1);






 