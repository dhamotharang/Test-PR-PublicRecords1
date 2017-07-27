import doxie_build,ut;

//Flag inmates that are currently incarcerated curr_incar_flag = 'Y' or ''
/*
If the status meets the following criteria:

regexfind('^(ACTIVE|INCARCERATED|IN CUSTODY|INMATE)|LIFE|POPULATION',StringLib.StringToUpperCase(R.cur_stat_inm_desc))) = true

and if not blank the act_rel_dt date is greater than today’s date (use sch_rel_dt, or ctrl_rel_dt if act_rel_dt date is blank)

then flag as incarcerated.

 

Else if regexfind('^(ACTIVE|INCARCERATED|IN CUSTODY|INMATE)|LIFE|POPULATION',StringLib.StringToUpperCase(R.cur_stat_inm_desc))) = true

And act_rel_dt, sch_rel_dt, or ctrl_rel_dt dates are blank and today’s date - process date is <= 30 days and the file is categorized as a full file replace.

 

Else If the status is null and the act_rel_dt, sch_rel_dt, or ctrl_rel_dt dates are greater than today’s date then flag as incarcerated.

 

Else If the status is null and the act_rel_dt is null and the sch_rel_dt, or ctrl_rel_dt dates are greater than today’s date then flag as incarcerated.

 

These changes will fix the issues found on example line item 2 where the offender is flagged as active but the data has not been updated.

Line item 76 where the status is parole but because of the ctrl_date was greater than today’s date it was flagged as incarcerated.  The other flaw exposed by this example is that the actual release date is less than today’s date.  The actual release date should be considered before the other two dates.
*/

offnd 	:= distribute(doxie_build.proc_build_DOC_offenders,hash(offender_key));
pun 	:= distribute(doxie_build.proc_build_DOC_punishment,hash(offender_key));
//states with an ORBIT update type of "full-replace"
set_ffStates := [
'AL',
'AZ',
'CT',
'FL',
'GA',
'ID',
'IL',
'KS',
'MD',
'MI',
'MN',
'MO',
'MS',
'MT',
'NC',
'NE',
'NH',
'NJ',
'NV',
'OH',
'OK',
'OR',
'RI',
'SC',
'TN',
'UT',
'WI'
];

offnd trecs(offnd L, pun R) := transform

StatusRule1 		:= map((L.offender_key = R.offender_key) and (regexfind('^(ACTIVE|INCARCERATED|IN CUSTODY|INMATE)|LIFE|POPULATION',StringLib.StringToUpperCase(R.cur_stat_inm_desc))) 
								and ((unsigned) stringlib.stringfilterout(R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt,' ')[1..8] > (unsigned)ut.GetDate) => '1'
							,(L.offender_key = R.offender_key) and (regexfind('^(ACTIVE|INCARCERATED|IN CUSTODY|INMATE)|LIFE|POPULATION',StringLib.StringToUpperCase(R.cur_stat_inm_desc))) 
								and (R.act_rel_dt+R.ctl_rel_dt+R.sch_rel_dt)='' 
								and R.vendor in set_ffStates 
								and (unsigned)ut.GetDate - (unsigned)R.process_date < 31 => '1'
							,R.cur_stat_inm_desc = '' => '3'
							,'0');
DateRule1	 		:= map((L.offender_key = R.offender_key) and (R.cur_stat_inm_desc = '' and R.act_rel_dt between ut.GetDate and '30000000') => '1'
							,R.act_rel_dt = '' => '3'
							,'0');
DateRule2	 		:= map((L.offender_key = R.offender_key) and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and (R.sch_rel_dt between ut.GetDate and '30000000') => '1'
							,R.sch_rel_dt = '' => '3'
							,'0');
DateRule3	 		:= map((L.offender_key = R.offender_key) and R.cur_stat_inm_desc = '' and R.act_rel_dt = '' and (R.ctl_rel_dt between ut.GetDate and '30000000') => '1'
							,R.ctl_rel_dt = '' => '3'
							,'0');
    		
self.curr_incar_flag	:= map((StatusRule1 = '1' or
							DateRule1 = '1' or DateRule2 = '1' or DateRule3 = '1') => 'Y'
							,'');
self.curr_parole_flag 	 := '';
self.curr_probation_flag := '';
self := L;


end;
flaggedRecs := join(offnd,pun,
				left.offender_key = right.offender_key,
				trecs(left,right),left outer,local);

ut.MAC_SF_BuildProcess(flaggedRecs,'~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate,outOffnd,2);
ut.MAC_SF_BuildProcess(pun,'~thor_data400::base::corrections_punishment_' + doxie_build.buildstate,outPun,2);

export proc_build_DOC_offenders_flagged:= sequential(outOffnd
											 ,outPun);
								







