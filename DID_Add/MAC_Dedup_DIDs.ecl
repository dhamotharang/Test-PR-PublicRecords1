export MAC_Dedup_DIDs(infile, id_field,
						did_field, did_score,
					    outfile,bool_indiv_scores = 'false',
						sa_field='score_a',sd_field='score_d',ss_field='score_s',sp_field='score_p',sf_field = 'score_f')
		 := macro


#uniquename(mdd_recs_dist)
#uniquename(mdd_recs_tra)

%mdd_recs_dist% := group(sort(distribute(infile, hash(id_field)),id_field,
		did_field, -did_score,
	local),id_field,local);

/*#uniquename(pickscore)
%pickscore%(unsigned6 selfdid, unsigned6 ledid, unsigned6 ridid, integer2 lescore, integer2 riscore) := 
	if(ledid = ridid,	//if within same did, then take higher score
		IF ( lescore < riscore, riscore, lescore ),
		if ( selfdid = ridid, 
			 riscore,   //or we unseated the left, so take the right
			 lescore));	//or we kept the left and dropped the right
*/

typeof(infile) %mdd_recs_tra%(infile le, infile ri) := transform
	self.DID_field := IF ( le.did_score < ri.did_score or (le.did_score=ri.did_score and le.did_field > ri.did_field), ri.did_field, le.did_field );
	self.DID_score := IF ( le.did_score < ri.did_score, ri.did_score, le.did_score );
    #if (bool_indiv_scores)
		self.sa_field := if (le.did_score < ri.did_score or (le.did_score=ri.did_score and le.did_field > ri.did_field), ri.sa_field, le.sa_field);
		self.sd_field := if (le.did_score < ri.did_score or (le.did_score=ri.did_score and le.did_field > ri.did_field), ri.sd_field, le.sd_field);
		self.ss_field := if (le.did_score < ri.did_score or (le.did_score=ri.did_score and le.did_field > ri.did_field), ri.ss_field, le.ss_field);
		self.sp_field := if (le.did_score < ri.did_score or (le.did_score=ri.did_score and le.did_field > ri.did_field), ri.sp_field, le.sp_field);
		self.sf_field := if (le.did_score < ri.did_score or (le.did_score=ri.did_score and le.did_field > ri.did_field), ri.sf_field, le.sf_field);
	#end
	self := le;
  end;

outfile := group(rollup(%mdd_recs_dist%,true,%mdd_recs_tra%(left,right)));

endmacro;