import doxie, faa, data_services;

src_rec := record
	 header.Layout_Source_ID;
	 faa.layout_aircraft_registration_out_slim;
end;

dAircraft_as_Source	:=	project(FAA.Aircraft_as_Source(,true),src_rec);

mac_key_src(dAircraft_as_Source, faa.layout_aircraft_registration_out_slim, 
						airc_child, 
						data_services.data_location.prefix() + 'thor_data400::key::airc_src_index_',id)
						
export Key_Src_Airc := id;