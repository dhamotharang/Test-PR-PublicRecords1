IMPORT Civ_Court, civil_court, ut, lib_StringLib , STD; 

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/mi_civil_county_saginaw02.mp

fSaginaw := Civ_court.File_In_MI_Saginaw;

fmtsin := [
		'%m/%d/%Y',
		'%Y-%m-%d'
	];
fmtout := '%Y%m%d';

unsigned Date_YY_to_YYYY(unsigned yy, unsigned delta=5) := FUNCTION
	unsigned now	:= (unsigned)Std.Date.Today();
	unsigned high	:= (unsigned)now[1..4] + delta;
	unsigned test	:= yy + ((unsigned)now[1..2]*100);
	unsigned yyyy	:= if(test<=high, test, test-100);
	RETURN yyyy;
END;

Civil_Court.Layout_In_Matter tSaginaw(fSaginaw input) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '56';
self.state_origin				:= 'MI';
self.source_file				:= 'MI-CIV-SAGINAW-CO';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_num);
self.case_key					  := '56'+UpperCaseNum;
self.court_code					:= '';
self.court							:= 'COUNTY OF SAGINAW 70TH DISTRICT STATE COURT';
self.case_number				:= UpperCaseNum;
self.case_type					:= ut.CleanSpacesAndUpper(input.case_type);
self.case_title					:= ut.CleanSpacesAndUpper(input.case_title);
TempFileDte							:= IF(trim(input.filed_date,all) <> '', ut.ConvertDateMultiple(input.filed_date,fmtsin,fmtout), '');
self.filing_date				:= IF(STD.DATE.IsValidDate((INTEGER) TempFileDte),TempFileDte,'');
TempJgmtDispDate				:= IF(REGEXFIND('FINAL DISPOSITION',input.activity1),ut.ConvertDateMultiple(input.activity_date1,fmtsin,fmtout),
														IF(REGEXFIND('FINAL DISPOSITION',input.activity2),ut.ConvertDateMultiple(input.activity_date1,fmtsin,fmtout),
															IF(REGEXFIND('FINAL DISPOSITION',input.activity3),ut.ConvertDateMultiple(input.activity_date1,fmtsin,fmtout),
															 IF(REGEXFIND('FINAL DISPOSITION',input.activity4),ut.ConvertDateMultiple(input.activity_date1,fmtsin,fmtout),''))));
self.judgmt_disposition_date := IF(STD.DATE.IsValidDate((INTEGER) TempJgmtDispDate),TempJgmtDispDate,'');
self.judgmt_disposition	:= IF(REGEXFIND('FINAL DISPOSITION',input.activity1),trim(REGEXFIND('(.*) - (.*)',input.activity1,2),left,right),
														IF(REGEXFIND('FINAL DISPOSITION',input.activity2),trim(REGEXFIND('(.*) - (.*)',input.activity2,2),left,right),
															IF(REGEXFIND('FINAL DISPOSITION',input.activity3),trim(REGEXFIND('(.*) - (.*)',input.activity3,2),left,right),
															 IF(REGEXFIND('FINAL DISPOSITION',input.activity4),trim(REGEXFIND('(.*) - (.*)',input.activity4,2),left,right),''))));
TempDispDate					:= IF(trim(input.disposition_date,all) <> '',ut.ConvertDateMultiple(input.disposition_date,fmtsin,fmtout), '');
StdDispDate						 := IF(LENGTH(TempDispDate)<8,
														(string)Date_YY_to_YYYY((integer)TempDispDate[1..2])+TempDispDate[3..4]+TempDispDate[5..6],
														TempDispDate);
self.disposition_date := IF(STD.DATE.IsValidDate((INTEGER) StdDispDate),StdDispDate,'');
TempAwardAmt			:= IF(STD.Str.Find(input.activity1,'$',1) > 0,input.activity1[STD.Str.Find(input.activity1,'$',1)-1..],
											 IF(STD.Str.Find(input.activity2,'$',1) > 0,input.activity2[STD.Str.Find(input.activity2,'$',1)-1..],
												IF(STD.Str.Find(input.activity3,'$',1) > 0,input.activity1[STD.Str.Find(input.activity3,'$',1)-1..],
													IF(STD.Str.Find(input.activity4,'$',1) > 0,input.activity4[STD.Str.Find(input.activity4,'$',1)-1..],''))));
CleanAmount				:= REGEXFIND('[0-9]+(,)*[0-9]*',TempAwardAmt,0);
self.award_amount := StringLib.StringFilter(CleanAmount,'0123456789');
self := [];
END;

pSaginaw 	:= project(fSaginaw,tSaginaw(left));

srt_output := sort(pSaginaw,case_number,case_title,case_type,filing_date);

Civil_Court.Layout_In_Matter PopDisp(srt_output L, srt_output R) := TRANSFORM
	self.judgmt_disposition_date	:=  IF(L.judgmt_disposition_date = '', R.judgmt_disposition_date,L.judgmt_disposition_date);
	self.judgmt_disposition				:=	IF(L.judgmt_disposition = '',R.judgmt_disposition,L.judgmt_disposition);
	self.disposition_date					:= 	IF(L.disposition_date = '',R.disposition_date,L.disposition_date);
	self.award_amount							:=	IF(L.award_amount = '',R.award_amount,L.award_amount);
	self													:= L;
END;

rDisposition	:= rollup(srt_output, PopDisp(left,right),case_number,case_title,case_type,filing_date);

dSaginaw 	:= dedup(sort(distribute(rDisposition,hash(case_key)),
                  process_date,case_key, court, case_number, case_type,
									case_title, filing_date,judgmt_disposition_date,
									judgmt_disposition, disposition_date, local),
									case_key, court, case_number, case_type,
									case_title, filing_date,judgmt_disposition_date,
									judgmt_disposition, disposition_date, local,left):
									PERSIST('~thor_data400::in::civil_MI_Saginaw_matter');

EXPORT Map_MI_Saginaw_Matter := dSaginaw(case_number <> '');