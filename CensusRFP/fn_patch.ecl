import ut;
//1915 and 1997

in_census := DATASET(ut.foreign_prod + 'thor::results::census_bureau_rfp::nmnjmi::4', CensusRFP.Layout_Final, THOR);

//cleanup phones
CensusRFP.Mac_validate_phones(in_census,listed_phone_num,,,clean_listed_phones)
CensusRFP.Mac_validate_phones(clean_listed_phones,alternate_phone_num,,,clean_alternate_phones)

//clean dates 

clean_census := project(clean_alternate_phones, transform(CensusRFP.Layout_Final,

self.dob := if(left.dob[1..2] = '00', '01' + left.dob[3..], left.dob),

self.listed_phone_status_date := if(left.listed_phone_status_date[1..2] = '00', '01' + left.listed_phone_status_date[3..], left.listed_phone_status_date),

self.alternate_phone_status_date := if(left.alternate_phone_status_date[1..2] = '00', '01' + left.alternate_phone_status_date[3..],left.alternate_phone_status_date),

self.email_address_activity_date := if(left.email_address_activity_date[1..2] = '00', '01' + left.email_address_activity_date[3..], left.email_address_activity_date),

self := left));


clean_census_1 := project(clean_census, transform(CensusRFP.Layout_Final,

self.listed_phone_type := if(left.listed_phone_num <> '', left.listed_phone_type, ''),
self.listed_phone_status := if(left.listed_phone_num <> '', left.listed_phone_status, ''),
self.listed_phone_status_date := if(left.listed_phone_num <> '', left.listed_phone_status_date, ''),
self.alternate_phone_type := if(left.alternate_phone_num <> '', left.alternate_phone_type, ''),
self.alternate_phone_status := if(left.alternate_phone_num <> '', left.alternate_phone_status, ''),
self.alternate_phone_status_date := if(left.alternate_phone_num <> '', left.alternate_phone_status_date, ''),

self.email_address_activity_date := 
if(left.email_address_activity_date[3..4] = '00' or (unsigned)left.email_address_activity_date[3..4] > 31 , left.email_address_activity_date[1..2] + '01' + left.email_address_activity_date[5..], left.email_address_activity_date),

self := left));


OUTPUT(clean_census_1,,'~thor::results::census_bureau_rfp::nmnjmi::5',COMPRESSED,OVERWRITE);


/*ds := CensusRFP.Mac_Run();

OUTPUT(ds,,'~thor::results::census_bureau_rfp::nmnjmi',COMPRESSED,OVERWRITE);
OUTPUT(ENTH(ds,1,9000),,'~thor::results::census_bureau_rfp::nmnjmi::sample',COMPRESSED,OVERWRITE);

OUTPUT(ENTH(ds,1,9000),,'~thor::results::census_bureau_rfp::nmnjmi::sample.csv',
		       CSV(HEADING(1),SEPARATOR('|'),TERMINATOR('\n')),OVERWRITE);*/
					 
					 
					 
					 
ds1 := DATASET('~thor::results::census_bureau_rfp::nmnjmi::5', CensusRFP.Layout_Final, THOR);
ds := ENTH(ds1,1,9000);

SEQUENTIAL(
OUTPUT(ds,,'~thor::results::census_bureau_rfp::nmnjmi::sample.csv',
		       CSV(HEADING(SINGLE),SEPARATOR(','),TERMINATOR('\n')),OVERWRITE),
					 
fileservices.Despray('~thor::results::census_bureau_rfp::nmnjmi::sample.csv',
	'edata12-bld.br.seisint.com',
	'/export/home/wma/censusRFP/new_sample.csv',
	allowoverwrite := true)
);
	





