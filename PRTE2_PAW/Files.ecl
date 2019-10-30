Import paw,BIPV2;
EXPORT files := module

	EXPORT paw_basefile := DATASET('~PRTE::BASE::paw', Layouts.Layout_Base, FLAT );

	EXPORT file_paw_IN := DATASET('~PRTE::IN::paw', Layouts.Layout_In, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

	EXPORT file_Employment_Out := PROJECT(paw_basefile, Layouts.Employment_Out );

	SHARED file_keybuild := project(	file_Employment_Out,Layouts.Employment_Out_old );
	
	EXPORT file_Employment_Out_BIPv2 := PROJECT(paw_basefile, Layouts.Employment_Out_BIPv2);
	
	//file_bdid////////
	dSlim		  := TABLE(file_Employment_Out, {Bdid,contact_id});
	dSort         := SORT(dSlim, Bdid,contact_id);
	EXPORT file_bdid := DEDUP(DSort ,Bdid,contact_id);
	
	///////////file_companyname_domain//////////////////
	tempproj := project(paw_basefile, {file_keybuild.company_name;string50 domain;});
					
	// group by company name and domain
	temptable1a := table(tempproj,{company_name,domain,cnt:=count(group)},company_name,domain);
	temptable1 := table(temptable1a,{company_name,domain,unsigned cnt:=sum(group,cnt)},company_name,domain);
	// group just by domain
	temptable2a := table(temptable1,{domain,unsigned cnt:=sum(group,cnt)},domain);
	temptable2 := table(temptable2a,{domain,unsigned cnt:=sum(group,cnt)},domain);
	// compute what percentage of the total records for the domain are for a particular company name
	tempjoinrec := record
		temptable1;
		typeof(temptable2.cnt) tot_cnt;
		real ratio;
	end;
	tempjoin := join(	temptable1(domain != ''),
					temptable2(domain != ''),
					left.domain = right.domain,
					transform(tempjoinrec,
							self.domain := right.domain,
							self.tot_cnt := right.cnt,
							self.ratio := if(left.cnt = 0,0.0,if((real)left.cnt/(real)right.cnt < 0.01,skip,(real)left.cnt/(real)right.cnt)),
							self := left));
	// now, roll up all those with 1% or more of the records, by domain
	tempsort := sort(tempjoin,-tot_cnt,domain,-cnt,company_name);

	temprollup := rollup(	tempsort,
						left.tot_cnt = right.tot_cnt and
						left.domain = right.domain,
						transform(tempjoinrec,
								self.ratio := left.ratio + right.ratio,
								self := left));

	// take all domains where all company names with at least 1% make up at least 20%, and get all those records
	tempjoinback := join(	temprollup(ratio >= 0.20),
						tempjoin,
						left.domain = right.domain,
						transform(right));

	// get the ones that don't fit our criteria -- these are our 'O'pen domains.
	templeftout := join(temptable2,
					tempjoinback,
					left.domain = right.domain,
					transform(left),
					left only);
	keyrec := record
		tempjoinback.domain;
		tempjoinback.company_name;
		string1 domain_type; // 'O'pen (like Yahoo.com, Gmail.com, etc) or 'C'losed (like yale.edu, wsj.com, etc)
		real ratio;
	end;
	dSlim_closed := PROJECT(	tempjoinback,
						TRANSFORM(keyrec,
								SELF.domain_type := 'C',
								SELF := LEFT));
	dSlim_open := PROJECT(	templeftout,
						TRANSFORM(keyrec,
						SELF.domain_type := 'O',
						SELF.company_name := '',
						SELF.ratio := 0.0,
						SELF := LEFT));

	EXPORT file_companyname_domain := dSlim_closed + dSlim_open;
	
	///////////file_contactid///////
	dbaseBIP			:= project(file_Employment_Out_BIPv2(contact_id > 0),
							transform(
								Layouts.Employment_Out_BIPv2,
								self	:= left;
							));
	File_To_Process_To_Key_	:= dbaseBIP(contact_id > 0);
	File_To_Process_To_Key 	:= project(File_To_Process_To_Key_, {recordof(File_To_Process_To_Key_), BIPV2.IDlayouts.l_xlink_ids});

	recordof(File_To_Process_To_Key) JoinForLinkIds	(File_To_Process_To_Key l, dbaseBip r)	:=	transform
		self	:=	r;
		self	:=	l;
	end;
	JoinedForLinks	:=	join(	File_To_Process_To_Key,
							dbaseBIP,
							left.contact_id = right.contact_id,
							JoinForLinkIds(left,right),
							left outer);
	Export file_contactid  := sort(JoinedForLinks,contact_id);

	///////file_did///////
	dSlim		  := TABLE(file_keybuild, {did,contact_id});
	dSort         := sort(dSlim, did,contact_id);
	EXPORT file_did := dedup(DSort ,did,contact_id);

END;