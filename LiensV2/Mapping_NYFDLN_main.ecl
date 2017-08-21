//////////////////////////////////////////////////////////////////////////////////////////
// Attribute 	: MAPPING_NYFDLN_MAIN

// DEPENDENT ON : liensv2.layout_liens_main_temp,
//				  liensV2.Layout_Liens_temp_base,
//				  liensV2.mapping_NYFDLN,
//				  liensv2.Layout_liens_main_module.layout_liens_main,
//				  liensv2.Layout_liens_main_module.layout_filing_status

// PURPOSE	 	: distribute(tmsid) and sort the mapped main daily NYFDLN file  
//			      and add to the distributed full file and rollup
//				  the fill file.
//////////////////////////////////////////////////////////////////////////////////////////

import LiensV2, address;

// Process daily file (distribute, sort and flatten)

liensv2.layout_liens_main_temp tmakemain(liensV2.Layout_Liens_Temp_Base L) := transform

self := L;

end;

NY_main_temp := project(LiensV2.mapping_NYFDLN, tmakemain(left));
NY_main_dist := distribute(NY_main_temp, hash(tmsid));

NY_main_temp_sort  := sort(NY_main_dist, tmsid, rmsid,record_code,date_vendor_removed, filing_jurisdiction,filing_state,orig_filing_number,orig_filing_type, 
                              -orig_filing_date,orig_filing_time,case_number,filing_number,filing_type_desc, -filing_date,filing_time, -vendor_entry_date,judge,case_title, 
							  filing_book,filing_page,-release_date,amount,eviction,satisifaction_type,judg_satisfied_date,judg_vacated_date,tax_code,irs_serial_number,effective_date,
							  lapse_date,accident_date,sherrif_indc,expiration_date,agency,agency_city,agency_state,agency_county,legal_lot,legal_block,legal_borough,filing_status,filing_status_desc,-process_date,local);
							  
liensv2.Layout_liens_main_module.layout_liens_main tmakefatrecord(liensv2.layout_liens_main_temp L) := transform

self.filing_status := row(L,liensv2.Layout_liens_main_module.layout_filing_status);
self := L;

end;

file_flat := project(NY_main_temp_sort, tmakefatrecord(left));

// Full File - distributed (tmsid)

Full_NYFDLN_Main_nondist := dataset('~thor_data400::base::Liens::Main::NYFDLN',liensv2.layout_liens_main_module.layout_liens_main,thor);

Full_NYFDLN_Main := distribute(Full_NYFDLN_Main_nondist,hash(tmsid));

// Add Full File and Daily file (distributed)

daily_plus_full := LiensV2.fAddEvictionFlag(Full_NYFDLN_Main + file_flat);

// Sort and rollup full file (local)

full_sort := sort(daily_plus_full,record,except process_date,orig_filing_time,local);

liensv2.Layout_liens_main_module.layout_liens_main tmakechildren(liensv2.Layout_liens_main_module.layout_liens_main L, liensv2.Layout_liens_main_module.layout_liens_main R) := transform

self.filing_status := L.filing_status + row({r.filing_status[1].filing_status, r.filing_status[1].filing_status_desc},liensv2.Layout_liens_main_module.layout_filing_status);
self := L;
end;

NY_main_out := rollup(full_sort, tmsid +rmsid+record_code+date_vendor_removed+ filing_jurisdiction+filing_state+orig_filing_number+orig_filing_type+ 
                              orig_filing_date+orig_filing_time + case_number+filing_number+filing_type_desc+ filing_date + filing_time+ vendor_entry_date+judge+case_title+ 
							  filing_book+filing_page+release_date+amount+eviction+satisifaction_type+judg_satisfied_date+judg_vacated_date+tax_code+irs_serial_number+effective_date+
							  lapse_date+accident_date+sherrif_indc+expiration_date+agency+agency_city+agency_state+agency_county+legal_lot+legal_block+legal_borough, tmakechildren(left, right), local);



export mapping_NYFDLN_main:= NY_main_out;


