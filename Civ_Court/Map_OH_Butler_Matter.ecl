import civil_court, crim_common;

//PLANTIFF RECORDS////////////////////////////////////////////////////////////
fButlerPlan 	:= Civ_Court.File_In_OH_Butler(plaintiff<>'' and plaintiff<>'PLAINTIFF' and plaintiff<>'Plaintiff');

Civil_Court.Layout_In_Matter tMICiv1(fButlerPlan input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date				:= civil_court.Version_Development;
self.vendor						:='94';
self.state_origin				:='OH';
self.source_file				:='(CV)OH-ButlerCntyCivil';
self.case_key					:='94'+trim(input.case_num,left,right)+hash32(input.plaintiff + input.defendant);
self.parent_case_key			:='';
self.court_code					:='';
self.court						:='Butler County';
self.case_number				:= trim(input.case_num,left,right);
self.case_type_code				:= trim(input.type_,left,right);//trim(input.type_descrip,left,right);
self.case_type					:= trim(input.type_descrip,left,right);//trim(input.type_,left,right);
self.case_title					:= regexreplace(trim(input.case_num,left,right),trim(input.caption,left,right),'');
self.case_cause_code			:= '';
self.case_cause					:= '';
self.manner_of_filing_code		:= '';
self.manner_of_filing			:= '';
self.filing_date				:= if(fSlashedMDYtoCYMD(input.case_filed)<>'',
									fSlashedMDYtoCYMD(input.case_filed),
									'');
self.manner_of_judgmt_code		:= '';
self.manner_of_judgmt			:= '';
self.judgmt_date				:= '';
self.ruled_for_against_code		:= '';
self.ruled_for_against			:= '';
self.judgmt_type_code			:= '';
self.judgmt_type				:= '';
self.judgmt_disposition_date	:= '';
self.judgmt_disposition_code	:= '';
self.judgmt_disposition			:= '';
self.disposition_code			:= '';
self.disposition_description	:= '';
self.disposition_date			:= if(fSlashedMDYtoCYMD(input.disp_status_dt)<>'' and fSlashedMDYtoCYMD(input.disp_status_dt)<>'00000000',
									fSlashedMDYtoCYMD(input.disp_status_dt),
									'');
self.suit_amount				:= '';
self.award_amount				:= '';
end;

pButlerPlan 	:= project(fButlerPlan,tMICiv1(left));

//DEFENDANT RECORDS////////////////////////////////////////////////////////////
fButlerDef 	:= Civ_Court.File_In_OH_Butler(defendant<>'' and defendant<>'DEFENDANT' and defendant<>'Defendant');

Civil_Court.Layout_In_Matter tMICiv(fButlerDef input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date				:= civil_court.Version_Development;
self.vendor						:='94';
self.state_origin				:='OH';
self.source_file				:='(CV)OH-ButlerCntyCivil';
self.case_key					:='94'+trim(input.case_num,left,right)+hash32(input.plaintiff + input.defendant);
self.parent_case_key			:='';
self.court_code					:='';
self.court						:='Butler County';
self.case_number				:= trim(input.case_num,left,right);
self.case_type_code				:= trim(input.type_,left,right);//trim(input.type_descrip,left,right);
self.case_type					:= trim(input.type_descrip,left,right);//trim(input.type_,left,right);
self.case_title					:= regexreplace(trim(input.case_num,left,right),trim(input.caption,left,right),'');
self.case_cause_code			:= '';
self.case_cause					:= '';
self.manner_of_filing_code		:= '';
self.manner_of_filing			:= '';
self.filing_date				:= if(fSlashedMDYtoCYMD(input.case_filed)<>'',
									fSlashedMDYtoCYMD(input.case_filed),
									'');
self.manner_of_judgmt_code		:= '';
self.manner_of_judgmt			:= '';
self.judgmt_date				:= '';
self.ruled_for_against_code		:= '';
self.ruled_for_against			:= '';
self.judgmt_type_code			:= '';
self.judgmt_type				:= '';
self.judgmt_disposition_date	:= '';
self.judgmt_disposition_code	:= '';
self.judgmt_disposition			:= '';
self.disposition_code			:= '';
self.disposition_description	:= '';
self.disposition_date			:= if(fSlashedMDYtoCYMD(input.disp_status_dt)<>'' and fSlashedMDYtoCYMD(input.disp_status_dt)<>'00000000',
									fSlashedMDYtoCYMD(input.disp_status_dt),
									'');
self.suit_amount				:= '';
self.award_amount				:= '';
end;

pButlerDef 	:= project(fButlerDef,tMICiv(left));

//CONCATENATED RECORDS////////////////////////////////////////////////////////
pButler := pButlerPlan+pButlerDef;

dButler 	:= dedup(sort(distribute(pButler,hash(case_key)),
									case_key,court,case_type,filing_date,-judgmt_date,local),
									case_key,court,case_type,local,left):
									PERSIST('~thor_200::in::civil_OH_butler_matter');

export Map_OH_Butler_Matter := dButler;