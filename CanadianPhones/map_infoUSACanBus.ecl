import CanadianPhones,Address, VersionControl;
dicb := distribute(CanadianPhones.file_infoUSACanBus,random());

	
		CanadianPhones.layout_infoUSACanBus tNormalizeAddress(dicb  l, unsigned4 cnt) :=
		transform
       
		self.address            :=choose(cnt
																				,trim(l.address)
																				,trim(l.secondary_address)
																				);
		self.city				:=choose(cnt
																				,trim(l.city)
																				,trim(l.secondary_city)
																				);
		self.province           :=choose(cnt
																				,trim(l.province)
																				,trim(l.secondary_province)
																				);
		self.postal_code	    := choose(cnt
																				,trim(l.postal_code)
																				,trim(l.secondary_postal_code)
																				);
			   

	  self :=l;
		end;
		
		dAddressNorm	:= normalize(dicb , 2, tNormalizeAddress(left,counter));


ibusFileDate:= VersionControl.fGetFilenameVersion(CanadianPhones.thor_cluster + 'in::infousaBiz') : stored('ibusFileDate');
CanadianPhones.layoutCanadianWhitepagesBase ticb(dAddressNorm input) := Transform

self.Date_first_reported:= (string8)ibusFileDate;
self.Date_last_reported:=(string8)ibusFileDate;

self.vendor						:='IU';
self.Source_file				:='INFOUSA_YELLOWPAGES';
self.name						:= input.contact_name_title_address;
self.firstname  				:= input.contact_first_name; 
self.lastname   				:= input.contact_last_name;
self.professionalsuffix 		:= input.professional_title;
self.company_name				:= input.company_name;
self.streetname					:= input.address;
self.suitenumber				:= input.suite_number;
self.postalcity					:= input.city;
self.province					:= input.province;
self.postalcode					:= input.postal_code;
self.phonenumber				:= input.phone;

CleanAddress					:= Address.CleanCanadaAddress109(input.address + ' '+ input.suite_number,
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



self.listing_type 	:='B';
self				:= input; 
self 				:=[];
end;

picb := project(dAddressNorm,ticb(left));

export map_infoUSACanBus:= output(picb,,CanadianPhones.thor_cluster + 'in::infousaBiz::'+ibusFileDate+'::canada_clean',overwrite);