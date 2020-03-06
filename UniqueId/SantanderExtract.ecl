IMPORT STD, _Control;
f := UniqueId.File_AllData;

lists := [
'EU CONSOLIDATED LIST',
'OFAC NON-SDN ENTITIES',
'OFAC SANCTIONS',
'OFAC SDN',
'PRIMARY MONEY LAUNDERING CONCERN',
'PRIMARY MONEY LAUNDERING CONCERN - JURISDICTIONS',
'UN CONSOLIDATED LIST'
];

w := f(WatchListName in lists);

Entities := PROJECT(w, TRANSFORM(UniqueId.Layout_Santander.rEntity,
					self.comments := Std.Uni.SubstituteIncluded(left.comments,U'\r\n',U' ');
					self := left;));

akas := NORMALIZE(w, left.aka_list.aka, TRANSFORM(UniqueId.Layout_Santander.rAliases,
						self.Entity_Unique_ID := LEFT.Entity_Unique_ID;
						self := RIGHT;));

addr := NORMALIZE(w, left.address_list.address, 
						TRANSFORM(UniqueId.Layout_Santander.rAddresses,
						self.Entity_Unique_ID := LEFT.Entity_Unique_ID;
						self := RIGHT;));

info := NORMALIZE(w, left.additional_info_list.additionalinfo, 
									TRANSFORM(UniqueId.Layout_Santander.rInfo,
						self.Entity_Unique_ID := LEFT.Entity_Unique_ID;
						self := RIGHT;));

ids := NORMALIZE(w, left.identification_list.identification, 
								TRANSFORM(UniqueId.Layout_Santander.rIds,
						self.Entity_Unique_ID := LEFT.Entity_Unique_ID;
						self := RIGHT;));

phones := NORMALIZE(w, left.phone_number_list.phones, 
								TRANSFORM(UniqueId.Layout_Santander.rPhones,
						self.Entity_Unique_ID := LEFT.Entity_Unique_ID;
						self := RIGHT;));

							
// *** country reports
lfn1 := '~thor::uniqueid::hpcc-uid-ofacsanctions.xml';
c1 := PROJECT(DATASET(lfn1, UniqueId.Layout_Watchlist.rGeo, 
									XML('Watchlist/Country_List/Country')),
					TRANSFORM(UniqueId.Layout_Watchlist.rGeo,
					self.WatchListName := 'OFAC SANCTIONS';
					self := left;));

lfn2 := '~thor::uniqueid::hpcc-uid-primarymoneylaunderingconcern-jurisdictions.xml ';
c2 := PROJECT(DATASET(lfn2, UniqueId.Layout_Watchlist.rGeo, 
									XML('Watchlist/Country_List/Country')),
					TRANSFORM(UniqueId.Layout_Watchlist.rGeo,
					self.WatchListName := 'PRIMARY MONEY LAUNDERING CONCERN - JURISDICTIONS';
					self := left;));

c := c1 + c2;

Countries := PROJECT(c, UniqueId.Layout_Santander.rCountry);

countryakas := NORMALIZE(c, left.aka_list.aka, TRANSFORM(UniqueId.Layout_Santander.rCountryAka,
						self.Entity_Unique_ID := LEFT.Entity_Unique_ID;
						self := RIGHT;));

locations := NORMALIZE(c, left.location_list.location, TRANSFORM(UniqueId.Layout_Santander.rLocation,
						self.Entity_Unique_ID := LEFT.Entity_Unique_ID;
						self := RIGHT;));

// ***
records := SORT(
						TABLE(Entities, {Entities.WatchListName, records := COUNT(GROUP)}, 
							WatchListName, few) +
						TABLE(Countries, {Countries.WatchListName, records := COUNT(GROUP)}, 
							WatchListName, few),							
							WatchListName);

ip := _Control.IPAddress.bctlpedata10;

path := '/data/hds_3/uniqueid/santander/';

UnsprayReport(string lfn) := 		STD.file.Despray(
					'~thor::uniqueid::santander::' + lfn,
			ip,
			path + lfn + '.csv',
			allowoverwrite := true);
			
DespraySantander := PARALLEL(
	UnsprayReport('entities'),
	UnsprayReport('akas'),
	UnsprayReport('addresses'),
	UnsprayReport('info'),
	UnsprayReport('identifiers'),
	UnsprayReport('phones'),
	UnsprayReport('countries'),
	UnsprayReport('countryakas'),
	UnsprayReport('locations'),
	UnsprayReport('counts')
);

EXPORT SantanderExtract := SEQUENTIAL(
OUTPUT(Entities,,'~thor::uniqueid::santander::entities', 
						CSV(HEADING(SINGLE),SEPARATOR(','),TERMINATOR('\n'),QUOTE('"')),OVERWRITE),
OUTPUT(akas,,'~thor::uniqueid::santander::akas', 
						CSV(HEADING(SINGLE),SEPARATOR(','),TERMINATOR('\n'),QUOTE('"')),OVERWRITE),
OUTPUT(addr,,'~thor::uniqueid::santander::addresses', 
						CSV(HEADING(SINGLE),SEPARATOR(','),TERMINATOR('\n'),QUOTE('"')),OVERWRITE),
OUTPUT(info,,'~thor::uniqueid::santander::info', 
						CSV(HEADING(SINGLE),SEPARATOR(','),TERMINATOR('\n'),QUOTE('"')),OVERWRITE),
OUTPUT(ids,,'~thor::uniqueid::santander::identifiers', 
						CSV(HEADING(SINGLE),SEPARATOR(','),TERMINATOR('\n'),QUOTE('"')),OVERWRITE),
OUTPUT(phones,,'~thor::uniqueid::santander::phones', 
						CSV(HEADING(SINGLE),SEPARATOR(','),TERMINATOR('\n'),QUOTE('"')),OVERWRITE),
OUTPUT(Countries,,'~thor::uniqueid::santander::countries',
						CSV(HEADING(SINGLE),SEPARATOR(','),TERMINATOR('\n'),QUOTE('"')),OVERWRITE),
OUTPUT(countryakas,,'~thor::uniqueid::santander::countryakas',
						CSV(HEADING(SINGLE),SEPARATOR(','),TERMINATOR('\n'),QUOTE('"')),OVERWRITE),
OUTPUT(Locations,,'~thor::uniqueid::santander::locations',
						CSV(HEADING(SINGLE),SEPARATOR(','),TERMINATOR('\n'),QUOTE('"')),OVERWRITE),
OUTPUT(records,,'~thor::uniqueid::santander::counts',
						CSV(HEADING('Watch List,Count',SINGLE),SEPARATOR(','),TERMINATOR('\n'),QUOTE('"')),OVERWRITE),

DespraySantander
);







	