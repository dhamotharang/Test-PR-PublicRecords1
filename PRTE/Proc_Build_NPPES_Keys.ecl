import	_control, PRTE, PRTE_CSV;
pversion := '20110124';
export Proc_Build_NPPES_Keys(string pIndexVersion) := function
	
	rKeyNPPES__autokey_address	:=
	record		
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_autokey_address;
	end;					

	rKeyNPPES__autokey_addressb2	:=
	record		
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_autokey_addressb2;
	end;
	
	rKeyNPPES__autokey_citystname	:=
	record
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_autokey_citystname;
	end;
	
	rKeyNPPES__autokey_citystnameb2	:=
	record		
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_autokey_citystnameb2;
	end;
	
	rKeyNPPES__autokey_name	:=
	record		
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_autokey_name;
	end;
	
	rKeyNPPES__autokey_nameb2	:=
	record		
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_autokey_nameb2;
	end;
	
	rKeyNPPES__autokey_namewords2	:=
	record		
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_autokey_namewords2;
	end;
	
	rKeyNPPES__autokey_payload	:=
	record		
		PRTE_CSV.NPPES. rthor_data400__key__NPPES_autokey_payload;
	end;

	rKeyNPPES__autokey_stname	:=
	record
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_autokey_stname;
	end;
	
	rKeyNPPES__autokey_stnameb2	:=
	record		
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_autokey_stnameb2;
	end;
	
	rKeyNPPES__autokey_zip	:=
	record
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_autokey_zip;
	end;

	rKeyNPPES__autokey_zipb2	:=
	record		
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_autokey_zipb2;
	end;
	
	rKeyNPPES__linkids	:=
	record
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_linkids;
	end;		
	
	rKeyNPPES__npi	:=
	record
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_npi;
	end;

	rKeyNPPES__lnpid	:=
	record
		PRTE_CSV.NPPES.rthor_data400__key__NPPES_lnpid;
	end;

  dKeyNPPES__autokey_address 				:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_autokey_address, rKeyNPPES__autokey_address);			
  dKeyNPPES__autokey_addressb2 			:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_autokey_addressb2, rKeyNPPES__autokey_addressb2);				
  dKeyNPPES__autokey_citystname 		:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_autokey_citystname, rKeyNPPES__autokey_citystname);  
	dKeyNPPES__autokey_citystnameb2 	:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_autokey_citystnameb2, rKeyNPPES__autokey_citystnameb2);	
  dKeyNPPES__autokey_name 					:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_autokey_name, rKeyNPPES__autokey_name);	
	dKeyNPPES__autokey_nameb2 				:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_autokey_nameb2, rKeyNPPES__autokey_nameb2);	
  dKeyNPPES__autokey_namewords2 		:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_autokey_namewords2, rKeyNPPES__autokey_namewords2);
  dKeyNPPES__autokey_payload				:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_autokey_payload, rKeyNPPES__autokey_payload);	
  dKeyNPPES__autokey_stname 				:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_autokey_stname, rKeyNPPES__autokey_stname);
  dKeyNPPES__autokey_stnameb2 			:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_autokey_stnameb2, rKeyNPPES__autokey_stnameb2);	
  dKeyNPPES__autokey_zip 						:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_autokey_zip, rKeyNPPES__autokey_zip);	
  dKeyNPPES__autokey_zipb2 					:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_autokey_zipb2, rKeyNPPES__autokey_zipb2);
 	dKeyNPPES__linkids								:= 	project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_linkids, rKeyNPPES__linkids);  
	dKeyNPPES__npi										:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_npi, rKeyNPPES__npi);	
	dKeyNPPES__lnpid									:=  project(PRTE_CSV.NPPES.dthor_data400__key__NPPES_lnpid, rKeyNPPES__lnpid);	
	
	kKeyNPPES__autokey_address				:=  index(dKeyNPPES__autokey_address,{prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups},{dKeyNPPES__autokey_address},'~prte::key::NPPES::' + pIndexVersion + '::autokey::address');													
	kKeyNPPES__autokey_addressb2			:=  index(dKeyNPPES__autokey_addressb2,{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid},{dKeyNPPES__autokey_addressb2},'~prte::key::NPPES::' + pIndexVersion + '::autokey::addressb2');
	kKeyNPPES__autokey_citystname			:=  index(dKeyNPPES__autokey_citystname,{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyNPPES__autokey_citystname},'~prte::key::NPPES::' + pIndexVersion + '::autokey::citystname');
	kKeyNPPES__autokey_citystnameb2		:=  index(dKeyNPPES__autokey_citystnameb2,{city_code,st,cname_indic,cname_sec,bdid},{dKeyNPPES__autokey_citystnameb2},'~prte::key::NPPES::' + pIndexVersion + '::autokey::citystnameb2');
	kKeyNPPES__autokey_name						:=  index(dKeyNPPES__autokey_name,{dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyNPPES__autokey_name},'~prte::key::NPPES::' + pIndexVersion + '::autokey::name');
	kKeyNPPES__autokey_nameb2					:=  index(dKeyNPPES__autokey_nameb2,{cname_indic,cname_sec,bdid},{dKeyNPPES__autokey_nameb2},'~prte::key::NPPES::' + pIndexVersion + '::autokey::nameb2');
	kKeyNPPES__autokey_namewords2			:=  index(dKeyNPPES__autokey_namewords2,{word,state,seq,bdid},{dKeyNPPES__autokey_namewords2},'~prte::key::NPPES::' + pIndexVersion + '::autokey::namewords2');
	kKeyNPPES__autokey_payload				:=  index(dKeyNPPES__autokey_payload,{fakeid},{dKeyNPPES__autokey_payload},'~prte::key::NPPES::' + pIndexVersion + '::autokey::payload');
	kKeyNPPES__autokey_stname					:=  index(dKeyNPPES__autokey_stname,{st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyNPPES__autokey_stname},'~prte::key::NPPES::' + pIndexVersion + '::autokey::stname');
	kKeyNPPES__autokey_stnameb2				:=  index(dKeyNPPES__autokey_stnameb2,{st,cname_indic,cname_sec,bdid},{dKeyNPPES__autokey_stnameb2},'~prte::key::NPPES::' + pIndexVersion + '::autokey::stnameb2');
	kKeyNPPES__autokey_zip						:=  index(dKeyNPPES__autokey_zip,{zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyNPPES__autokey_zip},'~prte::key::NPPES::' + pIndexVersion + '::autokey::zip');
	kKeyNPPES__autokey_zipb2					:=  index(dKeyNPPES__autokey_zipb2,{zip,cname_indic,cname_sec,bdid},{dKeyNPPES__autokey_zipb2},'~prte::key::NPPES::' + pIndexVersion + '::autokey::zipb2');
	kKeyNPPES__linkids								:=  index(dKeyNPPES__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeyNPPES__linkids}, '~prte::key::NPPES::' + pIndexVersion + '::linkids');
	kKeyNPPES__npi										:=  index(dKeyNPPES__npi,{npi},{dKeyNPPES__npi},'~prte::key::NPPES::' + pIndexVersion + '::npi');
	kKeyNPPES__lnpid									:=  index(dKeyNPPES__lnpid,{lnpid},{dKeyNPPES__lnpid},'~prte::key::NPPES::' + pIndexVersion + '::lnpid');

	return	sequential(
											parallel(	
																build(kKeyNPPES__autokey_address					 	, update),
																build(kKeyNPPES__autokey_addressb2				 	, update),
																build(kKeyNPPES__autokey_citystname		   		, update),																
																build(kKeyNPPES__autokey_citystnameb2				, update),
																build(kKeyNPPES__autokey_name						 		, update),																
																build(kKeyNPPES__autokey_nameb2					 		, update),
																build(kKeyNPPES__autokey_namewords2			 		, update),															
																build(kKeyNPPES__autokey_payload					 	, update),
																build(kKeyNPPES__autokey_stname							, update),																
																build(kKeyNPPES__autokey_stnameb2				 		, update),
																build(kKeyNPPES__autokey_zip						   	, update),
																build(kKeyNPPES__autokey_zipb2						 	, update),																
																build(kKeyNPPES__linkids							    	, update),
																build(kKeyNPPES__npi						   					, update),
																build(kKeyNPPES__lnpid					   					, update)
															 ),
											PRTE.UpdateVersion('NPPESKeys',													//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;