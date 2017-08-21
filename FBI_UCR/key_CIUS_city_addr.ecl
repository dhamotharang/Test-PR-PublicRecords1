import address, address_attributes, doxie, fbi_ucr, ut;

CIUS_city := FBI_UCR.file_CIUS_city;

FBI_UCR.layouts.layout_CIUS_city FBIClean(CIUS_city l) := TRANSFORM
	clean_address := Address.CleanAddress183('', l.city + ', ' + l.state);
	self.city 	:= clean_address [65..89];
	self.state 	:= clean_address [115..116];
	self.FBI_Score := address_attributes.functions.getFBISafetyScore(l.murder, l.rape, l.robbery, l.assault, l.burglary, l.larceny, l.motor_vehicle_theft, l.arson);
	self := l;
end;

cleaned := project(CIUS_city, FBIClean(left));
	
clean_key_data := cleaned(state		!='' and 
													city	 	!=''); 

export key_CIUS_city_addr := index(clean_key_data,{
														state, 
														city
														},
														{clean_key_data},'~thor_Data400::key::neighborhood::' + doxie.Version_SuperKey + '::fbi_cius_city::address');
