/*
	The logic below was originally located in CriminalRecords_BatchService.Possible_Incarceration_Indicator_Batch_Service_Records.
  This is an attempt to make this logic more reusable, as we currently have pieces of this same code located in multiple places. 
*/

EXPORT MAC_Incarceration_Filter(inf, 																 																																		 
																outf, 
																releasePPOverride = false,					 // If true, records matching a *release* or *probation/parole* pattern 
																																		 //  will force the incarceration indicator to 0.
																dedup_recs 				= false,					 // Sort and dedup records by did and date (if available), returning the most recent by did.
																batch_view 				= false,					 // Use 'acctno' field when sorting/deduping.
																inc_flag_field		= 'Incarceration_Flag', // The incarceration indicator field in the input dataset
																event_dt					= 'event_dt',
																cur_stat_inm_desc	= 'cur_stat_inm_desc',
																cur_loc_inm				= 'cur_loc_inm',
																sent_length_desc	= 'sent_length_desc',
																act_rel_dt				= 'act_rel_dt',
																sch_rel_dt				= 'sch_rel_dt',
																ctl_rel_dt				= 'ctl_rel_dt'																
																) := MACRO
	
	#uniquename(layout_in)	
	%layout_in% := recordof (inf);	
	
	#uniquename(layout_out_tmp)
	%layout_out_tmp% := record
		%layout_in%;
		boolean	 	isPP;
		boolean 	isRelease;
	end;
	
	STRING PI_PATTERN 	:= '^(Active|Population|Inmate|Incarcerated|IN +CUSTODY|UNDER +CUSTODY|IN, +ADMISSION)|LIFE';
	PI_SENT_PATTERN 		:= '^(LIFE|LIFE [WITHOUT|W/O]* PAROLE)$';
	RELEASE_PATTERN 		:= '^(Release|Released)$';
	PP_PATTERN 					:= 'Probation|Parole|P&P';
	
	unsigned1 COND_OUT 			:= 0;
	unsigned1 COND_IN 			:= 1;
	unsigned1 COND_UNKNOWN 	:= 2;		
	
	unsigned4 currentDt := (UNSIGNED4) StringLib.getDateYYYYMMDD() : GLOBAL;
	
	#uniquename(isProbablyNotIncarcerated)
	boolean %isProbablyNotIncarcerated%(STRING statStr, STRING sentStr, SET OF UNSIGNED4 relDates) := function
	
		#uniquename(dateRule)
		#uniquename(statusRule)
		
		// The original logic can be found in "CriminalRecords_BatchService._possible_incarceration_vb".
		%dateRule%(UNSIGNED4 relDt, UNSIGNED4 curDt) := MAP(relDt >= curDt => COND_IN,
																												relDt = 0 => COND_UNKNOWN,
																												COND_OUT);
		%statusRule%(STRING inmStat, STRING sentDesc) := MAP(REGEXFIND(PI_PATTERN, inmStat, NOCASE) => COND_IN,
																			LENGTH(inmStat) = 0 and REGEXFIND(PI_SENT_PATTERN, sentDesc, NOCASE) => COND_IN,
																			LENGTH(inmStat) = 0 => COND_UNKNOWN,
																			COND_OUT);
		
		#uniquename(statRule)
		#uniquename(dateRule1)
		#uniquename(dateRule2)
		#uniquename(dateRule3)
		#uniquename(dtsNotIn)
		#uniquename(dtInOrOut)
		unsigned1 %statRule% := %statusRule%(TRIM(statStr, LEFT, RIGHT), TRIM(sentStr, LEFT, RIGHT));
		unsigned1 %dateRule1% := %dateRule%((UNSIGNED4) relDates[1], currentDt);
		unsigned1 %dateRule2% := %dateRule%((UNSIGNED4) relDates[2], currentDt);
		unsigned1 %dateRule3% := %dateRule%((UNSIGNED4) relDates[3], currentDt);
		boolean %dtsNotIn% := (%dateRule2% <> COND_IN and %dateRule3% <> COND_IN) or %dateRule1% = COND_OUT or %dateRule3% = COND_OUT; 
		boolean %dtInOrOut% := %dateRule1% <> COND_UNKNOWN or %dateRule2% <> COND_UNKNOWN or %dateRule3% <> COND_UNKNOWN;

		return (%statRule% <> COND_IN or %dtInOrOut%) and (%statRule% = COND_OUT or %dtsNotIn%);
	end;

	#uniquename(flag_incarceration)
	%layout_out_tmp% %flag_incarceration%(%layout_in% l) := TRANSFORM
			#uniquename(isIncarcerated)
			%isIncarcerated% := ~%isProbablyNotIncarcerated%(l.cur_stat_inm_desc, l.sent_length_desc, [(UNSIGNED4) l.act_rel_dt, (UNSIGNED4) l.sch_rel_dt, (UNSIGNED4) l.ctl_rel_dt]);
			#uniquename(isRel)
			%isRel% := REGEXFIND(RELEASE_PATTERN, trim(l.cur_stat_inm_desc, left, right), NOCASE);
			#uniquename(isPnP)
			%isPnP% := REGEXFIND(PP_PATTERN, trim(l.cur_loc_inm, left, right), NOCASE);
			SELF.inc_flag_field := if(releasePPOverride and (%isRel% or %isPnP%), '0', if(%isIncarcerated%, '1', '0')),
			SELF.isRelease := %isRel%,
			SELF.isPP			 := %isPnP%,
			SELF := l,
			SELF := []
	END;		
	
	#uniquename(candidates)
	%candidates% := project(inf, %flag_incarceration%(left));	
	
	#uniquename(candidates_dd)
	%candidates_dd% := if(~dedup_recs,
											  %candidates%,														 
											  dedup(sort(%candidates%(event_dt<>''), 
														 #if(batch_view)
														 acctno,
														 #end 
														 #if(dedup_recs)
														 -if(did=0, 1, 0), 
														 did, -event_dt, if(isRelease or isPP, 0, 1), -inc_flag_field, 
														 #end
														 record),
														 #if(batch_view)
														 acctno
														 #end
														 #if(dedup_recs)
														 ,left.did>0 and left.did = right.did // so we don't dedup by did, if record has no did.
														 #else
														 record
														 #end														 
														 ) 
											 // will preserve records with no event dt, so if they indicate incarceration, they'll continue to be reported.
											 + %candidates%(event_dt=''));
	
	outf := project(%candidates_dd%, %layout_in%);
		
	
ENDMACRO;
