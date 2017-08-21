import	_control, PRTE, PRTE_CSV;

pversion := '20130214';

export Proc_Build_GSA_Keys(string pIndexVersion) := function
ds_address  			:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__autokey__address);
ds_addressb2			:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__autokey__addressb2);
ds_citystname 		:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__autokey__citystname);
ds_citystnameb2		:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__autokey__citystnameb2);
ds_name 					:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__autokey__name);
ds_nameb2					:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__autokey__nameb2);
ds_namewords2			:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__autokey__namewords2);
ds_payload				:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__autokey__payload);
ds_stname 				:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__autokey__stname);
ds_stnameb2				:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__autokey__stnameb2);
ds_zip  					:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__autokey__zip);
ds_zipb2					:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__autokey__zipb2);
ds_gsa_id					:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__gsa_id);
ds_bdid 					:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__bdid);
ds_did 						:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__did);
ds_linkids				:= DATASET([], prte_csv.gsa.rthor_data400__key__gsa__linkids);

address_IN  			:= INDEX(ds_address, {prim_name, prim_range, st, city_code, zip, sec_range, dph_lname, lname, pfname, fname, states, lname1, lname2, lname3, lookups}, {ds_address}, '~prte::key::gsa::' + pIndexVersion + '::autokey::address');
addressb2_IN			:= INDEX(ds_addressb2, {prim_name, prim_range, st, city_code, zip, sec_range, cname_indic, cname_sec, bdid}, {ds_addressb2}, '~prte::key::gsa::' + pIndexVersion + '::autokey::addressb2');
citystname_IN	  	:= INDEX(ds_citystname, {city_code, st, dph_lname, lname, pfname, fname, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_citystname}, '~prte::key::gsa::' + pIndexVersion + '::autokey::citystname');
citystnameb2_IN		:= INDEX(ds_citystnameb2, {city_code, st, cname_indic, cname_sec, bdid}, {ds_citystnameb2}, '~prte::key::gsa::' + pIndexVersion + '::autokey::citystnameb2');
name_IN 					:= INDEX(ds_name, {dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_name}, '~prte::key::gsa::' + pIndexVersion + '::autokey::name');
nameb2_IN					:= INDEX(ds_nameb2, {cname_indic, cname_sec, bdid}, {ds_nameb2}, '~prte::key::gsa::' + pIndexVersion + '::autokey::nameb2');
namewords2_IN			:= INDEX(ds_namewords2, {word, state, seq, bdid}, {ds_namewords2}, '~prte::key::gsa::' + pIndexVersion + '::autokey::namewords2');
payload_IN				:= INDEX(ds_payload, {fakeid}, {ds_payload}, '~prte::key::gsa::' + pIndexVersion + '::autokey::payload');
stname_IN 				:= INDEX(ds_stname, {st, dph_lname, lname, pfname, fname, minit, yob, s4, zip, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_stname}, '~prte::key::gsa::' + pIndexVersion + '::autokey::stname');
stnameb2_IN				:= INDEX(ds_stnameb2, {st, cname_indic, cname_sec, bdid}, {ds_stnameb2}, '~prte::key::gsa::' + pIndexVersion + '::autokey::stnameb2');
zip_IN  					:= INDEX(ds_zip, {zip, dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_zip}, '~prte::key::gsa::' + pIndexVersion + '::autokey::zip');
zipb2_IN				 	:= INDEX(ds_zipb2, {zip, cname_indic, cname_sec, bdid}, {ds_zipb2}, '~prte::key::gsa::' + pIndexVersion + '::autokey::zipb2');
gsa_id_IN 				:= INDEX(ds_gsa_id, {gsa_id}, {ds_gsa_id}, '~prte::key::gsa::' + pIndexVersion + '::gsa_id');	
bdid_IN 					:= INDEX(ds_bdid, {bdid}, {ds_bdid}, '~prte::key::gsa::' + pIndexVersion + '::bdid');	
did_IN 						:= INDEX(ds_did, {did}, {ds_did}, '~prte::key::gsa::' + pIndexVersion + '::did');	
linkids_IN 				:= INDEX(ds_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_linkids}, '~prte::key::gsa::' + pIndexVersion + '::linkids');	

return	sequential(
											parallel(		
																 BUILD(address_IN, 				update),
																 BUILD(addressb2_IN, 			update),
																 BUILD(citystname_IN, 		update),
																 BUILD(citystnameb2_IN, 	update),
																 BUILD(name_IN, 					update),
																 BUILD(nameb2_IN, 				update),
																 BUILD(namewords2_IN, 		update),
																 BUILD(payload_IN, 				update),
																 BUILD(stname_IN, 				update),
																 BUILD(stnameb2_IN, 			update),
																 BUILD(zip_IN, 						update),
																 BUILD(zipb2_IN, 					update),
																 BUILD(gsa_id_IN, 				update),
																 BUILD(bdid_IN, 					update),
																 BUILD(did_IN, 						update),
																 BUILD(linkids_IN, 				update)),
										 PRTE.UpdateVersion('GSAKeys',								   //	Package name
																pIndexVersion,											 //	Package version
																_control.MyInfo.EmailAddressNormal,  //	Who to email with specifics
																'B',																 //	B = Boca, A = Alpharetta
																'N',																 //	N = Non-FCRA, F = FCRA
																'N'																   //	N = Do not also include boolean, Y = Include boolean, too
																));
end;																
