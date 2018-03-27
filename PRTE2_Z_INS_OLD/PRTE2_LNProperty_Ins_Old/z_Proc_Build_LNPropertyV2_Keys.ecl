//*EXPORT Proc_Build_LNPropertyV2_Keys := 'todo';
import	_control,PRTE_CSV;
//* BUILD LN PROPERTYV2 INDEXES for Customer Test
export	Proc_Build_LNPropertyV2_Keys(string	pIndexVersion)	:=
function
	// Get the key layout definitions
	rKeyLNPropertyV2__addlfaresdeed_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__addlfaresdeed_fid;
	end;
	
	rKeyLNPropertyV2__addlfarestax_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__addlfarestax_fid;
	end;
	
	rKeyLNPropertyV2__addllegal_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__addllegal_fid;
	end;
	
	rKeyLNPropertyV2__addr_search_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__addr_search_fid;
	end;
	
	rKeyLNPropertyV2__assessor_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__assessor_fid;
	end;
	
	rKeyLNPropertyV2__assessor_parcelnum	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__assessor_parcelnum;
	end;
	
	rKeyLNPropertyV2__autokey__address	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__address;
	end;
	
	rKeyLNPropertyV2__autokey__addressb2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__addressb2;
	end;
	
	rKeyLNPropertyV2__autokey__citystname	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__citystname;
	end;
	
	rKeyLNPropertyV2__autokey__citystnameb2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__citystnameb2;
	end;
	
	rKeyLNPropertyV2__autokey__fein2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__fein2;
	end;
	
	rKeyLNPropertyV2__autokey__name	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__name;
	end;
	
	rKeyLNPropertyV2__autokey__nameb2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__nameb2;
	end;
	
	rKeyLNPropertyV2__autokey__namewords2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__namewords2;
	end;
	
	rKeyLNPropertyV2__autokey__payload	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__payload;
	end;
	
	rKeyLNPropertyV2__autokey__phone2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__phone2;
	end;
	
	rKeyLNPropertyV2__autokey__phoneb2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__phoneb2;
	end;
	
	rKeyLNPropertyV2__autokey__ssn2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__ssn2;
	end;
	
	rKeyLNPropertyV2__autokey__stname	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__stname;
	end;
	
	rKeyLNPropertyV2__autokey__stnameb2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__stnameb2;
	end;
	
	rKeyLNPropertyV2__autokey__zip	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__zip;
	end;
		
	rKeyLNPropertyV2__autokey__zipb2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__zipb2;
	end;
	
	rKeyLNPropertyV2__deed_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__deed_fid;
	end;
	
	rKeyLNPropertyV2__deed_parcelnum	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__deed_parcelnum;
	end;
	
	rKeyLNPropertyV2__search_bdid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__search_bdid;
	end;
	
	rKeyLNPropertyV2__search_did	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__search_did;
	end;
	
	rKeyLNPropertyV2__search_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__search_fid;
	end;
	
	rKeyLNPropertyV2__search_fid_county	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__search_fid_county;
	end;
	
	// Reformat the csv datasets to the layouts defined above
	dKeyLNPropertyV2__addlfaresdeed_fid			:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__addlfaresdeed_fid,rKeyLNPropertyV2__addlfaresdeed_fid);
	dKeyLNPropertyV2__addlfarestax_fid			:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__addlfarestax_fid,rKeyLNPropertyV2__addlfarestax_fid);
	dKeyLNPropertyV2__addllegal_fid					:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__addllegal_fid,rKeyLNPropertyV2__addllegal_fid);
	dKeyLNPropertyV2__addr_search_fid				:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__addr_search_fid,rKeyLNPropertyV2__addr_search_fid);
	dKeyLNPropertyV2__assessor_fid					:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__assessor_fid,rKeyLNPropertyV2__assessor_fid);
	dKeyLNPropertyV2__assessor_parcelnum		:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__assessor_parcelnum,rKeyLNPropertyV2__assessor_parcelnum);
	dKeyLNPropertyV2__autokey__address			:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__address,rKeyLNPropertyV2__autokey__address);
	dKeyLNPropertyV2__autokey__addressb2		:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__addressb2,rKeyLNPropertyV2__autokey__addressb2);
	dKeyLNPropertyV2__autokey__citystname		:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__citystname,rKeyLNPropertyV2__autokey__citystname);
	dKeyLNPropertyV2__autokey__citystnameb2	:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__citystnameb2,rKeyLNPropertyV2__autokey__citystnameb2);
	dKeyLNPropertyV2__autokey__fein2				:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__fein2,rKeyLNPropertyV2__autokey__fein2);
	dKeyLNPropertyV2__autokey__name					:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__name,rKeyLNPropertyV2__autokey__name);
	dKeyLNPropertyV2__autokey__nameb2				:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__nameb2,rKeyLNPropertyV2__autokey__nameb2);
	dKeyLNPropertyV2__autokey__namewords2		:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__namewords2,rKeyLNPropertyV2__autokey__namewords2);
	dKeyLNPropertyV2__autokey__payload			:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__payload,rKeyLNPropertyV2__autokey__payload);
	dKeyLNPropertyV2__autokey__phone2				:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__phone2,rKeyLNPropertyV2__autokey__phone2);
	dKeyLNPropertyV2__autokey__phoneb2			:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__phoneb2,rKeyLNPropertyV2__autokey__phoneb2);
	dKeyLNPropertyV2__autokey__ssn2					:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__ssn2,rKeyLNPropertyV2__autokey__ssn2);
	dKeyLNPropertyV2__autokey__stname				:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__stname,rKeyLNPropertyV2__autokey__stname);
	dKeyLNPropertyV2__autokey__stnameb2			:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__stnameb2,rKeyLNPropertyV2__autokey__stnameb2);
	dKeyLNPropertyV2__autokey__zip					:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__zip,rKeyLNPropertyV2__autokey__zip);
	dKeyLNPropertyV2__autokey__zipb2				:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__autokey__zipb2,rKeyLNPropertyV2__autokey__zipb2);
	dKeyLNPropertyV2__deed_fid							:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__deed_fid,rKeyLNPropertyV2__deed_fid);
	dKeyLNPropertyV2__deed_parcelnum				:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__deed_parcelnum,rKeyLNPropertyV2__deed_parcelnum);
	dKeyLNPropertyV2__search_bdid						:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__search_bdid,rKeyLNPropertyV2__search_bdid);
	dKeyLNPropertyV2__search_did						:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__search_did,rKeyLNPropertyV2__search_did);
	dKeyLNPropertyV2__search_fid						:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__search_fid,rKeyLNPropertyV2__search_fid);
	dKeyLNPropertyV2__search_fid_county			:= 	project(PRTE_CSV.LN_PropertyV2.dthor_data400__key__ln_propertyv2__search_fid_county,rKeyLNPropertyV2__search_fid_county);
	
	// Index definitions for keys
	kKeyLNPropertyV2__autokey__address			:=	index(dKeyLNPropertyV2__autokey__address,{prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups},{dKeyLNPropertyV2__autokey__address},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::address');
	kKeyLNPropertyV2__autokey__addressb2		:=	index(dKeyLNPropertyV2__autokey__addressb2,{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid},{dKeyLNPropertyV2__autokey__addressb2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::addressb2');
	kKeyLNPropertyV2__autokey__citystname		:=	index(dKeyLNPropertyV2__autokey__citystname,{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyLNPropertyV2__autokey__citystname},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::citystname');
	kKeyLNPropertyV2__autokey__citystnameb2	:=	index(dKeyLNPropertyV2__autokey__citystnameb2,{city_code,st,cname_indic,cname_sec,bdid},{dKeyLNPropertyV2__autokey__citystnameb2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::citystnameb2');
	kKeyLNPropertyV2__autokey__fein2				:=	index(dKeyLNPropertyV2__autokey__fein2,{f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid},{dKeyLNPropertyV2__autokey__fein2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::fein2');
	kKeyLNPropertyV2__autokey__name					:=	index(dKeyLNPropertyV2__autokey__name,{dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyLNPropertyV2__autokey__name},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::name');
	kKeyLNPropertyV2__autokey__nameb2				:=	index(dKeyLNPropertyV2__autokey__nameb2,{cname_indic,cname_sec,bdid},{dKeyLNPropertyV2__autokey__nameb2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::nameb2');
	kKeyLNPropertyV2__autokey__namewords2		:=	index(dKeyLNPropertyV2__autokey__namewords2,{word,state,seq,bdid},{dKeyLNPropertyV2__autokey__namewords2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::namewords2');
	kKeyLNPropertyV2__autokey__payload			:=	index(dKeyLNPropertyV2__autokey__payload,{fakeid},{dKeyLNPropertyV2__autokey__payload},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::payload');
	kKeyLNPropertyV2__autokey__phone2				:=	index(dKeyLNPropertyV2__autokey__phone2,{p7,p3,dph_lname,pfname,st,did},{dKeyLNPropertyV2__autokey__phone2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::phone2');
	kKeyLNPropertyV2__autokey__phoneb2			:=	index(dKeyLNPropertyV2__autokey__phoneb2,{p7,p3,cname_indic,cname_sec,st,bdid},{dKeyLNPropertyV2__autokey__phoneb2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::phoneb2');
	kKeyLNPropertyV2__autokey__ssn2					:=	index(dKeyLNPropertyV2__autokey__ssn2,{s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did},{dKeyLNPropertyV2__autokey__ssn2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::ssn2');
	kKeyLNPropertyV2__autokey__stname				:=	index(dKeyLNPropertyV2__autokey__stname,{st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyLNPropertyV2__autokey__stname},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::stname');
	kKeyLNPropertyV2__autokey__stnameb2			:=	index(dKeyLNPropertyV2__autokey__stnameb2,{st,cname_indic,cname_sec,bdid},{dKeyLNPropertyV2__autokey__stnameb2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::stnameb2');
	kKeyLNPropertyV2__autokey__zip					:=	index(dKeyLNPropertyV2__autokey__zip,{zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyLNPropertyV2__autokey__zip},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::zip');
	kKeyLNPropertyV2__autokey__zipb2				:=	index(dKeyLNPropertyV2__autokey__zipb2,{zip,cname_indic,cname_sec,bdid},{dKeyLNPropertyV2__autokey__zipb2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::zipb2');
	kKeyLNPropertyV2__addlfaresdeed_fid			:=	index(dKeyLNPropertyV2__addlfaresdeed_fid,{ln_fares_id},{dKeyLNPropertyV2__addlfaresdeed_fid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::addlfaresdeed.fid');
	kKeyLNPropertyV2__addlfarestax_fid			:=	index(dKeyLNPropertyV2__addlfarestax_fid,{ln_fares_id},{dKeyLNPropertyV2__addlfarestax_fid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::addlfarestax.fid');
	kKeyLNPropertyV2__addllegal_fid					:=	index(dKeyLNPropertyV2__addllegal_fid,{ln_fares_id},{dKeyLNPropertyV2__addllegal_fid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::addllegal.fid');
	kKeyLNPropertyV2__addr_search_fid				:=	index(dKeyLNPropertyV2__addr_search_fid,{prim_name,prim_range,zip,predir,postdir,suffix,sec_range,source_code_2,LN_owner,owner,nofares_owner,source_code_1},{ln_fares_id,lname,fname,name_suffix},'~prte::key::ln_propertyv2::' + pIndexVersion + '::addr_search.fid');
	kKeyLNPropertyV2__assessor_fid					:=	index(dKeyLNPropertyV2__assessor_fid,{ln_fares_id,proc_date},{dKeyLNPropertyV2__assessor_fid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::assessor.fid');
	kKeyLNPropertyV2__assessor_parcelnum		:=	index(dKeyLNPropertyV2__assessor_parcelnum,{fares_unformatted_apn},{ln_fares_id},'~prte::key::ln_propertyv2::' + pIndexVersion + '::assessor.parcelNum');
	kKeyLNPropertyV2__deed_fid							:=	index(dKeyLNPropertyV2__deed_fid,{ln_fares_id,proc_date},{dKeyLNPropertyV2__deed_fid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::deed.fid');
	kKeyLNPropertyV2__deed_parcelnum				:=	index(dKeyLNPropertyV2__deed_parcelnum,{fares_unformatted_apn},{ln_fares_id},'~prte::key::ln_propertyv2::' + pIndexVersion + '::deed.parcelNum');
	kKeyLNPropertyV2__search_bdid						:=	index(dKeyLNPropertyV2__search_bdid,{s_bid},{dKeyLNPropertyV2__search_bdid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::search.bdid');
	kKeyLNPropertyV2__search_did						:=	index(dKeyLNPropertyV2__search_did,{s_did,source_code_2},{ln_fares_id,source_code,lname,fname,prim_range,predir,prim_name,suffix,postdir,sec_range,st,p_city_name,zip,county,geo_blk},'~prte::key::ln_propertyv2::' + pIndexVersion + '::search.did');
	kKeyLNPropertyV2__search_fid						:=	index(dKeyLNPropertyV2__search_fid,{ln_fares_id,which_orig,source_code_2,source_code_1},{dKeyLNPropertyV2__search_fid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::search.fid');
	kKeyLNPropertyV2__search_fid_county			:=	index(dKeyLNPropertyV2__search_fid_county,{ln_fares_id},{p_county_name,o_county_name},'~prte::key::ln_propertyv2::' + pIndexVersion + '::search.fid_county');

	return	sequential(
											parallel(
																build(kKeyLNPropertyV2__autokey__address			,update),
																build(kKeyLNPropertyV2__autokey__addressb2		,update),
																build(kKeyLNPropertyV2__autokey__citystname		,update),
																build(kKeyLNPropertyV2__autokey__citystnameb2	,update),
																build(kKeyLNPropertyV2__autokey__fein2				,update),
																build(kKeyLNPropertyV2__autokey__name					,update),
																build(kKeyLNPropertyV2__autokey__nameb2				,update),
																build(kKeyLNPropertyV2__autokey__namewords2		,update),
																build(kKeyLNPropertyV2__autokey__payload			,update),
																build(kKeyLNPropertyV2__autokey__phone2				,update),
																build(kKeyLNPropertyV2__autokey__phoneb2			,update),
																build(kKeyLNPropertyV2__autokey__ssn2					,update),
																build(kKeyLNPropertyV2__autokey__stname				,update),
																build(kKeyLNPropertyV2__autokey__stnameb2			,update),
																build(kKeyLNPropertyV2__autokey__zip					,update),
																build(kKeyLNPropertyV2__autokey__zipb2				,update),
																build(kKeyLNPropertyV2__addlfaresdeed_fid			,update),
																build(kKeyLNPropertyV2__addlfarestax_fid			,update),
																build(kKeyLNPropertyV2__addllegal_fid					,update),
																build(kKeyLNPropertyV2__addr_search_fid				,update),
																build(kKeyLNPropertyV2__assessor_fid					,update),
																build(kKeyLNPropertyV2__assessor_parcelnum		,update),
																build(kKeyLNPropertyV2__deed_fid						  ,update),
																build(kKeyLNPropertyV2__deed_parcelnum				,update),
																build(kKeyLNPropertyV2__search_bdid						,update),
																build(kKeyLNPropertyV2__search_did						,update),
																build(kKeyLNPropertyV2__search_fid						,update),
																build(kKeyLNPropertyV2__search_fid_county			,update)
															 ),
											PRTE.UpdateVersion(	'LNPropertyV2Keys',										//	Package name
																					pIndexVersion,												//	Package version
																					_control.MyInfo.EmailAddressNormal,		//	Who to email with specifics
																					'B',																	//	B = Boca,A = Alpharetta
																					'N',																	//	N = Non-FCRA,F = FCRA
																					'N'																		//	N = Do not also include boolean,Y = Include boolean,too
																				)
										 );
end;