import civil_court, crim_common;


STRING8 FromDD_MMM_YY(STRING date) := FUNCTION

  day := IF(date[3]='-',date[1..2],'0'+date[1]);
	month_pos := IF(date[3]='-',4,3);
	mon_temp	:= StringLib.StringToUpperCase(date[month_pos..month_pos+2]);
	string2 month := CASE(mon_temp, 
												'JAN' => '01',
												'FEB' => '02',
												'MAR' => '03',
												'APR' => '04',
												'MAY' => '05',
												'JUN' => '06',
												'JUL' => '07',
												'AUG' => '08',
												'SEP' => '09',
												'OCT' => '10',
												'NOV' => '11',
												'DEC' => '12',
												'00'
											 );
	string4	year := IF(date[month_pos+4..month_pos+5]<thorlib.wuid()[4..5]+1,'20','19') + date[month_pos+4..month_pos+5];
	return year + month + day;
END;

//PLANTIFF RECORDS////////////////////////////////////////////////////////////
fKentPlan 	:= Civ_Court.File_In_MI_Kent.old(plaintiff_name<>'' and plaintiff_name<>'PLAINTIFF_NAME' and plaintiff_name<>'Plaintiff Name');

Civil_Court.Layout_In_Matter tMICiv1(fKentPlan input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
self.process_date				:= civil_court.Version_Development;
self.vendor						:='93';
self.state_origin				:='MI';
self.source_file				:='(CV)MI-KentCntyCivil';
self.case_key					:='93'+trim(input.case_number,left,right)+hash32(input.plaintiff_name + input.defendant_name);
self.parent_case_key			:='';
self.court_code					:='';
self.court						:='Kent County';
self.case_number				:= trim(input.case_number,left,right);
self.case_type_code				:= '';
self.case_type					:= '';
self.case_title					:= '';
self.case_cause_code			:= '';
self.case_cause					:= '';
self.manner_of_filing_code		:= '';
self.manner_of_filing			:= '';
self.filing_date				:= '';
self.manner_of_judgmt_code		:= '';
self.manner_of_judgmt			:= '';
self.judgmt_date				:= if(fSlashedMDYtoCYMD(trim(input.judgement_date[1..10],left,right))[1..2] >= '19' 
									and fSlashedMDYtoCYMD(trim(input.judgement_date[1..10],left,right)) < self.process_date,
									fSlashedMDYtoCYMD(trim(input.judgement_date[1..10],left,right)), 
									FromDD_MMM_YY(input.judgement_date[1..10]));
self.ruled_for_against_code		:= if(regexfind('Defendant',input.in_favor_of),
									'A',
									if(regexfind('Plaintiff',input.in_favor_of),
									'F',
									''));
self.ruled_for_against			:= if(regexfind('Defendant',input.in_favor_of),
									'Against',
									if(regexfind('Plaintiff',input.in_favor_of),
									'For',
									''));
self.judgmt_type_code			:= '';
self.judgmt_type				:= trim(input.judgement,left,right);
self.judgmt_disposition_date	:= '';
self.judgmt_disposition_code	:= '';
self.judgmt_disposition			:= '';
self.disposition_code			:= '';
self.disposition_description	:= '';
self.disposition_date			:= '';
self.suit_amount				:= '';
self.award_amount				:= regexreplace('\\$|\\,|\\.',if(regexfind('\\$',input.amount,0)<>'',
									regexreplace('\\"',input.amount,''),
									if(regexfind('\\$',input.amount,0)=''and regexfind('\\.[0-9]$',trim(input.amount,left,right),0)<>'',
									'$'+regexreplace('\\"',input.amount,'')+'0',
									if(regexfind('\\$',input.amount,0)='' and regexfind('\\.',trim(input.amount,left,right),0)='',
									'$'+regexreplace('\\"',input.amount,'')+'.00',
									if(regexfind('\\$',input.amount,0)='',
									'$'+regexreplace('\\"',input.amount,''),
									regexreplace('\\"',input.amount,''))))),'');
end;

pKentPlan 	:= project(fKentPlan,tMICiv1(left));

//DEFENDANT RECORDS////////////////////////////////////////////////////////////
fKentDef 	:= Civ_Court.File_In_MI_Kent.old(defendant_name<>'' and defendant_name<>'DEFENDANT_NAME' and defendant_name<>'Defendant Name');

Civil_Court.Layout_In_Matter tMICiv(fKentDef input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date				:= civil_court.Version_Development;
self.vendor						:='93';
self.state_origin				:='MI';
self.source_file				:='(CV)MI-KentCntyCivil';
self.case_key					:='93'+trim(input.case_number,left,right)+hash32(input.plaintiff_name + input.defendant_name);
self.parent_case_key			:='';
self.court_code					:='';
self.court						:='Kent County';
self.case_number				:= trim(input.case_number,left,right);
self.case_type_code				:= '';
self.case_type					:= '';
self.case_title					:= '';
self.case_cause_code			:= '';
self.case_cause					:= '';
self.manner_of_filing_code		:= '';
self.manner_of_filing			:= '';
self.filing_date				:= '';
self.manner_of_judgmt_code		:= '';
self.manner_of_judgmt			:= '';
self.judgmt_date				:= if(fSlashedMDYtoCYMD(trim(input.judgement_date[1..10],left,right))[1..2] >= '19' 
									and fSlashedMDYtoCYMD(trim(input.judgement_date[1..10],left,right)) < self.process_date,
									fSlashedMDYtoCYMD(trim(input.judgement_date[1..10],left,right)), 
									FromDD_MMM_YY(input.judgement_date[1..10]));
self.ruled_for_against_code		:= if(regexfind('Defendant',input.in_favor_of),
									'F',
									if(regexfind('Plaintiff',input.in_favor_of),
									'A',
									''));
self.ruled_for_against			:= if(regexfind('Defendant',input.in_favor_of),
									'For',
									if(regexfind('Plaintiff',input.in_favor_of),
									'Against',
									''));
self.judgmt_type_code			:= '';
self.judgmt_type				:= trim(input.judgement,left,right);
self.judgmt_disposition_date	:= '';
self.judgmt_disposition_code	:= '';
self.judgmt_disposition			:= '';
self.disposition_code			:= '';
self.disposition_description	:= '';
self.disposition_date			:= '';
self.suit_amount				:= '';
self.award_amount				:= regexreplace('\\$|\\,|\\.',if(regexfind('\\$',input.amount,0)<>'',
									regexreplace('\\"',input.amount,''),
									if(regexfind('\\$',input.amount,0)=''and regexfind('\\.[0-9]$',trim(input.amount,left,right),0)<>'',
									'$'+regexreplace('\\"',input.amount,'')+'0',
									if(regexfind('\\$',input.amount,0)='' and regexfind('\\.',trim(input.amount,left,right),0)='',
									'$'+regexreplace('\\"',input.amount,'')+'.00',
									if(regexfind('\\$',input.amount,0)='',
									'$'+regexreplace('\\"',input.amount,''),
									regexreplace('\\"',input.amount,''))))),'');
end;

pKentDef 	:= project(fKentDef,tMICiv(left));

//NEW PLANTIFF RECORDS////////////////////////////////////////////////////////////
fKentPlanNew 	:= Civ_Court.File_In_MI_Kent.new(plaintiff_name<>'' and plaintiff_name<>'PLAINTIFF_NAME' and plaintiff_name<>'Plaintiff Name');

Civil_Court.Layout_In_Matter tMICiv3(fKentPlanNew input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date				:= civil_court.Version_Development;
self.vendor						:='93';
self.state_origin				:='MI';
self.source_file				:='(CV)MI-KentCntyCivil';
self.case_key					:='93'+trim(input.case_number,left,right)+hash32(input.plaintiff_name + input.defendant_name);
self.parent_case_key			:='';
self.court_code					:='';
self.court						:='Kent County';
self.case_number				:= trim(input.case_number,left,right);
self.case_type_code				:= '';
self.case_type					:= '';
self.case_title					:= '';
self.case_cause_code			:= '';
self.case_cause					:= '';
self.manner_of_filing_code		:= '';
self.manner_of_filing			:= '';
self.filing_date				:= '';
self.manner_of_judgmt_code		:= '';
self.manner_of_judgmt			:= '';
self.judgmt_date				:= if(fSlashedMDYtoCYMD(trim(input.judgement_date[1..10],left,right))[1..2] >= '19' 
									and fSlashedMDYtoCYMD(trim(input.judgement_date[1..10],left,right)) < self.process_date,
									fSlashedMDYtoCYMD(trim(input.judgement_date[1..10],left,right)), 
									FromDD_MMM_YY(input.judgement_date[1..10]));
self.ruled_for_against_code		:= if(regexfind('Defendant',input.in_favor_of),
									'A',
									if(regexfind('Plaintiff',input.in_favor_of),
									'F',
									''));
self.ruled_for_against			:= if(regexfind('Defendant',input.in_favor_of),
									'Against',
									if(regexfind('Plaintiff',input.in_favor_of),
									'For',
									''));
self.judgmt_type_code			:= '';
self.judgmt_type				:= trim(input.judgement,left,right);
self.judgmt_disposition_date	:= '';
self.judgmt_disposition_code	:= '';
self.judgmt_disposition			:= '';
self.disposition_code			:= '';
self.disposition_description	:= '';
self.disposition_date			:= '';
self.suit_amount				:= '';
self.award_amount				:= regexreplace('\\$|\\,|\\.',if(regexfind('\\$',input.amount,0)<>'',
									regexreplace('\\"',input.amount,''),
									if(regexfind('\\$',input.amount,0)=''and regexfind('\\.[0-9]$',trim(input.amount,left,right),0)<>'',
									'$'+regexreplace('\\"',input.amount,'')+'0',
									if(regexfind('\\$',input.amount,0)='' and regexfind('\\.',trim(input.amount,left,right),0)='',
									'$'+regexreplace('\\"',input.amount,'')+'.00',
									if(regexfind('\\$',input.amount,0)='',
									'$'+regexreplace('\\"',input.amount,''),
									regexreplace('\\"',input.amount,''))))),'');
end;

pKentPlan2 	:= project(fKentPlanNew,tMICiv3(left));

//NEW DEFENDANT RECORDS////////////////////////////////////////////////////////////
fKentDefNew 	:= Civ_Court.File_In_MI_Kent.new(defendant_name<>'' and defendant_name<>'DEFENDANT_NAME' and defendant_name<>'Defendant Name');

Civil_Court.Layout_In_Matter tMICiv4(fKentDefNew input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date				:= civil_court.Version_Development;
self.vendor						:='93';
self.state_origin				:='MI';
self.source_file				:='(CV)MI-KentCntyCivil';
self.case_key					:='93'+trim(input.case_number,left,right)+hash32(input.plaintiff_name + input.defendant_name);
self.parent_case_key			:='';
self.court_code					:='';
self.court						:='Kent County';
self.case_number				:= trim(input.case_number,left,right);
self.case_type_code				:= '';
self.case_type					:= '';
self.case_title					:= '';
self.case_cause_code			:= '';
self.case_cause					:= '';
self.manner_of_filing_code		:= '';
self.manner_of_filing			:= '';
self.filing_date				:= '';
self.manner_of_judgmt_code		:= '';
self.manner_of_judgmt			:= '';
self.judgmt_date				:= if(fSlashedMDYtoCYMD(trim(input.judgement_date[1..10],left,right))[1..2] >= '19' 
									and fSlashedMDYtoCYMD(trim(input.judgement_date[1..10],left,right)) < self.process_date,
									fSlashedMDYtoCYMD(trim(input.judgement_date[1..10],left,right)), 
									FromDD_MMM_YY(input.judgement_date[1..10]));
self.ruled_for_against_code		:= if(regexfind('Defendant',input.in_favor_of),
									'F',
									if(regexfind('Plaintiff',input.in_favor_of),
									'A',
									''));
self.ruled_for_against			:= if(regexfind('Defendant',input.in_favor_of),
									'For',
									if(regexfind('Plaintiff',input.in_favor_of),
									'Against',
									''));
self.judgmt_type_code			:= '';
self.judgmt_type				:= trim(input.judgement,left,right);
self.judgmt_disposition_date	:= '';
self.judgmt_disposition_code	:= '';
self.judgmt_disposition			:= '';
self.disposition_code			:= '';
self.disposition_description	:= '';
self.disposition_date			:= '';
self.suit_amount				:= '';
self.award_amount				:= regexreplace('\\$|\\,|\\.',if(regexfind('\\$',input.amount,0)<>'',
									regexreplace('\\"',input.amount,''),
									if(regexfind('\\$',input.amount,0)=''and regexfind('\\.[0-9]$',trim(input.amount,left,right),0)<>'',
									'$'+regexreplace('\\"',input.amount,'')+'0',
									if(regexfind('\\$',input.amount,0)='' and regexfind('\\.',trim(input.amount,left,right),0)='',
									'$'+regexreplace('\\"',input.amount,'')+'.00',
									if(regexfind('\\$',input.amount,0)='',
									'$'+regexreplace('\\"',input.amount,''),
									regexreplace('\\"',input.amount,''))))),'');
end;

pKentDef2 	:= project(fKentDefNew,tMICiv4(left));

//CONCATENATED RECORDS////////////////////////////////////////////////////////
pKent := pKentPlan+pKentDef+pKentPlan2 + pKentDef2;

dKent 	:= dedup(sort(distribute(pKent,hash(case_key)),
									case_key,court,case_type,filing_date,-judgmt_date,local),
									case_key,court,case_type,local,left):
									PERSIST('~thor_200::in::civil_MI_Kent_matter');

export Map_MI_Kent_Matter := dKent;