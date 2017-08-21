import crim_common, Crim, ut, hygenics_crim;

/*Input File*/
df := CRIM.File_OH_Monroe(trim(sex,left,right)<> 'Sex');

//Regex patterns
num		:=	'(\\([0-9]*\\)|[0-9]+ \\([0-9]*\\)|\\([0-9]*\\) [0-9]+|[0-9]+|[0-9]+[ ]*[0-9]/[0-9]|[0-9]+)';
part_time	:= '1/2';
time_yr		:=	num+'\\)*[ ]*(1/2)*[ ]*(YEARS| YEAR| YRS| YR)';
time_mnth	:=	num+'\\)*[ ]*(1/2)*[ ]*(MONTHS| MONTH| MTHS| MTH)';
time_day		:=	num+'\\)*[ ]*(1/2)*[ ]*(DAYS| DAY| DYS| DY)';

//Parse Patterns
PATTERN ws1					:=	[' ','\t',',','(',')'];
PATTERN ws					:=	ws1 ws1?;
PATTERN	jail				:=	['PRISON','PRISION','COUNTY JAIL','TO SERVE','SHALL SERVE','SENTENCED TO','SENTNECED TO','LOCAL INCARCERATION','EOCC'];
PATTERN	dl					:=	['DRIVERS LICENSE','DRIVER LICENSE','DRIVER\'S LICENSE'];
PATTERN	suspend			:=	['SUSPENDED','SUSPENDED COSTS & RESTITUTION'] NOT AFTER (dl ws);
PATTERN	parole			:=	['COMMUNITY CONTROL','COMMUNITY CONTROL SANCTIONS','COMUNITY CONTROL','POST RELEASE CONTROL'];
PATTERN dismiss			:=	['DISMISSED'];
PATTERN	part_day		:=	['1/2'];
PATTERN	num_match		:=	[PATTERN('[0-9]')+,'TWENTY','THIRTY','FORTY','FIFTY','SIXTY','SEVENTY','EIGHTY','NINETY'] OPT(ws part_day);
PATTERN	life_match	:=	['LIFE'];
PATTERN	yr_match		:=	['YEARS','YEAR','YRS','YR'];
PATTERN	mnth_match	:=	['MONTHS','MONTH','MTHS','MTH'];
PATTERN	day_match		:=	['DAYS','DAY','DYS','DY'];

PATTERN	patWord			:=	PATTERN('[A-Z]+');


RULE	sentence1		:=	( jail | suspend | parole ) OPT(patWord ws);
RULE	sent_dismiss	:= OPT(patWord ws) dismiss OPT(patWord ws);
RULE	days				:=	( yr_match | mnth_match | day_match);
RULE	time				:=	(num_match OPT(ws)+ days | life_match);
RULE	CrimResult	:=	sentence1 ws OPT(patWord ws)+ time | time ws OPT(patWord ws)+ sentence1 | sent_dismiss;

l_CleanSent := RECORD
	df;
	string clean_sentence;
END;


l_CleanSent	cSentField(df L) := TRANSFORM
	TrimUpperSentence	:= StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(L.sentencing_information));
	StdSentence				:= map(regexfind('ONE ',TrimUpperSentence,0)<>''		=> StringLib.StringFindReplace(TrimUpperSentence,'ONE ','1'),
											regexfind('TWO ',TrimUpperSentence,0)<>''		=> StringLib.StringFindReplace(TrimUpperSentence,'TWO ','2'),
											regexfind('THREE ',TrimUpperSentence,0)<>''	=> StringLib.StringFindReplace(TrimUpperSentence,'THREE ','3'),
											regexfind('FOUR ',TrimUpperSentence,0)<>''	=> StringLib.StringFindReplace(TrimUpperSentence,'FOUR ','4'),
											regexfind('FIVE ',TrimUpperSentence,0)<>''	=> StringLib.StringFindReplace(TrimUpperSentence,'FIVE ','5'),
											regexfind('SIX ',TrimUpperSentence,0)<>''		=> StringLib.StringFindReplace(TrimUpperSentence,'SIX ','6'),
											regexfind('SEVEN ',TrimUpperSentence,0)<>''	=> StringLib.StringFindReplace(TrimUpperSentence,'SEVEN ','7'),
											regexfind('EIGHT ',TrimUpperSentence,0)<>''	=> StringLib.StringFindReplace(TrimUpperSentence,'EIGHT ','8'),
											regexfind('NINE ',TrimUpperSentence,0)<>''  => StringLib.StringFindReplace(TrimUpperSentence,'NINE ','9'),
											regexfind('TEN ',TrimUpperSentence,0)<>''  	=> StringLib.StringFindReplace(TrimUpperSentence,'TEN ','10'),
											TrimUpperSentence);
	ClnSentence							:= StringLib.StringCleanSpaces(IF(regexfind('[0-9]+[ ]*\\((.*)\\)',StdSentence), regexreplace('\\((.*)\\)',StdSentence,' '),
																													IF(regexfind('[A-Z]+[ ]*\\((.*)\\)',StdSentence), regexreplace('\\( \\)',StdSentence,' '),StdSentence)));
	SELF.clean_sentence:= ClnSentence;
	SELF	:= L;
END;

clean_out	:= project(df, cSentField(left));
																	
dup_rec	:= dedup(clean_out);

l_parsed := RECORD
	dup_rec;
//	df;
  STRING60 timePhrase			:=	MATCHTEXT(time);
  STRING30 SentencePhrase	:=	MATCHTEXT(sentence1);
END;

parse_out := PARSE(dup_rec,clean_sentence,CrimResult,l_parsed,SCAN);
srt_rec	:= dedup(sort(parse_out,case_number,description,sentencing_information));

jailpattern			:=	'[A-Z]*[ ]*(PRISON|PRISION|COUNTY JAIL|TO SERVE|SHALL SERVE|SENTENCED TO|SENTNECED TO|LOCAL INCARCERATION|EOCC)';
parolepattern		:=	'[A-Z]*[ ]*(COMMUNITY CONTROL|COMUNITY CONTROL|POST RELEASE CONTROL)';

Crim_Common.Layout_In_Court_Offenses tOHCrim(srt_rec dInput) := Transform
self.process_date		:= Crim_Common.Version_Development;
self.offender_key 	:= '91'+ ut.CleanSpacesAndUpper(dInput.case_number);
self.vendor					:= '91';
self.state_origin		:= 'OH';
self.source_file		:= 'OH-Monroe_County';
self.off_comp 				:= '';
self.off_delete_flag 	:= '';
self.off_date 				:= '';
self.arr_date 				:= '';
self.num_of_counts 		:= '';
self.le_agency_cd 		:= '';
self.le_agency_desc 	:= '';
self.le_agency_case_number := '';
self.traffic_ticket_number := '';
self.traffic_dl_no 		:= '';
self.traffic_dl_st 		:= '';
self.arr_off_code 		:= '';
self.arr_off_desc_1 	:= '';
self.arr_off_desc_2 		:= '';
self.arr_off_type_cd 		:= '';
self.arr_off_type_desc 	:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= '';
self.arr_statute_desc 	:= '';
self.arr_disp_date 			:= '';
self.arr_disp_code 			:= '';
self.arr_disp_desc_1 		:= '';
self.arr_disp_desc_2 		:= '';
self.pros_refer_cd 			:= '';
self.pros_refer 				:= '';
self.pros_assgn_cd 			:= '';
self.pros_assgn 				:= '';
self.pros_chg_rej 			:= '';
self.pros_off_code 			:= '';
self.pros_off_desc_1 		:= '';
self.pros_off_desc_2 		:= '';
self.pros_off_type_cd 	:= '';
self.pros_off_type_desc := '';
self.pros_off_lev 			:= '';
self.pros_act_filed 		:= '';
self.court_case_number 	:= ut.CleanSpacesAndUpper(dInput.case_number);
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 	:= '';
self.court_final_plea 	:= '';
self.court_off_code 		:= '';
self.court_off_desc_1 	:= ut.CleanSpacesAndUpper(dInput.description);
self.court_off_desc_2		:= '';
self.court_off_type_cd 	:= '';
self.court_off_type_desc := '';
trimDegree							:= REGEXREPLACE('[^A-Z1-9]',ut.CleanSpacesAndUpper(dInput.degree),'');
self.court_off_lev 			:= map(trimDegree = 'M1' => 'MA',
																trimDegree = 'M2' => 'MB',
																trimDegree = 'M3' => 'MC',
																trimDegree = 'M4' => 'MD',
																trimDegree = 'M5' => 'ME',
																trimDegree = 'M6' => 'MF',trimDegree);
self.court_statute 			:= ut.CleanSpacesAndUpper(dInput.section_number);
self.court_additional_statutes 	:= '';
self.court_statute_desc := '';
self.court_disp_date 		:= '';
self.court_disp_code 		:= '';
self.court_disp_desc_1	 := map(regexfind('GUILTY',dInput.sentencing_information,0)<>'' => 'GUILTY',
																regexfind('DISMIS',dInput.sentencing_information,0)<>'' => 'DISMISSED','');
self.court_disp_desc_2 	:= '';
self.sent_date 					:= ut.date_slashed_MMDDYYYY_to_YYYYMMDD(dInput.sentencing_date);

conf_flag							:= If(regexfind('LIFE',dInput.sentencing_information,0)<>'','L',
															If(regexfind(jailpattern,dInput.SentencePhrase,0)<>'','J',
																IF(regexfind('SUSPENDED',dInput.SentencePhrase,0)<>'','S',
																 IF(regexfind(parolepattern,dInput.SentencePhrase,0)<>'','P',''))));

data_yr								:= IF(dInput.timePhrase <> '' and regexfind(time_yr,dInput.timePhrase) and regexfind(part_time,dInput.timePhrase),
														regexreplace('(1/2)|[^0-9]',dInput.timePhrase,'') + ' YEAR(S)'+' 6 MONTHS',
														IF(dInput.timePhrase <> '' and regexfind(time_yr,dInput.timePhrase) and not regexfind(part_time,dInput.timePhrase),
															regexreplace('[^0-9]',dInput.timePhrase,'') + ' YEAR(S)',''));
data_month							:= IF(dInput.timePhrase <> '' and regexfind(time_mnth,dInput.timePhrase) and regexfind(part_time,dInput.timePhrase),
														regexreplace('(1/2)|[^0-9]',dInput.timePhrase,'') + ' MONTH(S)'+' 15 DAYS',
														IF(dInput.timePhrase <> '' and regexfind(time_mnth,dInput.timePhrase) and not regexfind(part_time,dInput.timePhrase),
															regexreplace('[^0-9]',dInput.timePhrase,'') + ' MONTH(S)',''));
data_day								:= IF(dInput.timePhrase <> '' and regexfind(time_day,dInput.timePhrase), regexreplace('[^0-9]',dInput.timePhrase,'') + ' DAY(S)','');

self.sent_jail 					:= StringLib.StringCleanSpaces(IF(conf_flag = 'J' and data_yr <> '', data_yr,
																												IF(conf_flag = 'J' and data_month <> '', data_month,
																												 IF(conf_flag = 'J' and data_day <> '', data_day,
																													IF(conf_flag = 'L' and regexfind('[0-9]',data_yr),data_yr + ' TO LIFE',
																														IF(conf_flag = 'L' and not regexfind('[0-9]',data_yr),'LIFE',''))))));
self.sent_susp_time 		:= StringLib.StringCleanSpaces(IF(conf_flag = 'S' and data_yr <> '', data_yr,
																												IF(conf_flag = 'S' and data_month <> '', data_month,
																												 IF(conf_flag = 'S' and data_day <> '', data_day,''))));
self.sent_court_cost 		:= '';
self.sent_court_fine 		:= '';
self.sent_susp_court_fine := '';
self.sent_probation 			:= '';
TempCC										:= StringLib.StringCleanSpaces(IF(REGEXFIND(parolepattern, dInput.clean_sentence),
																														REGEXFIND(parolepattern+'(.*)\\.',dInput.clean_sentence,0),
																														IF(REGEXFIND('DISMISSED',dInput.clean_sentence),REGEXFIND('(.*)[ ]*DISMISSED(.*)',dInput.clean_sentence,0),'')));
//CleanCC										:= StringLib.StringCleanSpaces(REGEXREPLACE('(PLEAD GUILTY|PLEAD GUILITY)(.*)\\.',TempCC,''));
self.sent_addl_prov_code 	:= '';
self.sent_addl_prov_desc_1 := TempCC[1..40];
self.sent_addl_prov_desc_2 := TempCC[41..];
self.sent_consec 						:= '';
self.sent_agency_rec_cust_ori := '';
self.sent_agency_rec_cust 		:= '';
self.appeal_date 						:= '';
self.appeal_off_disp 				:= '';
self.appeal_final_decision 	:= '';
end;

pOHCrim := project(srt_rec,tOHCrim(left));

srtOHCrim	:= pOHCrim;
//output(srtOHCrim);
CrimJail	 := srtOHCrim(trim(sent_jail,all) <> '' and trim(court_disp_desc_1,all) <> 'DISMISSED');
CrimNojail := srtOHCrim(trim(sent_jail,all) = ''and trim(court_disp_desc_1,all) <> 'DISMISSED');
// CrimJail	 := sort(srtOHCrim(trim(sent_jail,all) <> '' and trim(court_disp_desc_1,all) <> 'DISMISSED'),
                    // court_case_number,court_statute,court_off_lev,sent_date,local);
// CrimNojail := sort(srtOHCrim(trim(sent_jail,all) = ''and trim(court_disp_desc_1,all) <> 'DISMISSED'),
                    // court_case_number,court_statute,court_off_lev,sent_date,local);										
CrimDismiss := srtOHCrim(trim(court_disp_desc_1,all) = 'DISMISSED'); //To avoid adding jail info to a dismissed case record

//Join to combine multiple records
Crim_Common.Layout_In_Court_Offenses JoinIt(CrimJail L, CrimNojail R) := TRANSFORM
	self.sent_jail := IF(L.sent_jail <> '',L.sent_jail,R.sent_jail);
	self.sent_susp_time	:= IF(R.sent_susp_time <> '',R.sent_susp_time,L.sent_susp_time);
	self := L;
	self := R;
END;

JoinCrim	:=	join(CrimJail,  CrimNojail,
								left.court_case_number = right.court_case_number and
								left.court_statute = right.court_statute and
								left.court_off_lev = right.court_off_lev and
								left.sent_date = right.sent_date,
								JoinIt(LEFT,RIGHT), full outer, local);
								
AppendDismiss	:= JoinCrim+CrimDismiss;

fOHOffend:= dedup(sort(distribute(AppendDismiss(offender_key <> ''),hash(offender_key)),
									offender_key,court_case_number,court_statute,court_off_lev,court_disp_desc_1,sent_date,sent_jail,sent_susp_time,local),
									record,local):
									PERSIST('~thor_dell400::persist::Crim_OH_Monroe_Offenses_Clean');


EXPORT Map_OH_Monroe_Offenses := fOHOffend;