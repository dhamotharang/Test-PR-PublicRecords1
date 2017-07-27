import ut;

EXPORT EmailCompare(STRING50 email1, STRING50 email2='', string20 fname1='', string20 lname1='') := module

shared e1 := stringlib.stringtouppercase(trim(email1));
shared e2 := stringlib.stringtouppercase(trim(email2));

shared at_symbol_position1 := Stringlib.StringFind(e1, '@', 1);
shared prefix1 := e1[1..at_symbol_position1-1];
shared domain1 := e1[at_symbol_position1+1..];

shared at_symbol_position2 := Stringlib.StringFind(e2, '@', 1);
shared prefix2 := e2[1..at_symbol_position2-1];
shared domain2 := e2[at_symbol_position2+1..];
	
shared prefix_sim_score := 100 - MAX(ut.StringSimilar100(prefix1, prefix2),ut.StringSimilar100(prefix2, prefix1));
shared domain_sim_score := 100 - MAX(ut.StringSimilar100(domain1, domain2),ut.StringSimilar100(domain2, domain1));
shared entire_email_sim_score := 100 - MAX(ut.StringSimilar100(e1, e2),ut.StringSimilar100(e2, e1));

// output(entire_email_sim_score, named('entire_email_sim_score'));
// output(prefix1, named('prefix1'));
// output(domain1, named('domain1'));
// output(prefix2, named('prefix2'));
// output(domain2, named('domain2'));
// output(prefix_sim_score, named('prefix_sim_score'));
// output(domain_sim_score, named('domain_sim_score'));								
// output(result, named('result'));
																								
export EmailScore := MAP(e1='' OR e2=''	=> 255,  																// default missing value score
							at_symbol_position1=0 or at_symbol_position2=0 => 13,  	// force a low score on email address missing the @ sign
							entire_email_sim_score > 95 => entire_email_sim_score,  // if only 1 character off in the entire string, return the full string compare score
							ut.min2(prefix_sim_score,domain_sim_score));						// else, take the lower score from the domain or the prefix
	
shared fname := stringlib.stringtouppercase(trim(fname1));
shared lname := stringlib.stringtouppercase(trim(lname1));
shared e_addr := prefix1;
	
shared e_firstscore := risk_indicators.FnameScore(e_addr, fname);
shared e_lastscore := risk_indicators.LnameScore(e_addr, lname);
			
shared f_len := if(length(fname)<4, length(fname), 4);
shared l_len := if(length(lname)<4, length(lname), 4);
	
shared email_4bytefirst_flag := if(e_addr='' or fname='', '', if(Stringlib.StringFind(e_addr, fname[1..f_len],1)>0,'1', '0'));
shared email_4bytelast_flag := if(e_addr='' or lname='', '', if(Stringlib.StringFind(e_addr, lname[1..l_len],1)>0, '1', '0'));

	init_match1 := if(e_addr[1]=fname[1] and e_addr[2]=lname[1],'1', '0');
	init_match1b := if(e_addr[1]=fname[1] and e_addr[3]=lname[1],'1', '0');
shared init_match := if(init_match1='1' or init_match1b='1', '1', '0');
				
export Email_First_Level := map(email_4bytefirst_flag='' => '-1',
						e_firstscore > 79 => '1',
						email_4bytefirst_flag = '1' => '2',
						init_match = '1' => '3', 
						e_firstscore < 80 and email_4bytefirst_flag != '1' and init_match != '1' => '0',
						'-1');

export Email_Last_Level := map(email_4bytelast_flag='' => '-1',
						e_lastscore > 79 => '1',
						email_4bytelast_flag = '1' => '2',
						init_match = '1' => '3', 
						e_lastscore < 80 and email_4bytelast_flag != '1' and init_match!= '1' => '0',
						'-1');

end;