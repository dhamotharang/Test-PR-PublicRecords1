
import LiensV2, address;
// map to layout_liens_main_temp
liensv2.layout_liens_main_temp tmakemain(liensV2.Layout_Liens_temp_base L) := transform

self := L;

end;

SU_main_temp := project(LiensV2.Mapping_Superior_as_hogan, tmakemain(left));
SU_main_dist := distribute(SU_main_temp, hash(tmsid));

SU_main_temp_sort  := sort(SU_main_dist, tmsid, rmsid,ADDDELFLAG,record_code,date_vendor_removed, filing_jurisdiction,filing_state, orig_filing_number,orig_filing_type, 
                              -orig_filing_date,orig_filing_time,case_number,filing_number,filing_type_desc, -filing_date,filing_time, -vendor_entry_date,judge,case_title, 
							  filing_book,filing_page,-release_date,amount,eviction,satisifaction_type,judg_satisfied_date,judg_vacated_date,tax_code,irs_serial_number,effective_date,
							  lapse_date,accident_date,sherrif_indc,expiration_date,agency,agency_city,agency_state,agency_county,legal_lot,legal_block,legal_borough,filing_status,filing_status_desc,-process_date,local);

SU_main_temp_dedup := dedup(SU_main_temp_sort,tmsid, rmsid,ADDDELFLAG,record_code,date_vendor_removed, filing_jurisdiction,filing_state, orig_filing_number,orig_filing_type, 
                              orig_filing_date,orig_filing_time,case_number,filing_number,filing_type_desc, filing_date,filing_time, vendor_entry_date,judge,case_title, 
							  filing_book,filing_page,release_date,amount,eviction,satisifaction_type,judg_satisfied_date,judg_vacated_date,tax_code,irs_serial_number,effective_date,
							  lapse_date,accident_date,sherrif_indc,expiration_date,agency,agency_city,agency_state,agency_county,legal_lot,legal_block,legal_borough,filing_status,filing_status_desc,local);
// Create child filing status 
liensv2.Layout_liens_main_module.layout_liens_main tmakefatrecord(liensv2.layout_liens_main_temp L) := transform

self.filing_status := row(L,liensv2.Layout_liens_main_module.layout_filing_status);
self := L;

end;


file_fat := LiensV2.fAddEvictionFlag(project(SU_main_temp_dedup, tmakefatrecord(left)));

liensv2.Layout_liens_main_module.layout_liens_main tmakechildren(liensv2.Layout_liens_main_module.layout_liens_main L, liensv2.Layout_liens_main_module.layout_liens_main R) := transform

self.filing_status := L.filing_status + row({r.filing_status[1].filing_status, r.filing_status[1].filing_status_desc},liensv2.Layout_liens_main_module.layout_filing_status);
self := L;
end;

SU_main_out := rollup(file_fat, tmsid +rmsid+record_code+date_vendor_removed+ filing_jurisdiction+filing_state+orig_filing_number+orig_filing_type+ 
                              orig_filing_date+orig_filing_time + case_number+filing_number+filing_type_desc+ filing_date + filing_time+ vendor_entry_date+judge+case_title+ 
							  filing_book+filing_page+release_date+amount+eviction+satisifaction_type+judg_satisfied_date+judg_vacated_date+tax_code+irs_serial_number+effective_date+
							  lapse_date+accident_date+sherrif_indc+expiration_date+agency+agency_city+agency_state+agency_county+legal_lot+legal_block+legal_borough, tmakechildren(left, right), local);

export Mapping_Superior_Liens_main:= SU_main_out(record_code <> '');

