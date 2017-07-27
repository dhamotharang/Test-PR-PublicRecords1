import CrimSrch, Crim_Common;

string8 fMinDate2(string8 pDate1, string8 pDate2)
 := if(if((integer4)pDate1=0,'99999999',pDate1) < if((integer4)pDate2=0,'99999999',pDate2),
	   if((integer4)pDate1=0,'',pDate1),
	   if((integer4)pDate2=0,'',pDate2));

string8 fMinDate(string8 pDate1, string8 pDate2, string8 pDate3='', string8 pDate4='', string8 pDate5='', string8 pDate6='')
 := fMinDate2(pDate1,fMinDate2(pDate2,fMinDate2(pDate3,fMinDate2(pDate4,fMinDate2(pDate5,pDate6)))));

string1 fDefaultTrafficFlag(string2 pVendor)
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

CrimSrch.Layout_Moxie_Offenses_temp tCourtOffensesandCourtOffendertoOffenses(Crim_Common.Layout_Moxie_Court_Offenses pCourtOffenses,Crim_Common.Layout_Moxie_Crim_Offender2.previous pCourtOffender)
 :=
  transform
	self.date_first_reported		:= pCourtOffenses.process_date;
	self.date_last_reported			:= pCourtOffenses.process_date;
	self.offender_key				:= pCourtOffenses.offender_key;
	self.vendor						:= pCourtOffenses.vendor;
	self.state_of_origin			:= pCourtOffenses.state_origin;
	self.source_file				:= pCourtOffenses.source_file;
	self.off_name					:= pCourtOffender.pty_nm;
	self.orig_offense_key			:= trim(pCourtOffenses.offender_key)+intformat(hash(pCourtOffenses.arr_date+pCourtOffenses.arr_off_desc_1+pCourtOffenses.court_disp_date+pCourtOffenses.Court_Off_Desc_1),20,1);
	self.off_date					:= pCourtOffenses.off_date;
	self.off_code					:= '';
	self.charge						:= '';
	self.counts						:= pCourtOffenses.num_of_counts;
	self.off_desc_1					:= '';
	self.off_desc_2					:= '';
	self.off_type					:= '';
	self.off_level					:= '';
	self.sor_off_victim_minor		:= '';
	self.sor_off_victim_age			:= '';
	self.sor_off_victim_gender		:= '';
	self.sor_off_victim_relationship:= '';
	self.arrest_date				:= pCourtOffenses.arr_date;
	self.arrest_off_code			:= pCourtOffenses.arr_off_code;
	self.arrest_off_desc			:= if(pCourtOffenses.arr_off_desc_1<>'',pCourtOffenses.arr_off_desc_1,pCourtOffenses.arr_off_desc_2);
	self.arrest_off_level			:= pCourtOffenses.arr_off_lev;
	self.arrest_off_statute			:= pCourtOffenses.arr_statute;
	self.arrest_statute_desc		:= pCourtOffenses.arr_statute_desc;
	self.arrest_disp_date			:= pCourtOffenses.arr_disp_date;
	self.arrest_disp_desc			:= trim(pCourtOffenses.arr_disp_desc_1) + trim(' ' + pCourtOffenses.arr_disp_desc_2);
	self.le_agency_code				:= pCourtOffenses.le_agency_cd;
	self.le_agency_desc				:= pCourtOffenses.le_agency_desc;
	self.le_agency_case_number		:= pCourtOffenses.le_agency_case_number;
	self.traffic_ticket_number		:= pCourtOffenses.traffic_ticket_number;
	self.case_number				:= pCourtOffenses.court_case_number;
	self.court_code					:= pCourtOffenses.court_cd;
	self.court_desc					:= pCourtOffenses.court_desc;
	self.court_final_plea			:= pCourtOffenses.court_final_plea;
	self.court_off_code				:= pCourtOffenses.court_off_code;
	self.court_off_desc				:= if(pCourtOffenses.court_off_desc_1<>'',pCourtOffenses.court_off_desc_1,pCourtOffenses.court_off_desc_2);
	self.court_off_level			:= pCourtOffenses.court_off_lev;
	self.court_statute				:= pCourtOffenses.court_statute;
	self.court_statute_desc			:= if(pCourtOffenses.court_statute_desc[1..7]='Statute','',pCourtOffenses.court_statute_desc);
	self.conv_date					:= '';
	self.conv_county_code			:= '';
	self.conv_county				:= '';
	self.court_disp_date			:= pCourtOffenses.court_disp_date;
	self.court_disp_code			:= pCourtOffenses.court_disp_code;
	self.court_disp_desc			:= if(pCourtOffenses.court_disp_desc_1<>'',pCourtOffenses.court_disp_desc_1,pCourtOffenses.court_disp_desc_2);
	self.sent_date					:= pCourtOffenses.sent_date;
	self.sent_code					:= '';
	self.sent_comp					:= '';
	self.sent_desc_1				:= trim(if(pCourtOffenses.sent_jail<>'','Jail: ' + pCourtOffenses.sent_jail,'') + if(pCourtOffenses.sent_susp_time<>'','   Jail Suspended: ' + pCourtOffenses.sent_susp_time,''),left);
	self.sent_desc_2				:= if(pCourtOffenses.sent_Probation<>'','Probation: ' + pCourtOffenses.sent_Probation,'');
	self.sent_desc_3				:= trim(if(pCourtOffenses.sent_court_fine<>'','Fine: ' + fFixDollar(pCourtOffenses.sent_court_fine),'') + if(pCourtOffenses.sent_susp_court_fine<>'','   Fine Suspended: ' + fFixDollar(pCourtOffenses.sent_susp_court_fine),''),left);
	self.sent_desc_4				:= if(pCourtOffenses.sent_court_cost<>'','Court Costs: ' + fFixDollar(pCourtOffenses.sent_court_cost),'');
	self.inc_adm_date				:= '';
	self.fcra_offense_key			:= trim(pCourtOffenses.offender_key)+intformat(hash(pCourtOffenses.arr_date+pCourtOffenses.arr_off_desc_1+pCourtOffenses.court_disp_date+pCourtOffenses.Court_Off_Desc_1),20,1);
	self.fcra_conviction_flag		:= 'U';
	self.fcra_traffic_flag			:= fDefaultTrafficFlag(pCourtOffenses.Vendor);
	self.fcra_date					:= fMinDate(pCourtOffenses.arr_date,pCourtOffenses.off_date,pCourtOffenses.court_disp_date,pCourtOffender.case_filing_dt);
	self.fcra_date_type				:= case(self.fcra_date,
											pCourtOffenses.arr_date => 'A',
											pCourtOffenses.off_date => 'O',
											pCourtOffenses.court_disp_date => 'D',
											pCourtOffender.case_filing_dt => 'F',
											'U'
										   );
	self.conviction_override_date		:= if((integer4)pCourtOffenses.court_disp_date<>0,
											  pCourtOffenses.court_disp_date,
											  if((integer4)pCourtOffenses.sent_date<>0,
												 pCourtOffenses.sent_date,
												 if((integer4)pCourtOffenses.off_date<>0,
													pCourtOffenses.off_date,
													if((integer4)pCourtOffenses.arr_date<>0,
													   pCourtOffenses.arr_date,
													   pCourtOffender.case_filing_dt
													  )
												   )
												)
											 );
	self.conviction_override_date_type	:= case(self.conviction_override_date,
												pCourtOffenses.court_disp_date => 'D',
												pCourtOffenses.sent_date => 'S',
												pCourtOffenses.off_date => 'O',
												pCourtOffenses.arr_date => 'A',
												pCourtOffender.case_filing_dt => 'F',
												'U'
											   );
	self.offense_score					:= 'U';
	self := pCourtOffenses;
	
	
  self := [];
  end
 ;

//													  '1'=DOC, and we don't want them...  everything else
dCourtOffenderCourt	:= /*CrimSrch.Crim_Court_FCRA_UT_Orem_Offender
					 + */File_Crim_Offender2(data_type<>'1' and Vendor not in sCourt_Vendors_To_Omit);
dCourtOffensesDist 	:= distribute(/*CrimSrch.Crim_Court_FCRA_UT_Orem_Offenses 
								+ */File_Court_Offenses,hash(Offender_Key));
								
dCourtOffenderDist	:= distribute(dCourtOffenderCourt,hash(Offender_Key));
dCourtOffensesSort	:= sort(dCourtOffensesDist,	Offender_Key,local);
dCourtOffenderSort	:= sort(dCourtOffenderDist,	Offender_Key+pty_typ,local);
dCourtOffenderDedup	:= dedup(dCourtOffenderSort,Offender_Key,local);

dCourtOffensesJoined:= join(dCourtOffensesSort,dCourtOffenderDedup,
							left.Offender_Key = right.Offender_Key,
							tCourtOffensesandCourtOffendertoOffenses(left,right),
							local
						   );

#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
export Court_Offenses_as_CrimSrch_Offenses
 := dCourtOffensesJoined
 : persist('persist::Court_Offenses_as_CrimSrch_Offenses')
 ;
#else
export Court_Offenses_as_CrimSrch_Offenses
 := dCourtOffensesJoined
 ;
#end