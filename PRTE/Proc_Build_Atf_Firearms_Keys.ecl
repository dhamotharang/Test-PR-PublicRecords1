import	_control, PRTE_CSV, MDR;

export Proc_Build_Atf_Firearms_Keys(string pIndexVersion) := function

	rKeyAtf__Firearms__atfid	:=
	record
  unsigned8 atf_id;
	string2 source;
  unsigned4 seq;
  unsigned1 rec_code;
  string12 bdid;
  string3 bdid_score;
  string3 d_score;
  string9 best_ssn;
  string12 did_out;
  string8 date_first_seen;
  string8 date_last_seen;
  string1 expiration_flag;
  string1 record_type;
  string15 license_number;
  string9 lic_regn;
  string9 orig_lic_dist;
  string2 lic_dist;
  string9 lic_cnty;
  string9 lic_type;
  string11 lic_xprdte;
  string9 lic_seqn;
  string51 license_name;
  string51 business_name;
  string51 premise_street;
  string24 premise_city;
  string14 premise_state;
  string17 premise_orig_zip;
  string51 mail_street;
  string26 mail_city;
  string11 mail_state;
  string14 mail_zip_code;
  string11 voice_phone;
  string1 irs_region;
  string5 license1_title;
  string20 license1_fname;
  string20 license1_mname;
  string20 license1_lname;
  string5 license1_name_suffix;
  string3 license1_score;
  string51 license1_cname;
  string5 license2_title;
  string20 license2_fname;
  string20 license2_mname;
  string20 license2_lname;
  string5 license2_name_suffix;
  string3 license2_score;
  string51 license2_cname;
  string51 business_cname;
  string10 premise_prim_range;
  string2 premise_predir;
  string28 premise_prim_name;
  string4 premise_suffix;
  string2 premise_postdir;
  string10 premise_unit_desig;
  string8 premise_sec_range;
  string25 premise_p_city_name;
  string25 premise_v_city_name;
  string2 premise_st;
  string5 premise_zip;
  string4 premise_zip4;
  string4 premise_cart;
  string1 premise_cr_sort_sz;
  string4 premise_lot;
  string1 premise_lot_order;
  string2 premise_dpbc;
  string1 premise_chk_digit;
  string2 premise_rec_type;
  string2 premise_fips_st;
  string3 premise_fips_county;
  string18 premise_fips_county_name;
  string10 premise_geo_lat;
  string11 premise_geo_long;
  string4 premise_msa;
  string7 premise_geo_blk;
  string1 premise_geo_match;
  string4 premise_err_stat;
  string10 mail_prim_range;
  string2 mail_predir;
  string28 mail_prim_name;
  string4 mail_suffix;
  string2 mail_postdir;
  string10 mail_unit_desig;
  string8 mail_sec_range;
  string25 mail_p_city_name;
  string25 mail_v_city_name;
  string2 mail_st;
  string5 mail_zip;
  string4 mail_zip4;
  string4 mail_cart;
  string1 mail_cr_sort_sz;
  string4 mail_lot;
  string1 mail_lot_order;
  string2 mail_dpbc;
  string1 mail_chk_digit;
  string2 mail_rec_type;
  string2 mail_fips_st;
  string3 mail_fips_county;
  string10 mail_geo_lat;
  string11 mail_geo_long;
  string4 mail_msa;
  string7 mail_geo_blk;
  string1 mail_geo_match;
  string4 mail_err_stat;
  unsigned6 did;
	end;	
	
	rKeyAtf__Firearms__linkids	:=
	record
		PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__linkids;
	end;
	
	rKeyAtf__Firearms__autokey__address	:=
	record
		PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__autokey__address;
	end;

	rKeyAtf__Firearms__autokey__addressb2	:=
	record
		PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__autokey__addressb2;
	end;

	rKeyAtf__Firearms__autokey__citystname	:=
	record
		PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__autokey__citystname;
	end;

	rKeyAtf__Firearms__autokey__citystnameb2	:=
	record
		PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__autokey__citystnameb2;
	end;	

	rKeyAtf__Firearms__autokey__name	:=
	record
		PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__autokey__name;
	end;

	rKeyAtf__Firearms__autokey__nameb2	:=
	record
		PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__autokey__nameb2;
	end;

	rKeyAtf__Firearms__autokey__namewords2	:=
	record
		PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__autokey__namewords2;
	end;

	rKeyAtf__Firearms__autokey__payload	:=
	record
  unsigned6 fakeid;
	string2 source;
  unsigned4 seq;
  unsigned1 rec_code;
  string12 bdid;
  string3 bdid_score;
  string3 d_score;
  string9 best_ssn;
  string12 did_out;
  string8 date_first_seen;
  string8 date_last_seen;
  string1 expiration_flag;
  string1 record_type;
  string15 license_number;
  string9 lic_regn;
  string9 orig_lic_dist;
  string2 lic_dist;
  string9 lic_cnty;
  string9 lic_type;
  string11 lic_xprdte;
  string9 lic_seqn;
  string51 license_name;
  string51 business_name;
  string51 premise_street;
  string24 premise_city;
  string14 premise_state;
  string17 premise_orig_zip;
  string51 mail_street;
  string26 mail_city;
  string11 mail_state;
  string14 mail_zip_code;
  string11 voice_phone;
  string1 irs_region;
  string5 license1_title;
  string20 license1_fname;
  string20 license1_mname;
  string20 license1_lname;
  string5 license1_name_suffix;
  string3 license1_score;
  string51 license1_cname;
  string5 license2_title;
  string20 license2_fname;
  string20 license2_mname;
  string20 license2_lname;
  string5 license2_name_suffix;
  string3 license2_score;
  string51 license2_cname;
  string51 business_cname;
  string10 premise_prim_range;
  string2 premise_predir;
  string28 premise_prim_name;
  string4 premise_suffix;
  string2 premise_postdir;
  string10 premise_unit_desig;
  string8 premise_sec_range;
  string25 premise_p_city_name;
  string25 premise_v_city_name;
  string2 premise_st;
  string5 premise_zip;
  string4 premise_zip4;
  string4 premise_cart;
  string1 premise_cr_sort_sz;
  string4 premise_lot;
  string1 premise_lot_order;
  string2 premise_dpbc;
  string1 premise_chk_digit;
  string2 premise_rec_type;
  string2 premise_fips_st;
  string3 premise_fips_county;
  string18 premise_fips_county_name;
  string10 premise_geo_lat;
  string11 premise_geo_long;
  string4 premise_msa;
  string7 premise_geo_blk;
  string1 premise_geo_match;
  string4 premise_err_stat;
  string10 mail_prim_range;
  string2 mail_predir;
  string28 mail_prim_name;
  string4 mail_suffix;
  string2 mail_postdir;
  string10 mail_unit_desig;
  string8 mail_sec_range;
  string25 mail_p_city_name;
  string25 mail_v_city_name;
  string2 mail_st;
  string5 mail_zip;
  string4 mail_zip4;
  string4 mail_cart;
  string1 mail_cr_sort_sz;
  string4 mail_lot;
  string1 mail_lot_order;
  string2 mail_dpbc;
  string1 mail_chk_digit;
  string2 mail_rec_type;
  string2 mail_fips_st;
  string3 mail_fips_county;
  string10 mail_geo_lat;
  string11 mail_geo_long;
  string4 mail_msa;
  string7 mail_geo_blk;
  string1 mail_geo_match;
  string4 mail_err_stat;
  unsigned8 atf_id;
  unsigned1 zero;
  string1 blank;
  unsigned6 did_out6;
  unsigned6 bdid6;
	end;
	
	rKeyAtf__Firearms__autokey__ssn2	:=
	record
		PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__autokey__ssn2;
	end;

	rKeyAtf__Firearms__autokey__stname	:=
	record
		PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__autokey__stname;
	end;

	rKeyAtf__Firearms__autokey__stnameb2	:=
	record
		PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__autokey__stnameb2;
	end;

	rKeyAtf__Firearms__autokey__zip	:=
	record
		PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__autokey__zip;
	end;

	rKeyAtf__Firearms__autokey__zipb2	:=
	record
		PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__autokey__zipb2;
	end;

	rKeyAtf__Firearms__bdid	:=
	record
		//PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__bdid;
		string12 bdid;
		unsigned8 atf_id
	end;

	rKeyAtf__Firearms__did	:=
	record
		//PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__did;
		unsigned6 did;
		unsigned8 atf_id
	end;

	rKeyAtf__Firearms__lnum	:=
	record
		//PRTE_CSV.Atf_Firearms.rthor_data400__key__Atf__Firearms__lnum;
		string15 license_number;
		unsigned8 atf_id
	end;
	
	dKeyAtf__Firearms__atfid					:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__atfid, transform(rKeyAtf__Firearms__atfid,self.source := if(left.record_type='F',MDR.sourceTools.src_Federal_Firearms,MDR.sourceTools.src_Federal_Explosives),self:=left,self:=[]));	
 	dKeyAtf__Firearms__linkids					:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__linkids, rKeyAtf__Firearms__linkids);	
	dKeyAtf__Firearms__autokey__address			:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__autokey__address, rKeyAtf__Firearms__autokey__address);
	dKeyAtf__Firearms__autokey__addressb2		:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__autokey__addressb2, rKeyAtf__Firearms__autokey__addressb2);
	dKeyAtf__Firearms__autokey__citystname		:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__autokey__citystname, rKeyAtf__Firearms__autokey__citystname);
	dKeyAtf__Firearms__autokey__citystnameb2	:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__autokey__citystnameb2, rKeyAtf__Firearms__autokey__citystnameb2);	
	dKeyAtf__Firearms__autokey__name					:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__autokey__name, rKeyAtf__Firearms__autokey__name);
	dKeyAtf__Firearms__autokey__nameb2				:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__autokey__nameb2, rKeyAtf__Firearms__autokey__nameb2);
	dKeyAtf__Firearms__autokey__namewords2		:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__autokey__namewords2, rKeyAtf__Firearms__autokey__namewords2);	
	dKeyAtf__Firearms__autokey__payload			:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__autokey__payload, transform(rKeyAtf__Firearms__autokey__payload,self.source := if(left.record_type='F',MDR.sourceTools.src_Federal_Firearms,MDR.sourceTools.src_Federal_Explosives),self:=left,self:=[]));	
	dKeyAtf__Firearms__autokey__ssn2					:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__autokey__ssn2, rKeyAtf__Firearms__autokey__ssn2);
	dKeyAtf__Firearms__autokey__stname				:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__autokey__stname, rKeyAtf__Firearms__autokey__stname);
	dKeyAtf__Firearms__autokey__stnameb2			:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__autokey__stnameb2, rKeyAtf__Firearms__autokey__stnameb2);
	dKeyAtf__Firearms__autokey__zip					:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__autokey__zip, rKeyAtf__Firearms__autokey__zip);
	dKeyAtf__Firearms__autokey__zipb2				:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__autokey__zipb2, rKeyAtf__Firearms__autokey__zipb2);
	dKeyAtf__Firearms__bdid									:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__bdid, rKeyAtf__Firearms__bdid);	
	dKeyAtf__Firearms__did										:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__did, rKeyAtf__Firearms__did);
	dKeyAtf__Firearms__lnum								:= 	project(PRTE_CSV.Atf_Firearms.dthor_data400__key__Atf__Firearms__lnum, rKeyAtf__Firearms__lnum);	

	kKeyAtf__Firearms__atfid					:=	index(dKeyAtf__Firearms__atfid, {atf_id}, {dKeyAtf__Firearms__atfid}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::atfid');
  kKeyAtf__Firearms__linkids					:=	index(dKeyAtf__Firearms__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeyAtf__Firearms__linkids}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::linkids');
	kKeyAtf__Firearms__autokey__address			:=	index(dKeyAtf__Firearms__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyAtf__Firearms__autokey__address}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::autokey::address');
	kKeyAtf__Firearms__autokey__addressb2		:=	index(dKeyAtf__Firearms__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyAtf__Firearms__autokey__addressb2}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::autokey::addressb2');
	kKeyAtf__Firearms__autokey__citystname		:=	index(dKeyAtf__Firearms__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyAtf__Firearms__autokey__citystname}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::autokey::citystname');
	kKeyAtf__Firearms__autokey__citystnameb2	:=	index(dKeyAtf__Firearms__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyAtf__Firearms__autokey__citystnameb2}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::autokey::citystnameb2');	
	kKeyAtf__Firearms__autokey__name					:=	index(dKeyAtf__Firearms__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyAtf__Firearms__autokey__name}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::autokey::name');
	kKeyAtf__Firearms__autokey__nameb2				:=	index(dKeyAtf__Firearms__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyAtf__Firearms__autokey__nameb2}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::autokey::nameb2');
	kKeyAtf__Firearms__autokey__namewords2		:=	index(dKeyAtf__Firearms__autokey__namewords2, {word,state,seq,bdid}, {dKeyAtf__Firearms__autokey__namewords2}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::autokey::namewords2');
	kKeyAtf__Firearms__autokey__payload			:=	index(dKeyAtf__Firearms__autokey__payload, {fakeid}, {dKeyAtf__Firearms__autokey__payload}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::autokey::payload');
	kKeyAtf__Firearms__autokey__ssn2					:=	index(dKeyAtf__Firearms__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyAtf__Firearms__autokey__ssn2}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::autokey::ssn2');
	kKeyAtf__Firearms__autokey__stname				:=	index(dKeyAtf__Firearms__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyAtf__Firearms__autokey__stname}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::autokey::stname');
	kKeyAtf__Firearms__autokey__stnameb2			:=	index(dKeyAtf__Firearms__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyAtf__Firearms__autokey__stnameb2}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::autokey::stnameb2');
	kKeyAtf__Firearms__autokey__zip					:=	index(dKeyAtf__Firearms__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyAtf__Firearms__autokey__zip}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::autokey::zip');
	kKeyAtf__Firearms__autokey__zipb2				:=	index(dKeyAtf__Firearms__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyAtf__Firearms__autokey__zipb2}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::autokey::zipb2');
	kKeyAtf__Firearms__bdid						:=	index(dKeyAtf__Firearms__bdid, {bdid}, {dKeyAtf__Firearms__bdid}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::bdid');
	kKeyAtf__Firearms__did						:=	index(dKeyAtf__Firearms__did, {did}, {dKeyAtf__Firearms__did}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::did');
	kKeyAtf__Firearms__lnum						:=	index(dKeyAtf__Firearms__lnum, {license_number}, {dKeyAtf__Firearms__lnum}, '~prte::key::Atf::Firearms::' + pIndexVersion + '::lnum');
	
	//FCRA
		kKeyAtf__Firearms__atfid_fcra					:=	index(dKeyAtf__Firearms__atfid, {atf_id}, {dKeyAtf__Firearms__atfid}, '~prte::key::Atf::Firearms::fcra::' + pIndexVersion + '::atfid');
		kKeyAtf__Firearms__did_fcra						:=	index(dKeyAtf__Firearms__did, {did}, {dKeyAtf__Firearms__did}, '~prte::key::Atf::Firearms::fcra::' + pIndexVersion + '::did');

	return	sequential(
											parallel(
																build(kKeyAtf__Firearms__atfid	, update),
																build(kKeyAtf__Firearms__linkids	, update),
																build(kKeyAtf__Firearms__autokey__address			, update),
																build(kKeyAtf__Firearms__autokey__addressb2		, update),
																build(kKeyAtf__Firearms__autokey__citystname	, update),
																build(kKeyAtf__Firearms__autokey__citystnameb2, update),																
																build(kKeyAtf__Firearms__autokey__name				, update),
																build(kKeyAtf__Firearms__autokey__nameb2			, update),
																build(kKeyAtf__Firearms__autokey__namewords2	, update),
																build(kKeyAtf__Firearms__autokey__payload			, update),																
																build(kKeyAtf__Firearms__autokey__ssn2				, update),
																build(kKeyAtf__Firearms__autokey__stname			, update),
																build(kKeyAtf__Firearms__autokey__stnameb2		, update),
																build(kKeyAtf__Firearms__autokey__zip					, update),
																build(kKeyAtf__Firearms__autokey__zipb2				, update),
																build(kKeyAtf__Firearms__bdid					    		, update),																
																build(kKeyAtf__Firearms__did						    	, update),
																build(kKeyAtf__Firearms__lnum				   		, update),
																build(kKeyAtf__Firearms__atfid_fcra				, update),
																build(kKeyAtf__Firearms__did_fcra				  , update)
															 ),
											PRTE.UpdateVersion('ATFKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				),
										PRTE.UpdateVersion('FCRA_ATFKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'F',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
