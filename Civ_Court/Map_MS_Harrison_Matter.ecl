IMPORT Civ_Court, civil_court, ut, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ms_civil_county_harrison02.mp

fMS := Civ_Court.Files_In_MS_Harrison.Civil;


Civil_Court.Layout_In_Matter tMS(fMS input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '97';
self.state_origin				:= 'MS';
self.source_file				:= 'MS-HARRISON_CTY';
self.case_key					  := '97'+ut.CleanSpacesAndUpper(input.case_num);
self.court_code					:= '';
self.court						  := 'HARRISON COUNTY';
self.case_number				:= ut.CleanSpacesAndUpper(input.case_num);
self.case_type_code			:= '';
self.case_type					:= ut.CleanSpacesAndUpper(input.case_type);
self.filing_date				:= IF(input.file_date = '10000000','',input.file_date);
self.judgmt_disposition_date := IF(input.disposition_date = '10000000','',input.disposition_date);
ClnDisposition					:= REGEXREPLACE('PASS TO FILES|UNKNOWN',input.disposition,'',NOCASE);
self.judgmt_disposition := ut.CleanSpacesAndUpper(input.disposition);
self := [];
end;

pMS 	:= project(fMS,tMS(left));

//Rollup to remove unnecessary duplicate records with blank diposition from previous normalization
srtMS	:= sort(distribute(pMS,hash(case_key)),case_key,case_type,-filing_date,local);

Civil_Court.Layout_In_Matter RollMS(srtMS L, srtMS R) := TRANSFORM
	self.judgmt_disposition_date	:= IF(L.judgmt_disposition_date = '',R.judgmt_disposition_date,L.judgmt_disposition_date);
	self.judgmt_disposition				:= IF(L.judgmt_disposition = '',R.judgmt_disposition,L.judgmt_disposition);
	self	:= L;
END;

RollItUp	:= rollup(srtMS, RollMS(LEFT,RIGHT),case_key,case_type,filing_date,local);

ddMS 	:= dedup(sort(distribute(RollItUp,hash(case_key)),
                  process_date, case_key, court, case_number, case_type, 
									filing_date, judgmt_disposition_date,judgmt_disposition,local),
									case_key, court, case_number, case_type, filing_date,
									judgmt_disposition_date,judgmt_disposition,local,left):
									PERSIST('~thor_data400::in::civil_ms_harrison_matter');

EXPORT Map_MS_Harrison_Matter := ddMS(case_number <> '');