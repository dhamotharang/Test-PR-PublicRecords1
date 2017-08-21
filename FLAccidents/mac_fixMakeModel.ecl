export mac_fixMakeModel(infile,vehicle_id_nbr,outfile) := macro

#uniquename(dvina)
#uniquename(trecs)
#uniquename(jrecs)
#uniquename(blank_vins)
#uniquename(allrecs)						

%dvina%	:= VehLic.File_VINA;

infile %trecs%(infile L, %dvina% R) := transform

self.vehicle_seg					:= map(L.vehicle_id_nbr= R.vin_input => R.variable_segment,L.vehicle_seg);	
self.vehicle_seg_type				:= map(L.vehicle_id_nbr= R.vin_input => R.veh_type,L.vehicle_seg_type);	
self.model_year						:= map(L.vehicle_id_nbr= R.vin_input => R.model_year,L.model_year);	
self.body_style_code				:= map(L.vehicle_id_nbr= R.vin_input => R.vina_body_style,L.body_style_code);	
self.engine_size					:= map(L.vehicle_id_nbr= R.vin_input => R.engine_size,L.engine_size);	
self.fuel_code						:= map(L.vehicle_id_nbr= R.vin_input => R.fuel_code,L.fuel_code);	
self.number_of_driving_wheels		:= map(L.vehicle_id_nbr= R.vin_input => R.vp_tilt_wheel,L.number_of_driving_wheels);	
self.steering_type					:= map(L.vehicle_id_nbr= R.vin_input => R.vp_power_steering,L.steering_type);		
self.vina_series					:= map(L.vehicle_id_nbr= R.vin_input => R.vina_series,L.vina_series);	
self.vina_model						:= map(L.vehicle_id_nbr= R.vin_input => R.vina_model,L.vina_model);	
self.vina_make						:= map(L.vehicle_id_nbr= R.vin_input => R.vp_abbrev_make_name,L.vina_make);	
self.vina_body_style				:= map(L.vehicle_id_nbr= R.vin_input => R.vina_body_style,L.vina_body_style);		

self.model_description				:= map(L.vehicle_id_nbr= R.vin_input => R.model_description,L.model_description);		
self.series_description				:= map(L.vehicle_id_nbr= R.vin_input => R.series_description,L.series_description);	
self.make_description				  := map(L.vehicle_id_nbr= R.vin_input => R.make_description,L.make_description);	
// map(make_descr != '' and self.series_description !='' =>
																		// if(regexfind(self.series_description,make_descr)
																		// ,regexreplace(' '+self.series_description,make_descr,'')
																		// ,make_descr)
															// ,make_descr);

self.car_cylinders					:= map(L.vehicle_id_nbr= R.vin_input => R.number_of_cylinders,L.car_cylinders);	

self := L;
end;

%jrecs% := join(distribute(infile(vehicle_id_nbr!=''),hash(vehicle_id_nbr)),distribute(%dvina%,hash(vin_input)),
				left.vehicle_id_nbr= right.vin_input,
				%trecs%(left,right),left outer,local);
				
////////////////////////////////////////////////////////////////////////////
//Flows have been split 
//for faster processing time.  
///////////////////////////////////////////////////////////////////////////

%blank_vins% := infile(vehicle_id_nbr='');
%allrecs% := %jrecs%+%blank_vins%;
outfile :=%allrecs%;

endmacro;
