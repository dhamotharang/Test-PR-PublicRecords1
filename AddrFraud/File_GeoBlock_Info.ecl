import address_attributes, ut;

layout_geo_ll := RECORD
	string12 geolink;
	string10 lat;
	string11 long;
END;

//change this once the census data and address cleaner have been updated file_Census2010_geoblks;
base := Address_Attributes.file_blockgroup.file_Census2000_geoblks;

layout_geo_ll makeInfo(base l) := transform
	self := l;
	self := [];
end;

final := project(base, makeInfo(left));

export File_GeoBlock_Info := final;
