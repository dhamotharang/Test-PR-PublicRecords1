Import Data_Services, doxie, faa;

src_rec := record
	 header.Layout_Source_ID;
	 faa.layout_aircraft_registration_out_slim;
end;

dAircraft_as_Source	:=	project(header.Files_SeqdSrc().AC,src_rec);

mac_key_src(dAircraft_as_Source, faa.layout_aircraft_registration_out_slim, 
						airc_child, 
						Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::airc_src_index_',id)
						
export Key_Src_Airc := id;