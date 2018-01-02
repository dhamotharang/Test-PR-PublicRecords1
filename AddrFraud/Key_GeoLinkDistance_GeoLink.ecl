import doxie, ut, data_services;

GEO_LIMIT := 50; // max number of geoblk-geoblk associations to keep

geo2geo := functions.FileDistance( GEO_LIMIT );

layout_out := record
	string12 geolink1;
	string12 geolink2;
	unsigned2 dist_100th; // distance in hundreths of a mile, converted from a REAL in order that the key be index on it
end;

out := project( geo2geo, transform( layout_out, self.dist_100th := (unsigned2)round(left.distance*100), self := left ) );

export Key_GeoLinkDistance_GeoLink := index( out, {out.geolink1, dist_100th}, {out},
	data_services.data_location.prefix() + 'thor_data400::key::addrfraud::geolink_to_geolink::geolink_dist_100th_'+ doxie.Version_SuperKey );