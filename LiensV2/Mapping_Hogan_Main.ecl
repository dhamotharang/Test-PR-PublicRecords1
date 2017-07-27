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

import LiensV2, address;

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
file_deletes := file_flat(ADDDELFLAG = 'D') ;


// FULL FILE 

Full_hogan_Main_nondist := dataset('~thor_data400::base::liens::main::hogan',liensv2.layout_liens_main_module_for_hogan.layout_liens_main,thor);

liensv2.Layout_liens_main_module_for_hogan.layout_liens_main tjoin(Full_hogan_Main_nondist  L, file_deletes  R) := transform

self := L ;
end;

// REMOVE DELETES FROM MAIN BASE FILE

Full_hogan_remove_Delete:= join(Full_hogan_Main_nondist, file_deletes , left.orig_rmsid = right.orig_rmsid and left.tmsid = right.tmsid,
                                                                  tjoin(left,right),left only);

// TRANSFORM UPDATES TO MAIN FILE LAYOUT

liensv2.Layout_liens_main_module_for_hogan.layout_liens_main  treformat(rec_temp L) := transform  
self := L; 
end ; 

file_update := distribute(project(file_flat, treformat(left)),hash(tmsid));

Full_hogan_Main := distribute(Full_hogan_remove_Delete,hash(tmsid));


// Add Full File and Daily file (distributed)

daily_plus_full := Full_hogan_Main +  file_update;

// Sort and rollup full file (local)

full_sort := sort(daily_plus_full,record,except process_date,orig_filing_time,local);


liensv2.Layout_liens_main_module_for_hogan.layout_liens_main tmakechildren(liensv2.Layout_liens_main_module_for_hogan.layout_liens_main L, liensv2.Layout_liens_main_module_for_hogan.layout_liens_main R) := transform

self.filing_status := L.filing_status + row({r.filing_status[1].filing_status, r.filing_status[1].filing_status_desc},liensv2.Layout_liens_main_module_for_hogan.layout_filing_status);
self := L;
end;

Hogan_main_out := rollup(full_sort, tmsid +rmsid+record_code+date_vendor_removed+ filing_jurisdiction+filing_state+orig_filing_number+orig_filing_type+ 
                              orig_filing_date+orig_filing_time + case_number+filing_number+filing_type_desc+ filing_date + filing_time+ vendor_entry_date+judge+case_title+ 
							  filing_book+filing_page+release_date+amount+eviction+satisifaction_type+judg_satisfied_date+judg_vacated_date+tax_code+irs_serial_number+effective_date+
							  lapse_date+accident_date+sherrif_indc+expiration_date+agency+agency_city+agency_state+agency_county+legal_lot+legal_block+legal_borough+certificate_number, tmakechildren(left, right), local);

export mapping_Hogan_main:= Hogan_main_out;

