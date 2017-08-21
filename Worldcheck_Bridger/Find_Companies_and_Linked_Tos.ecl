/*2011-05-31T20:40:42Z (Judy Tao_prod)

*/
#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import ut, worldcheck, std;

export Find_Companies_and_Linked_Tos(dataset(Layout_Rectified) in_f) := function

//FIND COMPANY NAMES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ds 		:= in_f(regexfind(';',companies));
ds2 	:= in_f(~regexfind(';',companies)):persist('~thor_200::persist::worldcheck::one_no_companies');

	layout_rec := record, maxlength(100000)
		ds;
		string names 	:= '';
		integer comp_cnt;
	end;

	layout_rec proj_rec(ds l) := transform
		self 			:= l;
		self.comp_cnt 	:= ut.NoWords(l.companies,';');
	end;

	proj_out := project(ds,proj_rec(left));

	layout_rec norm_recs(proj_out l,unsigned c) := transform
		self.companies 	:= TRIM(ut.Word(l.companies,c,';'),LEFT,RIGHT );
		self 			:= l;
	end;

	norm_out := normalize(proj_out,left.comp_cnt,norm_recs(left,counter));
	
	layout_rec CompP(norm_out l, in_f r) := transform
		self.names 		:= if(regexfind('[A-Z]',stringlib.stringtouppercase(l.companies)),
								l.companies,
								if(trim(l.last_name, left, right)<>'',
								STD.Str.ToUpperCase(TRIM(r.last_name,left,right))+', '+r.uid,
								l.companies));	
		self 			:= l;
	end;

	CompanyFind1 := JOIN(sort(distribute(norm_out,hash(companies)),companies,local),sort(distribute(in_f,hash(uid)),uid,local),
							LEFT.Companies = RIGHT.UID,
							CompP(LEFT,RIGHT),
							LEFT OUTER,local);

	companyfind := dedup(companyfind1, record, all):persist('~thor_200::persist::worldcheck::norm_companies');
	sortcfind 	:= sort(companyfind,uid);
	
	layout_rec denorm_recs(sortcfind l, sortcfind r, unsigned c) := transform
		self.names := if(c = 1,
							r.names,
						if(l.names <> '',
							l.names + ' | ' + r.names,
							r.names));//populate companies and uids
		self := l
	end;

	denorm_out 	:= denormalize(sortcfind, sortcfind,
                                (left.uid = right.uid),
                                denorm_recs(left, right,counter));

	dedup_out 	:= dedup(denorm_out, uid, all);

	Layout_Rectified proj_rec1(dedup_out l) := transform
		self.companies := l.names;
		self := l;
	end;

	proj_out1 := project(dedup_out,proj_rec1(left));//:persist('~thor_200::persist::in::worldcheck_companies');

proj_out_comp := proj_out1 + ds2;

//FIND REMAINING COMPANY NAMES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Layout_Rectified join_final1(proj_out_comp l, proj_out_comp r) := TRANSFORM
		self.companies := if(~regexfind('[A-Z]',stringlib.stringtouppercase(l.companies)) and trim(l.companies, left, right)<>'',
							StringLib.StringToUpperCase(TRIM(r.last_name,left,right))+', '+r.uid,
							l.companies);				
		SELF := l;
	END;

	CompanyFind22 := JOIN(sort(distribute(proj_out_comp(companies<>''),hash(companies)),companies),sort(distribute(proj_out_comp(uid<>''),hash(uid)),uid),
							LEFT.companies = RIGHT.UID,
							join_final1(LEFT,RIGHT),
							LEFT OUTER);

CompanyFind_Final := CompanyFind22 + proj_out_comp(companies='') + proj_out_comp(uid='');

//FIND LINKED TOs~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ds3 := CompanyFind_Final(regexfind(';',linked_tos));
ds4 := CompanyFind_Final(~regexfind(';',linked_tos)):persist('~thor_200::persist::worldcheck::one_no_linktos');

	layout_rec1 := record, maxlength(100000)
		ds3;
		string links 	:= '';
		integer link_cnt;
	end;

	layout_rec1 proj_rec11(ds3 l) := transform
		self 			:= l;
		self.link_cnt 	:= ut.NoWords(l.linked_tos,';');
	end;

	proj_out11 := project(ds3,proj_rec11(left));

	layout_rec1 norm_recs1(proj_out11 l,unsigned c) := transform
		self.linked_tos := TRIM( ut.Word(l.linked_tos,c,';'),LEFT,RIGHT );
		self 			:= l;
	end;

	norm_out1 := normalize(proj_out11,left.link_cnt,norm_recs1(left,counter)):persist('~thor_200::persist::worldcheck::normalize_link_tos');

	layout_rec1 CompP1(norm_out1 l, CompanyFind_Final r) := TRANSFORM
		self.links 	:= if(regexfind('[A-Z]',stringlib.stringtouppercase(l.linked_tos)),
							l.linked_tos,
						if(TRIM(r.first_name, left, right)='' and trim(r.last_name, left, right)<>'',
							StringLib.StringToUpperCase(TRIM(r.last_name,left,right))+', '+r.uid,
						if(TRIM(r.first_name, left, right)<>'' and trim(r.last_name, left, right)<>'',
							StringLib.StringToUpperCase(TRIM(r.last_name,left,right)+', '+TRIM(r.first_name,left,right))+', '+r.uid,
						'')));	
		self 		:= l;
	END;

	Link_join 		:= JOIN(sort(distribute(norm_out1,hash(linked_tos)),linked_tos,local), sort(distribute(CompanyFind_Final,hash(uid)),uid,local),
							LEFT.linked_tos = RIGHT.UID,
							CompP1(LEFT,RIGHT),
							LEFT OUTER);

	Link_dedup 		:= dedup(Link_join, record, all):persist('~thor_200::persist::worldcheck::norm_linktos');
	Link_sort 		:= sort(Link_dedup,uid);
	
	layout_rec1 denorm_recs1(Link_sort l, Link_sort r, unsigned c) := transform
		self.links 	:= if(c = 1,
							r.links,
							if(l.links <> '',
							l.links + ' | ' + r.links,
							r.links)); //populate linked name and uid
		self 		:= l
	end;

	denorm_out1 	:= denormalize(Link_sort, Link_sort,
									(left.uid = right.uid),
									denorm_recs1(left, right,counter));

	dedup_out1 		:= dedup(denorm_out1, uid, all);

	Layout_Rectified proj_rec2(dedup_out1 l) := transform
		self.linked_tos := l.links;
		self 			:= l;
	end;

	proj_out2 := project(dedup_out1,proj_rec2(left));

final_out1 := proj_out2 + ds4;  

//FIND REMAINING LINKED TOs~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Layout_Rectified join_final(final_out1 l, final_out1 r) := TRANSFORM
		self.linked_tos := if(~regexfind('[A-Z]',stringlib.stringtouppercase(l.linked_tos)),
								if(TRIM(r.first_name,left,right)='' and trim(r.last_name, left, right)<>'',
								StringLib.StringToUpperCase(TRIM(r.last_name,left,right))+', '+r.uid,
								if(TRIM(r.first_name,left,right)<>'' and trim(r.last_name, left, right)<>'',
								StringLib.StringToUpperCase(TRIM(r.last_name,left,right)+', '+TRIM(r.first_name,left,right))+', '+r.uid,
								l.linked_tos)), l.linked_tos);
		SELF 			:= l;
	END;

	Join_Links := JOIN(sort(distribute(final_out1(linked_tos<>''),hash(linked_tos)),linked_tos,local), sort(distribute(final_out1(uid<>''),hash(uid)),uid,local),
							LEFT.linked_tos = RIGHT.UID,
							join_final(LEFT,RIGHT),
							LEFT OUTER);

LinkFind_Final := Join_Links + final_out1(uid='') + final_out1(linked_tos=''): persist('~thor_200::persist::worldcheck::companies_link_tos');

return LinkFind_Final;

end;