import ut,Vehlic, vehicleV2;

export Mac_validVIN_exp(veh_layout, veh_in, veh_out) := macro

string8 yyyymmdd(string date_field) := if(length(trim(date_field, all)) = 6, trim(date_field, all) + '01', date_field);


veh_join	:=	join(distribute(veh_in,hash((string25)orig_vin)), VehLic.Vin_Matches,
				 left.orig_vin = right.vin_input,
				 vehicleV2.trans_make_veh_vin(left, right),left outer, local
				);
				 
veh_temp := dedup(veh_join, all, local);


veh_layout tvaldates(veh_temp L) := transform

self.REGISTRATION_EFFECTIVE_DATE := yyyymmdd(if((unsigned6)L.REGISTRATION_EFFECTIVE_DATE[1..6] < (unsigned6)L.REGISTRATION_EXPIRATION_DATE[1..6], L.REGISTRATION_EFFECTIVE_DATE, ''));
self.REGISTRATION_EXPIRATION_DATE := yyyymmdd(if((unsigned6)L.REGISTRATION_EFFECTIVE_DATE[1..6] < (unsigned6)L.REGISTRATION_EXPIRATION_DATE[1..6], L.REGISTRATION_EXPIRATION_DATE, ''));
self := L;

end;

veh_out := project(veh_temp, tvaldates(left));

endmacro;