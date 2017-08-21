import	_control, PRTE, PRTE_CSV;
pversion := '20110124';
export Proc_Build_CALBUS_Keys(string pIndexVersion) := function
			
	rKeyCALBUS__xseglist	:=
	record
		PRTE_CSV.CALBUS.rthor_data400__key__CALBUS_xseglist;
	end;
			
	rKeyCALBUS__bdid	:=
	record
		PRTE_CSV.CALBUS.rthor_data400__key__CALBUS_bdid;
	end;

	rKeyCALBUS__autokey_addressb2	:=
	record		
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_autokey_addressb2;
	end;
	
	rKeyCALBUS__autokey_citystnameb2	:=
	record		
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_autokey_citystnameb2;
	end;
	
	rKeyCALBUS__autokey_nameb2	:=
	record		
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_autokey_nameb2;
	end;
	
	rKeyCALBUS__autokey_payload	:=
	record		
		PRTE_CSV.CALBUS. rthor_data400__key__calbus_autokey_payload;
	end;

	rKeyCALBUS__autokey_zipb2	:=
	record		
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_autokey_zipb2;
	end;
	
	rKeyCALBUS__autokey_stnameb2	:=
	record		
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_autokey_stnameb2;
	end;
	
	rKeyCALBUS__autokey_namewords2	:=
	record		
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_autokey_namewords2;
	end;
	
	rKeyCALBUS__autokey_name	:=
	record		
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_autokey_name;
	end;
	
	rKeyCALBUS__autokey_address	:=
	record		
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_autokey_address;
	end;
	
	rKeyCALBUS__autokey_stname	:=
	record
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_autokey_stname;
	end;
	
	rKeyCALBUS__autokey_citystname	:=
	record
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_autokey_citystname;
	end;
	
	rKeyCALBUS__autokey_zip	:=
	record
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_autokey_zip;
	end;
		
	rKeyCALBUS__doc_accnumber	:=
	record
	PRTE_CSV.CALBUS.rthor_data400__key__calbus_doc_accnumber;
	end;
	
	rKeyCALBUS__xdstat2	:=
	record
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_xdstat2;
	end;
	
	rKeyCALBUS__account_nbr	:=
	record
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_account_nbr;
	end;
	
	rKeyCALBUS__nidx3	:=	
	record
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_nidx3;
	end;
	
	rKeyCALBUS__dictindx3	:=	
	record	
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_dictindx3;
	end;	

	rKeyCALBUS__dtldictx	:=	
	record		
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_dtldictx;
	end;	
	
	rKeyCALBUS__exkeyi	:=	
	record		
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_exkeyi;
	end;	
	
	rKeyCALBUS__exkeyo	:=	
	record
		PRTE_CSV.CALBUS.rthor_data400__key__calbus_exkeyo;
	end;	
	
	rKeyCALBUS__linkids	:=
	record
		PRTE_CSV.CALBUS.rthor_data400__key__CALBUS_linkids;
	end;			
			
	dKeyCALBUS__xseglist							:= 	project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_xseglist, rKeyCALBUS__xseglist);	
	dKeyCALBUS__bdid									:= 	project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_bdid, rKeyCALBUS__bdid);						
  dKeyCALBUS__autokey_addressb2 		:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_autokey_addressb2, rKeyCALBUS__autokey_addressb2);				
  dKeyCALBUS__autokey_citystnameb2 	:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_autokey_citystnameb2, rKeyCALBUS__autokey_citystnameb2);	
  dKeyCALBUS__autokey_nameb2 				:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_autokey_nameb2, rKeyCALBUS__autokey_nameb2);	
  dKeyCALBUS__autokey_payload				:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_autokey_payload, rKeyCALBUS__autokey_payload);	
  dKeyCALBUS__autokey_zipb2 				:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_autokey_zipb2, rKeyCALBUS__autokey_zipb2);
  dKeyCALBUS__autokey_stnameb2 			:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_autokey_stnameb2, rKeyCALBUS__autokey_stnameb2);	
  dKeyCALBUS__autokey_namewords2 		:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_autokey_namewords2, rKeyCALBUS__autokey_namewords2);	
  dKeyCALBUS__autokey_name 					:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_autokey_name, rKeyCALBUS__autokey_name);	
  dKeyCALBUS__autokey_address 			:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_autokey_address, rKeyCALBUS__autokey_address);	
  dKeyCALBUS__autokey_stname 				:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_autokey_stname, rKeyCALBUS__autokey_stname);	
  dKeyCALBUS__autokey_citystname 		:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_autokey_citystname, rKeyCALBUS__autokey_citystname);	
  dKeyCALBUS__autokey_zip 					:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_autokey_zip, rKeyCALBUS__autokey_zip);	
  dKeyCALBUS__doc_accnumber 				:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_doc_accnumber, rKeyCALBUS__doc_accnumber);	
  dKeyCALBUS__xdstat2 							:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_xdstat2, rKeyCALBUS__xdstat2);	
  dKeyCALBUS__account_nbr						:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_account_nbr, rKeyCALBUS__account_nbr);	
  dKeyCALBUS__nidx3 								:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_nidx3, rKeyCALBUS__nidx3);	
  dKeyCALBUS__dictindx3 						:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_dictindx3, rKeyCALBUS__dictindx3);	
  dKeyCALBUS__dtldictx 							:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_dtldictx, rKeyCALBUS__dtldictx);	
  dKeyCALBUS__exkeyi 								:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_exkeyi, rKeyCALBUS__exkeyi);	
  dKeyCALBUS__exkeyo 								:=  project(PRTE_CSV.CALBUS.dthor_data400__key__calbus_exkeyo, rKeyCALBUS__exkeyo);	
	dKeyCALBUS__linkids								:= 	project(PRTE_CSV.CALBUS.dthor_data400__key__CALBUS_linkids, rKeyCALBUS__linkids);	
	
													
	kKeyCALBUS__xseglist							:=	index(dKeyCALBUS__xseglist, {f}, {dKeyCALBUS__xseglist}, '~prte::key::calbus::' + pIndexVersion + '::xseglist');
	KKeyCALBUS__bdid									:=  index(dKeyCALBUS__bdid, {bdid}, {dKeyCALBUS__bdid}, '~prte::key::calbus::' + pIndexVersion + '::bdid');
	kKeyCALBUS__autokey_addressb2			:=  index(dKeyCALBUS__autokey_addressb2,{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid},{dKeyCALBUS__autokey_addressb2},'~prte::key::calbus::' + pIndexVersion + '::autokey::addressb2');
	kKeyCALBUS__autokey_citystnameb2	:=  index(dKeyCALBUS__autokey_citystnameb2,{city_code,st,cname_indic,cname_sec,bdid},{dKeyCALBUS__autokey_citystnameb2},'~prte::key::calbus::' + pIndexVersion + '::autokey::citystnameb2');
	kKeyCALBUS__autokey_nameb2				:=  index(dKeyCALBUS__autokey_nameb2,{cname_indic,cname_sec,bdid},{dKeyCALBUS__autokey_nameb2},'~prte::key::calbus::' + pIndexVersion + '::autokey::nameb2');
	kKeyCALBUS__autokey_payload				:=  index(dKeyCALBUS__autokey_payload,{fakeid},{dKeyCALBUS__autokey_payload},'~prte::key::calbus::' + pIndexVersion + '::autokey::payload');
	kKeyCALBUS__autokey_zipb2					:=  index(dKeyCALBUS__autokey_zipb2,{zip,cname_indic,cname_sec,bdid},{dKeyCALBUS__autokey_zipb2},'~prte::key::calbus::' + pIndexVersion + '::autokey::zipb2');
	kKeyCALBUS__autokey_stnameb2			:=  index(dKeyCALBUS__autokey_stnameb2,{st,cname_indic,cname_sec,bdid},{dKeyCALBUS__autokey_stnameb2},'~prte::key::calbus::' + pIndexVersion + '::autokey::stnameb2');
	kKeyCALBUS__autokey_namewords2		:=  index(dKeyCALBUS__autokey_namewords2,{word,state,seq,bdid},{dKeyCALBUS__autokey_namewords2},'~prte::key::calbus::' + pIndexVersion + '::autokey::namewords2');
	kKeyCALBUS__autokey_name					:=  index(dKeyCALBUS__autokey_name,{dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyCALBUS__autokey_name},'~prte::key::calbus::' + pIndexVersion + '::autokey::name');
	kKeyCALBUS__autokey_address				:=  index(dKeyCALBUS__autokey_address,{prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups},{dKeyCALBUS__autokey_address},'~prte::key::calbus::' + pIndexVersion + '::autokey::address');
	kKeyCALBUS__autokey_stname				:=  index(dKeyCALBUS__autokey_stname,{st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyCALBUS__autokey_stname},'~prte::key::calbus::' + pIndexVersion + '::autokey::stname');
	kKeyCALBUS__autokey_citystname		:=  index(dKeyCALBUS__autokey_citystname,{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyCALBUS__autokey_citystname},'~prte::key::calbus::' + pIndexVersion + '::autokey::citystname');
	kKeyCALBUS__autokey_zip						:=  index(dKeyCALBUS__autokey_zip,{zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyCALBUS__autokey_zip},'~prte::key::calbus::' + pIndexVersion + '::autokey::zip');
	kKeyCALBUS__doc_accnumber					:=  index(dKeyCALBUS__doc_accnumber,{src,doc,account_number},{dKeyCALBUS__doc_accnumber},'~prte::key::calbus::' + pIndexVersion + '::doc.accnumber');
	kKeyCALBUS__xdstat2								:=  index(dKeyCALBUS__xdstat2,{f},{dKeyCALBUS__xdstat2},'~prte::key::calbus::' + pIndexVersion + '::xdstat2');
	kKeyCALBUS__account_nbr						:=  index(dKeyCALBUS__account_nbr,{account_number},{dKeyCALBUS__account_nbr},'~prte::key::calbus::' + pIndexVersion + '::account_nbr');
	kKeyCALBUS__nidx3									:=  index(dKeyCALBUS__nidx3,{typ,nominal,lseg,part,src,doc,seg,kwp,wip,suffix},{dKeyCALBUS__nidx3},'~prte::key::calbus::' + pIndexVersion + '::nidx3');
	kKeyCALBUS__dictindx3							:=  index(dKeyCALBUS__dictindx3,{word,nominal,suffix,freq,docfreq},{dKeyCALBUS__dictindx3},'~prte::key::calbus::' + pIndexVersion + '::dictindx3');
	kKeyCALBUS__dtldictx							:=  index(dKeyCALBUS__dtldictx,{word,nominal,suffix,freq,docfreq},{dKeyCALBUS__dtldictx},'~prte::key::calbus::' + pIndexVersion + '::dtldictx');
	kKeyCALBUS__exkeyi								:=  index(dKeyCALBUS__exkeyi,{hashkey,part,src,doc},{dKeyCALBUS__exkeyi},'~prte::key::calbus::' + pIndexVersion + '::exkeyi');
	kKeyCALBUS__exkeyo								:=  index(dKeyCALBUS__exkeyo,{src,doc},{dKeyCALBUS__exkeyo},'~prte::key::calbus::' + pIndexVersion + '::exkeyo');
	kKeyCALBUS__linkids								:=  index(dKeyCALBUS__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeyCALBUS__linkids}, '~prte::key::calbus::' + pIndexVersion + '::linkids');

	return	sequential(
											parallel(																																
																build(kKeyCALBUS__xseglist						    	, update),
																build(kKeyCALBUS__bdid								    	, update),
																build(kKeyCALBUS__autokey_addressb2				 	, update),
																build(kKeyCALBUS__autokey_citystnameb2			, update),
																build(kKeyCALBUS__autokey_nameb2					 	, update),
																build(kKeyCALBUS__autokey_payload					 	, update),
																build(kKeyCALBUS__autokey_zipb2						 	, update),																
																build(kKeyCALBUS__autokey_stnameb2				 	, update),
																build(kKeyCALBUS__autokey_namewords2			 	, update),
																build(kKeyCALBUS__autokey_name						 	, update),
																build(kKeyCALBUS__autokey_address					 	, update),
																build(kKeyCALBUS__autokey_stname						, update),
																build(kKeyCALBUS__autokey_citystname		   	, update),
																build(kKeyCALBUS__autokey_zip						   	, update),
																build(kKeyCALBUS__doc_accnumber					   	, update),
																build(kKeyCALBUS__bdid								    	, update),																
																build(kKeyCALBUS__xdstat2							    	, update),
																build(kKeyCALBUS__account_nbr						   	, update),
																build(kKeyCALBUS__nidx3								    	, update),
																build(kKeyCALBUS__dictindx3							  	, update),
																build(kKeyCALBUS__dtldictx							   	, update),
																build(kKeyCALBUS__exkeyi								   	, update),
																build(kKeyCALBUS__exkeyo								   	, update),																
																build(kKeyCALBUS__linkids							    	, update)
																																																
															 ),
											PRTE.UpdateVersion('GovdataKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
