
EXPORT proc_compid_extract(string filedate) := FUNCTION
	
	IMPORT Death_Master, _control;
	
	//#workunit('name','DeathMaster - Compid Extract');
	
	email_list	:=	'valerie.minnis@lexisnexis.com; DataReceiving@lexisnexis.com; ALP-MediaOps@choicepoint.com; pamela.petersen@lexisnexis.com; kevin.reeder@lexisnexis.com';

	rsCompIdDmastDels				:=	DATASET('~thor_data400::out::death_master::compid::deletes', layouts_extract.layout_compid_extract, FLAT);
	rsCompIdDmastIns				:=	DATASET('~thor_data400::out::death_master::compid::inserts', layouts_extract.layout_compid_extract, FLAT);

	rsCompIdDmastDelsFinal	:=	DEDUP(SORT(DISTRIBUTE(rsCompIdDmastDels, HASH32(SSN)), SSN, LOCAL), ALL, LOCAL);
	rsCompIdDmastInsFinal		:=	DEDUP(SORT(DISTRIBUTE(rsCompIdDmastIns, HASH32(SSN)), SSN, LOCAL), ALL, LOCAL);

	writeDeletes	:=	OUTPUT(rsCompIdDmastDelsFinal, , '~thor_data400::out::death_master::compid::deletes_final', CLUSTER('thor400_20'), OVERWRITE);
	writeInserts	:=	OUTPUT(rsCompIdDmastInsFinal, , '~thor_data400::out::death_master::compid::inserts_final', CLUSTER('thor400_20'), OVERWRITE);

	deSprayDeletes	:=	FileServices.Despray('~thor_data400::out::death_master::compid::deletes_final', _Control.IPAddress.edata11, 
											 '/load01/choicepoint_inbound/outbound/deaths/dth_del_' + filedate + '.txt',,,,TRUE);
											 
	deSprayInserts	:=	FileServices.Despray('~thor_data400::out::death_master::compid::inserts_final', _Control.IPAddress.edata11, 
											 '/load01/choicepoint_inbound/outbound/deaths/dth_upd_' + filedate + '.txt',,,,TRUE);

	clearDeletesSuper	:=	FileServices.ClearSuperFile('~thor_data400::out::death_master::compid::deletes');								 
	clearInsertsSuper	:=	FileServices.ClearSuperFile('~thor_data400::out::death_master::compid::inserts');
	
	send_email 				:= fileservices.sendemail(email_list, 'Compid Death Extract is complete', 'The files dth_del_' + filedate + ' and dth_upd_'
	                                                         + filedate + ' can be found on edata14 in /load01/choicepoint_inbound/outbound/deaths');
										 
	RETURN SEQUENTIAL(PARALLEL(writeDeletes, writeInserts)
									, PARALLEL(deSprayDeletes, deSprayInserts)
									, PARALLEL(clearDeletesSuper, clearInsertsSuper)
									, send_email);

END;