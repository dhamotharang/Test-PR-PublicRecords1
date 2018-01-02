import doxie_build, ut, header, gong, risk_indicators,doxie, data_services;

// #if(Risk_Indicators.iid_constants.validation_debug)
	// head := dataset(ut.foreign_prod+'thor_data400::base::headerkey_building', header.Layout_Header_v2, flat);
// #else
	head := doxie_build.file_header_building;
// #end

earliest := Constants.YearsAgo(8)[1..6];

head_valid := head(
	dt_first_seen != 0,
	dt_last_seen > (unsigned3)earliest,
	prim_name[1..6] != 'PO BOX',
	trim(st)!='',
	trim(county)!='',
	trim(geo_blk)!=''
);

a2d   := Functions.AddrToDid( head_valid, true );

// explicitly cast to strings just to be sure no qstring vs string hashing affects distribution
a2d_dist   := distribute( a2d,                  hash((string2)st+(string3)county+(string7)geo_blk) );
coord_dist := distribute( File_GeoBlock_Info(), hash(geolink));

// join to the geolink file before doing the heavy processing, as the inner join removes geo blocks we believe are inadequate (reduces processing)
Layouts.Address AddCoords( a2d_dist le, coord_dist ri ) := TRANSFORM
	self.geolink := ri.geolink;
	self.latitude  := (real4)ri.lat;
	self.longitude := (real4)ri.long;
	
	self.dt_first_seen := (unsigned4)( (string)le.dt_first_seen + '01' );
	self.dt_last_seen  := (unsigned4)( (string)le.dt_last_seen  + '01' );

	// we're calculating by geo block, so blank out the specific address components.
	self.prim_range := '';
	self.predir     := '';
	self.prim_name  := '';
	self.suffix     := '';
	self.postdir    := '';
	self.unit_desig := '';
	self.sec_range  := '';
	
	self := le;
END;

a2d_with_coord := join( a2d_dist, coord_dist,
	left.st=right.geolink[1..2] and left.county=right.geolink[3..5] and left.geo_blk=right.geolink[6..12],
	AddCoords(LEFT,RIGHT), local, keep(1) );

fraud := Address_Risk.BuildRiskDataset( a2d_with_coord );																		
																			
export Key_AddrFraud_GeoLink := index( fraud,
	{fraud.geolink},
	{fraud},
    data_services.data_location.prefix() + 'thor_data400::key::addrrisk_geolink_' + doxie.Version_SuperKey);