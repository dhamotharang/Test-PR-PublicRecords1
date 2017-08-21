import crim_common, Crim, Address, lib_stringlib,ut;

input := crim.File_TX_Statewide.cmbndFile;

//////////////////////////////////////////////////////////////////////////////////

Crim_Common.Layout_In_Court_Activity rTX(input l) := Transform

//---
String heightToInches(String s) := FUNCTION
cleanheight := regexreplace('[^0-9]', s, '');
height_ft:=(integer)cleanheight[1..1];
height_in:=(integer)cleanheight[2..5];
return (string)intformat((height_ft*12+height_in), 3, 1);
END;
//---
string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
//---
string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');
//---			


self.process_date			:= Crim_Common.Version_Development;
self.vendor 				:= '01';
self.state_origin 			:= 'TX';
self.source_file		   	:= 'TX DEPT OF PUB SFTY';
self.off_comp				:='';
self.case_number			:='';
self.event_type				:='';

self.event_sort_key := getReasonableRange(fSlashedMDYtoCYMD(l.ssd_dte));
self.event_date := getReasonableRange(fSlashedMDYtoCYMD(l.ssd_dte));
self.event_location_code := '';
self.event_location_desc := regexreplace('ONLY',regexreplace('~FOR NCIC 2000 DATA CONVERSION PURPOSES ONLY',l.agy_txt,''),'');
self.event_desc_code := l.ssn_cod;
self.event_desc_1 := map(
l.ssn_cod = '401'=> 'ABSCONDED',
l.ssn_cod = '402'=> 'ADMINISTRATIVE DISCHARGE',
l.ssn_cod = '403'=> 'CERTIFICATE OF RELIEF',
l.ssn_cod = '404'=> 'COMMITED SUICIDE',
l.ssn_cod = '404'=> 'COMMITTED SUICIDE',
l.ssn_cod = '405'=> 'COMMUTATION RELEASED',
l.ssn_cod = '405'=> 'COMMUTATION RESCINDED',
l.ssn_cod = '406'=> 'CONDITIONALLY RELEASED',
l.ssn_cod = '407'=> 'CONDITIONAL RELEASE REVOKED',
l.ssn_cod = '407'=> 'RETURNED CONDITIONALLY REL VIOL',
l.ssn_cod = '408'=> 'DIED',
l.ssn_cod = '409'=> 'DISCHARGED',
l.ssn_cod = '410'=> 'ESCAPED',
l.ssn_cod = '411'=> 'EXECUTED',
l.ssn_cod = '412'=> 'FURLOUGHED',
l.ssn_cod = '413'=> 'FURLOUGH REVOKED',
l.ssn_cod = '413'=> 'RETURNED FURLOUGH VIOL',
l.ssn_cod = '414'=> 'MANDATORY RELEASE',
l.ssn_cod = '415'=> 'MANDATORY RELEASE REVOKED',
l.ssn_cod = '415'=> 'RETURNED MANDATORY RELEASE VIOL',
l.ssn_cod = '416'=> 'PARDONED',
l.ssn_cod = '417'=> 'PAROLED',
l.ssn_cod = '418'=> 'PAROLE REVOCATION',
l.ssn_cod = '419'=> 'PROBATION',
l.ssn_cod = '420'=> 'PROBATION REVOCATION',
l.ssn_cod = '420'=> 'PROBATION REVOKED',
l.ssn_cod = '421'=> 'RECEIVED',
l.ssn_cod = '421'=> 'RECEIVED IN TDCJ',
l.ssn_cod = '422'=> 'RELEASED PER COURT ORDER',
l.ssn_cod = '423'=> 'RELEASED ON APPEAL BOND',
l.ssn_cod = '424'=> 'RELEASED - COMMUTATION',
l.ssn_cod = '424'=> 'RELEASED-COMMUTATION',
l.ssn_cod = '425'=> 'WORK FURLOUGH',
l.ssn_cod = '426'=> 'WORK FURLOUGH REVOKED',
l.ssn_cod = '427'=> 'TRANSFERRED IN',
l.ssn_cod = '428'=> 'MINIMUM TIME RELEASE',
l.ssn_cod = '429'=> 'ACCEPTED PAROLE TRANSFER',
l.ssn_cod = '429'=> 'PAROLE TRANSFER',
l.ssn_cod = '430'=> 'ACCEPTED PROBATION TRANSFER',
l.ssn_cod = '430'=> 'PROBATION TRANSFER',
l.ssn_cod = '431'=> 'RECEIVED FOR STUDY',
l.ssn_cod = '432'=> 'RETURN TO COURT',
l.ssn_cod = '433'=> 'ESCAPEE RETURNED',
l.ssn_cod = '434'=> 'SHOCK PROBATION',
l.ssn_cod = '435'=> 'SUPERVISION REINSTATED',
l.ssn_cod = '436'=> 'REVOKED',
l.ssn_cod = '437'=> 'SUBSTANCE ABUSE PUNISHMENT',
l.ssn_cod = '437'=> 'SUBSTANCE ABUSE PUNISHMENT FACILITY',
l.ssn_cod = '438'=> 'RELEASED TO DETAINER',
l.ssn_cod = '438'=> 'RELEASED TO DETAINERS',
l.ssn_cod = '439'=> 'PAROLE IN ABSENTIA',
l.ssn_cod = '440'=> 'RECEIVED IN COUNTY JAIL',
l.ssn_cod = '441'=> 'RECEIVED',
l.ssn_cod = '442'=> 'INTENSIVE SUPERVISION',
l.ssn_cod = '443'=> 'CLEMENCY DISCHARGE',
l.ssn_cod = '444'=> 'PIA MAND SUPERVISION',
l.ssn_cod = '445'=> 'RECEIVED STATE JAIL',
l.ssn_cod = '490'=> 'RELEASED TO NON CORR AGENCY',
l.ssn_cod = '490'=> 'TRANSFERRED',
l.ssn_cod = '491'=> 'SPECIAL PAROLE TERM',
l.ssn_cod = '492'=> 'PRE-TRIAL DIVERSION',
l.ssn_cod = '493'=> 'INTER STATE COMP',
l.ssn_cod = '493'=> 'RELEASED',
l.ssn_cod = '494'=> 'MANDATORY RELEASE - PROBATION',
l.ssn_cod = '495'=> 'MANDATORY RELEASE - PROB. SPECIAL PAROLE',
l.ssn_cod = '496'=> 'PAROLE - SPECIAL PAROLE TERM',
l.ssn_cod = '497'=> 'PAROLE - PROBATION',
l.ssn_cod = '498'=> 'PAROLE/PROBATION SPECIAL TERM',
l.ssn_cod = '499'=> 'PROBATION/SPECIAL PAROLE TERM',
l.ssn_cod = '500'=> 'PAROLE TO DETAINER',
l.ssn_cod = '501'=> 'MANDATORY SUPERVISION TO DETAINER',
l.ssn_cod = '502'=> 'PAROLE INTENSIVE SUPERVISION',
l.ssn_cod = '503'=> 'MANDATORY SUPERVISION INTENSIVE SUPERVISION',
l.ssn_cod = '504'=> 'PAROLE SEX OFFENDER REGISTRATION',
l.ssn_cod = '505'=> 'MANDATORY SUPERVISION SEX OFFENDER REGISTRATION',
l.ssn_cod = '506'=> 'PAROLE IN ABSENTIA-MANDATORY SUPERVISION DETAINER',
l.ssn_cod = '507'=> 'PAROLE IN ABSENTIA-PAROLE DETAINER',
l.ssn_cod = '508'=> 'PAROLE NON CORRECTIONAL RELEASE',
l.ssn_cod = '509'=> 'MANDATORY SUPERVISION NON CORRECTIONAL RELEASE',
l.ssn_cod = '510'=> 'DISCHARGE SEX OFFENDER','');
self.event_desc_2		:=map(l.sle_txt = 'FOR NCIC 2000 DATA CONVERSION PURPOSES ONLY' or
									l.sle_txt = 'ONLY'
										=> ''
										,l.sle_txt);

self.offender_key		:= self.vendor + if(l.dps_number='',l.per_idn,l.dps_number);
end;

refOffender := project(input, rTX(left));

dedOffender := dedup(sort(distribute(refOffender(event_desc_1 != ''),hash(offender_key)),
										offender_key,event_date,event_location_desc,event_desc_1,local),
										offender_key,event_date,event_location_desc,event_desc_1,local) 
										:PERSIST('~thor_dell400::persist::Crim_TX_Statewide_Activity');

export map_TX_Activity := dedOffender;