import address,business_header,ut;
export Improve_Bdids(

	 dataset(Layouts.Base																	) pJudges
	,boolean																								pUseOtherEnviron	= _Dataset().IsDataland
	,dataset(business_header.Layout_Business_Header_base	) pBHBase						= business_header.files(,pUseOtherEnviron).base.business_headers.qa
	,string																									pPersistname			= persistnames().ImproveBdids

) :=
function
	lmaxrecordsize := _Dataset().max_record_size;
	
	/*
		so, do a zipradius on the defendant address out to maybe 10 miles?
		the closest business that matches the company name doesn't necessarily mean it is the right one
		but that's all I have to go on
		so, unique company name and zip combo
	*/

	//first, find company, zip, combos that only have one bdid associated with them
	dbh_slim				:= project(pBHBase(zip != 0)	,transform({unsigned6 bdid, string company_name,string zip}, self.zip := intformat(left.zip,5,1); self := left;));
	dbh_slim_table 	:= table(dbh_slim, {company_name,bdid,zip,string clean_company_name := ut.CleanCompany(company_name)},company_name,bdid,zip);
	dbh_slim_table2 := table(dbh_slim_table	,{company_name,zip,unsigned8 cnt := count(group)},company_name,zip);	//how many bdids per companyname, zip combo
	dbh_slim_filt 	:= dbh_slim_table2(cnt = 1);
	dbh_back				:= join(dbh_slim_table,dbh_slim_filt,left.zip = right.zip and left.company_name = right.company_name, transform(recordof(dbh_slim_table), self := left));
	
	djudge_prep 						:= project(pJudges	,transform({layouts.base,string clean_company_name,unsigned8 rid}, self := left;self.clean_company_name := ut.CleanCompany(left.rawfields.orgname); self.rid := counter)) : global;
	djudge_prep_withzip			:= djudge_prep((unsigned)Clean_address.zip != 0);
	djudge_prep_withoutzip 	:= djudge_prep((unsigned)Clean_address.zip  = 0);

	//second, join to bh file on company_name, zip to attorney_name, defendant zip first, attempt to get some bdids
	// do most specific to less specific
	dfirstjoin := join(
		 djudge_prep_withzip
		,dbh_back
		,			left.Clean_address.zip	= right.zip
			and stringlib.stringtouppercase(trim(left.rawfields.orgname)) = stringlib.stringtouppercase(trim(RIGHT.company_name))
		,transform(
			 recordof(djudge_prep)
			,self.bdid	:= right.bdid;
 			 self				:= left;
		)
		,left outer
		,partition right
	);
	
	dmatches1 	:= dfirstjoin(bdid != 0);
	dnomatches1 := dfirstjoin(bdid  = 0);

	dsecondjoin := join(
		 distribute(dnomatches1, random())
		,dbh_back
		,			left.Clean_address.zip	= right.zip
			and LEFT.clean_company_name[1..20] = RIGHT.clean_company_name[1..20]
			and ut.CompanySimilar100(LEFT.clean_company_name, RIGHT.clean_company_name) <= 10
		,transform(
			 recordof(djudge_prep)
			,self.bdid	:= right.bdid;
 			 self				:= left;
		)
		,left outer
		,partition right
		,keep(1)
	);
	
	dmatches2 	:= dsecondjoin(bdid != 0) + dmatches1;
	dnomatches2 := dsecondjoin(bdid  = 0);


	dnomatches2_zipradius := project(dnomatches2	
		,transform(
			{recordof(dnomatches2),set of integer4 ziprad5{maxlength(lmaxrecordsize)},set of integer4 ziprad10 {maxlength(lmaxrecordsize)},set of integer4 ziprad15{maxlength(lmaxrecordsize)}/*,set of integer4 ziprad20{maxlength(lmaxrecordsize)}*/}
			,self 					:= left;
			 self.ziprad5 	:= ziplib.ZipsWithinRadius(left.Clean_address.zip,5	);
			 self.ziprad10	:= ziplib.ZipsWithinRadius(left.Clean_address.zip,10	);
			 self.ziprad15	:= ziplib.ZipsWithinRadius(left.Clean_address.zip,15	);
//			 self.ziprad20	:= ziplib.ZipsWithinRadius(left.Clean_address.zip,20	);
	));

	dnomatches2_zipradius_norm5 := normalize(dnomatches2_zipradius,count(left.ziprad5)
		,transform(
			 {recordof(dnomatches2),unsigned2 zipdist}
			,self.zipdist 										:= 5;
			 self.Clean_address.zip := intformat(left.ziprad5[counter],5,1);
			 self 														:= left;
	));

	dnomatches2_zipradius_norm10 := normalize(dnomatches2_zipradius,count(left.ziprad10)
		,transform(
			 {recordof(dnomatches2),unsigned2 zipdist}
			,self.zipdist 										:= 10;
			 self.Clean_address.zip := intformat(left.ziprad10[counter],5,1);
			 self 														:= left;
	));

	dnomatches2_zipradius_norm15 := normalize(dnomatches2_zipradius,count(left.ziprad15)
		,transform(
			 {recordof(dnomatches2),unsigned2 zipdist}
			,self.zipdist 										:= 15;
			 self.Clean_address.zip := intformat(left.ziprad15[counter],5,1);
			 self 														:= left;
	));
/*
	dnomatches2_zipradius_norm20 := normalize(dnomatches2_zipradius,count(left.ziprad20)
		,transform(
			 {recordof(dnomatches2),unsigned2 zipdist}
			,self.zipdist 										:= 20;
			 self.Clean_address.zip := intformat(left.ziprad20[counter],5,1);
			 self 														:= left;
	));
*/	
	dnomatches2_zipradius_all := 
			dnomatches2_zipradius_norm5
		+ dnomatches2_zipradius_norm10
		+ dnomatches2_zipradius_norm15
//		+ dnomatches2_zipradius_norm20
		;
	dnomatches2_zipradius_all_dedup := dedup(sort(dnomatches2_zipradius_all,rid,Clean_address.zip, zipdist), rid, Clean_address.zip);

	//then do joins again
	/////////////////////////////////////////////////
	dzipradjoin1 := join(
		 dnomatches2_zipradius_all_dedup
		,dbh_back
		,			left.Clean_address.zip	= right.zip
			and stringlib.stringtouppercase(trim(left.rawfields.orgname)) = stringlib.stringtouppercase(trim(RIGHT.company_name))
		,transform(
			 recordof(dnomatches2_zipradius_norm5)
			,self.bdid	:= right.bdid;
 			 self				:= left;
		)
		,left outer
		,partition right
	);
	
	dzipradmatches1 	:= dzipradjoin1(bdid != 0);
	dzipradnomatches1 := dzipradjoin1(bdid  = 0);

	dzipradjoin2 := join(
		 dzipradnomatches1
		,dbh_back
		,			left.Clean_address.zip	= right.zip
			and LEFT.clean_company_name[1..20] = RIGHT.clean_company_name[1..20]
			and ut.CompanySimilar100(LEFT.clean_company_name, RIGHT.clean_company_name) <= 10
		,transform(
			 recordof(dnomatches2_zipradius_norm5)
			,self.bdid	:= right.bdid;
 			 self				:= left;
		)
		,left outer
		,partition right
		,keep(1)
	);
	
	dzipradmatches2 	:= dzipradjoin2(bdid != 0) + dzipradmatches1;
	dzipradnomatches2 := dzipradjoin2(bdid  = 0);
	
	dziprad_dedup := project(dedup(sort(dzipradmatches2 + dzipradnomatches2, rid, zipdist), rid),recordof(djudge_prep));
	
	returndataset := project(dmatches2 + dziprad_dedup + djudge_prep_withoutzip,layouts.base);

	return 	returndataset;

end;