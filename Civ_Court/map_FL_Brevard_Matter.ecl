import civil_court, crim_common, lib_stringlib;

fBrevard 	:= Civ_Court.File_In_FL_Brevard;

Civil_Court.Layout_In_Matter tFLCiv(fBrevard input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date				:= civil_court.Version_Development;
self.vendor						:='29';
self.state_origin				:='FL';
self.source_file				:='FL-BREVARD-CO-CIV-CT';
self.case_key					:='29'+trim(input.case_number,left,right)+hash(fSlashedMDYtoCYMD(regexreplace('-',trim(input.filing_dt,left,right),'/'))+trim(input.last_name,left,right)+trim(input.first_name,left,right)+trim(input.middle_name,left,right));
self.parent_case_key			:='';
self.court_code					:='';
self.court						:='Brevard County';
self.case_number				:= input.case_number;
self.case_type_code				:= '';
self.case_type					:= input.case_type;
self.case_title					:= '';
self.case_cause_code			:= '';
self.case_cause					:= '';
self.manner_of_filing_code		:= '';
self.manner_of_filing			:= '';
self.filing_date				:= if(stringlib.stringfilterout(input.Filing_Dt, '-') between '19010101' and civil_court.Version_Development, stringlib.stringfilterout(input.Filing_Dt, '-'), '');
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
self.disposition_date			:= '';
self.suit_amount				:= '';
self.award_amount				:= '';
end;

pBrevard 	:= project(fBrevard,tFLCiv(left));

dBrevard 	:= dedup(sort(distribute(pBrevard,hash(case_key)),
									case_key,court,case_type,filing_date,judgmt_date,local),
									case_key,court,case_type,local,left)
									: PERSIST('~thor_200::in::civil_FL_Brevard_matter');

export Map_FL_Brevard_Matter := dBrevard;