IMPORT  RoxieKeyBuild,ut,autokey,doxie, header_services;

KeyName       	:= cluster.cluster_out+'Key::PAW::';
dBase 	      	:= File_Base(email_address != '');
File_To_Process_To_Key	:= File_keybuild(dBase);

tempproj := project(File_To_Process_To_Key,transform(
	{
		File_To_Process_To_Key.company_name;
		string50 domain;
	},
	self.company_name := TRIM(stringlib.StringToUpperCase(left.company_name),left,right),
	self.domain := TRIM(stringlib.StringToUpperCase(regexfind('[@](.*)',left.email_address,1)),left,right),
	self := left));

// group by company name and domain
temptable1a := table(distribute(tempproj,hash64(random())),{company_name,domain,cnt:=count(group)},company_name,domain,local);
temptable1 := table(temptable1a,{company_name,domain,unsigned cnt:=sum(group,cnt)},company_name,domain);

// group just by domain
temptable2a := table(distribute(temptable1,hash64(random())),{domain,unsigned cnt:=sum(group,cnt)},domain,local);
temptable2 := table(temptable2a,{domain,unsigned cnt:=sum(group,cnt)},domain);

// compute what percentage of the total records for the domain are for a particular company name
tempjoinrec := record
	temptable1;
	typeof(temptable2.cnt) tot_cnt;
	real ratio;
end;

tempjoin := join(temptable1(domain != ''),temptable2(domain != ''),
	left.domain = right.domain,
	transform(tempjoinrec,
		self.domain := right.domain,
		self.tot_cnt := right.cnt,
		// skip any with less than 1% of the records
		self.ratio := if(left.cnt = 0,0.0,if((real)left.cnt/(real)right.cnt < 0.01,skip,(real)left.cnt/(real)right.cnt)),
		self := left));

// now, roll up all those with 1% or more of the records, by domain
tempsort := sort(tempjoin,-tot_cnt,domain,-cnt,company_name);

temprollup := rollup(tempsort,
	left.tot_cnt = right.tot_cnt and
	left.domain = right.domain,
	transform(tempjoinrec,
		self.ratio := left.ratio + right.ratio,
		self := left));

// take all domains where all company names with at least 1% make up at least 20%, and get all those records
tempjoinback := join(temprollup(ratio >= 0.20),tempjoin,
	left.domain = right.domain,
	transform(right));

// get the ones that don't fit our criteria -- these are our 'O'pen domains.
templeftout := join(temptable2,tempjoinback,
	left.domain = right.domain,
	transform(left),
	left only);

keyrec := record
	tempjoinback.domain;
	tempjoinback.company_name;
	string1 domain_type; // 'O'pen (like Yahoo.com, Gmail.com, etc) or 'C'losed (like yale.edu, wsj.com, etc)
	real ratio;
end;

dSlim_closed := PROJECT(tempjoinback,TRANSFORM(keyrec,
	SELF.domain_type := 'C',
	SELF := LEFT));
dSlim_open := PROJECT(templeftout,TRANSFORM(keyrec,
	SELF.domain_type := 'O',
	SELF.company_name := '',
	SELF.ratio := 0.0,
	SELF := LEFT));

dSlim := dSlim_closed + dSlim_open;

export Key_companyname_domain := INDEX(dSlim  ,{domain},{dSlim},KeyName+doxie.Version_SuperKey+'::companyname_domain');

