import	_control, PRTE_CSV, Death_Master, doxie;

export Proc_Build_Death_Master_Keys(string pIndexVersion)	:=

function

   rkey__death_master__did	:=
	record
		//PRTE_CSV.death_master.rthor_data400__key__death_master__did;
	unsigned6 l_did;
	string12 did;
	unsigned1 did_score;
	string8 filedate;
	string1 rec_type;
	string1 rec_type_orig;
	string9 ssn;
	string20 lname;
	string4 name_suffix;
	string15 fname;
	string15 mname;
	string1 vorp_code;
	string8 dod8;
	string8 dob8;
	string2 st_country_code;
	string5 zip_lastres;
	string5 zip_lastpayment;
	string2 state;
	string3 fipscounty;
	string2 crlf;
	string1 state_death_flag := '';
  string3 death_rec_src := '';
	string18 county_name;
	unsigned8 __internal_fpos__;
	end;
	
	  rkey__death_master__ssn_table_v3	:=
	record
		PRTE_CSV.death_master.rthor_data400__key__death_master__ssn_table_v2;
	end;
	
	  rkey__death_master__filtered__ssn_table_v3	:=
	record
		PRTE_CSV.death_master.rthor_data400__key__death_master__filtered__ssn_table_v2;
	end;
	
		dkey__death_master__did			            := 	project(PRTE_CSV.death_master.dthor_data400__key__death_master__did, rkey__death_master__did);
	dkey__death_master__ssn_table_v3	        := 	project(PRTE_CSV.death_master.dthor_data400__key__death_master__ssn_table_v2, rkey__death_master__ssn_table_v3);
    dkey__death_master__filtered__ssn_table_v3	:= 	project(PRTE_CSV.death_master.dthor_data400__key__death_master__filtered__ssn_table_v2, rkey__death_master__filtered__ssn_table_v3);

	kkey__death_master__did			            :=	index(dkey__death_master__did, {l_did }, {dkey__death_master__did}, '~prte::key::death_master::' + pIndexVersion + '::did');
    kkey__death_master__ssn_table_v3		    :=	index(dkey__death_master__ssn_table_v3,{ssn}, {dkey__death_master__ssn_table_v3}, '~prte::key::death_master::' + pIndexVersion + '::ssn_table_v3');
    kkey__death_master__filtered__ssn_table_v3	:=	index(dkey__death_master__filtered__ssn_table_v3,{ssn}, {dkey__death_master__filtered__ssn_table_v3}, '~prte::key::death_master::' + pIndexVersion + '::ssn_table_v3_filtered');

// deathv2 
    rkey__death_masterv2__autokey__address	:=
	record
		PRTE_CSV.death_masterv2.rthor_data400__key__death_masterv2__autokey__address;
	end;
	dKeydeath_masterv2__autokey__address			:= 	project(PRTE_CSV.death_masterv2.dthor_data400__key__death_masterv2__autokey__address, rkey__death_masterv2__autokey__address);
	kKeydeath_masterv2__autokey__address			:=	index(dKeydeath_masterv2__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeydeath_masterv2__autokey__address}, '~prte::key::death_masterv2::' + pIndexVersion + '::autokey::address');

  rKeydeath_masterv2__autokey__citystname	:=
	record
		PRTE_CSV.death_masterv2.rthor_data400__key__death_masterv2__autokey__citystname;
	end;
	dKeydeath_masterv2__autokey__citystname		:= 	project(PRTE_CSV.death_masterv2.dthor_data400__key__death_masterv2__autokey__citystname, rKeydeath_masterv2__autokey__citystname);
	kKeydeath_masterv2__autokey__citystname		:=	index(dKeydeath_masterv2__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeydeath_masterv2__autokey__citystname}, '~prte::key::death_masterv2::' + pIndexVersion + '::autokey::citystname');

rKeydeath_masterv2__autokey__name	:=
	record
		PRTE_CSV.death_masterv2.rthor_data400__key__death_masterv2__autokey__name;
	end;
	dKeydeath_masterv2__autokey__name					:= 	project(PRTE_CSV.death_masterv2.dthor_data400__key__death_masterv2__autokey__name, rKeydeath_masterv2__autokey__name);
	kKeydeath_masterv2__autokey__name					:=	index(dKeydeath_masterv2__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeydeath_masterv2__autokey__name}, '~prte::key::death_masterv2::' + pIndexVersion + '::autokey::name');

    rKeydeath_masterv2__autokey__payload	:=
	record
		PRTE_CSV.death_masterv2.rthor_data400__key__death_masterv2__autokey__payload;
	end;
	
	rKeydeath_masterv2__autokey__payload__new	:=
	record
		PRTE_CSV.death_masterv2.rthor_data400__key__death_masterv2__autokey__payload__new;
	end;
	
	dKeydeath_masterv2__autokey__payload			:= 	project(PRTE_CSV.death_masterv2.dthor_data400__key__death_masterv2__autokey__payload, rKeydeath_masterv2__autokey__payload__new);
	kKeydeath_masterv2__autokey__payload			:=	index(dKeydeath_masterv2__autokey__payload, {fakeid}, {dKeydeath_masterv2__autokey__payload}, '~prte::key::death_masterv2::' + pIndexVersion + '::autokey::payload');

	rKeydeath_masterv2__autokey__ssn2	:=
	record
		PRTE_CSV.death_masterv2.rthor_data400__key__death_masterv2__autokey__ssn2;
	end;
	dKeydeath_masterv2__autokey__ssn2					:= 	project(PRTE_CSV.death_masterv2.dthor_data400__key__death_masterv2__autokey__ssn2, rKeydeath_masterv2__autokey__ssn2);
	kKeydeath_masterv2__autokey__ssn2					:=	index(dKeydeath_masterv2__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeydeath_masterv2__autokey__ssn2}, '~prte::key::death_masterv2::' + pIndexVersion + '::autokey::ssn2');

	rKeydeath_masterv2__autokey__stname	:=
	record
		PRTE_CSV.death_masterv2.rthor_data400__key__death_masterv2__autokey__stname;
	end;
	dKeydeath_masterv2__autokey__stname				:= 	project(PRTE_CSV.death_masterv2.dthor_data400__key__death_masterv2__autokey__stname, rKeydeath_masterv2__autokey__stname);
	kKeydeath_masterv2__autokey__stname				:=	index(dKeydeath_masterv2__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeydeath_masterv2__autokey__stname}, '~prte::key::death_masterv2::' + pIndexVersion + '::autokey::stname');

  rKeydeath_masterv2__autokey__zip	:=
	record
		PRTE_CSV.death_masterv2.rthor_data400__key__death_masterv2__autokey__zip;
	end;
	dKeydeath_masterv2__autokey__zip					:= 	project(PRTE_CSV.death_masterv2.dthor_data400__key__death_masterv2__autokey__zip, rKeydeath_masterv2__autokey__zip);
	kKeydeath_masterv2__autokey__zip					:=	index(dKeydeath_masterv2__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeydeath_masterv2__autokey__zip}, '~prte::key::death_masterv2::' + pIndexVersion + '::autokey::zip');

    rKeydeath_masterv2__death_id	:=
	record
		PRTE_CSV.death_masterv2.rthor_data400__key__death_masterv2__death_id;
	end;
	
	rKeydeath_masterv2__death_id__new	:=
	record
		//PRTE_CSV.death_masterv2.rthor_data400__key__death_masterv2__death_id__new;
	string16 state_death_id;
  string12 did;
  unsigned1 did_score;
  string8 filedate;
  string1 rec_type;
  string1 rec_type_orig;
  string9 ssn;
  string20 lname;
  string4 name_suffix;
  string15 fname;
  string15 mname;
  string1 vorp_code;
  string8 dod8;
  string8 dob8;
  string2 st_country_code;
  string5 zip_lastres;
  string5 zip_lastpayment;
  string2 state;
  string3 fipscounty;
  string2 crlf;
	string1 state_death_flag := '';
  string3 death_rec_src := '';
  string2 src := '';
  string1 glb_flag := '';
  string18 county_name;
  unsigned8 __internal_fpos__;
	end;
	
    dKeydeath_masterv2__death_id		:= 	project(PRTE_CSV.death_masterv2.dthor_data400__key__death_masterv2__death_id , rKeydeath_masterv2__death_id__new);
	kKeydeath_masterv2__death_id		:=	index(dKeydeath_masterv2__death_id,{state_death_id}, {dKeydeath_masterv2__death_id}, '~prte::key::death_masterv2::' + pIndexVersion + '::death_id');

    rKeydeath_masterv2__did	:=
	record
     unsigned6 l_did;
     string12 did;
     unsigned1 did_score;
     string8 filedate;
     string1 rec_type;
     string1 rec_type_orig;
     string9 ssn;
     string20 lname;
     string4 name_suffix;
     string15 fname;
     string15 mname;
     string1 vorp_code;
     string8 dod8;
     string8 dob8;
     string2 st_country_code;
     string5 zip_lastres;
     string5 zip_lastpayment;
     string2 state;
     string3 fipscounty;
     string2 crlf;
		 string1 state_death_flag := '';
		 string3 death_rec_src := '';
     string16 state_death_id;
     string2 src := '';
     string1 glb_flag:='';
     string18 county_name;
     unsigned8 __internal_fpos__;
  
		//PRTE_CSV.death_masterv2.rthor_data400__key__death_masterv2__did;
	end;
	
    dKeydeath_masterv2__did		:= 	project(PRTE_CSV.death_masterv2.dthor_data400__key__death_masterv2__did , transform(rKeydeath_masterv2__did, 
	                                                                        self := left));
	
	kKeydeath_masterv2__did		:=	index(dKeydeath_masterv2__did,{l_did}, {dKeydeath_masterv2__did}, '~prte::key::death_masterv2::' + pIndexVersion + '::did');

    rKeydeath_masterv2__dob	:=
	record
		PRTE_CSV.death_masterv2.rthor_data400__key__death_masterv2__dob;
	end;
	
    dKeydeath_masterv2__dob	:= 	project(PRTE_CSV.death_masterv2.dthor_data400__key__death_masterv2__dob , rKeydeath_masterv2__dob);
	kKeydeath_masterv2__dob	:=	index(dKeydeath_masterv2__dob,{dob8, state, dph_lname, pfname}, {state_death_id}, '~prte::key::death_masterv2::' + pIndexVersion + '::dob');

    rKeydeath_masterv2__dod	:=
	record
		PRTE_CSV.death_masterv2.rthor_data400__key__death_masterv2__dod;
	end;
	
    dKeydeath_masterv2__dod		:= 	project(PRTE_CSV.death_masterv2.dthor_data400__key__death_masterv2__dod , rKeydeath_masterv2__dod);
	kKeydeath_masterv2__dod		:=	index(dKeydeath_masterv2__dod,{dod8, state, dph_lname, pfname},{state_death_id}, '~prte::key::death_masterv2::' + pIndexVersion + '::dod');

    rKeydeath_masterv2__supp_id:=
	record
		PRTE_CSV.Death_Supplemental.rthor_data400__key__death_supplemental__death_id;
	end;
	
    dKeydeath_masterv2__supp_id		:= 	project(PRTE_CSV.Death_Supplemental.dthor_data400__key__death_supplemental__death_id, rKeydeath_masterv2__supp_id);
	kKeydeath_masterv2__supp_id		:=	index(dKeydeath_masterv2__supp_id,{state_death_id},{dKeydeath_masterv2__supp_id}, '~prte::key::death_supplemental::' + pIndexVersion + '::death_id');
	
	  rkey__death_master__ssn	:= record
	recordof (Death_Master.key_ssn(false));
	end;
	
     dKeydeath_master__ssn		:= 	project(choosen(pull(Death_Master.key_ssn(false)), 0), rkey__death_master__ssn);
	kKeydeath_master__ssn		:=	index(dKeydeath_master__ssn,{ssn},{dKeydeath_master__ssn}, '~prte::key::death_master::' + pIndexVersion + '::ssn');

	  rkey__death_master__ssn_fcra	:= record
	recordof (Death_Master.key_ssn(true));
	end;
	
     dKeydeath_master__ssn_fcra		:= 	project(choosen(pull(Death_Master.key_ssn(true)), 0), rkey__death_master__ssn_fcra);
	kKeydeath_master__ssn_fcra		:=	index(dKeydeath_master__ssn_fcra,{ssn},{dKeydeath_master__ssn_fcra}, '~prte::key::fcra::death_master::' + pIndexVersion + '::ssn');

	  rkey__death_masterv2__did_fcra	:= record
	recordof (Doxie.key_death_masterV2_DID_fcra);
	end;

    dKeydeath_masterv2__did_fcra		:= 	project(choosen(pull(Doxie.key_death_masterV2_DID_fcra), 0), rkey__death_masterv2__did_fcra);
	kKeydeath_masterv2__did_fcra	:=	index(dKeydeath_masterv2__did_fcra,{l_did}, {dKeydeath_masterv2__did_fcra}, '~prte::key::fcra::death_masterv2::' + pIndexVersion + '::did');

 
	return	sequential(
											parallel(
																build(kkey__death_master__did			, update),
																build(kkey__death_master__ssn_table_v3			, update),
																// build(kkey__death_master__filtered__ssn_table_v3			, update), 
																build(kKeydeath_masterv2__autokey__address			, update), 
                                build(kKeydeath_masterv2__autokey__citystname			, update), 
		                            build(kKeydeath_masterv2__autokey__name			, update),
																build(kKeydeath_masterv2__autokey__payload			, update),
																build(kKeydeath_masterv2__autokey__ssn2			, update),
																build(kKeydeath_masterv2__autokey__stname			, update),
																build(kKeydeath_masterv2__autokey__zip			, update),
																build(kKeydeath_masterv2__death_id			, update),
																build(kKeydeath_masterv2__did			, update),
																build(kKeydeath_masterv2__dob			, update),
																build(kKeydeath_masterv2__dod			, update),
																build(kKeydeath_masterv2__supp_id			, update),
																build(kKeydeath_master__ssn			, update),
																build(kKeydeath_master__ssn_fcra			, update),
																build(kKeydeath_masterv2__did_fcra			, update)
													  ),
													  
											PRTE.UpdateVersion('DeathMasterKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;