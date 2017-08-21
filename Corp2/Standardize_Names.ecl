IMPORT Address, NID, Corp2_Mapping;

export Standardize_Names := module
	shared TempLayout	:=	record
		unsigned8	unique_id;	// to tie back to original record
		unsigned4	name_type;	// RA or Contact
		string100	FullName;
		string5		title;
		string20	fname;
		string20	mname;
		string20	lname;
		string5		name_suffix;
		string3		score;
		string70	cname;
	end;	

	export fCleanName(dataset(TempLayout) pRawFileInput) := function
												 
		NID.Mac_CleanFullNames(pRawFileInput, cleanedNames, fullName);
												 
		TempLayout trfFullName(cleanedNames L) := TRANSFORM
			person_flags := ['P', 'D'];
			business_flags := ['B', 'U', 'I'];

			self.title				:= if (L.nametype in person_flags, l.cln_title,'');
			self.fname				:= if (L.nametype in person_flags, l.cln_fname,'');
			self.mname				:= if (L.nametype in person_flags, l.cln_mname,'');
			self.lname				:= if (L.nametype in person_flags, l.cln_lname,'');
			self.name_suffix	:= if (L.nametype in person_flags, l.cln_suffix,'');
			self.score				:= '';
			self.cname				:= if (L.nametype in business_flags, l.FullName, '');
			self							:= l;		
		end;
	
		GetNameParts	:=	PROJECT(cleanedNames, trfFullName(LEFT));		
	
		return GetNameParts;
	end;

	export fAll( dataset(Corp2_Mapping.LayoutsCommon.Temporary)  pRawFileInput) :=
   function
	 
	 Corp2_Mapping.LayoutsCommon.Temporary	trfRecordOrigin(Corp2_Mapping.LayoutsCommon.Temporary l, unsigned4 cnt)	:=	transform
			self.unique_id			:=	cnt;
			self								:=	l;
		end;

		reProject					:=	project(pRawFileInput, trfRecordOrigin(left,counter));
	 
		dStdNameInputDist	:=	distribute(reProject,hash(unique_id)) : independent;
	 
		tempLayout	tNormalizeName(Corp2_Mapping.LayoutsCommon.Temporary l, unsigned4 cnt)	:=	transform
			self.unique_id	:= 	l.unique_id;
			self.name_type	:= 	cnt;
			self.FullName		:= 	choose(cnt	,l.corp_ra_full_name
																			,l.cont_full_name);
			self						:=	[];
		end;		
   
		AllNames		:=	NORMALIZE(dStdNameInputDist(corp_ra_full_name <> '' or cont_full_name <> '')  ,2,tNormalizeName(LEFT,counter),local);
	 
		dCleanName	:= 	distribute(fCleanName(AllNames(FullName<>'')),hash(unique_id)) : independent;
		
		Corp2_Mapping.LayoutsCommon.Temporary tGetStandardizedName(Corp2_Mapping.LayoutsCommon.Temporary l	,tempLayout r) :=	transform
			self.corp_ra_title1					:=	if(r.name_type = 1	,r.title			,l.corp_ra_title1);
			self.corp_ra_fname1					:=	if(r.name_type = 1	,r.fname			,l.corp_ra_fname1);
			self.corp_ra_mname1					:=	if(r.name_type = 1	,r.mname			,l.corp_ra_mname1);
			self.corp_ra_lname1					:=	if(r.name_type = 1	,r.lname			,l.corp_ra_lname1);
			self.corp_ra_name_suffix1		:=	if(r.name_type = 1	,r.name_suffix,l.corp_ra_name_suffix1);
			self.corp_ra_score1					:=	if(r.name_type = 1	,r.score			,l.corp_ra_score1);
			self.corp_ra_cname1					:=	if(r.name_type = 1	,r.cname			,l.corp_ra_cname1);
		
			self.cont_title							:=	if(r.name_type = 2	,r.title			,l.cont_title);
			self.cont_fname							:=	if(r.name_type = 2	,r.fname			,l.cont_fname);
			self.cont_mname							:=	if(r.name_type = 2	,r.mname			,l.cont_mname);
			self.cont_lname							:=	if(r.name_type = 2	,r.lname			,l.cont_lname);
			self.cont_name_suffix				:=	if(r.name_type = 2	,r.name_suffix,l.cont_name_suffix);
			self.cont_score							:=	if(r.name_type = 2	,r.score			,l.cont_score);
			self.cont_cname							:=	if(r.name_type = 2	,r.cname			,l.corp_ra_cname1);
			self												:= l;
			self												:= [];
		end;
				
		dCleanRANameAppended	:= join(
																	dStdNameInputDist
																	,dCleanName(name_type = 1)
																	,left.unique_id = right.unique_id
																	,tGetStandardizedName(left,right)
																	,local
																	,left outer
																	);
		
		dCleanContNameAppended:= join(
																	dCleanRANameAppended
																	,dCleanName(name_type = 2)
																	,left.unique_id = right.unique_id
																	,tGetStandardizedName(left,right)
																	,local
																	,left outer
																	);

		return dCleanContNameAppended;
   
  end;
end;