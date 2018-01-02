import address_attributes, doxie, data_services;

L := record
	qstring12 geolink;
	integer4 lat1000;
	real4 lat;
	real4 lon;
end;

//updated to use actual Census2000 geoblk data- when the 2010 Census data comes on line, switch to file_Census2010_geoblks
base := AddrFraud.File_GeoBlock_Info;  

L format( base le ) := TRANSFORM
	self.geolink := le.geolink;
	self.lat1000 := round(1000*(real4)le.lat);
	self.lat := (real4)le.lat;
	self.lon := (real4)le.long;
END;
slim := project( base, format(left) );


export Key_GeoLink_LatLon := index( slim, {lat1000}, {geolink,lat,lon}, data_services.data_location.prefix() + 'thor_data400::key::addrfraud::geoblk_latlon_'+ doxie.Version_SuperKey );