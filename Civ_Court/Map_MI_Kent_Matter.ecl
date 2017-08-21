import civil_court, crim_common;

//PLANTIFF RECORDS////////////////////////////////////////////////////////////
fKentPlan 	:= Civ_Court.File_In_MI_Kent(plaintiff_name<>'' and plaintiff_name<>'PLAINTIFF_NAME' and plaintiff_name<>'Plaintiff Name');

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
									'');
self.ruled_for_against_code		:= if(trim(input.in_favor_of,left,right)='Defendant',
									'A',
									if(trim(input.in_favor_of,left,right)='Plantiff',
									'F',
									''));
self.ruled_for_against			:= if(trim(input.in_favor_of,left,right)='Defendant',
									'Against',
									if(trim(input.in_favor_of,left,right)='Plantiff',
									'For',
									''));
self.judgmt_type_code			:= '';
self.judgmt_type				:= '';
self.judgmt_disposition_date	:= '';
self.judgmt_disposition_code	:= '';
self.judgmt_disposition			:= '';
self.disposition_code			:= '';
self.disposition_description	:= '';
self.disposition_date			:= '';
self.suit_amount				:= '';
self.award_amount				:= regexreplace('\\$|\\,|\\.',if(regexfind('\\$',input.judgement,0)<>'',
									regexreplace('\\"',input.judgement,''),
									if(regexfind('\\$',input.judgement,0)=''and regexfind('\\.[0-9]$',trim(input.judgement,left,right),0)<>'',
									'$'+regexreplace('\\"',input.judgement,'')+'0',
									if(regexfind('\\$',input.judgement,0)='' and regexfind('\\.',trim(input.judgement,left,right),0)='',
									'$'+regexreplace('\\"',input.judgement,'')+'.00',
									if(regexfind('\\$',input.judgement,0)='',
									'$'+regexreplace('\\"',input.judgement,''),
									regexreplace('\\"',input.judgement,''))))),'');
end;

pKentPlan 	:= project(fKentPlan,tMICiv1(left));

//DEFENDANT RECORDS////////////////////////////////////////////////////////////
fKentDef 	:= Civ_Court.File_In_MI_Kent(defendant_name<>'' and defendant_name<>'DEFENDANT_NAME' and defendant_name<>'Defendant Name');

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
									'');
self.ruled_for_against_code		:= if(trim(input.in_favor_of,left,right)='Defendant',
									'F',
									if(trim(input.in_favor_of,left,right)='Plantiff',
									'A',
									''));
self.ruled_for_against			:= if(trim(input.in_favor_of,left,right)='Defendant',
									'For',
									if(trim(input.in_favor_of,left,right)='Plantiff',
									'Against',
									''));
self.judgmt_type_code			:= '';
self.judgmt_type				:= '';
self.judgmt_disposition_date	:= '';
self.judgmt_disposition_code	:= '';
self.judgmt_disposition			:= '';
self.disposition_code			:= '';
self.disposition_description	:= '';
self.disposition_date			:= '';
self.suit_amount				:= '';
self.award_amount				:= regexreplace('\\$|\\,|\\.',if(regexfind('\\$',input.judgement,0)<>'',
									regexreplace('\\"',input.judgement,''),
									if(regexfind('\\$',input.judgement,0)=''and regexfind('\\.[0-9]$',trim(input.judgement,left,right),0)<>'',
									'$'+regexreplace('\\"',input.judgement,'')+'0',
									if(regexfind('\\$',input.judgement,0)='' and regexfind('\\.',trim(input.judgement,left,right),0)='',
									'$'+regexreplace('\\"',input.judgement,'')+'.00',
									if(regexfind('\\$',input.judgement,0)='',
									'$'+regexreplace('\\"',input.judgement,''),
									regexreplace('\\"',input.judgement,''))))),'');
end;

pKentDef 	:= project(fKentDef,tMICiv(left));

//CONCATENATED RECORDS////////////////////////////////////////////////////////
pKent := pKentPlan+pKentDef;

dKent 	:= dedup(sort(distribute(pKent,hash(case_key)),
									case_key,court,case_type,filing_date,-judgmt_date,local),
									case_key,court,case_type,local,left):
									PERSIST('~thor_200::in::civil_MI_Kent_matter');

export Map_MI_Kent_Matter := dKent;