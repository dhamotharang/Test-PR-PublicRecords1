import	_control, PRTE_CSV;

export Proc_Build_FLCrash_Keys(string pIndexVersion) := function

	rKeyFLCrash__accnbr	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__flcrash__accnbr;
	end;	
	
	rKeyFLCrash__autokey__address	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__autokey__address;
	end;

	rKeyFLCrash__autokey__addressb2	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__autokey__addressb2;
	end;

	rKeyFLCrash__autokey__citystname	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__autokey__citystname;
	end;

	rKeyFLCrash__autokey__citystnameb2	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__autokey__citystnameb2;
	end;	

	rKeyFLCrash__autokey__name	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__autokey__name;
	end;

	rKeyFLCrash__autokey__nameb2	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__autokey__nameb2;
	end;

	rKeyFLCrash__autokey__namewords2	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__autokey__namewords2;
	end;

	rKeyFLCrash__autokey__payload	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__autokey__payload;
	end;
	
	rKeyFLCrash__autokey__stname	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__autokey__stname;
	end;

	rKeyFLCrash__autokey__stnameb2	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__autokey__stnameb2;
	end;

	rKeyFLCrash__autokey__zip	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__autokey__zip;
	end;

	rKeyFLCrash__autokey__zipb2	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__autokey__zipb2;
	end;

	rKeyFLCrash__bdid	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__bdid;
	end;

	rKeyFLCrash__did	:=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLCrash__did;
	end;

	rKeyFLCrash__dlnbr :=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__FLcrash__dlnbr;
	end;
	
	rKeyFLCrash__flcrash0 :=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__flcrash__flcrash0;
	end;
	
	rKeyFLCrash__flcrash1 :=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__flcrash__flcrash1;
	end;

	rKeyFLCrash__flcrash2v :=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__flcrash__flcrash2v;
	end;
	
		rKeyFLCrash__flcrash3v :=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__flcrash__flcrash3v;
	end;
	
		rKeyFLCrash__flcrash4 :=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__flcrash__flcrash4;
	end;
	
		rKeyFLCrash__flcrash5 :=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__flcrash__flcrash5;
	end;
	
		rKeyFLCrash__flcrash6 :=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__flcrash__flcrash6;
	end;

	rKeyFLCrash__flcrash7 :=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__flcrash__flcrash7;
	end;
	
		rKeyFLCrash__tagnbr :=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__flcrash__tagnbr;
	end;
	
		rKeyFLCrash__vin :=
	record
		PRTE_CSV.FLCrash.rthor_data400__key__flcrash__vin;
	end;

	dKeyFLCrash__accnbr									:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__flcrash__accnbr, rKeyFLCrash__accnbr);	
	dKeyFLCrash__autokey__address				:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__autokey__address, rKeyFLCrash__autokey__address);
	dKeyFLCrash__autokey__addressb2			:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__autokey__addressb2, rKeyFLCrash__autokey__addressb2);
	dKeyFLCrash__autokey__citystname		:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__autokey__citystname, rKeyFLCrash__autokey__citystname);
	dKeyFLCrash__autokey__citystnameb2	:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__autokey__citystnameb2, rKeyFLCrash__autokey__citystnameb2);	
	dKeyFLCrash__autokey__name					:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__autokey__name, rKeyFLCrash__autokey__name);
	dKeyFLCrash__autokey__nameb2				:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__autokey__nameb2, rKeyFLCrash__autokey__nameb2);
	dKeyFLCrash__autokey__namewords2		:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__autokey__namewords2, rKeyFLCrash__autokey__namewords2);	
	dKeyFLCrash__autokey__payload				:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__autokey__payload, rKeyFLCrash__autokey__payload);	
	dKeyFLCrash__autokey__stname				:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__autokey__stname, rKeyFLCrash__autokey__stname);
	dKeyFLCrash__autokey__stnameb2			:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__autokey__stnameb2, rKeyFLCrash__autokey__stnameb2);
	dKeyFLCrash__autokey__zip						:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__autokey__zip, rKeyFLCrash__autokey__zip);
	dKeyFLCrash__autokey__zipb2					:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__autokey__zipb2, rKeyFLCrash__autokey__zipb2);
	dKeyFLCrash__bdid										:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__bdid, rKeyFLCrash__bdid);	
	dKeyFLCrash__did										:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__did, rKeyFLCrash__did);
	dKeyFLCrash__dlnbr									:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__dlnbr, rKeyFLCrash__dlnbr);	
	dKeyFLCrash__flcrash0								:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__flcrash__flcrash0, rKeyFLCrash__flcrash0);
	dKeyFLCrash__flcrash1								:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__flcrash1, rKeyFLCrash__flcrash1);	
	dKeyFLCrash__flcrash2v							:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__flcrash2v, rKeyFLCrash__flcrash2v);	
	dKeyFLCrash__flcrash3v							:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__flcrash3v, rKeyFLCrash__flcrash3v);	
	dKeyFLCrash__flcrash4								:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__flcrash4, rKeyFLCrash__flcrash4);	
	dKeyFLCrash__flcrash5								:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__flcrash5, rKeyFLCrash__flcrash5);	
	dKeyFLCrash__flcrash6								:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__flcrash6, rKeyFLCrash__flcrash6);	
	dKeyFLCrash__flcrash7								:= 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__flcrash7, rKeyFLCrash__flcrash7);
	dKeyFLCrash__tagnbr								  := 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__tagnbr, rKeyFLCrash__tagnbr);
	dKeyFLCrash__vin								    := 	project(PRTE_CSV.FLCrash.dthor_data400__key__FLCrash__vin, rKeyFLCrash__vin);
	
	kKeyFLCrash__accnbr									:=	index(dKeyFLCrash__accnbr, {l_accnbr}, {dKeyFLCrash__accnbr}, '~prte::key::flcrash::' + pIndexVersion + '::accnbr');
	kKeyFLCrash__autokey__address				:=	index(dKeyFLCrash__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyFLCrash__autokey__address}, '~prte::key::flcrash::' + pIndexVersion + '::autokey::address');
	kKeyFLCrash__autokey__addressb2			:=	index(dKeyFLCrash__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyFLCrash__autokey__addressb2}, '~prte::key::flcrash::' + pIndexVersion + '::autokey::addressb2');
	kKeyFLCrash__autokey__citystname		:=	index(dKeyFLCrash__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyFLCrash__autokey__citystname}, '~prte::key::flcrash::' + pIndexVersion + '::autokey::citystname');
	kKeyFLCrash__autokey__citystnameb2	:=	index(dKeyFLCrash__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyFLCrash__autokey__citystnameb2}, '~prte::key::flcrash::' + pIndexVersion + '::autokey::citystnameb2');	
	kKeyFLCrash__autokey__name					:=	index(dKeyFLCrash__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyFLCrash__autokey__name}, '~prte::key::flcrash::' + pIndexVersion + '::autokey::name');
	kKeyFLCrash__autokey__nameb2				:=	index(dKeyFLCrash__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyFLCrash__autokey__nameb2}, '~prte::key::flcrash::' + pIndexVersion + '::autokey::nameb2');
	kKeyFLCrash__autokey__namewords2		:=	index(dKeyFLCrash__autokey__namewords2, {word,state,seq,bdid}, {dKeyFLCrash__autokey__namewords2}, '~prte::key::flcrash::' + pIndexVersion + '::autokey::namewords2');
	kKeyFLCrash__autokey__payload				:=	index(dKeyFLCrash__autokey__payload, {fakeid}, {dKeyFLCrash__autokey__payload}, '~prte::key::flcrash::' + pIndexVersion + '::autokey::payload');
	kKeyFLCrash__autokey__stname				:=	index(dKeyFLCrash__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyFLCrash__autokey__stname}, '~prte::key::flcrash::' + pIndexVersion + '::autokey::stname');
	kKeyFLCrash__autokey__stnameb2			:=	index(dKeyFLCrash__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyFLCrash__autokey__stnameb2}, '~prte::key::flcrash::' + pIndexVersion + '::autokey::stnameb2');
	kKeyFLCrash__autokey__zip						:=	index(dKeyFLCrash__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyFLCrash__autokey__zip}, '~prte::key::flcrash::' + pIndexVersion + '::autokey::zip');
	kKeyFLCrash__autokey__zipb2					:=	index(dKeyFLCrash__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyFLCrash__autokey__zipb2}, '~prte::key::flcrash::' + pIndexVersion + '::autokey::zipb2');
	kKeyFLCrash__bdid										:=	index(dKeyFLCrash__bdid, {l_bdid}, {dKeyFLCrash__bdid}, '~prte::key::flcrash::' + pIndexVersion + '::bdid');
	kKeyFLCrash__did										:=	index(dKeyFLCrash__did, {l_did}, {dKeyFLCrash__did}, '~prte::key::flcrash::' + pIndexVersion + '::did');
	kKeyFLCrash__dlnbr									:=	index(dKeyFLCrash__dlnbr, {l_dlnbr}, {dKeyFLCrash__dlnbr}, '~prte::key::flcrash::' + pIndexVersion + '::dlnbr');	
	kKeyFLCrash__flcrash0								:=	index(dKeyFLCrash__flcrash0, {l_acc_nbr}, {dKeyFLCrash__flcrash0}, '~prte::key::flcrash::' + pIndexVersion + '::flcrash0');	
	kKeyFLCrash__flcrash1								:=	index(dKeyFLCrash__flcrash1, {l_acc_nbr}, {dKeyFLCrash__flcrash1}, '~prte::key::flcrash::' + pIndexVersion + '::flcrash1');	
	kKeyFLCrash__flcrash2v							:=	index(dKeyFLCrash__flcrash2v, {l_acc_nbr}, {dKeyFLCrash__flcrash2v}, '~prte::key::flcrash::' + pIndexVersion + '::flcrash2');	
	kKeyFLCrash__flcrash3v							:=	index(dKeyFLCrash__flcrash3v, {l_acc_nbr}, {dKeyFLCrash__flcrash3v}, '~prte::key::flcrash::' + pIndexVersion + '::flcrash3');	
	kKeyFLCrash__flcrash4								:=	index(dKeyFLCrash__flcrash4, {l_acc_nbr}, {dKeyFLCrash__flcrash4}, '~prte::key::flcrash::' + pIndexVersion + '::flcrash4');	
	kKeyFLCrash__flcrash5								:=	index(dKeyFLCrash__flcrash5, {l_acc_nbr}, {dKeyFLCrash__flcrash5}, '~prte::key::flcrash::' + pIndexVersion + '::flcrash5');	
	kKeyFLCrash__flcrash6								:=	index(dKeyFLCrash__flcrash6, {l_acc_nbr}, {dKeyFLCrash__flcrash6}, '~prte::key::flcrash::' + pIndexVersion + '::flcrash6');	
	kKeyFLCrash__flcrash7								:=	index(dKeyFLCrash__flcrash7, {l_acc_nbr}, {dKeyFLCrash__flcrash7}, '~prte::key::flcrash::' + pIndexVersion + '::flcrash7');	
	kKeyFLCrash__tagnbr 								:=	index(dKeyFLCrash__tagnbr, {l_tagnbr}, {dKeyFLCrash__tagnbr}, '~prte::key::flcrash::' + pIndexVersion + '::tagnbr');	
	kKeyFLCrash__vin										:=	index(dKeyFLCrash__vin, {l_vin}, {dKeyFLCrash__vin}, '~prte::key::flcrash::' + pIndexVersion + '::vin');	
	

	return	sequential(
											parallel(
																build(kKeyFLCrash__accnbr	, update),
																build(kKeyFLCrash__autokey__address			, update),
																build(kKeyFLCrash__autokey__addressb2		, update),
																build(kKeyFLCrash__autokey__citystname	, update),
																build(kKeyFLCrash__autokey__citystnameb2, update),																
																build(kKeyFLCrash__autokey__name				, update),
																build(kKeyFLCrash__autokey__nameb2			, update),
																build(kKeyFLCrash__autokey__namewords2	, update),
																build(kKeyFLCrash__autokey__payload			, update),																
																build(kKeyFLCrash__autokey__stname			, update),
																build(kKeyFLCrash__autokey__stnameb2		, update),
																build(kKeyFLCrash__autokey__zip					, update),
																build(kKeyFLCrash__autokey__zipb2				, update),
																build(kKeyFLCrash__bdid					    		, update),																
																build(kKeyFLCrash__did						    	, update),
																build(kKeyFLCrash__dlnbr  				   		, update),
																build(kKeyFLCrash__flcrash0  				   	, update),
																build(kKeyFLCrash__flcrash1  				   	, update),
																build(kKeyFLCrash__flcrash2v  				  , update),
																build(kKeyFLCrash__flcrash3v  				  , update),
																build(kKeyFLCrash__flcrash4  				   	, update),
																build(kKeyFLCrash__flcrash5  				   	, update),
																build(kKeyFLCrash__flcrash6  				   	, update),
																build(kKeyFLCrash__flcrash7  				   	, update),
																build(kKeyFLCrash__tagnbr   				   	, update),
																build(kKeyFLCrash__vin      				   	, update)
															 ),
											PRTE.UpdateVersion('FloridaCrashKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
