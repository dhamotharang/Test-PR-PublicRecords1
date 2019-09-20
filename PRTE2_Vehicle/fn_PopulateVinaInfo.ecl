import Vina, std, VehicleCodes; 

//Populating VINA fields 
EXPORT fn_PopulateVinaInfo(dataset(recordof(layouts.Base_Main)) in_ds) := function

in_ds  						doJoin(in_ds l, VINA.layout_base_vintelligence r) := TRANSFORM
self.VINA_Veh_Type									:=	if(l.VINA_Veh_Type <> '', l.VINA_Veh_Type,r.vehicle_type);
self.VINA_NCIC_Make									:=	''; 					//did not match due to  truncation
self.VINA_Model_Year_YY							:=  if(l.VINA_Model_Year_YY <> '', l.VINA_Model_Year_YY, r.model_year[3..4]);
self.VINA_VIN												:=	if(l.VINA_VIN <> '', l.VINA_VIN, STD.Str.ToUpperCase(r.match_vin)); 
self.VINA_VIN_Pattern_Indicator			:=	if(l.VINA_VIN_Pattern_Indicator <> '', l.VINA_VIN_Pattern_Indicator,'');
self.VINA_Bypass_Code								:=	if(l.VINA_Bypass_Code <> '', l.VINA_Bypass_Code, '');  	 
self.VINA_VP_Restraint							:=  if(l.VINA_VP_Restraint <> '', l.VINA_VP_Restraint, '');
self.VINA_VP_Abbrev_Make_Name				:=  if(l.VINA_VP_Abbrev_Make_Name <> '', l.VINA_VP_Abbrev_Make_Name, STD.Str.ToUpperCase(r.make_abbreviation) );
self.VINA_VP_Year										:=	if(l.VINA_VP_Year <> '', l.VINA_VP_Year, '');
self.VINA_VP_Series									:=	''; 			//did not match due to truncation 
self.VINA_VP_Model									:=	'';  //did not match due to truncation 
self.VINA_VP_Air_Conditioning				:=	if(l.VINA_VP_Air_Conditioning <> '', l.VINA_VP_Air_Conditioning, STD.Str.ToUpperCase(r.air_conditioning));
self.VINA_VP_Power_Steering					:=	if(l.VINA_VP_Power_Steering <> '', l.VINA_VP_Power_Steering, STD.Str.ToUpperCase(r.power_steering));
self.VINA_VP_Power_Brakes						:=	if(l.VINA_VP_Power_Brakes <> '', l.VINA_VP_Power_Brakes, STD.Str.ToUpperCase(r. power_brakes));
self.VINA_VP_Power_Windows					:=	if(l.VINA_VP_Power_Windows <> '', l.VINA_VP_Power_Windows, STD.Str.ToUpperCase(r.power_windows));
self.VINA_VP_Tilt_Wheel							:=	if(l.VINA_VP_Tilt_Wheel <> '', l.VINA_VP_Tilt_Wheel, STD.Str.ToUpperCase(r.tilt_wheel));
self.VINA_VP_Roof										:=	if(l.VINA_VP_Roof <> '', l.VINA_VP_Roof, STD.Str.ToUpperCase(r.roof));
self.VINA_VP_Optional_Roof1					:=	if(l.VINA_VP_Optional_Roof1 <> '', l.VINA_VP_Optional_Roof1, STD.Str.ToUpperCase(r.optional_roof1));
self.VINA_VP_Optional_Roof2					:=	if(l.VINA_VP_Optional_Roof2	<> '', l.VINA_VP_Optional_Roof2, STD.Str.ToUpperCase(r.optional_roof2));
self.VINA_VP_Radio									:=	if(l.VINA_VP_Radio <> '',	l.VINA_VP_Radio, STD.Str.ToUpperCase(r.radio));
self.VINA_VP_Optional_Radio1				:= 	if(l.VINA_VP_Optional_Radio1 <> '', l.VINA_VP_Optional_Radio1, STD.Str.ToUpperCase(r.optional_radio1));
self.VINA_VP_Optional_Radio2				:= 	if(l.VINA_VP_Optional_Radio2 <> '', l.VINA_VP_Optional_Radio2, STD.Str.ToUpperCase(r.optional_radio2));
self.VINA_VP_Transmission						:=	if(l.VINA_VP_Transmission <> '', l.VINA_VP_Transmission, 	STD.Str.ToUpperCase(r.transmission));
self.VINA_VP_Optional_Transmission1	:=	if(l.VINA_VP_Optional_Transmission1 <> '', l.VINA_VP_Optional_Transmission1, STD.Str.ToUpperCase(r.optional_transmission1));
self.VINA_VP_Optional_Transmission2	:=	if(l.VINA_VP_Optional_Transmission2 <> '', l.VINA_VP_Optional_Transmission2, STD.Str.ToUpperCase(r.optional_transmission2));
self.VINA_VP_Anti_Lock_Brakes				:=	if(l.VINA_VP_Anti_Lock_Brakes <> '',l.VINA_VP_Anti_Lock_Brakes,STD.Str.ToUpperCase(r.anti_lock_brakes));
self.VINA_VP_Front_Wheel_Drive			:=	if(l.VINA_VP_Front_Wheel_Drive <> '', l.VINA_VP_Front_Wheel_Drive,'');
self.VINA_VP_Four_Wheel_Drive				:=	if(l.VINA_VP_Four_Wheel_Drive <> '', l.VINA_VP_Four_Wheel_Drive,'');
self.VINA_VP_Security_System				:=	if(l.VINA_VP_Security_System <> '', l.VINA_VP_Security_System, STD.Str.ToUpperCase(r.security_system));
self.VINA_VP_Daytime_Running_Lights	:=	if(l.VINA_VP_Daytime_Running_Lights <> '', l.VINA_VP_Daytime_Running_Lights, STD.Str.ToUpperCase(r.daytime_running_lights));
self.VINA_VP_Series_Name						:=	if(l.VINA_VP_Series_Name <> '',	l.VINA_VP_Series_Name, STD.Str.ToUpperCase(r.series_name));
self.VINA_Model_Year								:=  if(l.VINA_Model_Year  <> '', l.VINA_Model_Year, STD.Str.ToUpperCase(r.model_year));
self.VINA_Series										:=	''; //did not match due to truncation 
self.VINA_Model											:=	'';  //did not match due to truncation 
self.VINA_Body_Style								:=	if(l.VINA_Body_Style <> '', l.VINA_Body_Style,STD.Str.ToUpperCase(r.body_style_cd)) ;
self.VINA_Make_Desc									:=	if(l.VINA_Make_Desc <> '', STD.Str.ToUpperCase(l.VINA_Make_Desc), STD.Str.ToUpperCase(r.make_name));
self.VINA_Model_Desc								:=  if(l.VINA_Model_Desc <> '',	STD.Str.ToUpperCase(l.VINA_Model_Desc), STD.Str.ToUpperCase(r.mdl_desc));
self.VINA_Series_Desc								:=  if(l.VINA_Series_Desc	<> '', STD.Str.ToUpperCase(l.VINA_Series_Desc), STD.Str.ToUpperCase(r.series_name));
self.VINA_Body_Style_Desc						:=  if(l.VINA_Body_Style_Desc <> '', STD.Str.ToUpperCase(l.VINA_Body_Style_Desc), STD.Str.ToUpperCase(r.body_style_desc));
self.VINA_Number_Of_Cylinders				:= 	if(l.VINA_Number_Of_Cylinders <> '', l.VINA_Number_Of_Cylinders, STD.Str.ToUpperCase(r.cylinders));
self.VINA_Engine_Size								:=	if(l.VINA_Engine_Size <> '',l.VINA_Engine_Size, '');
self.VINA_Fuel_Code									:=	if(l.VINA_Fuel_Code <> '',l.VINA_Fuel_Code, STD.Str.ToUpperCase(r.fuel));
self.VINA_Price											:=	if(l.VINA_Price <> '', l.VINA_Price, r.base_list_price_expanded);


string3 v_major 								:=	VehicleCodes.StateColorToNCICColor(l.STATE_origin,l.Orig_Major_Color_Code);
string3 v_minor 								:=	VehicleCodes.StateColorToNCICColor(l.STATE_origin,l.Orig_Minor_Color_Code);
	
self.Best_Major_Color_Code			:=	if(	TRIM(l.Orig_Major_Color_Code)	=	'',
																					'UNK',
																					if(	v_major	<>	'UNK',
																							v_major,
																							l.Best_Major_Color_Code
																						)
																				);
self.Best_Minor_Color_Code			:=	if(	TRIM(l.Orig_Minor_Color_Code)	=	'',
																					'UNK',
																					if(	v_minor	<>	'UNK',
																							v_minor,
																							l.Best_Minor_Color_Code
																						)
																				);	
	
SELF := l;
END;

//Running in dataland
//j1 := join(in_ds,	files.file_vina_base,

j1 := join(in_ds,	files.file_vina_base,
						left.orig_vin[1..8] = right.match_vin[1..8] and 
						left.orig_vin[10] 	= right.match_vin[10]   and
						left.orig_year      = right.model_year,
									doJoin(left,right), left outer, keep(1));
									
return dedup(sort(j1, vehicle_key, iteration_key, orig_vin), all);
end;
