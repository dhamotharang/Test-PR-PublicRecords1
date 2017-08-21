import tools,address;

export Split_Input(

	 string																	pversion
	,dataset(layouts.temporary.big				)	pSprayedFile					= Prep_Input(pversion)
	,dataset(layouts.input.affpeople			)	pSprayedAffPeep				= Files().input.affpeople.using
	,dataset(layouts.input.affboards			)	pSprayedAffBoard			= Files().input.affboards.using
	,dataset(layouts.input.affPositions		)	pSprayedAffPos				= Files().input.affPositions.using
	,dataset(layouts.input.killreport			)	pSprayedkillReport		= Files().input.killReport.using
	,dataset(layouts.input.MergerAcquis		)	pSprayedMergerAcquis	= Files().input.MergerAcquis.using
	,string																	pPersistCompname			= persistnames().SplitInputCompanies
	,string																	pPersistContname			= persistnames().SplitInputContacts
) :=
module

	d := project		(pSprayedFile	,transform(layouts.temporary.companies_aid_prep	,self := left,self := []))							: persist(pPersistCompname);
	killmerge := Prep_Kill_Merger(pversion,pSprayedkillReport,pSprayedMergerAcquis);

	dKillAppendDates	:= killmerge.dkillfixdates	;
  dMergeAppendDates	:= killmerge.dMergefixDates ;

	dgetkillreport := join(
		 distribute(pSprayedFile    ,hash64(rawfields.enterprise_num))
		,distribute(dKillAppendDates,hash64(enterprise_nbr          ))
		,		left.rawfields.Enterprise_num = right.enterprise_nbr
		and left.filedate									= right.filedate				//should be in same feed
		,transform(
			 layouts.temporary.big
			,self.killreport	:= right
			,self							:= left
		)
		,keep(1)
		,left outer
		,local
	);
	
	dgetMergers := join(
		 distribute(dgetkillreport    ,hash64(rawfields.enterprise_num))
		,distribute(dMergeAppendDates ,hash64(target_enterprise_nbr))
		,		left.rawfields.Enterprise_num = right.target_enterprise_nbr
		and left.filedate									= right.filedate								//should be in same feed
		,transform(
			 layouts.temporary.big
			,self.MergerAcquis	:= right
			,self								:= left
		)
		,keep(1)
		,left outer
		,local
	);

	export Companies := project		(dgetMergers	,transform(layouts.temporary.companies_aid_prep	,self := left,self := []))							: persist(pPersistCompname);
	
	dboardslim	:= table(pSprayedAffBoard	(human_link_id != '')	,{company_nbr,human_link_id,__filename},company_nbr,human_link_id,__filename);
	dposslim 		:= table(pSprayedAffPos		(human_link_id != '')	,{company_nbr,human_link_id,__filename},company_nbr,human_link_id,__filename);
	dbothslim		:= table(dboardslim + dposslim	,{company_nbr,human_link_id,__filename},company_nbr,human_link_id,__filename);
	dbothslim_proj := project(dbothslim	,transform({dbothslim.company_nbr,dbothslim.human_link_id,dbothslim.__filename,string8 filedate},self := left,self := []));
	
	dbothslimDates := tools.mac_Append_Dates	(dbothslim_proj	,['__filename'],['filedate']);

	dbothslimDates_fixdates := project(dbothslimDates	,transform(recordof(dbothslimDates),self.filedate		:= if((unsigned)left.filedate != 0	,left.filedate	,pversion);self := left));

	dSprayedAffPeep_proj := project(pSprayedAffPeep	,transform({recordof(pSprayedAffPeep),string8 filedate},self := left,self := []));
	
	dSprayedAffPeep_dates := tools.mac_Append_Dates	(dSprayedAffPeep_proj	,['__filename'],['filedate']);

	dSprayedAffPeep_fixdates := project(dSprayedAffPeep_dates	,transform(recordof(dSprayedAffPeep_dates),self.filedate		:= if((unsigned)left.filedate != 0	,left.filedate	,pversion);self := left));
	
	dGetName		:= join(dSprayedAffPeep_fixdates,dbothslimDates_fixdates
		,		left.human_link_id = right.human_link_id	
		and left.filedate			 = right.filedate
		,transform({string9 human_link_id,string9 company_nbr,string89 full_name,string7	prefix,string29	first_name,string34	middle_name,string84	last_name,string4	suffix,string4 birth_year,string6	gender,string8 filedate}
			,self	:= left
			,self := right
	));
	
	tools.mac_RedefineFormat(pSprayedFile		,layouts.temporary.bigchild	,dRedefInput		,50000,,[10,10,20,10],pShouldExport := false);	//put repeated fields into child datasets for easier manipulation

	dnormContacts	 := normalize	(dRedefInput	,10,transform(layouts.temporary.contacts_aid_prep	,
		name := left.rawfields.executives[counter].name;
		
		self.rawfields.executive.title	:= left.rawfields.executives[counter].title	;
		self.rawfields.executive.code		:= left.rawfields.executives[counter].code	;
		self.rawfields.executive.name		:= name	;
		self.clean_name									:= if(name != ''	
																					,Address.CleanPersonFML73_fields(name).CleanNameRecord	
																					,Address.CleanNameFields('').CleanNameRecord
																			);
		self 														:= left;
		self														:= []
		))(rawfields.executive.name != '');
		
	dGetLinkId	:= join(dnormContacts,dedup(sort(dGetName,company_nbr,full_name,filedate),company_nbr,full_name,filedate)
		,			trim(left.rawfields.enterprise_num,left,right)	= trim(right.company_nbr,left,right)
			and	trim(left.rawfields.executive.name,left,right)	= trim(right.full_name	,left,right)
			and left.filedate																		= right.filedate
		,transform(
			 recordof(left)
			,self.birth_year		:= right.birth_year
			,self.gender				:= right.gender
			,self.human_link_id	:= right.human_link_id
			,self								:= left
		)
		,left outer
	);

  // -- rids are now not unique since normalize, make them unique
	minrid := min(pSprayedFile,rid); 
  
	export Contacts := project(dGetLinkId,transform(recordof(left),self.rid := minrid + counter,self := left))
		: persist(pPersistContname	);
end;