	IMPORT Header, Doxie, watchdog, MDR, UtilFile, Data_Services, ut;

string CleanSpaces(string s) := stringlib.StringCleanSpaces(s);

//---------

//Count of LexIDs in Person Header
//count Person Header Best file, by header segment:
//watchdog.file_best. "adl_ind" = Header segment
base_wdog_best := dataset(ut.foreign_prod +	'thor_data400::BASE::Watchdog_best',watchdog.layout_key,flat);
Key_Watchdog_PHdr_glb := INDEX(base_wdog_best, watchdog.layout_key, ut.foreign_prod+'thor_data400::key::watchdog_best.did_qa');

// output(TABLE(Key_Watchdog_PHdr_glb, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Best_LexIDs_by_segment'));

//------------------------------------------------

//LexIDs with DOB
// LexIDs_with_DOB := Key_Watchdog_PHdr_glb(dob > 0);

// output(TABLE(LexIDs_with_DOB, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Best_LexIDsWith_DOB_by_segment'));

//-----

//LexIDs with SSN
// LexIDs_with_SSN := Key_Watchdog_PHdr_glb((unsigned6) ssn > 0);

// output(TABLE(LexIDs_with_SSN, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Best_LexIDsWith_SSN_by_segment'));

//-----

//LexIDs with DOB and SSN
// LexIDs_with_DOB_SSN := Key_Watchdog_PHdr_glb(dob > 0, (unsigned6) ssn > 0);

// output(TABLE(LexIDs_with_DOB_SSN, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Best_LexIDsWith_DOB_SSN_by_segment'));

//-----

//Unique Best Addresses
// Unique_Best_Addresses := DEDUP(sort(distribute(base_wdog_best, hash(st)), -addr_dt_last_seen, st,city_name,prim_range,prim_name,sec_range, local,skew(1.0)), st,city_name,prim_range,prim_name,sec_range, all,local);

// output(Unique_Best_Addresses);
// output(TABLE(Unique_Best_Addresses, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Unique_Best_Addresses_by_segment'));

//-------------------------------------------------------------------------------------------------------------

//Person Header:

hdr_prod 			:= DATASET(ut.foreign_prod+'thor_data400::base::header_prod', Header.layout_header_v2, flat);	//Header.File_Headers;	 no TU sources
hdr_tu_True   := DATASET(ut.foreign_prod+'thor_data400::base::TransunionCred_did',header.Layout_Header, flat);	//Header.file_tn_did; TU True CHdr (TN)
hdr_tu_LNCP  	:= DATASET(ut.foreign_prod+'thor_data400::base::transunion_did',header.Layout_Header, flat);	//Header.File_Transunion_did;		//TU legacy LN/CP (LT, TU)
hdr_TUCS	   	:= DATASET(ut.foreign_prod+'thor_data400::base::tucs_did',header.Layout_Header, flat);	// Header.File_TUCS_did; 

PHDR_GLB    := hdr_prod + hdr_tu_True + hdr_tu_LNCP + hdr_TUCS; 

PHDR_GLB_slim := PROJECT(PHDR_GLB
												 ,TRANSFORM({PHDR_GLB.did, PHDR_GLB.dt_last_seen, PHDR_GLB.dt_vendor_last_reported, PHDR_GLB.src, PHDR_GLB.ssn,PHDR_GLB.dob, PHDR_GLB.lname,PHDR_GLB.fname,PHDR_GLB.mname,PHDR_GLB.name_suffix, PHDR_GLB.st,PHDR_GLB.city_name,PHDR_GLB.zip,PHDR_GLB.zip4,PHDR_GLB.prim_range,PHDR_GLB.prim_name,PHDR_GLB.sec_range, string cln_name := '',string cln_addr := ''}
												 ,self.cln_name := CleanSpaces(left.lname + ' ' + left.fname + ' ' + left.mname + ' ' + left.name_suffix);
												  self.cln_addr := CleanSpaces(left.st + ' ' + left.city_name + ' ' + left.zip + ' '+ left.prim_range + ' ' + left.prim_name + ' ' + left.sec_range);
												  self := left)
												);

// output(PHDR_GLB_slim);

//-------------------
/*
//Address counts:


DID_Addr_pairs := DEDUP(sort(distribute(PHDR_GLB_slim((unsigned6) did > 0),hash(did)), did, -dt_last_seen,-dt_vendor_last_reported, cln_addr, local), did, cln_addr, all,local);

DID_Addr_pairs_segments := JOIN(sort(distribute(DID_Addr_pairs, hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({DID_Addr_pairs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															 ,LEFT OUTER
															);
															 
// output(DID_Addr_pairs_segments);
// output(count(DID_Addr_pairs_segments), named('count_DID_Addr_pairs_segments'));;

//------

//A "good" Address is where ZIP4 is populated
// Good_Addresses_in_PHDR := DEDUP(sort(distribute(DID_Addr_pairs_segments((unsigned6) zip4 > 0), hash(cln_addr)), -dt_vendor_last_reported,cln_addr, local), cln_addr, all,local);

// output(TABLE(Good_Addresses_in_PHDR, {adl_ind, addr_count := count(group)}, adl_ind, few), all, named('Good_Addresses_in_PHDR_by_segment'));

//------

//An "active" Address is where dt_vendor_last_reported is within 6 months of current date
// Active_Addresses_in_PHDR := DEDUP(sort(distribute(Good_Addresses_in_PHDR(ut.MonthsApart((string6) ut.GetDate[1..6] , (string6) dt_vendor_last_reported) <= 6);, hash(cln_addr)), -dt_vendor_last_reported,cln_addr, local), cln_addr, all,local);

// output(Active_Addresses_in_PHDR, named('Active_Addresses_in_PHDR_sample'));
// output(TABLE(Active_Addresses_in_PHDR, {adl_ind, addr_count := count(group)}, adl_ind, few), all, named('Active_Addresses_in_PHDR_by_segment'));

//------

DID_Addr_pairs_with_good_addresses := DID_Addr_pairs_segments((unsigned6) zip4 > 0);

// output(DID_Addr_pairs_with_good_addresses);

DIDs_with_good_addresses := DEDUP(DID_Addr_pairs_with_good_addresses, did, all);
// output(TABLE(DIDs_with_good_addresses, {adl_ind, addr_count := count(group)}, adl_ind, few), all, named('DIDs_with_good_addresses_in_PHDR_by_segment'));


DID_Addr_pairs_with_good_addresses_count := TABLE(DID_Addr_pairs_with_good_addresses, {did, adl_ind, unsigned6 addr_count := count(group)}, did,adl_ind, few);
// output(AVE(DID_Addr_pairs_with_good_addresses_count(adl_ind = 'CORE'), DID_Addr_pairs_with_good_addresses_count.addr_count), named('DIDs_with_good_addresses_avg_CORE'));

//------

DID_Addr_pairs_good_addresses := DID_Addr_pairs_segments((unsigned6) zip4 > 0);


DID_Addr_pairs_with_current_addresses := DID_Addr_pairs_good_addresses(ut.MonthsApart((string6) ut.GetDate[1..6] , (string6) dt_vendor_last_reported) <= 6);

output(DID_Addr_pairs_with_current_addresses);

DIDs_with_current_addresses := DEDUP(DID_Addr_pairs_with_current_addresses, did, all);
output(TABLE(DIDs_with_current_addresses, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('DIDs_with_current_addresses_in_PHDR_by_segment'));


DID_Addr_pairs_with_current_addresses_count := TABLE(DID_Addr_pairs_with_current_addresses, {did, adl_ind, unsigned6 addr_count := count(group)}, did,adl_ind, few);
output(AVE(DID_Addr_pairs_with_current_addresses_count(adl_ind = 'CORE'), DID_Addr_pairs_with_current_addresses_count.addr_count), named('DIDs_with_current_addresses_avg_CORE'));

//------

DID_Addr_pairs_with_historical_addresses := DID_Addr_pairs_good_addresses(ut.MonthsApart((string6) ut.GetDate[1..6] , (string6) dt_vendor_last_reported) > 6);

output(DID_Addr_pairs_with_historical_addresses);

DIDs_with_historical_addresses := DEDUP(DID_Addr_pairs_with_historical_addresses, did, all);
output(TABLE(DIDs_with_historical_addresses, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('DIDs_with_historical_addresses_in_PHDR_by_segment'));


DID_Addr_pairs_with_historical_addresses_count := TABLE(DID_Addr_pairs_with_historical_addresses, {did, adl_ind, unsigned6 addr_count := count(group)}, did,adl_ind, few);
output(AVE(DID_Addr_pairs_with_historical_addresses_count(adl_ind = 'CORE'), DID_Addr_pairs_with_historical_addresses_count.addr_count), named('DIDs_with_historical_addresses_avg_CORE'));
*/
//-------------------
/*
//AKAs counts:
DID_Name_pairs := DEDUP(sort(distribute(PHDR_GLB_slim,hash(did)), did, -dt_last_seen,cln_name, local), did, cln_name, all,local);

DID_Name_pairs_segments := JOIN(sort(distribute(DID_Name_pairs, hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({DID_Name_pairs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);
															 
output(DID_Name_pairs_segments);

DID_Name_pairs_count := TABLE(DID_Name_pairs_segments, {did, adl_ind, unsigned6 name_count := count(group)}, did,adl_ind, few);

output(DID_Name_pairs_segments);
output(DID_Name_pairs_count);

DIDs_with_AKAs := DID_Name_pairs_count(name_count > 1);

output(TABLE(DIDs_with_AKAs, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('PHDR_DIDs_with_AKAs_by_segment'));

output(AVE(DID_Name_pairs_count(adl_ind = 'CORE'), DID_Name_pairs_count.name_count), named('PHDR_avg_number_of_AKAs_CORE'));
*/
//-------------------------------------------------------------------------------------------------------------
/*
IMPORT Header, data_services, ut;

ds_Relatives_Associates := DATASET(data_services.Data_Location.Relatives+'thor_data400::base::relatives',Header.layout_relatives,flat);

Relatives_Associates_current := ds_Relatives_Associates(current_relatives=true);

Associates_only := ds_Relatives_Associates(same_lname <> true);

layout_key_Relatives := 
	RECORD
		unsigned5 person1;
		boolean same_lname;
		unsigned2 number_cohabits;
		integer3 recent_cohabit;
		unsigned5 person2;
		integer2 prim_range;
		unsigned1 zero;
	 END;

key_Relatives := INDEX({unsigned5 person1,boolean same_lname, unsigned2 number_cohabits,integer3 recent_cohabit,unsigned5 person2}, {integer2 prim_range, unsigned1 zero}, ut.foreign_prod+ 'thor_data400::key::relatives_qa');

ds_Relatives_key := PROJECT(key_Relatives, layout_key_Relatives);

//output(ds_Relatives_key);

first_degree_relatives := DEDUP(sort(distribute(ds_Relatives_key, hash(person1)), person1, local), person1, all,local);

first_degree_relatives_segments := JOIN(sort(distribute(first_degree_relatives, hash(person1)), person1, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.person1 = right.did
															 ,transform({first_degree_relatives, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															 ,LEFT OUTER
															 ,skew(1.0)
															);


OUTPUT(TABLE(first_degree_relatives_segments, {adl_ind, did_count := count(group)},adl_ind, few), ALL, named('first_degree_Relatives_by_segment')); 
*/
//-------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------

//LexIDs with a Phone:

PPlus_all_sources := dataset(ut.foreign_prod+'thor_data400::base::phonesplusv2', Phonesplus_v2.Layout_In_Phonesplus.layout_in_common, thor);	//Phonesplus_V2.file_phonesplus_base;
PPlus_Above_Threshold := PPlus_all_sources(confidencescore >= 11);


PPlus_DIDs := DEDUP(PPlus_all_sources((unsigned6) did > 0), did, all);

PPlus_DIDs_segments := JOIN(sort(distribute(PPlus_DIDs((unsigned6) did > 0), hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({PPlus_DIDs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);

// output(TABLE(PPlus_DIDs_segments, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('PhonesPlus_LexIDs_with_WirelessPhone_by_segment'));

//---

PPlus_DIDs_current := DEDUP(PPlus_Above_Threshold((unsigned6) did > 0), did, all);

PPlus_DIDs_current_segments := JOIN(sort(distribute(PPlus_DIDs_current((unsigned6) did > 0), hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({PPlus_DIDs_current, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);

// output(TABLE(PPlus_DIDs_current_segments, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('PhonesPlus_Above_LexIDs_with_WirelessPhone_by_segment'));

//---

DID_Cell_pairs := DEDUP(sort(distribute(PPlus_all_sources,hash(did)), did, -confidencescore, cellphone, local), did, cellphone, all,local);

DID_Cell_pairs_segments := JOIN(sort(distribute(DID_Cell_pairs((unsigned6) did > 0), hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({DID_Cell_pairs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);
															 
// output(DID_Cell_pairs_segments);

DID_cell_pairs_count := TABLE(DID_Cell_pairs_segments, {did, adl_ind, unsigned6 cell_count := count(group)}, did,adl_ind, few);

// output(DID_cell_pairs_count);

DIDs_with_Cells := DID_cell_pairs_count(cell_count > 1);

// output(TABLE(DIDs_with_Cells, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('PPlus_DIDs_with_multipleCells_by_segment'));

// output(AVE(DID_cell_pairs_count(adl_ind = 'CORE'), DID_cell_pairs_count.cell_count), named('PPlus_avg_number_of_CellPhones_CORE'));

//-----

Gong_Master := DATASET(ut.foreign_prod+ 'thor_data400::base::gong_history',Gong.layout_historyaid,thor)(length(trim(phone10))=10 and phone10=stringlib.stringfilter(phone10,'0123456789'));
Gong_Master_current := Gong_Master(current_record_flag='Y');

Gong_DIDs_current := DEDUP(Gong_Master_current((unsigned6) did > 0), did, all);

Gong_DIDs_current_segments := JOIN(sort(distribute(Gong_DIDs_current((unsigned6) did > 0), hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({Gong_DIDs_current, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);

// output(TABLE(Gong_DIDs_current_segments, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Gong_current_LexIDs_with_LandlinePhone_by_segment'));


Gong_DIDs_historical := DEDUP(Gong_Master(current_record_flag <>'Y',(unsigned6) did > 0), did, all);

Gong_DIDs_historical_segments := JOIN(sort(distribute(Gong_DIDs_historical((unsigned6) did > 0), hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({Gong_DIDs_historical, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);

// output(TABLE(Gong_DIDs_historical_segments, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Gong_historical_LexIDs_with_LandlinePhone_by_segment'));


DID_gong_pairs := DEDUP(sort(distribute(Gong_Master((unsigned6) did > 0),hash(did)), did, -current_record_flag, phone10, local), did, phone10, all,local);

DID_gong_pairs_segments := JOIN(sort(distribute(DID_gong_pairs, hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({DID_gong_pairs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);
															 
output(DID_gong_pairs_segments);

//------


DID_gong_pairs_count := TABLE(DID_gong_pairs_segments, {did, adl_ind, unsigned6 gong_count := count(group)}, did,adl_ind, few);

output(DID_gong_pairs_count);
count(DID_gong_pairs_count);

DIDs_with_gongs := DID_gong_pairs_count(gong_count > 1);

output(TABLE(DIDs_with_gongs, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('GongMaster_DIDs_with_multiplegongs_by_segment'));

output(AVE(DID_gong_pairs_count(adl_ind = 'CORE'), DID_gong_pairs_count.gong_count), named('GongMaster_avg_number_of_gongPhones_CORE'));

//------

all_Phones_current := PROJECT(DID_Cell_pairs_segments(confidencescore >= 11), transform({string adl_ind, unsigned6 DID, string10 phone}, self.adl_ind := left.adl_ind; self.DID := left.DID; self.phone := left.Cellphone; self := left))
											+
											PROJECT(DID_gong_pairs_segments(current_record_flag = 'Y'), transform({string adl_ind, unsigned6 DID, string10 phone}, self.adl_ind := left.adl_ind; self.DID := left.DID; self.phone := left.phone10; self := left))
											;
							
all_Phone_current_pairs := DEDUP(sort(distribute(all_Phones_current, hash(DID)), adl_ind, DID, phone, local), adl_ind, DID, phone, all,local);


all_Phone_DIDs := DEDUP(all_Phone_current_pairs, DID, all);
output(TABLE(all_Phone_DIDs, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('All_Phones_LexIDs_by_segment'));


all_Phone_current_pairs_count := TABLE(all_Phone_current_pairs, {adl_ind, did, unsigned6 phone_count := count(group)}, adl_ind,did, few);
output(AVE(all_Phone_current_pairs_count(adl_ind = 'CORE'), all_Phone_current_pairs_count.phone_count), named('all_Phone_current_pairs_avg_number_of_Phones_CORE'));

DIDs_with_multiple_Phones := all_Phone_current_pairs_count(phone_count > 1);
output(TABLE(DIDs_with_multiple_Phones, {adl_ind, did_count := count(group)}, adl_ind, few), named('DIDs_with_multiple_phones_by_segment'));


//-------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------
/*
//LexIDs with a DL:

File_DL2_Base := dataset(ut.foreign_prod+'~thor_200::base::dl2::drvlic', 
                         DriversV2.Layout_DL_Extended, THOR);

											 

DL_DIDs := DEDUP(File_DL2_Base((unsigned6) did > 0, source_code <> 'CY'), did, all);

DL_DIDs_segments := JOIN(sort(distribute(DL_DIDs, hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({DL_DIDs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);

output(TABLE(DL_DIDs_segments, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('DriversV2_LexIDs_with_DL_by_segment'));
*/
//-------------------------------------------------------------------------------------------------------------

//LexIDs with a Vehicle:

// VehV2_Party := DATASET(ut.foreign_prod+'~thor_data400::base::VehicleV2::party',
							// VehicleV2.Layout_Base.Party_Bip, FLAT, __COMPRESSED__);

//output(TABLE(VehV2_Party, {source_code, counted := count(group)}, source_code, few), all);

/*
VIN_DIDs := DEDUP(VehV2_Party((unsigned6) append_did > 0, source_code in ['AE','DI'], Orig_Party_Type = 'I', Orig_Name_Type = '1'), append_did, all);

VIN_DIDs_segments := JOIN(sort(distribute(VIN_DIDs, hash(append_did)), append_did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.append_did = right.did
															 ,transform({VIN_DIDs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);

output(TABLE(VIN_DIDs_segments, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('VehicleV2_LexIDs_with_VIN_by_segment'));
*/
//------
/*
DID_VIN_pairs := DEDUP(sort(distribute(VehV2_Party((unsigned6) append_did > 0, source_code in ['AE','DI'], Orig_Party_Type = 'I', Orig_Name_Type = '1')
																			,hash(append_did))
														, append_did, -date_last_seen,vehicle_key, local)
											 ,append_did, vehicle_key, all,local);

DID_VIN_pairs_segments := JOIN(sort(distribute(DID_VIN_pairs, hash(append_did)), append_did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.append_did = right.did
															 ,transform({DID_VIN_pairs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);
															 
output(DID_VIN_pairs_segments);

DID_VIN_pairs_count := TABLE(DID_VIN_pairs_segments, {append_did, adl_ind, unsigned6 VIN_count := count(group)}, append_did,adl_ind, few);

output(DID_VIN_pairs_segments);
output(DID_VIN_pairs_count);

DIDs_with_multiple_VINs := DID_VIN_pairs_count(VIN_count > 1);

output(TABLE(DIDs_with_multiple_VINs, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('VehicleV2_LexIDs_with_multiple_VINs_by_segment'));

output(AVE(DID_VIN_pairs_count(adl_ind = 'CORE'), DID_VIN_pairs_count.VIN_count), named('VehicleV2_avg_number_of_VINs_CORE'));
*/
//-------------------------------------------------------------------------------------------------------------
/*
//Death Master:
ds_DeathMaster_V3_SSA_base 		:= DATASET(ut.foreign_prod+'~thor_data400::base::did_death_masterv3_ssa', Header.Layout_Did_Death_MasterV3, THOR);

//output(TABLE(ds_DeathMaster_V3_SSA_base((unsigned6) filedate >= 20130100), {filedate[1..6], src, death_rec_src, record_count := count(group)},filedate[1..6], src, death_rec_src, few), all);

DeathMaster_DIDs := DEDUP(ds_DeathMaster_V3_SSA_base((unsigned6) did > 0), did, all);

output(count(DeathMaster_DIDs), named('DeathMaster_DIDs'));
*/
//-------------------------------------------------------------------------------------------------------------
/*
//----------  FCRA_EmergesKeys  ----------//

	//-- CONCEALED WEAPONS (CCW) --///
Key_DID_FCRA_doxie_CCW := INDEX({unsigned8 did},eMerges.layout_ccw_out, ut.foreign_prod+'~thor_data400::key::ccw_doxie_did_fcra_qa');

//DID count:
Key_DID_FCRA_CCW_dedup := DEDUP(sort(distribute(Key_DID_FCRA_doxie_CCW(did <> 0), hash(did))
																					,did, local,skew(1.0))
																				,did, all,local);

OUTPUT(COUNT(Key_DID_FCRA_CCW_dedup), named('Key_DID_FCRA_CCW_count'));

	//-- HUNT & FISH --///
Key_DID_FCRA_doxie_HuntFish := INDEX({unsigned8 did},eMerges.layout_Hunters_out, ut.foreign_prod+'~thor_data400::key::hunters_doxie_did_fcra_qa');

//DID count:
Key_DID_FCRA_HuntFish_dedup := DEDUP(sort(distribute(Key_DID_FCRA_doxie_HuntFish(did <> 0), hash(did))
																					,did, local,skew(1.0))
																				,did, all,local);

OUTPUT(COUNT(Key_DID_FCRA_HuntFish_dedup), named('Key_DID_FCRA_HuntFish_count'));
*/
//-------------------------------------------------------------------------------------------------------------
/*
//Key_DID_FCRA_LiensV2 := INDEX(unsigned6 did := (unsigned6)did},{TMSID,RMSID}, ut.foreign_prod+'~thor_data400::key::liensv2::fcra::did_qa');
Key_DID_FCRA_LiensV2 := LiensV2.key_liens_DID_FCRA;

//DID count:
Key_DID_FCRA_LiensV2_dedup := DEDUP(sort(distribute(Key_DID_FCRA_LiensV2(did <> 0), hash(did))
																					,did, local,skew(1.0))
																				,did, all,local);

OUTPUT(COUNT(Key_DID_FCRA_LiensV2_dedup), named('Key_DID_FCRA_LiensV2_count'));
*/
//-------------------------------------------------------------------------------------------------------------
/*
rec_key_FCRA_BKv3 := 
RECORD
  unsigned6 did;
  string50 tmsid;
  string5 court_code;
  string7 case_number;
  unsigned8 __internal_fpos__;
 END;

key_FCRA_BKv3 := INDEX({unsigned6 did},rec_key_FCRA_BKv3, '~thor_data400::key::bankruptcyv3::fcra::20150130::did');

//DID count:
key_FCRA_BKv3_dedup := DEDUP(sort(distribute(key_FCRA_BKv3(did <> 0), hash(did))
																					,did, local,skew(1.0))
																				,did, all,local);

OUTPUT(COUNT(key_FCRA_BKv3_dedup), named('key_FCRA_BKv3_dedup_DID_count'));
*/
//-------------------------------------------------------------------------------------------------------------
/*
//Real Property:

IMPORT LN_PropertyV2, Property, ut;

//Property Search File - same as LN_PropertyV2.File_Search_DID
Prop_Search := DATASET(ut.foreign_prod+'~thor_data400::base::ln_propertyv2::search',
										LN_PropertyV2.Layout_DID_Out, flat);


//DID count from Assessments only:
Tax_dedup := DEDUP(sort(distribute(Prop_Search(ln_fares_id[2] = 'A', source_code in ['BP','OP'], did <> 0), hash(did))
																					,did, local,skew(1.0))
																				,did, all,local);

OUTPUT(COUNT(Tax_dedup), named('Tax_Assr_DID_count'));
*/
//-------------------------------------------------------------------------------------------------------------
	// IMPORT Header, Doxie, watchdog, MDR, UtilFile, Data_Services, ut;

// string CleanSpaces(string s) := stringlib.StringCleanSpaces(s);

//---------

//Count of LexIDs in Person Header
//count Person Header Best file, by header segment:
//watchdog.file_best. "adl_ind" = Header segment
// base_wdog_best := dataset(ut.foreign_prod +	'thor_data400::BASE::Watchdog_best',watchdog.layout_key,flat);
// Key_Watchdog_PHdr_glb := INDEX(base_wdog_best, watchdog.layout_key, ut.foreign_prod+'~thor_data400::key::watchdog_best.did_qa');

//output(TABLE(Key_Watchdog_PHdr_glb, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Best_LexIDs_by_segment'));

//------------------------------------------------
/*
//LexIDs with DOB
LexIDs_with_DOB := Key_Watchdog_PHdr_glb(dob > 0);

//output(TABLE(LexIDs_with_DOB, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Best_LexIDsWith_DOB_by_segment'));

//-----

//LexIDs with SSN
LexIDs_with_SSN := Key_Watchdog_PHdr_glb((unsigned6) ssn > 0);

//output(TABLE(LexIDs_with_SSN, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Best_LexIDsWith_SSN_by_segment'));

//-----

//LexIDs with DOB and SSN
LexIDs_with_DOB_SSN := Key_Watchdog_PHdr_glb(dob > 0, (unsigned6) ssn > 0);

//output(TABLE(LexIDs_with_DOB_SSN, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Best_LexIDsWith_DOB_SSN_by_segment'));
*/
//-----
/*
//Unique Best Addresses
Unique_Best_Addresses := DEDUP(sort(distribute(base_wdog_best, hash(st)), -addr_dt_last_seen, st,city_name,prim_range,prim_name,sec_range, local,skew(1.0)), st,city_name,prim_range,prim_name,sec_range, all,local);

output(Unique_Best_Addresses);
output(TABLE(Unique_Best_Addresses, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Unique_Best_Addresses_by_segment'));
*/
//-------------------------------------------------------------------------------------------------------------
/*
//Person Header:

hdr_prod 			:= DATASET(ut.foreign_prod+'~thor_data400::base::header_prod', Header.layout_header_v2, flat);	//Header.File_Headers;	 no TU sources
hdr_tu_True   := DATASET(ut.foreign_prod+'thor_data400::base::TransunionCred_did',header.Layout_Header, flat);	//Header.file_tn_did; TU True CHdr (TN)
hdr_tu_LNCP  	:= DATASET(ut.foreign_prod+'thor_data400::base::transunion_did',header.Layout_Header, flat);	//Header.File_Transunion_did;		//TU legacy LN/CP (LT, TU)
hdr_TUCS	   	:= DATASET(ut.foreign_prod+'thor_data400::base::tucs_did',header.Layout_Header, flat);	// Header.File_TUCS_did; 

PHDR_GLB    := hdr_prod + hdr_tu_True + hdr_tu_LNCP + hdr_TUCS; 

PHDR_GLB_slim := PROJECT(PHDR_GLB
												 ,TRANSFORM({PHDR_GLB.did, PHDR_GLB.dt_last_seen, PHDR_GLB.dt_vendor_last_reported, PHDR_GLB.src, PHDR_GLB.ssn,PHDR_GLB.dob, PHDR_GLB.lname,PHDR_GLB.fname,PHDR_GLB.mname,PHDR_GLB.name_suffix, PHDR_GLB.st,PHDR_GLB.city_name,PHDR_GLB.zip,PHDR_GLB.zip4,PHDR_GLB.prim_range,PHDR_GLB.prim_name,PHDR_GLB.sec_range, string cln_name := '',string cln_addr := ''}
												 ,self.cln_name := CleanSpaces(left.lname + ' ' + left.fname + ' ' + left.mname + ' ' + left.name_suffix);
												  self.cln_addr := CleanSpaces(left.st + ' ' + left.city_name + ' ' + left.zip + ' '+ left.prim_range + ' ' + left.prim_name + ' ' + left.sec_range);
												  self := left)
												);

output(PHDR_GLB_slim);
*/
//-------------------
/*
//Address counts:


DID_Addr_pairs := DEDUP(sort(distribute(PHDR_GLB_slim((unsigned6) did > 0),hash(did)), did, -dt_last_seen,-dt_vendor_last_reported, cln_addr, local), did, cln_addr, all,local);

DID_Addr_pairs_segments := JOIN(sort(distribute(DID_Addr_pairs, hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({DID_Addr_pairs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															 ,LEFT OUTER
															);
															 
output(DID_Addr_pairs_segments);
output(count(DID_Addr_pairs_segments), named('count_DID_Addr_pairs_segments'));;

//------

//A "good" Address is where ZIP4 is populated
Good_Addresses_in_PHDR := DEDUP(sort(distribute(DID_Addr_pairs_segments((unsigned6) zip4 > 0), hash(cln_addr)), -dt_vendor_last_reported,cln_addr, local), cln_addr, all,local);

output(TABLE(Good_Addresses_in_PHDR, {adl_ind, addr_count := count(group)}, adl_ind, few), all, named('Good_Addresses_in_PHDR_by_segment'));

//------

//An "active" Address is where dt_vendor_last_reported is within 6 months of current date
Active_Addresses_in_PHDR := DEDUP(sort(distribute(Good_Addresses_in_PHDR(ut.MonthsApart((string6) ut.GetDate[1..6] , (string6) dt_vendor_last_reported) <= 6);, hash(cln_addr)), -dt_vendor_last_reported,cln_addr, local), cln_addr, all,local);

output(Active_Addresses_in_PHDR, named('Active_Addresses_in_PHDR_sample'));
output(TABLE(Active_Addresses_in_PHDR, {adl_ind, addr_count := count(group)}, adl_ind, few), all, named('Active_Addresses_in_PHDR_by_segment'));
*/
//------
/*
DID_Addr_pairs_with_good_addresses := DID_Addr_pairs_segments((unsigned6) zip4 > 0);

output(DID_Addr_pairs_with_good_addresses);

DIDs_with_good_addresses := DEDUP(DID_Addr_pairs_with_good_addresses, did, all);
output(TABLE(DIDs_with_good_addresses, {adl_ind, addr_count := count(group)}, adl_ind, few), all, named('DIDs_with_good_addresses_in_PHDR_by_segment'));


DID_Addr_pairs_with_good_addresses_count := TABLE(DID_Addr_pairs_with_good_addresses, {did, adl_ind, unsigned6 addr_count := count(group)}, did,adl_ind, few);
output(AVE(DID_Addr_pairs_with_good_addresses_count(adl_ind = 'CORE'), DID_Addr_pairs_with_good_addresses_count.addr_count), named('DIDs_with_good_addresses_avg_CORE'));
*/
//------
/*
DID_Addr_pairs_good_addresses := DID_Addr_pairs_segments((unsigned6) zip4 > 0);


DID_Addr_pairs_with_current_addresses := DID_Addr_pairs_good_addresses(ut.MonthsApart((string6) ut.GetDate[1..6] , (string6) dt_vendor_last_reported) <= 6);

output(DID_Addr_pairs_with_current_addresses);

DIDs_with_current_addresses := DEDUP(DID_Addr_pairs_with_current_addresses, did, all);
output(TABLE(DIDs_with_current_addresses, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('DIDs_with_current_addresses_in_PHDR_by_segment'));


DID_Addr_pairs_with_current_addresses_count := TABLE(DID_Addr_pairs_with_current_addresses, {did, adl_ind, unsigned6 addr_count := count(group)}, did,adl_ind, few);
output(AVE(DID_Addr_pairs_with_current_addresses_count(adl_ind = 'CORE'), DID_Addr_pairs_with_current_addresses_count.addr_count), named('DIDs_with_current_addresses_avg_CORE'));

//------

DID_Addr_pairs_with_historical_addresses := DID_Addr_pairs_good_addresses(ut.MonthsApart((string6) ut.GetDate[1..6] , (string6) dt_vendor_last_reported) > 6);

output(DID_Addr_pairs_with_historical_addresses);

DIDs_with_historical_addresses := DEDUP(DID_Addr_pairs_with_historical_addresses, did, all);
output(TABLE(DIDs_with_historical_addresses, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('DIDs_with_historical_addresses_in_PHDR_by_segment'));


DID_Addr_pairs_with_historical_addresses_count := TABLE(DID_Addr_pairs_with_historical_addresses, {did, adl_ind, unsigned6 addr_count := count(group)}, did,adl_ind, few);
output(AVE(DID_Addr_pairs_with_historical_addresses_count(adl_ind = 'CORE'), DID_Addr_pairs_with_historical_addresses_count.addr_count), named('DIDs_with_historical_addresses_avg_CORE'));
*/
//-------------------
/*
//AKAs counts:
DID_Name_pairs := DEDUP(sort(distribute(PHDR_GLB_slim,hash(did)), did, -dt_last_seen,cln_name, local), did, cln_name, all,local);

DID_Name_pairs_segments := JOIN(sort(distribute(DID_Name_pairs, hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({DID_Name_pairs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);
															 
output(DID_Name_pairs_segments);

DID_Name_pairs_count := TABLE(DID_Name_pairs_segments, {did, adl_ind, unsigned6 name_count := count(group)}, did,adl_ind, few);

output(DID_Name_pairs_segments);
output(DID_Name_pairs_count);

DIDs_with_AKAs := DID_Name_pairs_count(name_count > 1);

output(TABLE(DIDs_with_AKAs, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('PHDR_DIDs_with_AKAs_by_segment'));

output(AVE(DID_Name_pairs_count(adl_ind = 'CORE'), DID_Name_pairs_count.name_count), named('PHDR_avg_number_of_AKAs_CORE'));
*/
//-------------------------------------------------------------------------------------------------------------
/*
IMPORT Header, data_services, ut;

ds_Relatives_Associates := DATASET(data_services.Data_Location.Relatives+'thor_data400::base::relatives',Header.layout_relatives,flat);

Relatives_Associates_current := ds_Relatives_Associates(current_relatives=true);

Associates_only := ds_Relatives_Associates(same_lname <> true);

layout_key_Relatives := 
	RECORD
		unsigned5 person1;
		boolean same_lname;
		unsigned2 number_cohabits;
		integer3 recent_cohabit;
		unsigned5 person2;
		integer2 prim_range;
		unsigned1 zero;
	 END;

key_Relatives := INDEX({unsigned5 person1,boolean same_lname, unsigned2 number_cohabits,integer3 recent_cohabit,unsigned5 person2}, {integer2 prim_range, unsigned1 zero}, ut.foreign_prod+ '~thor_data400::key::relatives_qa');

ds_Relatives_key := PROJECT(key_Relatives, layout_key_Relatives);

//output(ds_Relatives_key);

first_degree_relatives := DEDUP(sort(distribute(ds_Relatives_key, hash(person1)), person1, local), person1, all,local);

first_degree_relatives_segments := JOIN(sort(distribute(first_degree_relatives, hash(person1)), person1, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.person1 = right.did
															 ,transform({first_degree_relatives, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															 ,LEFT OUTER
															 ,skew(1.0)
															);


OUTPUT(TABLE(first_degree_relatives_segments, {adl_ind, did_count := count(group)},adl_ind, few), ALL, named('first_degree_Relatives_by_segment')); 
*/
//-------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------

//LexIDs with a Phone:

// PPlus_all_sources := dataset(ut.foreign_prod+'thor_data400::base::phonesplusv2', Phonesplus_v2.Layout_In_Phonesplus.layout_in_common, thor);	//Phonesplus_V2.file_phonesplus_base;
// PPlus_Above_Threshold := PPlus_all_sources(confidencescore >= 11);

/*
PPlus_DIDs := DEDUP(PPlus_all_sources((unsigned6) did > 0), did, all);

PPlus_DIDs_segments := JOIN(sort(distribute(PPlus_DIDs((unsigned6) did > 0), hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({PPlus_DIDs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);

output(TABLE(PPlus_DIDs_segments, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('PhonesPlus_LexIDs_with_WirelessPhone_by_segment'));
*/
//---
/*
PPlus_DIDs_current := DEDUP(PPlus_Above_Threshold((unsigned6) did > 0), did, all);

PPlus_DIDs_current_segments := JOIN(sort(distribute(PPlus_DIDs_current((unsigned6) did > 0), hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({PPlus_DIDs_current, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);

output(TABLE(PPlus_DIDs_current_segments, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('PhonesPlus_Above_LexIDs_with_WirelessPhone_by_segment'));
*/
//---
/*
DID_Cell_pairs := DEDUP(sort(distribute(PPlus_all_sources,hash(did)), did, -confidencescore, cellphone, local), did, cellphone, all,local);

DID_Cell_pairs_segments := JOIN(sort(distribute(DID_Cell_pairs((unsigned6) did > 0), hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({DID_Cell_pairs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);
															 
output(DID_Cell_pairs_segments);

DID_cell_pairs_count := TABLE(DID_Cell_pairs_segments, {did, adl_ind, unsigned6 cell_count := count(group)}, did,adl_ind, few);

output(DID_cell_pairs_count);

DIDs_with_Cells := DID_cell_pairs_count(cell_count > 1);

output(TABLE(DIDs_with_Cells, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('PPlus_DIDs_with_multipleCells_by_segment'));

output(AVE(DID_cell_pairs_count(adl_ind = 'CORE'), DID_cell_pairs_count.cell_count), named('PPlus_avg_number_of_CellPhones_CORE'));
*/
//-----

// Gong_Master := DATASET(ut.foreign_prod+ 'thor_data400::base::gong_history',Gong.layout_historyaid,thor)(length(trim(phone10))=10 and phone10=stringlib.stringfilter(phone10,'0123456789'));
// Gong_Master_current := Gong_Master(current_record_flag='Y');
/*
Gong_DIDs_current := DEDUP(Gong_Master_current((unsigned6) did > 0), did, all);

Gong_DIDs_current_segments := JOIN(sort(distribute(Gong_DIDs_current((unsigned6) did > 0), hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({Gong_DIDs_current, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);

output(TABLE(Gong_DIDs_current_segments, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Gong_current_LexIDs_with_LandlinePhone_by_segment'));
*/
/*
Gong_DIDs_historical := DEDUP(Gong_Master(current_record_flag <>'Y',(unsigned6) did > 0), did, all);

Gong_DIDs_historical_segments := JOIN(sort(distribute(Gong_DIDs_historical((unsigned6) did > 0), hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({Gong_DIDs_historical, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);

output(TABLE(Gong_DIDs_historical_segments, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('Gong_historical_LexIDs_with_LandlinePhone_by_segment'));
*/
/*
DID_gong_pairs := DEDUP(sort(distribute(Gong_Master((unsigned6) did > 0),hash(did)), did, -current_record_flag, phone10, local), did, phone10, all,local);

DID_gong_pairs_segments := JOIN(sort(distribute(DID_gong_pairs, hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({DID_gong_pairs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);
															 
output(DID_gong_pairs_segments);

//------


DID_gong_pairs_count := TABLE(DID_gong_pairs_segments, {did, adl_ind, unsigned6 gong_count := count(group)}, did,adl_ind, few);

output(DID_gong_pairs_count);
count(DID_gong_pairs_count);

DIDs_with_gongs := DID_gong_pairs_count(gong_count > 1);

output(TABLE(DIDs_with_gongs, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('GongMaster_DIDs_with_multiplegongs_by_segment'));

output(AVE(DID_gong_pairs_count(adl_ind = 'CORE'), DID_gong_pairs_count.gong_count), named('GongMaster_avg_number_of_gongPhones_CORE'));

//------

all_Phones_current := PROJECT(DID_Cell_pairs_segments(confidencescore >= 11), transform({string adl_ind, unsigned6 DID, string10 phone}, self.adl_ind := left.adl_ind; self.DID := left.DID; self.phone := left.Cellphone; self := left))
											+
											PROJECT(DID_gong_pairs_segments(current_record_flag = 'Y'), transform({string adl_ind, unsigned6 DID, string10 phone}, self.adl_ind := left.adl_ind; self.DID := left.DID; self.phone := left.phone10; self := left))
											;
							
all_Phone_current_pairs := DEDUP(sort(distribute(all_Phones_current, hash(DID)), adl_ind, DID, phone, local), adl_ind, DID, phone, all,local);


all_Phone_DIDs := DEDUP(all_Phone_current_pairs, DID, all);
output(TABLE(all_Phone_DIDs, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('All_Phones_LexIDs_by_segment'));


all_Phone_current_pairs_count := TABLE(all_Phone_current_pairs, {adl_ind, did, unsigned6 phone_count := count(group)}, adl_ind,did, few);
output(AVE(all_Phone_current_pairs_count(adl_ind = 'CORE'), all_Phone_current_pairs_count.phone_count), named('all_Phone_current_pairs_avg_number_of_Phones_CORE'));

DIDs_with_multiple_Phones := all_Phone_current_pairs_count(phone_count > 1);
output(TABLE(DIDs_with_multiple_Phones, {adl_ind, did_count := count(group)}, adl_ind, few), named('DIDs_with_multiple_phones_by_segment'));

*/
//-------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------
/*
//LexIDs with a DL:

File_DL2_Base := dataset(ut.foreign_prod+'~thor_200::base::dl2::drvlic', 
                         DriversV2.Layout_DL_Extended, THOR);

											 

DL_DIDs := DEDUP(File_DL2_Base((unsigned6) did > 0, source_code <> 'CY'), did, all);

DL_DIDs_segments := JOIN(sort(distribute(DL_DIDs, hash(did)), did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.did = right.did
															 ,transform({DL_DIDs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);

output(TABLE(DL_DIDs_segments, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('DriversV2_LexIDs_with_DL_by_segment'));
*/
//-------------------------------------------------------------------------------------------------------------

//LexIDs with a Vehicle:

// VehV2_Party := DATASET(ut.foreign_prod+'~thor_data400::base::VehicleV2::party',
							// VehicleV2.Layout_Base.Party_Bip, FLAT, __COMPRESSED__);

//output(TABLE(VehV2_Party, {source_code, counted := count(group)}, source_code, few), all);

/*
VIN_DIDs := DEDUP(VehV2_Party((unsigned6) append_did > 0, source_code in ['AE','DI'], Orig_Party_Type = 'I', Orig_Name_Type = '1'), append_did, all);

VIN_DIDs_segments := JOIN(sort(distribute(VIN_DIDs, hash(append_did)), append_did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.append_did = right.did
															 ,transform({VIN_DIDs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);

output(TABLE(VIN_DIDs_segments, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('VehicleV2_LexIDs_with_VIN_by_segment'));
*/
//------
/*
DID_VIN_pairs := DEDUP(sort(distribute(VehV2_Party((unsigned6) append_did > 0, source_code in ['AE','DI'], Orig_Party_Type = 'I', Orig_Name_Type = '1')
																			,hash(append_did))
														, append_did, -date_last_seen,vehicle_key, local)
											 ,append_did, vehicle_key, all,local);

DID_VIN_pairs_segments := JOIN(sort(distribute(DID_VIN_pairs, hash(append_did)), append_did, local,skew(1.0))
															 ,sort(distribute(base_wdog_best, hash(did)), did, local,skew(1.0))
															 ,left.append_did = right.did
															 ,transform({DID_VIN_pairs, STRING10 adl_ind}, self.adl_ind := right.adl_ind; self := left)
															);
															 
output(DID_VIN_pairs_segments);

DID_VIN_pairs_count := TABLE(DID_VIN_pairs_segments, {append_did, adl_ind, unsigned6 VIN_count := count(group)}, append_did,adl_ind, few);

output(DID_VIN_pairs_segments);
output(DID_VIN_pairs_count);

DIDs_with_multiple_VINs := DID_VIN_pairs_count(VIN_count > 1);

output(TABLE(DIDs_with_multiple_VINs, {adl_ind, did_count := count(group)}, adl_ind, few), all, named('VehicleV2_LexIDs_with_multiple_VINs_by_segment'));

output(AVE(DID_VIN_pairs_count(adl_ind = 'CORE'), DID_VIN_pairs_count.VIN_count), named('VehicleV2_avg_number_of_VINs_CORE'));
*/
//-------------------------------------------------------------------------------------------------------------
/*
//Death Master:
ds_DeathMaster_V3_SSA_base 		:= DATASET(ut.foreign_prod+'~thor_data400::base::did_death_masterv3_ssa', Header.Layout_Did_Death_MasterV3, THOR);

//output(TABLE(ds_DeathMaster_V3_SSA_base((unsigned6) filedate >= 20130100), {filedate[1..6], src, death_rec_src, record_count := count(group)},filedate[1..6], src, death_rec_src, few), all);

DeathMaster_DIDs := DEDUP(ds_DeathMaster_V3_SSA_base((unsigned6) did > 0), did, all);

output(count(DeathMaster_DIDs), named('DeathMaster_DIDs'));
*/
//-------------------------------------------------------------------------------------------------------------
/*
//----------  FCRA_EmergesKeys  ----------//

	//-- CONCEALED WEAPONS (CCW) --///
Key_DID_FCRA_doxie_CCW := INDEX({unsigned8 did},eMerges.layout_ccw_out, ut.foreign_prod+'~thor_data400::key::ccw_doxie_did_fcra_qa');

//DID count:
Key_DID_FCRA_CCW_dedup := DEDUP(sort(distribute(Key_DID_FCRA_doxie_CCW(did <> 0), hash(did))
																					,did, local,skew(1.0))
																				,did, all,local);

OUTPUT(COUNT(Key_DID_FCRA_CCW_dedup), named('Key_DID_FCRA_CCW_count'));

	//-- HUNT & FISH --///
Key_DID_FCRA_doxie_HuntFish := INDEX({unsigned8 did},eMerges.layout_Hunters_out, ut.foreign_prod+'~thor_data400::key::hunters_doxie_did_fcra_qa');

//DID count:
Key_DID_FCRA_HuntFish_dedup := DEDUP(sort(distribute(Key_DID_FCRA_doxie_HuntFish(did <> 0), hash(did))
																					,did, local,skew(1.0))
																				,did, all,local);

OUTPUT(COUNT(Key_DID_FCRA_HuntFish_dedup), named('Key_DID_FCRA_HuntFish_count'));
*/
//-------------------------------------------------------------------------------------------------------------
/*
//Key_DID_FCRA_LiensV2 := INDEX(unsigned6 did := (unsigned6)did},{TMSID,RMSID}, ut.foreign_prod+'~thor_data400::key::liensv2::fcra::did_qa');
Key_DID_FCRA_LiensV2 := LiensV2.key_liens_DID_FCRA;

//DID count:
Key_DID_FCRA_LiensV2_dedup := DEDUP(sort(distribute(Key_DID_FCRA_LiensV2(did <> 0), hash(did))
																					,did, local,skew(1.0))
																				,did, all,local);

OUTPUT(COUNT(Key_DID_FCRA_LiensV2_dedup), named('Key_DID_FCRA_LiensV2_count'));
*/
//-------------------------------------------------------------------------------------------------------------
/*
rec_key_FCRA_BKv3 := 
RECORD
  unsigned6 did;
  string50 tmsid;
  string5 court_code;
  string7 case_number;
  unsigned8 __internal_fpos__;
 END;

key_FCRA_BKv3 := INDEX({unsigned6 did},rec_key_FCRA_BKv3, '~thor_data400::key::bankruptcyv3::fcra::20150130::did');

//DID count:
key_FCRA_BKv3_dedup := DEDUP(sort(distribute(key_FCRA_BKv3(did <> 0), hash(did))
																					,did, local,skew(1.0))
																				,did, all,local);

OUTPUT(COUNT(key_FCRA_BKv3_dedup), named('key_FCRA_BKv3_dedup_DID_count'));
*/
//-------------------------------------------------------------------------------------------------------------
/*
//Real Property:

IMPORT LN_PropertyV2, Property, ut;

//Property Search File - same as LN_PropertyV2.File_Search_DID
Prop_Search := DATASET(ut.foreign_prod+'~thor_data400::base::ln_propertyv2::search',
										LN_PropertyV2.Layout_DID_Out, flat);


//DID count from Assessments only:
Tax_dedup := DEDUP(sort(distribute(Prop_Search(ln_fares_id[2] = 'A', source_code in ['BP','OP'], did <> 0), hash(did))
																					,did, local,skew(1.0))
																				,did, all,local);

OUTPUT(COUNT(Tax_dedup), named('Tax_Assr_DID_count'));
*/
//-------------------------------------------------------------------------------------------------------------
