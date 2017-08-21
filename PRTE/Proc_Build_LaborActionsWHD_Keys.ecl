import	_control, PRTE, PRTE_CSV;

export Proc_Build_LaborActionsWHD_Keys(string pIndexVersion) := function

rKeyLabActWHD__autokey__addressb2 :=
record
	PRTE_CSV.LaborActions_WHD.rthor_data400__key__laboractions_whd__autokey__addressb2;
end;

rKeyLabActWHD__autokey__citystnameb2 :=
record
	PRTE_CSV.LaborActions_WHD.rthor_data400__key__laboractions_whd__autokey__citystnameb2;
end;

rKeyLabActWHD__autokey__nameb2 :=
record
	PRTE_CSV.LaborActions_WHD.rthor_data400__key__laboractions_whd__autokey__nameb2;
end;

rKeyLabActWHD__autokey__namewords2 :=
record
	PRTE_CSV.LaborActions_WHD.rthor_data400__key__laboractions_whd__autokey__namewords2;
end;

rKeyLabActWHD__autokey__payload :=
record
	PRTE_CSV.LaborActions_WHD.rthor_data400__key__laboractions_whd__autokey__payload;
end;
 
rKeyLabActWHD__autokey__stnameb2:=
record
	PRTE_CSV.LaborActions_WHD.rthor_data400__key__laboractions_whd__autokey__stnameb2;
end;

rKeyLabActWHD__autokey__zipb2 :=
record
	PRTE_CSV.LaborActions_WHD.rthor_data400__key__laboractions_whd__autokey__zipb2;
end;
 
rKeyLabActWHD__bdid	:=
record
	PRTE_CSV.LaborActions_WHD.rthor_data400__key__laboractions_whd__bdid;
end;

rKeyLabActWHD__linkids	:=
record
	PRTE_CSV.LaborActions_WHD.rthor_data400__key__laboractions_whd__linkids;
end;

dKeyLabActWHD__autokey__addressb2 	:=  project(PRTE_CSV.laboractions_whd.dthor_data400__key__laboractions_whd__autokey__addressb2, rKeyLabActWHD__autokey__addressb2);				
dKeyLabActWHD__autokey__citystnameb2:=  project(PRTE_CSV.laboractions_whd.dthor_data400__key__laboractions_whd__autokey__citystnameb2, rKeyLabActWHD__autokey__citystnameb2);	
dKeyLabActWHD__autokey__nameb2 			:=  project(PRTE_CSV.laboractions_whd.dthor_data400__key__laboractions_whd__autokey__nameb2, rKeyLabActWHD__autokey__nameb2);	
dKeyLabActWHD__autokey__namewords2 	:=  project(PRTE_CSV.laboractions_whd.dthor_data400__key__laboractions_whd__autokey__namewords2, rKeyLabActWHD__autokey__namewords2);
dKeyLabActWHD__autokey__payload			:=  project(PRTE_CSV.laboractions_whd.dthor_data400__key__laboractions_whd__autokey__payload, rKeyLabActWHD__autokey__payload);	
dKeyLabActWHD__autokey__stnameb2 		:=  project(PRTE_CSV.laboractions_whd.dthor_data400__key__laboractions_whd__autokey__stnameb2, rKeyLabActWHD__autokey__stnameb2);
dKeyLabActWHD__autokey__zipb2 			:=  project(PRTE_CSV.laboractions_whd.dthor_data400__key__laboractions_whd__autokey__zipb2, rKeyLabActWHD__autokey__zipb2);
dKeyLabActWHD__bdid									:= 	project(PRTE_CSV.laboractions_whd.dthor_data400__key__laboractions_whd__bdid, rKeyLabActWHD__bdid);							
dKeyLabActWHD__linkids							:= 	project(PRTE_CSV.laboractions_whd.dthor_data400__key__laboractions_whd__linkids, rKeyLabActWHD__linkids);	
	
													
kKeyLabActWHD__autokey__addressb2		:=  index(dKeyLabActWHD__autokey__addressb2,{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid},{dKeyLabActWHD__autokey__addressb2},'~prte::key::laboractions_whd::' + pIndexVersion + '::autokey::addressb2');
kKeyLabActWHD__autokey__citystnameb2:=  index(dKeyLabActWHD__autokey__citystnameb2,{city_code,st,cname_indic,cname_sec,bdid},{dKeyLabActWHD__autokey__citystnameb2},'~prte::key::laboractions_whd::' + pIndexVersion + '::autokey::citystnameb2');
kKeyLabActWHD__autokey__nameb2			:=  index(dKeyLabActWHD__autokey__nameb2,{cname_indic,cname_sec,bdid},{dKeyLabActWHD__autokey__nameb2},'~prte::key::laboractions_whd::' + pIndexVersion + '::autokey::nameb2');
kKeyLabActWHD__autokey__namewords2	:=  index(dKeyLabActWHD__autokey__namewords2,{word,state,seq,bdid},{dKeyLabActWHD__autokey__namewords2},'~prte::key::laboractions_whd::' + pIndexVersion + '::autokey::namewords2');
kKeyLabActWHD__autokey__payload			:=  index(dKeyLabActWHD__autokey__payload,{fakeid},{dKeyLabActWHD__autokey__payload},'~prte::key::laboractions_whd::' + pIndexVersion + '::autokey::payload');
kKeyLabActWHD__autokey__stnameb2		:=  index(dKeyLabActWHD__autokey__stnameb2,{st,cname_indic,cname_sec,bdid},{dKeyLabActWHD__autokey__stnameb2},'~prte::key::laboractions_whd::' + pIndexVersion + '::autokey::stnameb2');
kKeyLabActWHD__autokey__zipb2				:=  index(dKeyLabActWHD__autokey__zipb2,{zip,cname_indic,cname_sec,bdid},{dKeyLabActWHD__autokey__zipb2},'~prte::key::laboractions_whd::' + pIndexVersion + '::autokey::zipb2');
kKeyLabActWHD__bdid									:=  index(dKeyLabActWHD__bdid, {bdid}, {dKeyLabActWHD__bdid}, '~prte::key::laboractions_whd::' + pIndexVersion + '::bdid');
kKeyLabActWHD__linkids							:=  index(dKeyLabActWHD__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeyLabActWHD__linkids}, '~prte::key::laboractions_whd::' + pIndexVersion + '::linkids');

return	sequential(
										parallel(												
																build(kKeyLabActWHD__autokey__addressb2,	 	 	update),
																build(kKeyLabActWHD__autokey__citystnameb2, 	update),
																build(kKeyLabActWHD__autokey__nameb2, 				update),
																build(kKeyLabActWHD__autokey__namewords2, 		update),
																build(kKeyLabActWHD__autokey__payload, 				update),
																build(kKeyLabActWHD__autokey__stnameb2, 			update),	
																build(kKeyLabActWHD__autokey__zipb2, 					update),																
																build(kKeyLabActWHD__bdid, 										update),
																build(kKeyLabActWHD__linkids, 								update)																
														),
								
								PRTE.UpdateVersion('LaborActionsWHDKeys',				    //	Package name
																pIndexVersion,											//	Package version
																_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																 'B',																//	B = Boca, A = Alpharetta
																 'N',																//	N = Non-FCRA, F = FCRA
																 'N'																//	N = Do not also include boolean, Y = Include boolean, too
																	)
										 );
end;
