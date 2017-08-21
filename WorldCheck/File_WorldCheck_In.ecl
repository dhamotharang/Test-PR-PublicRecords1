import ut, lib_stringlib, std;

dsset := dataset(WorldCheck.Cluster + 'in::worldcheck'
                                    ,WorldCheck.Layout_WorldCheck_in
																		,flat);

	WorldCheck.Layout_WorldCheck_in E_I_IndTrans(dsset l) := transform
		self.E_I_Ind := if(l.E_I_Ind in ['M','F','U'],
											'I',
											l.E_I_Ind);
		self.age_as_of_date := lib_stringlib.StringLib.StringFilterOut(L.age_as_of_date,'/');
		self := l;
	end;

ds_proj := project(dsset, E_I_IndTrans(left));

in_file := sort(distribute(ds_proj,hash(uid)),uid,local); 
									
ds 	:= in_file(regexfind(';',companies));
ds2 := in_file(~regexfind(';',companies));

	layout_rec := record, maxlength(100000)
		 ds;
		 string names := '';
		 integer comp_cnt;
	end;

	layout_rec proj_rec(ds l) := transform
		self := l;
		self.comp_cnt := std.str.countWords(l.companies,';'); 
	end;

proj_out := project(ds,proj_rec(left));

	layout_rec norm_recs(proj_out l,unsigned c) := transform
		self.companies := TRIM( ut.Word(l.companies,c,';'),LEFT,RIGHT );
		self := l;
	end;

norm_out := normalize(proj_out,left.comp_cnt,norm_recs(left,counter));

	layout_rec CompP(norm_out l, in_file r) := TRANSFORM
		self.names := if(regexfind('[A-Z]',stringlib.stringtouppercase(l.companies)),
						l.companies,
						StringLib.StringToUpperCase(TRIM(r.last_name,left,right)));					
		self := l;
	END;

CompanyFind1 := JOIN(sort(distribute(norm_out,hash(companies)),companies,local),
										 sort(distribute(in_file,hash(uid)),uid,local),
										 LEFT.Companies = RIGHT.UID,
										 CompP(LEFT,RIGHT),
										 LEFT OUTER,local);

companyfind := dedup(companyfind1,record);
sortcfind 	:= sort(companyfind,uid);

	layout_rec denorm_recs(sortcfind l,sortcfind r,unsigned c) := transform
		self.names := if(c = 1,r.names,if(l.names <> '',l.names + ';' + r.names,r.names));
		self := l
	end;

denorm_out 	:= denormalize (sortcfind, sortcfind,
                                (left.uid = right.uid),
                                denorm_recs(left, right,counter));

dedup_out 	:= dedup(denorm_out,uid);

	WorldCheck.Layout_WorldCheck_in proj_rec1(dedup_out l) := transform
		self.companies := l.names;
		self := l;
	end;

proj_out1 := project(dedup_out,proj_rec1(left));

final_out := proj_out1 + ds2;

//------------- linked to ----
								
ds3 := final_out(regexfind(';',linked_tos));
ds4 := final_out(~regexfind(';',linked_tos));

	layout_rec1 := record, maxlength(100000)
	 ds3;
	 string links := '';
	 integer link_cnt;
	end;

	layout_rec1 proj_rec11(ds3 l) := transform
		self := l;
		self.link_cnt := std.str.countwords(l.linked_tos,';');
	end;

proj_out11 := project(ds3,proj_rec11(left));

	layout_rec1 norm_recs1(proj_out11 l,unsigned c) := transform
		self.linked_tos := TRIM( ut.Word(l.linked_tos,c,';'),LEFT,RIGHT );
		self := l;
	end;

norm_out1 := normalize(proj_out11,left.link_cnt,norm_recs1(left,counter));

	layout_rec1 CompP1(norm_out1 l, final_out r) := TRANSFORM
		self.links := if(regexfind('[A-Z]',stringlib.stringtouppercase(l.linked_tos)),
						l.linked_tos,
						if(TRIM(r.first_name,left,right)='',
							StringLib.StringToUpperCase(TRIM(r.last_name,left,right)),
							StringLib.StringToUpperCase(TRIM(r.last_name,left,right)+', '+TRIM(r.first_name,left,right)))
						);
						
		self := l;
	END;

CompanyFind2 := JOIN(sort(distribute(norm_out1,hash(linked_tos)),linked_tos,local),
                     sort(distribute(final_out,hash(uid)),uid,local),
										 LEFT.linked_tos = RIGHT.UID,
										 CompP1(LEFT,RIGHT),
										 LEFT OUTER, local);

companyfind3 	:= dedup(companyfind2,record);

sortcfind1 		:= sort(companyfind3,uid);

	layout_rec1 denorm_recs1(sortcfind1 l,sortcfind1 r,unsigned c) := transform
		self.links := if(c = 1,r.links,if(l.links <> '',l.links + ';' + r.links,r.links));
		self := l
	end;

denorm_out1 	:= denormalize (sortcfind1, sortcfind1,
                                (left.uid = right.uid),
                                denorm_recs1(left, right,counter));

dedup_out1 	:= dedup(denorm_out1,uid);

	WorldCheck.Layout_WorldCheck_in proj_rec2(dedup_out1 l) := transform
		self.linked_tos := l.links;
		self := l;
	end;

proj_out2 := project(dedup_out1,proj_rec2(left));

final_out1 := proj_out2 + ds4;

	// -- now work on the remaining records ..
	WorldCheck.Layout_WorldCheck_in join_final(final_out1 l, final_out1 r) := TRANSFORM
		self.linked_tos := if(~regexfind('[A-Z]',stringlib.stringtouppercase(l.linked_tos)),
												if(TRIM(r.first_name,left,right)='',
												StringLib.StringToUpperCase(TRIM(r.last_name,left,right)),
												StringLib.StringToUpperCase(TRIM(r.last_name,left,right)+', '+TRIM(r.first_name,left,right))),
												l.linked_tos);
		SELF := l;
	END;

CompanyFind21 := JOIN(sort(distribute(final_out1(linked_tos<>''),hash(linked_tos)),linked_tos,local),
											sort(distribute(final_out(uid<>''),hash(uid)),uid,local),
											LEFT.linked_tos = RIGHT.UID,
											join_final(LEFT,RIGHT),
											LEFT OUTER, local);

companyfind21a := CompanyFind21 + final_out(uid='') + final_out1(linked_tos='');

	WorldCheck.Layout_WorldCheck_in join_final1(companyfind21a l, companyfind21a r) := TRANSFORM
		self.companies := if(~regexfind('[A-Z]',stringlib.stringtouppercase(l.companies)),
							StringLib.StringToUpperCase(TRIM(r.last_name,left,right)),
							l.companies);				
		SELF := l;
	END;

CompanyFind22 := JOIN(sort(distribute(companyfind21a(companies<>''),hash(companies)),companies, local),
											sort(distribute(companyfind21a(uid<>''),hash(uid)),uid, local),
											LEFT.companies = RIGHT.UID,
											join_final1(LEFT,RIGHT),
											LEFT OUTER, local);

CompanyFind22a := CompanyFind22 + companyfind21a(companies='') + companyfind21a(uid='');

export File_WorldCheck_In := DISTRIBUTE(CompanyFind22a, random()) : persist('~thor_200::persist::worldcheck::clean');