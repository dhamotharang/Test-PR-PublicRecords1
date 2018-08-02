import _Control, advo, riskwise, models, ut;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Address_History(GROUPED DATASET(risk_indicators.iid_constants.layout_outx) iid, 
																	boolean isFCRA,
																	string50 datarestrictionmask) := function

advo_permitted := datarestrictionmask[risk_indicators.iid_constants.posADVORestriction]<>'1';


ADVOKey := if(isFCRA, advo.Key_Addr1_FCRA, advo.Key_Addr1);
// Must be exact match on all parts -- including sec range being blank.

risk_indicators.iid_constants.layout_outx getAdvoCollege(iid le, ADVOKey ri) := TRANSFORM
	self.address_history_summary.address_history_advo_college_hit := (le.chrono_addr_flags.deliveryStatus<>'' and le.chrono_addr_flags.deliveryStatus='C') or
																																	 (le.chrono_addr_flags.deliveryStatus='' and ri.college_indicator='Y');
	self := le;
END;

with_advo_college_roxie  := join(iid, ADVOKey,
										left.h.zip != '' and 
										keyed(left.h.zip = right.zip) and
										keyed(left.h.prim_range = right.prim_range) and
										keyed(left.h.prim_name = right.prim_name) and
										keyed(left.h.suffix = right.addr_suffix) and
										keyed(left.h.predir = right.predir) and
										keyed(left.h.postdir = right.postdir) and
										keyed(left.h.sec_range = right.sec_range) , /* and
										((unsigned)RIGHT.date_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)), */
										getAdvoCollege(LEFT,RIGHT), left outer,
										atmost(riskwise.max_atmost), keep(1));
					

with_advo_college_thor_pre := join(distribute(iid(h.zip<>''), hash64(h.zip, h.prim_range, h.prim_name)), 
										distribute(pull(ADVOKey), hash64(zip, prim_range, prim_name)),
										(left.h.zip = right.zip) and
										(left.h.prim_range = right.prim_range) and
										(left.h.prim_name = right.prim_name) and
										(left.h.suffix = right.addr_suffix) and
										(left.h.predir = right.predir) and
										(left.h.postdir = right.postdir) and
										(left.h.sec_range = right.sec_range) , /* and
										((unsigned)RIGHT.date_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)), */
										getAdvoCollege(LEFT,RIGHT), left outer,
										atmost(riskwise.max_atmost), keep(1), 
										local);

with_advo_college_thor := with_advo_college_thor_pre + 
                    project(iid(h.zip=''), TRANSFORM(risk_indicators.iid_constants.layout_outx,
                              self.address_history_summary.address_history_advo_college_hit := (LEFT.chrono_addr_flags.deliveryStatus<>'' and LEFT.chrono_addr_flags.deliveryStatus='C');
                              self := left));

#IF(onThor)
	with_advo_college := with_advo_college_thor;
#ELSE
	with_advo_college := with_advo_college_roxie;
#END

// output(choosen(j1(advo_college_hit=1), eyeball), named('college_address_hits'));
// deduped_advo_college := dedup(sort(j1, seq, did, -address_history_summary.address_history_advo_college_hit), seq, did);


// Todd's code on petes address history attributes
default_value := -9999;

temprec := record
	risk_indicators.iid_constants.layout_outx;
	// temp variables
	risk_indicators.layouts.layout_address_history_summary;
	unsigned h_dt_first_seen := 0;
	string2 h_src := '';
	string addrkey;
	unsigned1 srccounttotal := 1;
	unsigned1 recordcount := 1;
	unsigned1 addrcounttotal := 1;
	real msfs := 0;
	real lor := 0;
	// string accountnumber;
	// unsigned historyDate;
	string inputaddrkey := '';	// temporary for testing
	string prim_ranget := '';
	string predirt := '';
	string prim_namet := '';
	string suffixt := '';
	string postdirt := '';
	string unit_desigt := '';
	string sec_ranget := '';
	string word1 := '';
	string word2 := '';
	string word3 := '';
	string word4 := '';
	string word5 := '';
end;


badWords := [	'ST', 'APT', 'AVE', 'DR', 'RD', 'BOX', 'TH', 'PO', 'N', 'W', 'E', 'S', 'LN', 'CT', 'BLVD', 'CIR', 'WAY',
					'PL', 'A', 'SW', 'RR', 'NW', 'B', 'NE', '#', 'SE', 'ND', 'UNIT', 'C', 'D', 'PARK', 'LAKE', 'TER', 'STE',
					'RIDGE', 'CREEK', 'TRL', 'ROAD', 'HIGHWAY', 'COUNTY', 'HWY', 'PKWY', 'HILL', 'F', 'LOT', 'G', 'H', 'VIEW',
					'VISTA', 'RUN', 'ROUTE', 'R', 'MEADOW', 'LOOP', 'L', 'BAY', 'GROVE', 'AVENUE', 'NORTH', 'EAST', 'POINT',
					'K', 'SPC', 'J', 'CLUB', 'US', 'CALLE', 'M', 'PIKE', 'SOUTH', 'VIA', 'HOLLOW', 'WEST', 'RT', 'DEL', 'I',
					'STREET', 'EL', 'PLACE', 'COURT', 'BEND', 'CROSSING', 'TERRACE', 'PSC', 'THE' /*mine*/,'POBOX'];

// get the address key
temprec getAddrKey(iid le) := transform

	num_prim_range := stringlib.stringfilter(le.h.prim_range, '0123456789');
	char_prim_range := stringlib.stringfilter(le.h.prim_range, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ');
	
	prword1 := models.common.getw( char_prim_range, 1,' ');
	prword2 := models.common.getw( char_prim_range, 2,' ');
	prword3 := models.common.getw( char_prim_range, 3,' ');
	prword4 := models.common.getw( char_prim_range, 4,' ');
	
	prw1 := if(prword1 in badWords, '', prword1);
	prw2 := if(prword2 in badWords, '', prword2);
	prw3 := if(prword3 in badWords, '', prword3);
	prw4 := if(prword4 in badWords, '', prword4);
	
	prim_range := num_prim_range + prw1 + prw2 + prw3 + prw4;
	
	predir := if(trim(le.h.predir) in badWords, '', le.h.predir);
	// will need to check each word in these fields and check against the bad words list////////////////////////////////////////////////////////////////////////////////////////////////////
	// ex "summerhill rd b", should remove rd and the b
	// use models.commen.getwords?  to get the words in the field?
	num_prim_name := stringlib.stringfilter(le.h.prim_name, '0123456789');
	char_prim_name := stringlib.stringfilter(le.h.prim_name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ');
	
	word1 := models.common.getw( char_prim_name, 1,' ');
	word2 := models.common.getw( char_prim_name, 2,' ');
	word3 := models.common.getw( char_prim_name, 3,' ');
	word4 := models.common.getw( char_prim_name, 4,' ');
	word5 := models.common.getw( char_prim_name, 5,' ');
	word6 := models.common.getw( char_prim_name, 6,' ');
	word7 := models.common.getw( char_prim_name, 7,' ');
	
	w1 := if(word1 in badWords, '', word1);
	w2 := if(word2 in badWords, '', word2);
	w3 := if(word3 in badWords, '', word3);
	w4 := if(word4 in badWords, '', word4);
	w5 := if(word5 in badWords, '', word5);
	w6 := if(word6 in badWords, '', word6);
	w7 := if(word7 in badWords, '', word7);
	
	prim_name := num_prim_name + w1 + w2 + w3 + w4 + w5 + w6 + w7;
	
	// prim_name := if(trim(char_prim_name) in badWords, num_prim_name, num_prim_name+char_prim_name);	// could use better logic?
	suffix := if(trim(le.h.suffix) in badWords, '', le.h.suffix);
	postdir := if(trim(le.h.postdir) in badWords, '', le.h.postdir);
	unit_desig := if(trim(le.h.unit_desig) in badWords, '', le.h.unit_desig);
	
	num_sec_range := stringlib.stringfilter(le.h.sec_range, '0123456789');
	char_sec_range := stringlib.stringfilter(le.h.sec_range, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ -&');
	
	secword1 := models.common.getw( char_sec_range, 1,' -&');
	secword2 := models.common.getw( char_sec_range, 2,' -&');
	secword3 := models.common.getw( char_sec_range, 3,' -&');
	
	sw1 := if(secword1 in badWords, '', secword1);
	sw2 := if(secword2 in badWords, '', secword2);
	sw3 := if(secword3 in badWords, '', secword3);
	
	sec_range := num_sec_range + sw1 + sw2 + sw3;

	concAddr := trim(prim_range) + trim(predir) + trim(prim_name) + trim(suffix) + trim(postdir) + trim(unit_desig) + trim(sec_range);
	numerics := stringlib.stringfilter(concAddr, '0123456789');
	chars := stringlib.stringfilter(concAddr, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	
	//testing
	self.prim_ranget := prim_range;
	self.predirt := predir;
	self.prim_namet := prim_name;
	self.suffixt := suffix;
	self.postdirt := postdir;
	self.unit_desigt := unit_desig;
	self.sec_ranget := sec_range;
	
	self.addrkey := trim(numerics) + trim(chars);	// NOT SURE WE SHOULD BLANK OUT NONNUMERICS, PETE SAID HE DIDNT DO THAT BUT IT SEEMS LIKE HE DID
	
	self.h_src := map(
							le.h.src[2] in ['D','V','W'] AND ~(le.h.src IN ['MW','UW'])		=> le.h.src[2],
							le.h.src IN ['TU','LT']	=> 'TU',
							le.h.src in ['FC','FS','UC','US','GC','GS','PC','PS','MS','AS'] => 'C',  // Criminal
							le.h.src IN ['MI','MA'] => 'XX', // won't count these
							le.h.src IN ['FA', 'FP', 'FB', 'LP', 'LA'] => 'P',	//property source
							le.h.src IN ['EM','E1','E2','E3','E4'] => 'EM', 
							le.h.src IN ['QH','WH'] => 'EQ',	// set quickheader to EQ
							le.h.src);
							
	// self := le.shell_input;
	// self.accountnumber := le.accountnumber;
	
	// check these
	// self.srccounttotal := if(le.h.src<>'', 1, 0);
	// self.recordcount := if(le.h.src<>'', 1, 0);
	// self.addrcounttotal := if(le.h.src<>'', 1, 0);

  head_first_seen := (string) le.h.dt_first_seen;
	self.h_dt_first_seen := if((unsigned) (head_first_seen[1..4])>0 and (unsigned) (head_first_seen[5..6])=0, (unsigned)(head_first_seen[1..4]+'01'), le.h.dt_first_seen);
	self := le;
end;
p := project(iid, getAddrKey(left));


// remove first seen dates of 0 but keep them if that is all we have.  also remove TU/TS unless that is all we have
removeDFS := record
	p.h.did;
	dfsnzcount := COUNT(GROUP,p.h_dt_first_seen <>0);
	minDF := MIN(GROUP,p.h_dt_first_seen);
	// do the TU/TS check here also
	ntutscount := COUNT(GROUP,p.h.src not in ['TU','TS']);
end;
t_roxie := table(p, removeDFS, h.did, few);
t_thor := table(distribute(p, hash64(h.did)), removeDFS, h.did, local);

#IF(onThor)
	t := t_thor;
#ELSE
	t := t_roxie;
#END

temprec checkDFS(p le, t ri) := transform
	self.did := if((le.h_dt_first_seen=0 and ri.dfsnzcount>0) OR (le.h.src in ['TU','TS'] and ri.ntutscount>0), skip, le.h.did);
	self := le;
end;
j5_roxie := group(sort(join(p, t, left.h.did=right.did, checkDFS(left,right)),seq, did),seq, did);

j5_thor := group(sort(join(distribute(p, hash64(did)), distribute(t, hash64(did)), 
											left.h.did=right.did, checkDFS(left,right), local),seq, did, local),seq, did, local);

#IF(onThor)
	j5 := j5_thor;
#ELSE
	j5 := j5_roxie;
#END

// count the number of source codes per DID, also count the number of address per DID
temprec countSRS(j5 le, j5 ri) := transform
	self.srccounttotal := le.srccounttotal + if(le.h.src=ri.h.src, 0, 1);
	self := ri;
end;
r2 := rollup(sort(j5,seq,h.did,h.src), countSRS(left,right), left.seq=right.seq and left.h.did=right.h.did);

// join full file back to the src counted file
temprec popSC(j5 le, r2 ri) := transform
	self.srccounttotal := ri.srccounttotal;
	self := le;
end;
j2_roxie := group(sort(join(j5, r2, left.seq=right.seq and left.h.did=right.h.did, popSC(left,right), left outer, keep(1)),seq, did), seq, did);
j2_thor := group(sort(join(j5, r2, left.seq=right.seq and left.h.did=right.h.did, popSC(left,right), left outer, keep(1),local),seq, did, local), seq, did, local);

#IF(onThor)
	j2 := j2_thor;
#ELSE
	j2 := j2_roxie;
#END

test1 := sort(j2,seq,did,addrkey);


// get an address count, will need to recount once we eliminate some records
temprec countAddrs(j2 le, j2 ri) := transform
	self.addrcounttotal := le.addrcounttotal + if(le.addrkey=ri.addrkey, 0, 1);
	self := ri;
end;
r3 := rollup(sort(j2,seq, h.did,addrkey), countAddrs(left,right), left.seq=right.seq and left.h.did=right.h.did);

temprec popAC(j2 le, r3 ri) := transform
	self.addrcounttotal := ri.addrcounttotal;
	self := le;
end;
j3_roxie := group(sort(join(j2, r3, left.seq=right.seq and left.h.did=right.h.did, popAC(left,right), left outer, keep(1)),seq, did), seq, did);
j3_thor := group(sort(join(j2, r3, left.seq=right.seq and left.h.did=right.h.did, popAC(left,right), left outer, keep(1), local),seq, did, local), seq, did, local);

#IF(onThor)
	j3 := j3_thor;
#ELSE
	j3 := j3_roxie;
#END

// sort by earliest first seen date and latest last seen date
s2 := sort(j3, seq, h.did, addrkey, h_dt_first_seen, -h.dt_last_seen);



// keep earliest first seen, src, record counter per address   --------- NEED TO KEEP THE MAX LAST SEEN PER ADDRKEY HERE
temprec getData(s2 le, s2 ri) := transform
	keepLeft := le.addrkey=ri.addrkey;
	
	self.recordcount := if(keepLeft, le.recordcount + 1, 0);
	self.h.dt_last_seen := if(keepLeft, MAX(le.h.dt_last_seen,ri.h.dt_last_seen), ri.h.dt_last_seen);
	self := if(keepLeft, le, ri);
end;
r4 := rollup(s2, getData(left,right), left.seq=right.seq and left.h.did=right.h.did, left.addrkey=right.addrkey);


f := r4((recordcount>1 or (recordcount=1 and ((ut.DaysApart(risk_indicators.iid_constants.myGetDate(historydate),((string)h_dt_first_seen)[1..6]+'01')<183) 
																							 or srccounttotal=1 
																							 or addrcounttotal=1) )));


// calculate months since first seen
temprec getMonthsSince(f le) := transform
	self.msfs := (ut.DaysApart(risk_indicators.iid_constants.myGetDate(le.historydate),((string)le.h_dt_first_seen)[1..6]+'01')/30.5);
	self := le;
end;
p2 := project(f, getMonthsSince(left));


s5 := sort(p2, seq, h.did, -h_dt_first_seen, -h.dt_last_seen, -addrkey/*, record*/);


// get len of res in months based on first seen dates
temprec getLOR(s5 le, s5 ri,integer i) := transform
	// self.lor := if(i=1, 	ut.DaysApart(today[1..6]+'01',ri.h_dt_first_seen[1..6]+'01')/30.5,
								// ut.DaysApart(le.h_dt_first_seen[1..6]+'01',ri.h_dt_first_seen[1..6]+'01')/30.5);
	self.lor := if(i=1, 	ri.msfs,
								ri.msfs-le.msfs);
	
	
	// set field for addr_count fields
	self.addr_count2 := if(ri.recordcount=2, 1, 0);
	self.addr_count3 := if(ri.recordcount>=3, 1, 0);
	self.addr_count6 := if(ri.recordcount>=6, 1, 0);
	self.addr_count10 := if(ri.recordcount>=10, 1, 0);
	
	// set len of res count fields
	self.lres_2mo_count := if(self.lor<=2, 1, 0);
	self.lres_6mo_count := if(self.lor<=6, 1, 0);
	self.lres_12mo_count := if(self.lor<=12, 1, 0);
	
	self.addrcounttotal := if(ri.h.did=0, 0, 1);	// reset the total count because we possibly lost records above
	self.unique_addr_cnt := if(ri.h.did=0, 0, ri.unique_addr_cnt);
	
	// get addrkey for input so that we can match to a addrkey on file to determine where in order it was found
	num_prim_range := stringlib.stringfilter(ri.prim_range, '0123456789');
	char_prim_range := stringlib.stringfilter(ri.prim_range, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ');
	
	prword1 := models.common.getw( char_prim_range, 1,' ');
	prword2 := models.common.getw( char_prim_range, 2,' ');
	prword3 := models.common.getw( char_prim_range, 3,' ');
	prword4 := models.common.getw( char_prim_range, 4,' ');
	
	prw1 := if(prword1 in badWords, '', prword1);
	prw2 := if(prword2 in badWords, '', prword2);
	prw3 := if(prword3 in badWords, '', prword3);
	prw4 := if(prword4 in badWords, '', prword4);
	
	prim_range := num_prim_range + prw1 + prw2 + prw3 + prw4;
	
	predir := if(trim(ri.predir) in badWords, '', ri.predir);
	// will need to check each word in these fields and check against the bad words list////////////////////////////////////////////////////////////////////////////////////////////////////
	// ex "summerhill rd b", should remove rd and the b
	// use models.commen.getwords?  to get the words in the field?
	num_prim_name := stringlib.stringfilter(ri.prim_name, '0123456789');
	char_prim_name := stringlib.stringfilter(ri.prim_name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ');
	
	word1 := models.common.getw( char_prim_name, 1,' ');
	word2 := models.common.getw( char_prim_name, 2,' ');
	word3 := models.common.getw( char_prim_name, 3,' ');
	word4 := models.common.getw( char_prim_name, 4,' ');
	word5 := models.common.getw( char_prim_name, 5,' ');
	word6 := models.common.getw( char_prim_name, 6,' ');
	word7 := models.common.getw( char_prim_name, 7,' ');
	
	w1 := if(word1 in badWords, '', word1);
	w2 := if(word2 in badWords, '', word2);
	w3 := if(word3 in badWords, '', word3);
	w4 := if(word4 in badWords, '', word4);
	w5 := if(word5 in badWords, '', word5);
	w6 := if(word6 in badWords, '', word6);
	w7 := if(word7 in badWords, '', word7);
	
	prim_name := num_prim_name + w1 + w2 + w3 + w4 + w5 + w6 + w7;
	
	// prim_name := if(trim(char_prim_name) in badWords, num_prim_name, num_prim_name+char_prim_name);	// could use better logic?
	suffix := if(trim(ri.addr_suffix) in badWords, '', ri.addr_suffix);
	postdir := if(trim(ri.postdir) in badWords, '', ri.postdir);
	unit_desig := if(trim(ri.unit_desig) in badWords, '', ri.unit_desig);
	
	num_sec_range := stringlib.stringfilter(ri.sec_range, '0123456789');
	char_sec_range := stringlib.stringfilter(ri.sec_range, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ -&');
	
	secword1 := models.common.getw( char_sec_range, 1,' -&');
	secword2 := models.common.getw( char_sec_range, 2,' -&');
	secword3 := models.common.getw( char_sec_range, 3,' -&');
	
	sw1 := if(secword1 in badWords, '', secword1);
	sw2 := if(secword2 in badWords, '', secword2);
	sw3 := if(secword3 in badWords, '', secword3);
	
	sec_range := num_sec_range + sw1 + sw2 + sw3;

	concAddr := trim(prim_range) + trim(predir) + trim(prim_name) + trim(suffix) + trim(postdir) + trim(unit_desig) + trim(sec_range);
	numerics := stringlib.stringfilter(concAddr, '0123456789');
	chars := stringlib.stringfilter(concAddr, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	
	inputAddrKey := trim(numerics) + trim(chars);
	self.inputaddrkey := inputAddrkey;
	
	self.hist_addr_match := if(inputAddrKey=ri.addrKey, i, 0);
	// if input match, hang onto the dates of that match
	self.input_addr_first_seen := if(inputAddrKey=ri.addrKey, ri.h.dt_first_seen, 0);   
	
	self.input_addr_last_seen := if(inputAddrKey=ri.addrKey, ri.h.dt_last_seen, 0);
	
	self.avg_mo_per_addr := if(ri.unique_addr_cnt=1 and ri.h_dt_first_seen=0, default_value, ri.avg_mo_per_addr);
	// self.avg_yr_per_addr := if(ri.unique_addr_cnt=1 and ri.h_dt_first_seen=0, default_value, ri.avg_yr_per_addr);
											
	self := ri;
end;
i := ITERATE(group(s5, seq, did), getLOR(left,right,counter));



// roll into final counts
temprec getOutput(i le, i ri) := transform
	self.unique_addr_cnt := if(le.h.did=0, 0, le.unique_addr_cnt + ri.addrcounttotal);
	
	self.lor := le.lor + ri.lor;	// now giving a total lor to be used for the avg in the next project
	
	self.addr_count2 := le.addr_count2 + ri.addr_count2;
	self.addr_count3 := le.addr_count3 + ri.addr_count3;
	self.addr_count6 := le.addr_count6 + ri.addr_count6;
	self.addr_count10 := le.addr_count10 + ri.addr_count10;
	
	self.lres_2mo_count := le.lres_2mo_count + ri.lres_2mo_count;
	self.lres_6mo_count := le.lres_6mo_count + ri.lres_6mo_count;
	self.lres_12mo_count := le.lres_12mo_count + ri.lres_12mo_count;
	
	// take the lower match number of the 2 that isn't 0
	use_left := (le.hist_addr_match<>0 and le.hist_addr_match < ri.hist_addr_match) or ri.hist_addr_match=0;
	self.hist_addr_match := if(use_left, le.hist_addr_match, ri.hist_addr_match);
	self.input_addr_first_seen := if(use_left, le.input_addr_first_seen, ri.input_addr_first_seen);
	self.input_addr_last_seen := if(use_left, le.input_addr_last_seen, ri.input_addr_last_seen); 
	
	self := le;
end;
r6 := rollup(i,left.seq=right.seq and left.h.did=right.h.did, getOutput(left,right));


temprec getPCT(r6 le) := transform
	self.avg_mo_per_addr := if(le.avg_mo_per_addr=default_value, default_value, roundup(le.lor/le.unique_addr_cnt));	
	self := le;
end;
p6 := project(r6, getPCT(left));


risk_indicators.iid_constants.layout_outx into_final(risk_indicators.iid_constants.layout_outx le, temprec ri) := transform
	self.address_history_summary.unique_addr_cnt := if(ri.unique_addr_cnt=0, 0, ri.unique_addr_cnt);       
	self.address_history_summary.addr_count2 := if(ri.unique_addr_cnt=0, default_value, ri.addr_count2);           
	self.address_history_summary.addr_count3 := if(ri.unique_addr_cnt=0, default_value, ri.addr_count3)  ;           
	self.address_history_summary.addr_count6 := if(ri.unique_addr_cnt=0, default_value, ri.addr_count6)  ;           
	self.address_history_summary.addr_count10 := if(ri.unique_addr_cnt=0, default_value, ri.addr_count10)  ;          
	self.address_history_summary.lres_2mo_count := if(ri.unique_addr_cnt=0, default_value, ri.lres_2mo_count)  ;        
	self.address_history_summary.lres_6mo_count := if(ri.unique_addr_cnt=0, default_value, ri.lres_6mo_count) ;              
	self.address_history_summary.lres_12mo_count := if(ri.unique_addr_cnt=0, default_value, ri.lres_12mo_count) ;        
	self.address_history_summary.hist_addr_match  := if(ri.unique_addr_cnt=0 or trim(le.prim_name)='', default_value, ri.hist_addr_match);
	self.address_history_summary.input_addr_first_seen := if(ri.unique_addr_cnt=0, 0, ri.input_addr_first_seen);
	self.address_history_summary.input_addr_last_seen := if(ri.unique_addr_cnt=0, 0, ri.input_addr_last_seen); 
	self.address_history_summary.avg_mo_per_addr := if(ri.unique_addr_cnt=0, default_value, ri.avg_mo_per_addr) ;
	self.address_history_summary.address_history_advo_college_hit := if(~advo_permitted, false, le.address_history_summary.address_history_advo_college_hit);
	self := le;
end;
	
// check the first record in the batch to determine if this a realtime transaction or an archive test
// if the record is default_history_date or same month as today's date, run production_realtime_mode
production_realtime_mode := iid[1].historydate=risk_indicators.iid_constants.default_history_date
														or iid[1].historydate = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..6]);		
history_mode := ~production_realtime_mode;

														
// for history_mode, do this lookup of advo at runtime
// in current mode, we get this value from the adl_risk_table in boca_shell_adl to save processing time
pre_join := if(advo_permitted and history_mode,group(with_advo_college, seq),iid);

j_final_roxie := group(join(pre_join, p6, left.seq=right.seq and left.did=right.did,
										into_final(left, right), left outer), seq);
										
j_final_thor := group(join(distribute(pre_join, hash64(seq, did)), distribute(p6, hash64(seq, did)), 
										left.seq=right.seq and left.did=right.did,
										into_final(left, right), left outer, local), seq, LOCAL);		
										
#IF(onThor)
	j_final := j_final_thor;
#ELSE
	j_final := j_final_roxie;
#END

return j_final;

end;
