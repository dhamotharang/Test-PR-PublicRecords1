export map_axciomCanBus(string8 abusFileDate) := function

import CanadianPhones,Address,VersionControl;

dacb := distribute(CanadianPhones.file_axciomCanBus.v2,random());

layoutCanadianWhitepagesBaseWOCCPA := layoutCanadianWhitepagesBase - [global_sid,record_sid];


layoutCanadianWhitepagesBaseWOCCPA tacb(dacb input) := transform
self.Date_first_reported:=abusFileDate;
self.Date_last_reported:=abusFileDate;

self.vendor:='AX';
self.Source_file:='AXCIOM_CANADIAN_BUSINESS';
self.company_name:= input.business_name;
self.housenumber:= input.street_number;
self.streetname:= input.street_name;
self.streetsuffix:= '';//input.street_directional;
self.postalcity:= input.city;
self.province:= input.province;
self.postalcode:= input.postal_code;
self.phonenumber:= input.area_code+input.phone_number;
self.listing_type:='B';


CleanAddress		:= Address.CleanCanadaAddress109(input.street_number + ' '+ input.street_name,// + ' '+input.street_directional,
													 input.city + ' ' + input.province+' '+ input.postal_code
													 );
 
self.prim_range 	:= CleanAddress[1..10]; 
self.predir 		:= CleanAddress[11..12];					   
self.prim_name 		:= CleanAddress[13..40];
self.addr_suffix 	:= CleanAddress[41..44];
self.unit_desig 	:= CleanAddress[45..54];
self.sec_range 		:= CleanAddress[55..62];
self.p_city_name 	:= CleanAddress[63..92];
self.state			:= CleanAddress[93..94];
self.zip			:= CleanAddress[95..100];
self.rec_type   	:= CleanAddress[101..102];
self.language 		:= CleanAddress[103];
self.errstat 		:= CleanAddress[104..109];


self				:= input; 
self			    :=[];
end;


pacb := project(dacb,tacb(left));

return
sequential(
output(abusFileDate),
output(pacb,,CanadianPhones.thor_cluster + 'in::axciomBus::'+abusFileDate+ '::canada_clean',overwrite),
fileservices.addsuperfile(CanadianPhones.thor_cluster + 'base::axciomBus',CanadianPhones.thor_cluster + 'in::axciomBus::'+abusFileDate+ '::canada_clean')
);
end;
