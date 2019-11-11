IMPORT GlobalWatchLists, iesp, ut, OFAC_XG5, Gateway, Doxie, Suppress, Patriot;

export Search_Batch_Function(GROUPED DATASET(patriot.Layout_batch_in) in_data, 
														boolean ofaconly_value,
														real threshold_value = 0.00,
														unsigned1 ofac_version =1,
														boolean include_ofac = false,
														boolean include_additional_watchlists =false,
														integer2 dob_radius = -1,
														dataset(iesp.share.t_StringArrayItem) watchlists_requested=dataset([], iesp.share.t_StringArrayItem),
														boolean exclude_aka = false,
														boolean exclude_weakaka = false,
														unsigned1 LexIdSourceOptout = 1,
														string TransactionID = '',
														string BatchUID = '',
														unsigned6 GlobalCompanyId = 0) :=
FUNCTION

mod_access := MODULE(Doxie.IDataAccess)
	EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
	EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
	EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
END;

r_threshold_score := map(threshold_value = 0.00 and ofac_version < 4 => OFAC_XG5.Constants.DEF_THRESHOLD_REAL, 
												threshold_value = 0.00 and ofac_version  >= 4 => OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL, 
												threshold_value < Patriot.Constants.MIN_THRESHOLD => Patriot.Constants.MIN_THRESHOLD,
												threshold_value > Patriot.Constants.MAX_THRESHOLD => Patriot.Constants.MAX_THRESHOLD,
												threshold_value);

//************************************************** ofac_version = 1,2,3 **************************************************

base := patriot.Search_Base_Function(in_data,ofaconly_value,r_threshold_score,false,ofac_version,include_ofac,Include_additional_watchlists,watchlists_requested);

gwl_key := GlobalWatchLists.Key_GlobalWatchLists_Key;

layout_batch_ex :=
RECORD
	Patriot.layout_batch_out;
	gwl_key.first_name;
	gwl_key.last_name;
	gwl_key.cname;
END;

// explode
layout_batch_ex norm(base le, patriot.Layout_Base_Results.layout_keys ri) :=
TRANSFORM
	SELF.pty_key := ri.pty_key;
	
	First5 := TRIM(((STRING)ri.score)[1..5]);
	isWhole := LENGTH(First5)=1;
	extraZeros := '000'[1..5-LENGTH(First5)];
	SELF.score := First5 + IF(isWhole,'.000',extraZeros);
	SELF := ri;
	SELF := le;
	SELF.HitNum := INTFORMAT(1,5,0);
	SELF := [];
END;
normed := NORMALIZE(base,LEFT.pty_keys,norm(LEFT,RIGHT));

{normed, UNSIGNED4 global_sid, UNSIGNED6 did} dobrange(normed l, globalwatchlists.Key_GlobalWatchLists_Key r):=transform
	self.global_sid := r.global_sid;
	self.did := r.did;
	return_match := find_dob_match(l.dob,,r.dob_1,r.dob_2,r.dob_3,r.dob_4,r.dob_5,r.dob_6,r.dob_7,r.dob_8,
																r.dob_9,r.dob_10,dob_radius);
	
	self.pty_key := if(return_match, l.pty_key,'');															
	self := l;
END;
	
pre_dobs_in_range_unsuppressed := join(normed,gwl_key,keyed(left.pty_key=right.pty_key),
											dobrange(left,right), keep(100));
											
pre_dobs_in_range := Suppress.Suppress_ReturnOldLayout(pre_dobs_in_range_unsuppressed, mod_access, RECORDOF(normed));

dobs_in_range := pre_dobs_in_range(pty_key<>'');
											
duped_dobs_in_range :=dedup(sort(dobs_in_range,acctno,pty_key),acctno, pty_key);	

dob_normed := group(sort(join(normed,duped_dobs_in_range,left.acctno=right.acctno and left.pty_key=right.pty_key,transform(recordof(normed),self:=left) ,atmost(1)),acctno),acctno);

normed_Use := if(dob_radius=-1, normed,dob_normed);

{layout_batch_out, UNSIGNED4 global_sid, UNSIGNED6 did} pull_full(normed le, gwl_key ri) :=
TRANSFORM, SKIP((exclude_AKA AND ri.name_type IN ['AKA','STRONG AKA', 'WEAK AKA']) OR (exclude_WeakAKA AND ri.name_type IN ['WEAK AKA']))
	SELF.country := le.country;
	SELF := ri;
	SELF := le;
END;
	
/* The following Transform was created to trap results that exceed the limit.  Product wants
   the input data returned with a comment letting the customer know that their search is too
	broad and there were too many results returned.  This transform is called when the limit 
	is exceeded. It keeps only the input data & places the Error message (a constant defined
	above) in the first Remarks field. Doing this allows the remainder of the file to process.
*/
{layout_batch_out, UNSIGNED4 global_sid, UNSIGNED6 did} return_input_with_error_msg (normed le ) :=
   TRANSFORM
      SELF.acctno         := le.acctno;
	   SELF.seq            := le.seq;
	   SELF.name_first     := le.name_first;
	   SELF.name_middle    := le.name_middle;
	   SELF.name_last      := le.name_last;
	   SELF.name_unparsed  := le.name_unparsed;
	   SELF.search_type    := le.search_type;
	   SELF.country        := le.country;
	   SELF.dob            := le.dob;
	   SELF.remarks_1      := Patriot.Constants.LIMIT_ERROR_MESSAGE;
	   SELF                := [];
   END;

	
j_org_unsuppressed := JOIN(normed_use, gwl_key,
			   keyed(LEFT.pty_key=RIGHT.pty_key) AND (
			   (LEFT.first_name=RIGHT.first_name AND ut.NBEQ(LEFT.last_name,RIGHT.last_name)) OR 
			   ut.NBEQ(LEFT.cname,RIGHT.cname) OR 
			   ut.NBEQ(LEFT.country,RIGHT.address_country)),
			   pull_full(LEFT,RIGHT), KEEP(50), 
			   LIMIT(1000),
			   // When an input record exceeds the limit, return only the input data & message.
			   ONFAIL( return_input_with_error_msg (LEFT)),
			   LEFT OUTER);

j_org := Suppress.Suppress_ReturnOldLayout(j_org_unsuppressed, mod_access, layout_batch_out);
			
/*  Per product (Dawn Hill), when an input record has a multiple hits where at least one of 
    those hits has too many records (exceeds the limit),she wants only one record returned
	 and that record to contain only the input data and the error message. And example:  The 
	 only input contained in an input record is:   
	 <row>
	 <acctno>1412</acctno> 
	 <name_unparsed>IRS</name_unparsed> 
	 </row>
	 The results for this search returns two company names:  IRIS and IHRS.  
	 IRIS returns hits from the key within the limit,
	 IHRS hits however exceed the limit.  Prior to this fix, the entire file fails.
	 In this IRS input scenario, Dawn would like only one record returned -- the one with 
	 the error message.
	 
	 The following rollup does this. The ds is sorted by the account number & then an implicit
	 sub-sorted by the Remarks_1 (Field the error message is contained in). The sub-sort is done
	 using the BOOLEAN result from the compare.  If the record contains the LIMIT_ERROR_MESSAGE
	 because the expression is false (Remarks_1 does equal the LIMIT_ERROR_MESSAGE), the result 
	 is 0, and therefore the record is sorted to the top. That sort is equivalent to:
	 j := ROLLUP( SORT( j_ord, acctno, IF(Remarks_1 = LIMIT_ERROR_MESSAGE, 0, 1)),
	              LEFT.acctno = RIGHT.acctno AND
				     LEFT.Remarks_1 = LIMIT_ERROR_MESSAGE,
				     TRANSFORM (LEFT));
	 Once the records are sorted by account number with the Error message records first, roll
	 up the records ONLY when the account numbers match and the LEFT.Remarks_1 field contains
	 the error message.  This keeps all records for accounts that do not and any records that
	 contain the error message and only one record per account number when the error message 
	 is present in one of the records for that account number.
*/    

j := ROLLUP( SORT( j_org, acctno, Remarks_1 != Constants.LIMIT_ERROR_MESSAGE),
             LEFT.acctno = RIGHT.acctno AND
				 LEFT.Remarks_1 = Patriot.Constants.LIMIT_ERROR_MESSAGE,
				 TRANSFORM (LEFT)
				);				

s := SORT(j,-score, pty_key);

Patriot.layout_batch_out iter(Patriot.layout_batch_out le, Patriot.layout_batch_out ri) :=
TRANSFORM
	HitNumAsNum := (INTEGER)le.HitNum;

	SELF.HitNum := (STRING)IF(HitNumAsNum=0,1,(HitNumAsNum+1));
	SELF := ri;
END;

wl_hits := ITERATE(s,iter(LEFT,RIGHT));
//************************************************** ofac_version = 4 - XG5 Bridger call**************************************************
// blank out Bridger Gateway url if not version 4	or if no searching was actually requested
skipWatchlist := ((ofac_version = 4 and Include_Ofac=FALSE and Include_Additional_Watchlists=FALSE and count(watchlists_requested)=0));
gateways	:= if(ofac_version <> 4 or skipWatchlist, dataset([],Gateway.Layouts.Config), Gateway.Configuration.Get());

OFAC_XG5.Layout.InputLayout XG5prep(in_data le) := TRANSFORM											
	SELF.seq := if(le.seq = 0, (unsigned4)le.acctno, le.seq);
	self.acctno := le.acctno;
	self.firstName := trim(le.name_first);
	self.middleName := trim(le.name_middle);
	self.lastName := trim(le.name_last);
	SELF.FullName := IF( le.name_first != '' OR le.name_last != '', '', TRIM(le.name_unparsed,LEFT,RIGHT) );
	dobTemp := if(le.dob = '', '', le.dob[5..6] + '/' + le.dob[7..8] + '/' + le.dob[1..4]); //Bridger needs DOB in mm/dd/yyyy
	SELF.DOB := dobTemp;	
	SELF.country := le.country;
	SELF.searchType := globalwatchlists.translate_SearchType(le.search_type); 
	SELF := [];
	
END;

 prep_XG5 := project(ungroup(in_data), XG5prep(left));  

 XG5_ptys := OFAC_XG5.OFACXG5call(prep_XG5, 
																	ofaconly_value ,
																	r_threshold_score * 100 , //OFAC_XG5.Constants.DEF_THRESHOLD,
																	include_ofac,
																	include_Additional_watchlists,
																	dob_radius,
																	watchlists_requested,
																	gateways);
 
 if(exists(XG5_ptys(ErrorMessage <> '')), FAIL('Bridger Gateway Error'));

 XG5Parsed := OFAC_XG5.OFACXG5_Response(XG5_ptys);
 
 XG5FormattedFlat	:= group(OFAC_XG5.FormatXG5_ResponseFlat(XG5Parsed),acctno);



HitsOut := if(ofac_version < 4, wl_hits , XG5FormattedFlat(trim(pty_key, left, right) <> ''));

// output(ofac_version, named('ofac_version'));
// output(XG5FormattedFlat, named('XG5FormattedFlat'));
// output(prep_XG5, named('prep_XG5'));
// output(XG5_ptys, named('XG5_ptys'));
// output(XG5Parsed, named('XG5Parsed'));
// output(XG5FormattedFlat, named('XG5FormattedFlat'));
//  code from Version 4 GlobalWatchLists was removed see history if it is needed

RETURN HitsOut;


END;