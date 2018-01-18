import doxie, data_services;

GEO_LIMIT := 50; // max number of geoblk-geoblk associations to keep

geo2geo := functions.FileDistance( GEO_LIMIT );

export Key_Distance_GeoLinkToGeoLink := index( geo2geo, {geo2geo.geolink1, geo2geo.geolink2}, {geo2geo.distance},
	data_services.data_location.prefix() + 'thor_data400::key::addrfraud::geolink_to_geolink::geolink1geolink2_'+ doxie.Version_SuperKey);
