import CrimSrch, Crim_Common;

string8 fMinDate2(string8 pDate1, string8 pDate2)
 := if(if((integer4)pDate1=0,'99999999',pDate1) < if((integer4)pDate2=0,'99999999',pDate2),
	   if((integer4)pDate1=0,'',pDate1),
	   if((integer4)pDate2=0,'',pDate2));

string8 fMinDate(string8 pDate1, string8 pDate2, string8 pDate3='', string8 pDate4='', string8 pDate5='', string8 pDate6='')
 := fMinDate2(pDate1,fMinDate2(pDate2,fMinDate2(pDate3,fMinDate2(pDate4,fMinDate2(pDate5,pDate6)))));

string1 fMapOffenseTypeToScore(string2 pVendor, string1 pOffenseType)
 := map(
    pVendor = 'AR' and pOffenseType = '	' => 'U',
		pVendor = 'AL' and pOffenseType = '	' => 'U', //added 20110317
		pVendor = 'AZ' and pOffenseType = '	' => 'U',
		pVendor = 'CO' and pOffenseType = '	' => 'U',
		pVendor = 'CT' and pOffenseType = '	' => 'U',
		pVendor = 'DC' and pOffenseType = '	' => 'U',
		pVendor = 'FL' and pOffenseType = '	' => 'U',
		pVendor = 'GA' and pOffenseType = 'F' => 'F',
		pVendor = 'GA' and pOffenseType = 'M' => 'M',
		pVendor = 'GA' and pOffenseType = '	' => 'U',
		pVendor = 'IA' and pOffenseType = '	' => 'U',
		pVendor = 'ID' and pOffenseType = 'F' => 'F',
		pVendor = 'ID' and pOffenseType = 'M' => 'M',
		pVendor = 'IL' and pOffenseType = '	' => 'U',
		pVendor = 'IN' and pOffenseType = '	' => 'U',
		pVendor = 'KS' and pOffenseType = '	' => 'U',
		pVendor = 'KS' and pOffenseType = 'M' => 'M',
		pVendor = 'KS' and pOffenseType = 'F' => 'F',
		pVendor = 'KY' and pOffenseType = '	' => 'U',
		pVendor = 'MD' and pOffenseType = '	' => 'U',
		pVendor = 'ME' and pOffenseType = '	' => 'U',
		pVendor = 'MI' and pOffenseType = '	' => 'U',
		pVendor = 'MN' and pOffenseType = '	' => 'U',
		pVendor = 'MO' and pOffenseType = '	' => 'U',
		pVendor = 'MS' and pOffenseType = '	' => 'U',
		pVendor = 'MT' and pOffenseType = '	' => 'U',
		pVendor = 'NC' and pOffenseType = '	' => 'U',
		pVendor = 'NC' and pOffenseType = 'M' => 'M',
		pVendor = 'NC' and pOffenseType = 'U' => 'U',
		pVendor = 'NC' and pOffenseType = 'F' => 'F',
		pVendor = 'NE' and pOffenseType = 'M' => 'M',
		pVendor = 'NE' and pOffenseType = 'F' => 'F',
		pVendor = 'NE' and pOffenseType = '	' => 'U',
		pVendor = 'NH' and pOffenseType = '	' => 'U',
		pVendor = 'NJ' and pOffenseType = '	' => 'U',
		pVendor = 'NM' and pOffenseType = '	' => 'U',
		pVendor = 'NV' and pOffenseType = '	' => 'U',
		pVendor = 'NY' and pOffenseType = 'F' => 'F',
		pVendor = 'NY' and pOffenseType = '	' => 'U',
		pVendor = 'OH' and pOffenseType = '	' => 'U',
		pVendor = 'OK' and pOffenseType = '	' => 'U',
		pVendor = 'OR' and pOffenseType = 'M' => 'M',
		pVendor = 'OR' and pOffenseType = 'F' => 'F',
		pVendor = 'OR' and pOffenseType = '	' => 'U',
		pVendor = 'OR' and pOffenseType = 'C' => 'U',
		pVendor = 'PA' and pOffenseType = '	' => 'U',
		pVendor = 'RI'  											=> 'U',
		pVendor = 'SC' and pOffenseType = '	' => 'U',
		pVendor = 'TN' and pOffenseType = '	' => 'U',
		pVendor = 'TX' and pOffenseType = '	' => 'U',
		pVendor = 'UT' and pOffenseType = 'U' => 'U',
		pVendor = 'UT' and pOffenseType = 'F' => 'F',
		pVendor = 'UT' and pOffenseType = 'D' => 'U',
		pVendor = 'UT' and pOffenseType = 'M' => 'M',
		pVendor = 'UT' and pOffenseType = 'I' => 'U',
		pVendor = 'UT' and pOffenseType = 'S' => 'S',
		pVendor = 'VA' and pOffenseType = '	' => 'U',
		pVendor = 'WA' and pOffenseType = '	' => 'U',
		pVendor = 'WI' and pOffenseType = '	' => 'U',
		'U'
	   )
 ;

string1 fMapOffenseLevelToScore(string2 pVendor, string2 pOffenseLevel, string8 pdate)
 := map(		
    pVendor = 'AR'                          => 'U',
		pVendor = 'AL' and pOffenseLevel = '  ' => 'F', //added 20110317
		pVendor = 'AZ' and pOffenseLevel = '5 ' => 'F',
		pVendor = 'AZ' and pOffenseLevel = '6 ' => 'F',
		pVendor = 'AZ' and pOffenseLevel = '4 ' => 'F',
		pVendor = 'AZ' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'AZ' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'AZ' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'AZ' and pOffenseLevel = '  ' => 'U',
		pVendor = 'CO' and pOffenseLevel = '  ' => 'U', //added 20110317
		pVendor = 'CT' and pOffenseLevel = 'AF' => 'F', //added 20110317
		pVendor = 'CT' and pOffenseLevel = 'BF' => 'F', //added 20110317
		pVendor = 'CT' and pOffenseLevel = 'CF' => 'F', //added 20110317
		pVendor = 'CT' and pOffenseLevel = 'DF' => 'F', //added 20110317
		pVendor = 'CT' and pOffenseLevel = 'AM' => 'M', //added 20110317
		pVendor = 'CT' and pOffenseLevel = 'BM' => 'M', //added 20110317
		pVendor = 'CT' and pOffenseLevel = 'CM' => 'M', //added 20110317
		pVendor = 'CT' and pOffenseLevel = 'F ' => 'F', //added 20110317
		pVendor = 'CT' and pOffenseLevel = 'M ' => 'M', //added 20110317
		pVendor = 'CT' and pOffenseLevel = '  ' => 'U', //added 20110317
		pVendor = 'DC' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'DC' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'DC' and pOffenseLevel = '  ' => 'U',
		pVendor = 'FL' and pOffenseLevel = 'P ' => 'M',
		pVendor = 'FL' and pOffenseLevel = '5 ' => 'F',
		pVendor = 'FL' and pOffenseLevel = 'C ' => 'U',
		pVendor = 'FL' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'FL' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'FL' and pOffenseLevel = 'L ' => 'U',
		pVendor = 'FL' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'FL' and pOffenseLevel = '  ' => 'U',
		pVendor = 'GA' and pOffenseLevel = '  ' => 'U',
		pVendor = 'IA' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'IA' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'ID' and pOffenseLevel = '  ' => 'F',
		pVendor = 'IL' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'IL' and pOffenseLevel = 'U ' => 'F',
		pVendor = 'IL' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'IL' and pOffenseLevel = '  ' => 'U',
		pVendor = 'IL' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'IL' and pOffenseLevel = 'X ' => 'F',
		pVendor = 'IL' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'IL' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'IL' and pOffenseLevel = '4 ' => 'F',
		pVendor = 'IL' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'IL' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'IN' and pOffenseLevel = 'FD' => 'F',
		pVendor = 'IN' and pOffenseLevel = 'MC' => 'M',
		pVendor = 'IN' and pOffenseLevel = 'CC' => 'U',
		pVendor = 'IN' and pOffenseLevel = 'FB' => 'F',
		pVendor = 'IN' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'IN' and pOffenseLevel = 'MA' => 'M',
		pVendor = 'IN' and pOffenseLevel = 'XX' => 'U',
		pVendor = 'IN' and pOffenseLevel = 'MB' => 'M',
		pVendor = 'IN' and pOffenseLevel = 'HO' => 'U',
		pVendor = 'IN' and pOffenseLevel = 'FA' => 'F',
		pVendor = 'IN' and pOffenseLevel = 'FC' => 'F',
		pVendor = 'KS' and pOffenseLevel = '  ' => 'U',
		pVendor = 'KS' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'KS' and pOffenseLevel = 'D ' => 'F',
		pVendor = 'KS' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'KS' and pOffenseLevel = 'E ' => 'F',
		pVendor = 'KS' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'KS' and pOffenseLevel = 'U ' => 'U',
		pVendor = 'KY' and pOffenseLevel = 'FA' => 'F',
		pVendor = 'KY' and pOffenseLevel = 'FB' => 'F',
		pVendor = 'KY' and pOffenseLevel = 'FC' => 'F',
		pVendor = 'KY' and pOffenseLevel = 'FD' => 'F',
		pVendor = 'KY' and pOffenseLevel = 'FX' => 'F',
		pVendor = 'MD' and pOffenseLevel = '  ' => 'U', //added 20110317
		pVendor = 'ME' and pOffenseLevel = '  ' => 'U',
		pVendor = 'MI' and pOffenseLevel = '  ' => 'F',
		pVendor = 'MN' and pOffenseLevel = '  ' => 'F',
		pVendor = 'MO' and pOffenseLevel = '  ' => 'F',
		pVendor = 'MS' and pOffenseLevel = '  ' => 'F',
		pVendor = 'MT' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'MT' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'MT' and pOffenseLevel = '  ' => 'U',
		pVendor = 'NC' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'NC' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'A1' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'B2' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'NC' and pOffenseLevel = '  ' => 'U',
		pVendor = 'NC' and pOffenseLevel = 'B1' => 'F',
		pVendor = 'NC' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'D ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'I ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'G ' => 'F',
		pVendor = 'NC' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'H ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'J ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'E ' => 'F',
		pVendor = 'NE' and pOffenseLevel = '  ' => 'U',
		pVendor = 'NE' and pOffenseLevel = 'I ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'E ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'D ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'H ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'NE' and pOffenseLevel = 'G ' => 'F',
		pVendor = 'NH' and pOffenseLevel = '  ' => 'U',
		pVendor = 'NJ'                          => 'U',
		pVendor = 'NM' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'NM' and pOffenseLevel = '  ' => 'U',
		pVendor = 'NM' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'NV'                          => 'F',
		pVendor = 'NY'                          => 'F',
		pVendor = 'OH' and pdate[1..4] >='1996' => 'F',
		pVendor = 'OK' 													=> 'F',
		pVendor = 'OR' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'OR' and pOffenseLevel = '  ' => 'U',
		pVendor = 'OR' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'OR' and pOffenseLevel = 'U ' => 'F',
		pVendor = 'OR' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'OR' and pOffenseLevel = 'O ' => 'F',
		pVendor = 'PA'                          => 'U',
		pVendor = 'RI'  											  => 'U',
		pVendor = 'SC' 													=> 'U',
		pVendor = 'TN'                          => 'F',
		pVendor = 'TX' and pOffenseLevel = 'F'  => 'F',
		pVendor = 'TX' and pOffenseLevel = 'M'  => 'M',
		pVendor = 'TX' and pOffenseLevel = ' '  => 'U',
		pVendor = 'UT' and pOffenseLevel = 'N ' => 'F',
		pVendor = 'UT' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'UT' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'UT' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'UT' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'UT' and pOffenseLevel = '  ' => 'U',
		pVendor = 'UT' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'UT' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'UT' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'VA' and pOffenseLevel = '  ' => 'U',
		pVendor = 'WA' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'WA' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'WI' and pOffenseLevel = '  ' => 'U',
		pVendor = 'WV' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'WV' and pOffenseLevel = 'M ' => 'M',
		'U'
	   )
 ;

Layout_Moxie_Offenses_temp tDOCOffensesandDOCOffendertoOffenses(Crim_Common.Layout_Moxie_DOC_Offenses.previous pDOCOffenses,Crim_Common.Layout_Moxie_Crim_Offender2.previous pDOCOffender)
 :=
  transform
	self.date_first_reported		:= pDOCOffenses.process_date;
	self.date_last_reported			:= pDOCOffenses.process_date;
	self.offender_key				:= pDOCOffenses.offender_key;
	self.vendor						:= pDOCOffenses.vendor;
	self.state_of_origin			:= pDOCOffenses.vendor;
	self.source_file				:= pDOCOffenses.source_file;
	self.off_name					:= pDOCOffender.pty_nm;
	self.orig_offense_key			:= pDOCOffenses.offense_key;
	self.off_date					:= pDOCOffenses.off_date;
	self.off_code					:= pDOCOffenses.off_code;
	self.charge						:= pDOCOffenses.chg;
	self.counts						:= pDOCOffenses.num_of_counts;
	self.off_desc_1					:= pDOCOffenses.off_desc_1;
	self.off_desc_2					:= pDOCOffenses.off_desc_2;
	self.off_type					:= pDOCOffenses.off_typ;
	self.off_level					:= pDOCOffenses.off_lev;
	self.sor_off_victim_minor		:= '';
	self.sor_off_victim_age			:= '';
	self.sor_off_victim_gender		:= '';
	self.sor_off_victim_relationship:= '';
	self.arrest_date				:= pDOCOffenses.arr_date;
	self.arrest_off_code			:= '';
	self.arrest_off_desc			:= '';
	self.arrest_off_level			:= '';
	self.arrest_off_statute			:= '';
	self.arrest_statute_desc		:= '';
	self.arrest_disp_date			:= '';
	self.arrest_disp_desc			:= '';
	self.le_agency_code				:= '';
	self.le_agency_desc				:= '';
	self.le_agency_case_number		:= '';
	self.traffic_ticket_number		:= '';
	self.case_number				:= pDOCOffenses.case_num;
	self.court_code					:= pDOCOffenses.court_cd;
	self.court_desc					:= pDOCOffenses.court_desc;
	self.court_final_plea			:= pDOCOffenses.ct_fnl_plea;
	self.court_off_code				:= pDOCOffenses.ct_off_code;
	self.court_off_desc				:= pDOCOffenses.ct_off_desc_1;
	self.court_off_level			:= pDOCOffenses.ct_off_lev;
	self.court_statute				:= '';
	self.court_statute_desc			:= '';
	self.conv_date					:= '';
	self.conv_county_code			:= pDOCOffenses.cty_conv_cd;
	self.conv_county				:= pDOCOffenses.cty_conv;
	self.court_disp_date			:= pDOCOffenses.ct_disp_dt;
	self.court_disp_code			:= pDOCOffenses.ct_disp_cd;
	self.court_disp_desc			:= pDOCOffenses.ct_disp_desc_1;
	self.sent_date					:= pDOCOffenses.stc_dt;
	self.sent_code					:= pDOCOffenses.stc_cd;
	self.sent_comp					:= pDOCOffenses.stc_comp;
	self.sent_desc_1 				:= pDOCOffenses.stc_desc_1;
	self.sent_desc_2				:= pDOCOffenses.stc_desc_2;
	self.sent_desc_3				:= if(pDOCOffenses.stc_lgth_desc<>'','Sentence description: ' + pDOCOffenses.stc_lgth_desc,'');
	self.sent_desc_4				:= trim(if(pDOCOffenses.min_term_desc<>'','Minimum term: ' + pDOCOffenses.min_term_desc,'') + if(pDOCOffenses.max_term_desc<>'','  Max term desc: ' + pDOCOffenses.max_term_desc,''),left);
	self.inc_adm_date				:= pDOCOffenses.inc_adm_dt;
	self.fcra_offense_key			:= trim(pDOCOffenses.offender_key)+pDOCOffenses.offense_key;
	self.fcra_conviction_flag		:= if(pDOCOffenses.Vendor in CrimSrch.sDOC_Vendors_Conviction_Unknown,'U','D');		// accommodate states where conviction unknown
	self.fcra_traffic_flag			:= 'N';
	self.fcra_date					:= fMinDate(pDOCOffenses.inc_adm_dt,pDOCOffenses.stc_dt,pDOCOffenses.ct_disp_dt,pDOCOffender.case_filing_dt);
	self.fcra_date_type				:= case(self.fcra_date,
											pDOCOffenses.inc_adm_dt => 'I',
											pDOCOffenses.stc_dt => 'S',
											pDOCOffenses.ct_disp_dt => 'D',
											pDOCOffender.case_filing_dt => 'F',
											'U'
										   );
	self.conviction_override_date		:= if(pDOCOffenses.Vendor in CrimSrch.sDOC_Vendors_Conviction_Unknown,
											  ' ',
											  if((integer4)pDOCOffenses.ct_disp_dt<>0,
												 pDOCOffenses.ct_disp_dt,
												 if((integer4)pDOCOffenses.inc_adm_dt<>0,
													pDOCOffenses.inc_adm_dt,
													if((integer4)pDOCOffenses.off_date<>0,
													   pDOCOffenses.off_date,
													   pDOCOffenses.arr_date
													  )
												   )
												)
											 );
	self.conviction_override_date_type	:= if(pDOCOffenses.Vendor in CrimSrch.sDOC_Vendors_Conviction_Unknown,
											  ' ',
											  case(self.conviction_override_date,
												   pDOCOffenses.ct_disp_dt => 'D',
												   pDOCOffenses.inc_adm_dt => 'I',
												   pDOCOffenses.off_date => 'O',
												   pDOCOffenses.arr_date => 'A',
												   'U'
											      )
											 );
	self.offense_score					:= 'U';
	self := pDOCOffenses;
	self := [];
  end
 ;

dDOCOffenderNoAKA	:= File_Crim_Offender2(data_type='1' and pty_typ='0');
dDOCOffensesDist 	:= distribute(File_DOC_Offenses,hash(Offender_Key));
dDOCOffenderDist	:= distribute(dDOCOffenderNoAKA,hash(Offender_Key));
dDOCOffensesSort	:= sort(dDOCOffensesDist,	Offender_Key,local);
dDOCOffenderSort	:= sort(dDOCOffenderDist,	Offender_Key,local);
dDOCOffenderDedup	:= dedup(dDOCOffenderSort,Offender_Key,local);

dDOCOffensesJoined	:= join(dDOCOffensesSort,dDOCOffenderDedup,
							left.Offender_Key = right.Offender_Key,
							tDOCOffensesandDOCOffendertoOffenses(left,right),
							left outer,
							local
						   );

Layout_Moxie_Offenses_temp tScoreOffenseOnType(Layout_Moxie_Offenses_temp pInput)
 :=
  transform
	self.offense_score		:= fMapOffenseTypeToScore(pInput.vendor,pInput.off_type);
	self					:= pInput;
  end
 ;

dDOCOffensesScoredOnType	:= project(dDOCOffensesJoined,tScoreOffenseOnType(left));

Layout_Moxie_Offenses_temp tScoreOffenseOnLevel(Layout_Moxie_Offenses_temp pInput)
 :=
  transform
	self.offense_score		:= if(pInput.offense_score<>'U',pInput.offense_score,fMapOffenseLevelToScore(pInput.vendor,pInput.off_level,pInput.inc_adm_date));
	self					:= pInput;
  end
 ;

dDOCOffensesScoredOnLevel	:= project(dDOCOffensesScoredOnType,tScoreOffenseOnLevel(left));										

#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
export DOC_Offenses_as_CrimSrch_Offenses
 := dDOCOffensesScoredOnLevel
 : persist('persist::DOC_Offenses_as_CrimSrch_Offenses')
 ;
#else
export DOC_Offenses_as_CrimSrch_Offenses
 := dDOCOffensesScoredOnLevel
 ;
#end