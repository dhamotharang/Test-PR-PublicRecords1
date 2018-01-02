import aca, doxie, risk_indicators, ut, data_services;

df := ACA.key_aca_addr;

layout_ACA_geolink := record
		string12		geolink;
		qstring10 	geo_lat;
		qstring11 	geo_long;
		recordof(df);
end;

//reclean address to create geolink
layout_ACA_geolink AddressClean(df l) := TRANSFORM
		//cleaned data
		street_address := l.prim_range + ' ' + l.predir + ' ' + l.prim_name + ' ' + l.postdir;
		clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(street_address, l.v_city_name, l.st, (string)l.z5);
		self.geo_lat := clean_address[146..155];
		self.geo_long := clean_address[156..166];
		//build geolink for AddrRisk
		self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
		self := l;
end;

Cleaned := project(df, AddressClean(Left));

export key_aca_geolink := index(Cleaned,{geolink}, {Cleaned}, data_services.data_location.prefix() + 'thor_Data400::key::neighborhood::'+doxie.Version_SuperKey+'::aca_institutions_geolink');