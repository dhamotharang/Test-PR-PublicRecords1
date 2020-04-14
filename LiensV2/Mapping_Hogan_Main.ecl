//////////////////////////////////////////////////////////////////////////////////////////
// Attribute 	: MAPPING_HOGAN_MAIN

// DEPENDENT ON : liensv2.layout_liens_main_temp,
//				  liensV2.Layout_Liens_temp_base,
//				  liensV2.mapping_hogan,
//				  liensv2.Layout_liens_main_module.layout_liens_main,
//				  liensv2.Layout_liens_main_module.layout_filing_status

// PURPOSE	 	: distribute(tmsid) and sort the mapped main daily Hogan file  
//			      and add to the distributed full file and rollup
//				  the fill file.
//////////////////////////////////////////////////////////////////////////////////////////

import LiensV2, address, Data_Services;

export mapping_Hogan_main := FUNCTION
// Process daily file (distribute, sort and flatten)

liensv2.layout_liens_main_temp tmakemain(liensV2.Layout_Liens_temp_base L) := transform
self.orig_rmsid := l.orig_rmsid;
self.record_code := '';
self := L;

end;

Hogan_main_temp := project(liensV2.mapping_hogan, tmakemain(left));
hogan_main_dist := distribute(hogan_main_temp, hash(tmsid));
hogan_main_temp_sort  := sort(hogan_main_dist, tmsid, rmsid,ADDDELFLAG,record_code,date_vendor_removed, filing_jurisdiction,filing_state, orig_filing_number,orig_filing_type, 
                              -orig_filing_date,orig_filing_time,case_number,filing_number,filing_type_desc, -filing_date,filing_time, -vendor_entry_date,judge,case_title, 
							  filing_book,filing_page,-release_date,amount,eviction,satisifaction_type,judg_satisfied_date,judg_vacated_date,tax_code,irs_serial_number,effective_date,
							  lapse_date,accident_date,sherrif_indc,expiration_date,agency,agency_city,agency_state,agency_county,legal_lot,legal_block,legal_borough,certificate_number,filing_status,filing_status_desc,-process_date,local);

Hogan_main_temp_dedup := dedup(Hogan_main_temp_sort, tmsid, rmsid,ADDDELFLAG,record_code,date_vendor_removed, filing_jurisdiction,filing_state, orig_filing_number,orig_filing_type, 
                              orig_filing_date,orig_filing_time,case_number,filing_number,filing_type_desc, filing_date,filing_time, vendor_entry_date,judge,case_title, 
							  filing_book,filing_page,release_date,amount,eviction,satisifaction_type,judg_satisfied_date,judg_vacated_date,tax_code,irs_serial_number,effective_date,
							  lapse_date,accident_date,sherrif_indc,expiration_date,agency,agency_city,agency_state,agency_county,legal_lot,legal_block,legal_borough,certificate_number,filing_status,filing_status_desc,local);



rec_temp := record
string1 ADDDELFLAG := '';
liensv2.Layout_liens_main_module_for_hogan.layout_liens_main ;
end;

// FORMAT  TO TEMP LAYOUT  WITH FLAG FIELD
rec_temp  tmakefatrecord(liensv2.layout_liens_main_temp L) := transform   

self.filing_status := row(L,liensv2.Layout_liens_main_module.layout_filing_status);
self := L;

end;

// CONTAIN BOTH  'D', UPDATE,ADD records

file_flat := project(hogan_main_temp_dedup, tmakefatrecord(left)); 

//FILTER UPDATE, CHANGE RECORDS

file_adds := file_flat(ADDDELFLAG != 'D');

// FILTER DELETE RECORDS
//file_deletes := DEDUP(SORT(liensV2.mapping_hogan(ADDDELFLAG = 'D'),orig_rmsid),orig_rmsid) ;
file_deletes := fnMainDeletes(LiensV2.file_Hogan_main, LiensV2.file_Hogan_party_full);

// FULL FILE 

Full_hogan_Main_nondist := dataset('~thor_data400::base::liens::main::hogan',liensv2.layout_liens_main_module_for_hogan.layout_liens_main,thor);

// REMOVE DELETES FROM MAIN BASE FILE

Full_hogan_remove_Delete	:=	JOIN(
																	DISTRIBUTE(Full_hogan_Main_nondist,HASH(orig_rmsid)), 
																	DISTRIBUTE(file_deletes(orig_rmsid_main_del <> ''),HASH(orig_rmsid_main_del)),
																	LEFT.orig_rmsid	=	RIGHT.orig_rmsid_main_del AND
																	left.tmsid = right.tmsid,
																	TRANSFORM(LEFT),
																	LEFT ONLY,
																	LOCAL,
																	LOOKUP
																	);

// TRANSFORM UPDATES TO MAIN FILE LAYOUT

liensv2.Layout_liens_main_module_for_hogan.layout_liens_main  treformat(rec_temp L) := transform  
self := L; 
end ; 

file_update := distribute(project(file_adds, treformat(left)),hash(tmsid));

Full_hogan_Main := distribute(Full_hogan_remove_Delete,hash(tmsid));


// Add Full File and Daily file (distributed)

daily_plus_full := Full_hogan_Main +  file_update;

// Sort and rollup full file (local)

// full_sort := sort(daily_plus_full,record,except process_date,orig_filing_time,local);
//VC DF-25909
full_sort := sort(daily_plus_full, 
                  tmsid ,rmsid,record_code,date_vendor_removed, filing_jurisdiction,filing_state,orig_filing_number,orig_filing_type, 
                  orig_filing_date,orig_filing_time , case_number,filing_number,filing_type_desc, filing_date , filing_time, vendor_entry_date,judge,case_title, 
							    filing_book,filing_page,release_date,amount,eviction,satisifaction_type,judg_satisfied_date,judg_vacated_date,tax_code,irs_serial_number,effective_date,
							    lapse_date,accident_date,sherrif_indc,expiration_date,agencyID,agency_state,agency_county,legal_lot,legal_block,legal_borough,certificate_number,-collection_date,-process_date

                ,local);


liensv2.Layout_liens_main_module_for_hogan.layout_liens_main tmakechildren(liensv2.Layout_liens_main_module_for_hogan.layout_liens_main L, liensv2.Layout_liens_main_module_for_hogan.layout_liens_main R) := transform

self.filing_status := L.filing_status + row({r.filing_status[1].filing_status, r.filing_status[1].filing_status_desc},liensv2.Layout_liens_main_module_for_hogan.layout_filing_status);
self := L;
end;

Hogan_main_out := rollup(full_sort, tmsid +rmsid+record_code+date_vendor_removed+ filing_jurisdiction+filing_state+orig_filing_number+orig_filing_type+ 
                              orig_filing_date+orig_filing_time + case_number+filing_number+filing_type_desc+ filing_date + filing_time+ vendor_entry_date+judge+case_title+ 
							  filing_book+filing_page+release_date+amount+eviction+satisifaction_type+judg_satisfied_date+judg_vacated_date+tax_code+irs_serial_number+effective_date+
							  lapse_date+accident_date+sherrif_indc+expiration_date+agencyID+agency_state+agency_county+legal_lot+legal_block+legal_borough+certificate_number, tmakechildren(left, right), local);


full_sort2 := sort(Hogan_main_out,tmsid, rmsid, -process_date, record_code, date_vendor_removed,  filing_jurisdiction, filing_state, orig_filing_number, orig_filing_type,  
                orig_filing_date, orig_filing_time ,  case_number, filing_number, filing_type_desc,  filing_date ,  filing_time,  vendor_entry_date, judge, case_title,  
							  filing_book, filing_page, release_date, amount, eviction, satisifaction_type, judg_satisfied_date, judg_vacated_date, tax_code, irs_serial_number, effective_date, 
							  lapse_date, accident_date, sherrif_indc, expiration_date, agencyID, agency_state, agency_county, legal_lot, legal_block, legal_borough, certificate_number, orig_filing_time,local);

deduprecords := dedup(full_sort2,tmsid, rmsid, record_code, date_vendor_removed,  filing_jurisdiction, filing_state, orig_filing_number, orig_filing_type,  
                orig_filing_date, orig_filing_time ,  case_number, filing_number, filing_type_desc,  filing_date ,  filing_time,  vendor_entry_date, judge, case_title,  
							  filing_book, filing_page, release_date, amount, eviction, satisifaction_type, judg_satisfied_date, judg_vacated_date, tax_code, irs_serial_number, effective_date, 
							  lapse_date, accident_date, sherrif_indc, expiration_date, agencyID, agency_state, agency_county, legal_lot, legal_block, legal_borough, certificate_number,local);

RETURN deduprecords;

END;

