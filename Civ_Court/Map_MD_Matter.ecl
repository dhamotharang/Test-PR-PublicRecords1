IMPORT Civ_Court, civil_court, ut, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/md_civil_02.mp

fMD := Civ_Court.File_In_MD;

//Temp layout with party names to normalize and capture case_title from first record to match party module
l_temp	:= RECORD
Civil_Court.Layout_In_Matter;
string party_name;
end;

l_temp tMD(fMD input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '61';
self.state_origin				:= 'MD';
self.source_file				:= 'MD-CIVIL-COURT';
self.case_key					  := '61'+trim(input.case_number,left,right);
self.court_code					:= ut.CleanSpacesAndUpper(input.case_number)[1..4];
self.court						  := MAP(self.court_code = '0101' => 'BALTIMORE CITY COURT',
															self.court_code = '0103' => 'BALTIMORE CITY COURT',
															self.court_code = '0201' => 'DORCHESTER COUNTY COURT',
															self.court_code = '0202' => 'SOMERSET COUNTY COURT',
															self.court_code = '0203' => 'WICOMICO COUNTY COURT',
															self.court_code = '0204' => 'WORCESTER COUNTY COURT',
															self.court_code = '0205' => 'WORCESTER COUNTY COURT',
															self.court_code = '0302' => 'CECIL COUNTY COURT',
															self.court_code = '0303' => 'KENT COUNTY COURT',
															self.court_code = '0304' => 'QUEEN ANNES COUNTY COURT',
															self.court_code = '0305' => 'TALBOT COUNTY COURT',
															self.court_code = '0306' => 'CAROLINE COUNTY COURT',
															self.court_code = '0307' => 'QUEEN ANNES COUNTY COURT',
															self.court_code = '0401' => 'CALVERT COUNTY COURT',
															self.court_code = '0402' => 'CHARLES COUNTY COURT',
															self.court_code = '0403' => 'SAINT MARYS COUNTY COURT',
															self.court_code = '0501' => 'PRINCE GEORGES COUNTY COURT',
															self.court_code = '0502' => 'PRINCE GEORGES COUNTY COURT',
															self.court_code = '0601' => 'MONTGOMERY COUNTY COURT',
															self.court_code = '0602' => 'MONTGOMERY COUNTY COURT',
															self.court_code = '0701' => 'ANNE ARUNDEL COUNTY COURT',
															self.court_code = '0702' => 'ANNE ARUNDEL COUNTY COURT',
															self.court_code = '0801' => 'BALTIMORE COUNTY COURT',
															self.court_code = '0802' => 'BALTIMORE COUNTY COURT',
															self.court_code = '0803' => 'BALTIMORE COUNTY COURT',
															self.court_code = '0804' => 'BALTIMORE COUNTY COURT',
															self.court_code = '0805' => 'BALTIMORE COUNTY COURT',
															self.court_code = '0901' => 'HARFORD COUNTY COURT',
															self.court_code = '1001' => 'HOWARD COUNTY COURT',
															self.court_code = '1002' => 'CARROLL COUNTY COURT',
															self.court_code = '1101' => 'FREDERICK COUNTY COURT',
															self.court_code = '1102' => 'WASHINGTON COUNTY COURT',
															self.court_code = '1201' => 'ALLEGANY COUNTY COURT',
															self.court_code = '1202' => 'GARRETT COUNTY COURT', 'MD STATEWIDE COURT');
self.case_number				:= trim(input.case_number,left,right);
self.case_title					:= IF(trim(input.plaintiff_nm) <> '' and input.party_cd in ['TAD','DEF','AKA'], ut.CleanSpacesAndUpper(input.plaintiff_nm)+' VS '+ut.CleanSpacesAndUpper(input.party_name),'');
self.judgmt_date				:= IF(trim(input.judmt_date,left,right) <= self.process_date and input.judmt_date[1..4] > '1904',
															trim(input.judmt_date,left,right),'');
tempJudgeAmt						:= trim(input.judmt_amt,left,right);
self.award_amount				:= ut.rmv_ld_zeros(tempJudgeAmt);
self.party_name					:= ut.CleanSpacesAndUpper(CHOOSE(C,input.plaintiff_nm,input.party_name,input.plt_atty_name,input.def_atty_name));
self := [];
end;

nMD	:= normalize(fMD,4,tMD(left,counter));

//Remove records with blank name and project into common Matter layout
pMD	:= project(nMD(party_name <> ''),transform(Civil_Court.Layout_In_Matter,self := left));

//Left case_title out of dedup as it can cause duplicate records for the same case with multiple defendants
dMD 	:= dedup(sort(distribute(pMD,hash(case_key)),
                  process_date,case_key, court_code, court, case_number, judgmt_date,local),
									case_key, court_code, court, case_number, judgmt_date, award_amount,local,left):
									PERSIST('~thor_data400::in::civil_MD_matter');


EXPORT Map_MD_Matter := dMD(case_number <> '');