import corrections,Hygenics_crim  ;

	
string8 fMinDate2(string8 pDate1, string8 pDate2)
 := if(if((integer4)pDate1=0,'99999999',pDate1) < if((integer4)pDate2=0,'99999999',pDate2),
	   if((integer4)pDate1=0,'',pDate1),
	   if((integer4)pDate2=0,'',pDate2));

string8 fMinDate(string8 pDate1, string8 pDate2, string8 pDate3='', string8 pDate4='', string8 pDate5='', string8 pDate6='')
 := fMinDate2(pDate1,fMinDate2(pDate2,fMinDate2(pDate3,fMinDate2(pDate4,fMinDate2(pDate5,pDate6)))));

string1 fDefaultTrafficFlag(string5 pVendor)
 := if(pVendor in sCourt_Vendors_With_No_Traffic,
	   'N',
	   if(pVendor in sCourt_Vendors_With_Only_Traffic,
		  'Y',
		  'U'
		 )
	  );

string fFixDollar(string pAmount)
 := trim('$'
 +	intformat((integer8)truncate((real8)pAmount / 100),15,0)
 +	'.'
 +	intformat((integer1)pAmount % 100,2,1),all)
 ;

hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory tCourtOffensesandCourtOffendertoOffenses(hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory pCourtOffenses, corrections.layout_offender pCourtOffender)
 := transform
	self.fcra_offense_key			:= trim(pCourtOffenses.offender_key)+intformat(hash(pCourtOffenses.arr_date+pCourtOffenses.arr_off_desc_1+pCourtOffenses.court_disp_date+pCourtOffenses.Court_Off_Desc_1),20,1);
	self.fcra_conviction_flag	:= 'U';
	self.fcra_traffic_flag		:= fDefaultTrafficFlag(pCourtOffenses.Vendor);
  // Prev Logic  commented 20140905	
	/*self.fcra_date						:= fMinDate(pCourtOffenses.arr_date,pCourtOffenses.off_date,pCourtOffenses.court_disp_date,pCourtOffender.case_date);
	  self.fcra_date_type				:= case(self.fcra_date,
																	pCourtOffenses.arr_date => 'A',
																	pCourtOffenses.off_date => 'O',
																	pCourtOffenses.court_disp_date => 'D',
																	pCourtOffender.case_date => 'F',
																	'U'
																	);	*/
																	
	self.fcra_date	          := Map(hygenics_crim._functions.Is_valid(hygenics_crim._functions.getdate, pCourtOffenses.court_disp_date) = 'Y' => pCourtOffenses.court_disp_date,
	                                 hygenics_crim._functions.Is_valid(hygenics_crim._functions.getdate, pCourtOffenses.convict_dt)      = 'Y' => pCourtOffenses.convict_dt,
																	 hygenics_crim._functions.Is_valid(hygenics_crim._functions.getdate, pCourtOffenses.sent_date)       = 'Y' => pCourtOffenses.sent_date,
																	// Is_valid(hygenics_crim._functions.getdate, pCourtOffenses.inc_adm_date) = 'Y'    => pCourtOffenses.inc_adm_date,
                                   '');
  self.fcra_date_type	      := Map(hygenics_crim._functions.Is_valid(hygenics_crim._functions.getdate, pCourtOffenses.court_disp_date) = 'Y' => 'D',
	                                 hygenics_crim._functions.Is_valid(hygenics_crim._functions.getdate, pCourtOffenses.convict_dt)      = 'Y' => 'C',
																	 hygenics_crim._functions.Is_valid(hygenics_crim._functions.getdate, pCourtOffenses.sent_date)       = 'Y' => 'S',
																	 //Valid_date(hygenics_crim._functions.getdate, pCourtOffenses.inc_adm_date) = 'Y'    => 'I',
                                   '');																	 

	self.conviction_override_date		:= if((integer4)pCourtOffenses.court_disp_date<>0,
																				pCourtOffenses.court_disp_date,
																			if((integer4)pCourtOffenses.sent_date<>0,
																				pCourtOffenses.sent_date,
																			if((integer4)pCourtOffenses.off_date<>0,
																				pCourtOffenses.off_date,
																			if((integer4)pCourtOffenses.arr_date<>0,
																				pCourtOffenses.arr_date,
																				pCourtOffender.case_date
																				)
																				)
																				)
																				);
	self.conviction_override_date_type	:= case(self.conviction_override_date,
																					pCourtOffenses.court_disp_date => 'D',
																					pCourtOffenses.sent_date => 'S',
																					pCourtOffenses.off_date => 'O',
																					pCourtOffenses.arr_date => 'A',
																					pCourtOffender.case_date => 'F',
																					'U'
																					);
	self.arr_off_lev_mapped 		:= pCourtOffenses.arr_off_lev_mapped;
	self.court_off_lev_mapped 	:= pCourtOffenses.court_off_lev_mapped;
	self.offense_score					:= 'U';
	// self.offense_category       := 0;
	self 												:= pCourtOffenses;
	self												:= pCourtOffender;
end;

//'1'=DOC, and we don't want them...  everything else
dCourtOffenderCourt	:= Hygenics_crim.File_Offenders(data_type<>'1');
dCourtOffensesDist 	:= distribute(Hygenics_crim.File_Court_Offenses,hash(Offender_Key));
								
dCourtOffenderDist	:= distribute(dCourtOffenderCourt,hash(Offender_Key));
dCourtOffensesSort	:= sort(dCourtOffensesDist,	Offender_Key,local);
dCourtOffenderSort	:= sort(dCourtOffenderDist,	Offender_Key+pty_typ,local);
dCourtOffenderDedup	:= dedup(dCourtOffenderSort,Offender_Key,local);

dCourtOffensesJoined:= join(dCourtOffensesSort,dCourtOffenderDedup,
													left.Offender_Key = right.Offender_Key,
													tCourtOffensesandCourtOffendertoOffenses(left,right),
													local):persist('~thor_data200::persist::Court_Offenses_as_CrimSrch_Offenses');

export Court_Offenses_as_CrimSrch_Offenses := dCourtOffensesJoined;
