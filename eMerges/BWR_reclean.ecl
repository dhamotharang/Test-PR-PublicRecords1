
/////////////////////////////////////
///  cut record down to just name
/////////////////////////////////////
base_file := emerges.file_hvccw_base;

// -- Do stat on name cleaning scores
/*
layout_hvc_name_score_stat := 
record
	base_file.score_on_input;
	integer4  total                := count(group);
end;

emerges_hvc_name_score_stat := table(base_file,layout_hvc_name_score_stat, score_on_input, few);

output(emerges_hvc_name_score_stat);
*/
// -- grab out the original name fields and dedup on them so don't have to clean all names

Layout_orig_name := RECORD
	base_file.title_in;
	base_file.lname_in;
	base_file.fname_in;
	base_file.mname_in;
	base_file.name_suffix_in;
END;
Layout_orig_name orig_name(base_file l):= transform
 self := l;
end;

orig_name_fields := project(base_file,orig_name(left));

orig_name_dist := distribute(orig_name_fields,hash(title_in, lname_in, fname_in, mname_in, name_suffix_in));

orig_name_srt := sort(orig_name_dist,title_in, lname_in, fname_in, mname_in, name_suffix_in, local);
orig_name_dedup := dedup(orig_name_srt, title_in, lname_in, fname_in, mname_in, name_suffix_in, local);

count(orig_name_srt);
count(orig_name_dedup);

Layout_clean_name := RECORD
	orig_name_dedup.title_in;
	orig_name_dedup.lname_in;
	orig_name_dedup.fname_in;
	orig_name_dedup.mname_in;
	orig_name_dedup.name_suffix_in;
	string73 clean_name := ''; 
END;
Layout_clean_name clean_name(orig_name_dedup l):= transform
 self := l;
 self.clean_name := address.cleanpersonLFM73(regexreplace('[|:/\\_{}\\[\'"*()#+.\\-&]', trim(l.lname_in) + ', ' + 
				trim(l.fname_in) + ' ' + trim(l.mname_in) + ' ' + trim(l.name_suffix_in), ''));
end;

clean_name_fields := project(orig_name_dedup,clean_name(left));
count(clean_name_fields);
output(clean_name_fields,, '~thor_data400::base::emerges_new_clean_names', overwrite);

// -- do stats on new name scores
// -- Do stat on name cleaning scores

layout_new_name_score := 
record
	string3 new_clean_score;
end;

Layout_new_name_score name_score(Layout_clean_name l):= transform
  self.new_clean_score := l.clean_name[71..73];
end;
new_clean_scores := project(clean_name_fields,name_score(left));


layout_new_name_score_stat := 
record
	new_clean_scores.new_clean_score;
	integer4  total                := count(group);
end;



new_name_score_stats := table(new_clean_scores,layout_new_name_score_stat, new_clean_score, few);

output(new_name_score_stats);







////////////////////////////////////////
////////////////////////////////////////
////////////////////////////////////////
////////////////////////////////////////
// reclean names

Layout_clean_name := RECORD
	string10	title_in;
	string30	lname_in;
	string30	fname_in;
	string30	mname_in;
	string3	name_suffix_in;
     boolean fname_only1;
	boolean fml1;
	string5 clean_title; 
	string20 clean_fname; 
	string20 clean_mname; 
	string20 clean_lname; 
	string5 clean_name_suffix; 
	string3 clean_score; 
END;

base_file := dataset('~thor_200::base::emerges_new_clean_names',Layout_clean_name,flat);


Layout_orig_name := RECORD
	base_file.title_in;
	base_file.lname_in;
	base_file.fname_in;
	base_file.mname_in;
	base_file.name_suffix_in;
	integer4 orig_lname_words := 0;
	integer4 orig_fname_words := 0;
	integer4 orig_mname_words := 0;
END;
Layout_orig_name orig_name(base_file l):= transform
 self := l;
 self.fname_only := if(length(trim(l.lname_in)) = 0 and length(trim(l.mname_in)) = 0 and
				length(trim(l.fname_in)) > 0, true, false);
 self.fml := regexfind('[a-zA-Z]+ [a-zA-Z][.] [a-zA-Z]+', l.fname_in);
 self.lname_blank := if(length(trim(l.lname_in)) = 0, true, false);
end;

//orig_name_fields := project(base_file,orig_name(left));

orig_name_dedup := project(base_file,orig_name(left));





/*
orig_name_dist := distribute(orig_name_fields,hash(title_in, lname_in, fname_in, mname_in, name_suffix_in));

orig_name_srt := sort(orig_name_dist,title_in, lname_in, fname_in, mname_in, name_suffix_in, local);
orig_name_dedup := dedup(orig_name_srt, title_in, lname_in, fname_in, mname_in, name_suffix_in, local);

count(orig_name_srt);
count(orig_name_dedup);
*/
count(orig_name_dedup);

Layout_clean_name2 := RECORD
	orig_name_dedup.title_in;
	orig_name_dedup.lname_in;
	orig_name_dedup.fname_in;
	orig_name_dedup.mname_in;
	orig_name_dedup.name_suffix_in;
     orig_name_dedup.fname_only;
	orig_name_dedup.fml;
     orig_name_dedup.lname_blank;
	string73 clean_name := ''; 
END;
Layout_clean_name2 clean_name(orig_name_dedup l):= transform
 self := l;
 self.clean_name := if(l.fname_only = true and l.fml = true,
					address.cleanperson73(regexreplace('[|:/\\_{}\\[\'"*()#+.\\-&]', trim(l.fname_in), '')),
				if(l.fname_only = true, 
					address.cleanpersonLFM73(regexreplace('[|:/\\_{}\\[\'"*()#+.\\-&]', trim(l.fname_in), '')),
				if(l.lname_blank = true, 
					address.cleanperson73(regexreplace('[|:/\\_{}\\[\'"*()#+.\\-&]', trim(l.fname_in) + ' ' + trim(l.mname_in), '')),
					address.cleanpersonLFM73(regexreplace('[|:/\\_{}\\[\'"*()#+.\\-&]', trim(l.lname_in) + ', ' + 
						trim(l.fname_in) + ' ' + trim(l.mname_in) + ' ' + trim(l.name_suffix_in), '')))
				));
end;

clean_name_fields := project(orig_name_dedup,clean_name(left));
count(clean_name_fields);
output(clean_name_fields,, '~thor_200::base::emerges_new_clean_names2', overwrite);

// -- do stats on new name scores
// -- Do stat on name cleaning scores

layout_new_name_score := 
record
	string3 new_clean_score;
end;

Layout_new_name_score name_score(Layout_clean_name2 l):= transform
  self.new_clean_score := l.clean_name[71..73];
end;
new_clean_scores := project(clean_name_fields,name_score(left));


layout_new_name_score_stat := 
record
	new_clean_scores.new_clean_score;
	integer4  total                := count(group);
end;



new_name_score_stats := table(new_clean_scores,layout_new_name_score_stat, new_clean_score, few);

output(new_name_score_stats);



//////////////////////////////////////////////////////
//rematch it to base file and get new clean names
///////////////////////////////////////////////////////
Layout_clean_name := RECORD
	string10	title_in;
	string30	lname_in;
	string30	fname_in;
	string30	mname_in;
	string3		name_suffix_in;
     boolean fname_only;
	boolean fml;
     boolean lname_blank;
	string5 clean_title; 
	string20 clean_fname; 
	string20 clean_mname; 
	string20 clean_lname; 
	string5 clean_name_suffix; 
	string3 clean_score; 
END;

new_names_file := dataset('~thor_200::base::emerges_new_clean_names2',Layout_clean_name,flat);
base_file := emerges.file_hvccw_base(length(trim(lname_in +fname_in + mname_in)) != 0);
base_file_blank := emerges.file_hvccw_base(length(trim(lname_in +fname_in + mname_in)) = 0);



// --------------------------------------
// -- distribute new names file and sort
// --------------------------------------
new_names_dist := distribute(new_names_file(length(trim(lname_in + fname_in + mname_in)) != 0),hash(title_in, lname_in, fname_in, mname_in, name_suffix_in));

new_names_srt := sort(new_names_dist,title_in, lname_in, fname_in, mname_in, name_suffix_in, local);

// --------------------------------------
// -- distribute emerges base file and sort
// --------------------------------------
base_file_dist := distribute(base_file,hash(title_in, lname_in, fname_in, mname_in, name_suffix_in));

base_file_srt := sort(base_file_dist,title_in, lname_in, fname_in, mname_in, name_suffix_in, local);

// --------------------------------------
// -- Join new clean names file to base emerges file
// --------------------------------------
emerges.Layout_eMerge_In getnewcleanname(emerges.Layout_eMerge_In L, layout_clean_name R) := transform
	self.title := R.clean_title;
	self.fname := R.clean_fname;
	self.mname := R.clean_mname;
	self.lname := R.clean_lname;
	self.name_suffix := R.clean_name_suffix;
	self.score_on_input := R.clean_score;
	self := L;
end;

renameclean_base_file := join(base_file_srt,new_names_srt,
					right.title_in 		= left.title_in and
					right.fname_in 		= left.fname_in and
					right.mname_in 		= left.mname_in and
					right.lname_in 		= left.lname_in and
					right.name_suffix_in 	= left.name_suffix_in,
					getnewcleanname(LEFT,RIGHT),LEFT OUTER, local) + base_file_blank;


output(renameclean_base_file,, '~thor_data400::base::emerges_hunt_vote_ccww20050124', overwrite);

layout_hvc_name_score_stat := 
record
	renameclean_base_file.score_on_input;
	integer4  total                := count(group);
end;

emerges_hvc_name_score_stat := table(renameclean_base_file,layout_hvc_name_score_stat, score_on_input, few);

output(emerges_hvc_name_score_stat);
