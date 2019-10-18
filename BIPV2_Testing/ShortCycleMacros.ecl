EXPORT ShortCycleMacros := 
MODULE

export mtype_priority(string mtype) := 
	CASE(
		mtype,
		'B' => 1,
		'G' => 2,
		'P' => 3,
		'M' => 4,
					 5
	);


export mac_combine_two_indexes(uniquekey_index, linkid_index, answers, jfield1_inf, jfield1_answers, jfield2_inf='', jfield2_answers='', jfield3_inf='', jfield3_answers='') :=
FUNCTIONMACRO

	/*
	first, get by linkids
	use any unaccounted for unique keys from the answer set to get those additional records
	project the additional records into the linkid format and + them in

	*/

	//find the data by the answer LinkIDs
	linkid_recs := linkid_index(keyed(UltID in set(answers(UltID > 0), ultid) and OrgID in set(answers(OrgID > 0), OrgID) and SELEID in set(answers(SELEID > 0), SELEID)));
			// HPCC-9831 - can do keyed filter on projected index but cant do keyed join
		
	//answer recs still needed
	arsn := answers(jfield1_answers <> '' and jfield1_answers not in set(linkid_recs, jfield1_inf));

	//find the data by the answer unique key
	uniquekey_recs := 
	project(
		uniquekey_index(
		keyed(jfield1_inf in set(arsn, jfield1_answers))
		)
		,transform(
			{linkid_recs},
			self := left,
			self := []
		)
	);
	

  both := linkid_recs + uniquekey_recs;

	
	// output(linkid_recs, named('linkid_recs'));
	// output(uniquekey_recs, named('uniquekey_recs'));
	// output(both, named('both'));
	return both;
ENDMACRO;


export mac_set_mtype(inf, answers, outf, outf_ddp, jfield1_inf, jfield1_answers, jfield2_inf='', jfield2_answers='', jfield3_inf='', jfield3_answers='') :=
MACRO

	#uniquename(myk);//these two joins just get me a manageable set of IDs to check for collapses in outf
	%myk% := 
	dedup(
		join(
			dedup(
				join( //slightly concerned that this join is too limiting
					answers,
					inf,
					(typeof(inf.jfield1_inf))left.jfield1_answers = right.jfield1_inf and right.ultid > 0,
					transform(
						{inf, unsigned6 answer_seleid},
						self.answer_seleid := left.seleid,//why bother assigning this?  its not used in the next join?
						self := right
					)
				),ultid,orgid,seleid,answer_seleid, all
			),
			bizlinkfull.Process_Biz_Layouts.key,
			keyed(
				left.ultid = right.ultid and
				left.orgid = right.orgid and
				left.seleid = right.seleid)
				and right.rcid in set(answers, seleid)
			,transform(
				{unsigned6 ultid, unsigned6 orgid, unsigned6 seleid, unsigned6 rcid},
				self := right
			)
			,limit(10000000)
		)
		, all
	);

	outf :=
	join(
		answers,
		inf,
		(typeof(inf.jfield1_inf))left.jfield1_answers = right.jfield1_inf
		#IF (#TEXT(jfield2_inf)<>'')
			and (typeof(inf.jfield2_inf))left.jfield2_answers = right.jfield2_inf
		#end
		#IF (#TEXT(jfield3_inf)<>'')
			and (typeof(inf.jfield3_inf))left.jfield3_answers = right.jfield3_inf
		#end		
		,transform(
			{answers.mtype, inf},
			self.mtype := 
				map(
					left.mtype = 'D' and right.seleid = 0		=> 'M',//they didnt see the seleid originally, and we still have none.  so, that's Missing
					left.mtype = 'D' and right.seleid > 0		=> 'P',//they didnt see the seleid originally, and we now have something.  so, that's Potential
					// left.seleid = right.seleid 							=> left.mtype, 
					left.seleid = right.seleid OR
					exists(%myk%(ultid = right.ultid and orgid = right.orgid and seleid = right.seleid and rcid = left.seleid)) 	//account for collapses in new build
						=> left.mtype, 
					left.mtype = 'G'												=> 'M', //if it was a G match, but we dont have it, thats Missing (recall error)
																									''
				);
			self := right
		)
	) : persist('~thor_data400::BIPV2_Testing.ShortCycleMacros.mac_set_mtype.'+trim(#text(outf), all));

	//for each prop rec, keep only one mtype, priority is B,G,M
	outf_ddp := 
		dedup(
			sort(outf, jfield1_inf, BIPV2_Testing.ShortCycleMacros.mtype_priority(mtype), -seleid)
			, jfield1_inf
		);

ENDMACRO;



export mac_reset(inf, outf, outrec, source_val = '\'\'') :=
MACRO

import BIPV2;

outrec := {string old_mtype, unsigned6 old_seleid, inf, string2 source_new, unsigned2 bdid_score2 := 0};

outf :=
project(
	inf,
	transform(
		outrec,
		BIPV2.IDmacros.mac_SetIDsZero(),
		self.source_new := source_val;												
		self.mtype := '';
		self.old_mtype := left.mtype,
		self.old_seleid := left.seleid,
		self := left
	)
);

ENDMACRO;


export mac_measure(ds, act, o, answers, jfield1_answers) :=
MACRO
  import ut;
	#uniquename(perecall_hits)
	#uniquename(recall_hits)
	#uniquename(recall_errors)
	#uniquename(precision_hits)
	#uniquename(precision_errors)
	#uniquename(has_old_mtype1)
	#uniquename(has_old_mtype)
	#uniquename(underscore_pos)
	
	 %perecall_hits%		:= ds(mtype = 'P');
	 %recall_hits% 		:= ds(mtype = 'G');
	 %precision_hits% 	:= ds(mtype = 'G'); //are these really the same?
	
	 %recall_errors% 	:= ds(mtype = 'M');
	 %precision_errors%:= ds(mtype = 'B');
	
	ut.hasField(ds, old_mtype, %has_old_mtype1%)
	 %has_old_mtype% := %has_old_mtype1%;
	
	 act := parallel(
		output(ds,														named(#text(ds))),
		#if(%has_old_mtype%)
			output(ds(mtype <> old_mtype),				named('change_' + #text(ds))),
		#end
		output(count(ds),											named('count_' + #text(ds))),
		// output(count(%recall_hits%), 					named('recall_hits_' + #text(ds))),
		// output(count(%precision_hits%),				named('precision_hits_' + #text(ds))),
		// output(count(%recall_errors%), 				named('recall_errors_' + #text(ds))),
		// output(count(%precision_errors%), 		named('precision_errors_' + #text(ds))),
		
		output((integer)(100 * count(%precision_hits%) 	/ count(%precision_hits%	+%precision_errors%)), named('precision_pct_' + #text(ds))),
		output((integer)(100 * count(%recall_hits%) 		/ count(%recall_hits%			+%recall_errors%)), named('recall_pct_' + #text(ds))),
		output((integer)(100 * count(%perecall_hits%) 	/ count(%recall_hits%			+%recall_errors%)), named('possible_extra_recall_pct_' + #text(ds)))
	);
	
	%underscore_pos% := stringlib.stringfind(#text(ds), '_', 1);
	 o := 
	project(
		ut.ds_oneRecord,
		transform(
			{string20 dsname, string20 dstime, integer4 total_answers_given, integer4 total_measured, integer4 pct_measured := 255, integer4 good_hits, integer4 bad_hits, integer4 unknown_hits, integer4 misses, 
				integer4 precision := 255, integer4 recall := 255, integer4 potential_recall := 255, integer4 pct_amgibigous_match := 255},
			self.dsname := #text(ds)[1..(%underscore_pos%-1)],
			self.dstime := #text(ds)[(%underscore_pos%+1)..],
			self.total_answers_given := count(answers((string)jfield1_answers <> ''));
			self.total_measured := count(ds);
			self.good_hits := count(%precision_hits%);
			self.bad_hits := count(%precision_errors%);
			self.unknown_hits := count(%perecall_hits%);
			self.misses := count(%recall_errors%);
		)
	);

endmacro;


END;