#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import WorldCheck, lib_stringlib, ut;

export Normalize_Keywords(dataset(Layout_WorldCheck_Premium) in_f):= function

	//Reformat to Premium Layout
	in_file := in_f;
	
	ds 	:= in_file(regexfind('~',keywords));
	ds2 := in_file(~regexfind('~',keywords));

	layout_rec := record, maxlength(100000)
		ds;
		string names := '';
		integer comp_cnt;
	end;

	layout_rec proj_rec(in_file l) := transform
		self := l;
		self.comp_cnt := ut.NoWords(l.keywords,'~');
	end;

	proj_out 	:= project(ds,proj_rec(left));  //more than 1 keyword
	proj_out2 	:= project(ds2,proj_rec(left)); //one or no keywords

	layout_rec norm_recs(proj_out l,unsigned c) := transform
		self.keywords := TRIM( ut.Word(l.keywords,c,'~'),LEFT,RIGHT );
		self := l;
	end;

	norm_o 		:= normalize(proj_out,left.comp_cnt,norm_recs(left,counter));
	norm_out	:= norm_o + proj_out2 : persist('~thor_200::persist::worldcheck::all_keywords');
	
	//Denorm Keyword IDs;
	layout_rec CompP2(norm_out l) := TRANSFORM
		self.names := l.keywords;		
		SELF := l;
	END;

	proj_keyword 	:= project(norm_out, CompP2(LEFT));
	dedup_keyword 	:= dedup(proj_keyword, record, all);
	sort_keyword 	:= sort(distribute(dedup_keyword, hash(uid)), uid, local);

	layout_rec denorm_recs(sort_keyword l, sort_keyword r, unsigned c) := transform
		
		find_keywd_id 	:= if(c = 1,
								WorldCheck_Bridger._Functions.Find_KeywordsID(trim(r.names, left, right)),
							if(l.names <> '',
								trim(l.names, left, right) + ',' + WorldCheck_Bridger._Functions.Find_KeywordsID(trim(r.names, left, right)),
								WorldCheck_Bridger._Functions.Find_KeywordsID(trim(r.names, left, right))));
		
		self.names 		:= if(regexfind('[0-9]+', find_keywd_id, 0)<>'',
								find_keywd_id,
								'');
		self 			:= l
	end;

	denorm_out 		:= denormalize (sort_keyword, sort_keyword,
                                (left.uid = right.uid),
                                denorm_recs(left, right,counter), local): persist('~thor_200::persist::worldcheck::denormalize_keywords_id');

	//Denorm keywords
	dedup_denorm 	:= dedup(denorm_out, record, all);
	sort_denorm 	:= sort(distribute(dedup_denorm,hash(uid)), uid, local);

	layout_rec denorm_recs2(sort_denorm l, sort_denorm r, unsigned c) := transform
		self.keywords := if(c = 1,
								r.keywords,
							if(l.keywords <> '',
								l.keywords + ';' + r.keywords,
								r.keywords));
		self := l
	end;

	denorm_out2 := denormalize (sort_denorm, sort_denorm,
                                (left.uid = right.uid),
                                denorm_recs2(left, right,counter), local);
	
	denorm_out2 rDup(denorm_out2 l):= transform
		self.names 	:= if(regexfind('11,11,', l.names, 0)<>'',
								regexreplace('11,11,', l.names, '11,'),
								l.names);
		self 		:= l;
	end;
	
	remove_dups := project(denorm_out2, rDup(left)): persist('~thor_200::persist::worldcheck::denormalize_keywords');;
	
	return remove_dups;

end;