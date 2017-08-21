import	_control, PRTE_CSV;

export	Proc_Build_Watchdog_Keys(string pIndexVersion)	:=
function

	rKeyWatchdog__best_did	:=
	record
		PRTE_CSV.Watchdog.rthor_data400__key__watchdog__best_did;
	end;

	rKeyWatchdog__best_did__new	:=
	record
		PRTE_CSV.Watchdog.rthor_data400__key__watchdog__best_did__new;
	end;

	rKeyWatchdog__best_did_nonblank	:=
	record
		PRTE_CSV.Watchdog.rthor_data400__key__watchdog__best_did_nonblank;
	end;
	
	rKeyWatchdog__best_did_nonblank__new	:=
	record
		PRTE_CSV.Watchdog.rthor_data400__key__watchdog__best_did_nonblank__new;
	end;

	rKeyWatchdog__best_nonen_did	:=
	record
		PRTE_CSV.Watchdog.rthor_data400__key__watchdog__best_nonen_did;
	end;

	rKeyWatchdog__best_nonen_did__new	:=
	record
		PRTE_CSV.Watchdog.rthor_data400__key__watchdog__best_nonen_did__new;
	end;

	rKeyWatchdog__nonen_did_nonblank	:=
	record
		PRTE_CSV.Watchdog.rthor_data400__key__watchdog__best_nonen_did_nonblank;
	end;

	rKeyWatchdog__nonen_did_nonblank__new	:=
	record
		PRTE_CSV.Watchdog.rthor_data400__key__watchdog__best_nonen_did_nonblank__new;
	end;

	rKeyWatchdog__nonglb_did	:=
	record
		PRTE_CSV.Watchdog.rthor_data400__key__watchdog__nonglb_did;
	end;

	rKeyWatchdog__nonglb_did__new	:=
	record
		PRTE_CSV.Watchdog.rthor_data400__key__watchdog__nonglb_did__new;
	end;

	rKeyWatchdog__nonglb_did_nonblank	:=
	record
		PRTE_CSV.Watchdog.rthor_data400__key__watchdog__nonglb_did_nonblank;
	end;
	
	rKeyWatchdog__nonglb_did_nonblank__new	:=
	record
		PRTE_CSV.Watchdog.rthor_data400__key__watchdog__nonglb_did_nonblank__new;
	end;
	
		rKeyWatchdog__ssn_bads	:=
	record
		PRTE_CSV.Watchdog.rthor_data400__key__watchdog__ssn_bads;
	end;

	dKeyWatchdog__best_did						:= 	project(PRTE_CSV.Watchdog.dthor_data400__key__watchdog__best_did , rKeyWatchdog__best_did__new);
	dKeyWatchdog__best_did_nonblank		:= 	project(PRTE_CSV.Watchdog.dthor_data400__key__watchdog__best_did_nonblank, rKeyWatchdog__best_did_nonblank__new);
	dKeyWatchdog__best_nonen_did			:= 	project(PRTE_CSV.Watchdog.dthor_data400__key__watchdog__best_nonen_did, rKeyWatchdog__best_nonen_did__new);
	dKeyWatchdog__nonen_did_nonblank	:= 	project(PRTE_CSV.Watchdog.dthor_data400__key__watchdog__best_nonen_did_nonblank, rKeyWatchdog__nonen_did_nonblank__new);
	dKeyWatchdog__nonglb_did					:= 	project(PRTE_CSV.Watchdog.dthor_data400__key__watchdog__nonglb_did, rKeyWatchdog__nonglb_did__new);
	dKeyWatchdog__nonglb_did_nonblank	:= 	project(PRTE_CSV.Watchdog.dthor_data400__key__watchdog__nonglb_did_nonblank, rKeyWatchdog__nonglb_did_nonblank__new);
	dKeyWatchdog__ssn_bads						:= 	project(PRTE_CSV.Watchdog.dthor_data400__key__watchdog__ssn_bads, rKeyWatchdog__ssn_bads);

	kKeyWatchdog__best_did						:=	index(dKeyWatchdog__best_did, {did,
phone,
ssn,
dob,
title,
fname,
mname,
lname,
name_suffix,
prim_range,
predir,
prim_name,
suffix,
postdir,
unit_desig,
sec_range,
city_name,
st,
zip,
zip4,
addr_dt_last_seen,
dod,
prpty_deed_id,
vehicle_vehnum,
bkrupt_crtcode_caseno,
main_count,
search_count,
dl_number,
bdid,
run_date,
total_records,
rawaid,
addr_dt_first_seen,
adl_ind,
valid_ssn}, {dKeyWatchdog__best_did}, '~prte::key::watchdog::' + pIndexVersion + '::best.did');
	kKeyWatchdog__best_did_nonblank		:=	index(dKeyWatchdog__best_did_nonblank, {did,
phone,
ssn,
dob,
title,
fname,
mname,
lname,
name_suffix,
prim_range,
predir,
prim_name,
suffix,
postdir,
unit_desig,
sec_range,
city_name,
st,
zip,
zip4,
addr_dt_last_seen,
dod,
prpty_deed_id,
vehicle_vehnum,
bkrupt_crtcode_caseno,
main_count,
search_count,
dl_number,
bdid,
run_date,
total_records,
rawaid,
addr_dt_first_seen,
adl_ind,
valid_ssn},{dKeyWatchdog__best_did_nonblank}, '~prte::key::watchdog::' + pIndexVersion + '::best.did_nonblank');
	kKeyWatchdog__best_nonen_did			:=	index(dKeyWatchdog__best_nonen_did, {did,
phone,
ssn,
dob,
title,
fname,
mname,
lname,
name_suffix,
prim_range,
predir,
prim_name,
suffix,
postdir,
unit_desig,
sec_range,
city_name,
st,
zip,
zip4,
addr_dt_last_seen,
dod,
prpty_deed_id,
vehicle_vehnum,
bkrupt_crtcode_caseno,
main_count,
search_count,
dl_number,
bdid,
run_date,
total_records,
rawaid,
addr_dt_first_seen,
adl_ind,
valid_ssn}, {dKeyWatchdog__best_nonen_did}, '~prte::key::watchdog::' + pIndexVersion + '::best_nonen.did');
	kKeyWatchdog__nonen_did_nonblank	:=	index(dKeyWatchdog__nonen_did_nonblank, {did,
phone,
ssn,
dob,
title,
fname,
mname,
lname,
name_suffix,
prim_range,
predir,
prim_name,
suffix,
postdir,
unit_desig,
sec_range,
city_name,
st,
zip,
zip4,
addr_dt_last_seen,
dod,
prpty_deed_id,
vehicle_vehnum,
bkrupt_crtcode_caseno,
main_count,
search_count,
dl_number,
bdid,
run_date,
total_records,
rawaid,
addr_dt_first_seen,
adl_ind,
valid_ssn}, {dKeyWatchdog__nonen_did_nonblank}, '~prte::key::watchdog::' + pIndexVersion + '::best_nonen.did_nonblank');
	kKeyWatchdog__nonglb_did					:=	index(dKeyWatchdog__nonglb_did, {did,
phone,
ssn,
dob,
title,
fname,
mname,
lname,
name_suffix,
prim_range,
predir,
prim_name,
suffix,
postdir,
unit_desig,
sec_range,
city_name,
st,
zip,
zip4,
addr_dt_last_seen,
dod,
prpty_deed_id,
vehicle_vehnum,
bkrupt_crtcode_caseno,
main_count,
search_count,
dl_number,
bdid,
run_date,
total_records,
rawaid,
addr_dt_first_seen,
adl_ind,
valid_ssn,
glb_name,
glb_address,
glb_dob,
glb_ssn,
glb_phone
}, {dKeyWatchdog__nonglb_did}, '~prte::key::watchdog::' + pIndexVersion + '::nonglb.did');
	kKeyWatchdog__nonglb_did_nonblank	:=	index(dKeyWatchdog__nonglb_did_nonblank, {did,
phone,
ssn,
dob,
title,
fname,
mname,
lname,
name_suffix,
prim_range,
predir,
prim_name,
suffix,
postdir,
unit_desig,
sec_range,
city_name,
st,
zip,
zip4,
addr_dt_last_seen,
dod,
prpty_deed_id,
vehicle_vehnum,
bkrupt_crtcode_caseno,
main_count,
search_count,
dl_number,
bdid,
run_date,
total_records,
rawaid,
addr_dt_first_seen,
adl_ind,
valid_ssn,
glb_name,
glb_address,
glb_dob,
glb_ssn,
glb_phone}, {dKeyWatchdog__nonglb_did_nonblank}, '~prte::key::watchdog::' + pIndexVersion + '::nonglb.did_nonblank');
	kKeyWatchdog__ssn_bads						:=	index(dKeyWatchdog__ssn_bads, {s_ssn}, {dKeyWatchdog__ssn_bads}, '~prte::key::watchdog::' + pIndexVersion + '::ssn_bads');

	return	sequential(
											parallel(
																build(kKeyWatchdog__best_did			, update),
																build(kKeyWatchdog__best_did_nonblank		, update),
																build(kKeyWatchdog__best_nonen_did	, update),
																build(kKeyWatchdog__nonen_did_nonblank, update),
																build(kKeyWatchdog__nonglb_did					, update),
																build(kKeyWatchdog__nonglb_did_nonblank					, update),
																build(kKeyWatchdog__ssn_bads			, update)
																),
											PRTE.UpdateVersion('WatchdogKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;

