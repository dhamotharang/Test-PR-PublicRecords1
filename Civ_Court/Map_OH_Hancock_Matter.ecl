import civil_court, crim_common;

fHancockPlan 	:= Civ_Court.File_In_OH_Hancock(plaintiff<>'' and plaintiff<>'PLAINTIFF' and plaintiff<>'Plaintiff');

Civil_Court.Layout_In_Matter tMICiv1(fHancockPlan input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date				:= civil_court.Version_Development;
self.vendor						:='96';
self.state_origin				:='OH';
self.source_file				:='(CV)OH-HancockCntyCivil';
self.case_key					:='96'+hash(input.case_num);
self.parent_case_key			:='';
self.court_code					:='';
self.court						:='Hancock County';
self.case_number				:= trim(input.case_num,left,right);
self.case_type_code				:= trim(input.type_,left,right);
self.case_type					:= trim(input.type_descr,left,right);
self.case_title					:= regexreplace(' [A-Z][A-Z][A-Z]$| et al',regexreplace(trim(input.case_num,left,right),trim(input.caption,left,right),''),'');
self.case_cause_code			:= '';
self.case_cause					:= '';
self.manner_of_filing_code		:= '';
self.manner_of_filing			:= '';
self.filing_date				:= if(fSlashedMDYtoCYMD(input.case_filed)<>'' and fSlashedMDYtoCYMD(input.case_filed)<=stringlib.GetDateYYYYMMDD(),
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
self.disposition_description	:= if(regexfind('GUILTY|DISMISS|SETTLE',StringLib.StringToUpperCase(trim(input.disp_code,left,right)),0)<>'',
									StringLib.StringToUpperCase(trim(input.disp_code,left,right)),
									'');
self.disposition_date			:= if(fSlashedMDYtoCYMD(input.disp_dt)<>'' and fSlashedMDYtoCYMD(input.disp_dt)<>'00000000' and fSlashedMDYtoCYMD(input.disp_dt)<= stringlib.GetDateYYYYMMDD(),
									fSlashedMDYtoCYMD(input.disp_dt),
									'');
self.suit_amount				:= '';
self.award_amount				:= '';
end;

pHancockPlan 	:= project(fHancockPlan,tMICiv1(left));

dHancock 	:= dedup(sort(distribute(pHancockPlan,hash(case_key)),
									case_key,court,case_type,filing_date,-judgmt_date,local),
									case_key,court,case_type,local,left):
									PERSIST('~thor_200::in::civil_OH_Hancock_matter');

export Map_OH_Hancock_Matter := dHancock;