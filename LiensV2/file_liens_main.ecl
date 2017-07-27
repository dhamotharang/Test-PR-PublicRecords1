import liensv2,ut;

liensv2.Layout_liens_main_module.layout_liens_main forkey(LiensV2.layout_liens_main_module_for_hogan.layout_liens_main l) :=
transform
self := l;
end;

HOGAN_main := project(LiensV2.file_Hogan_main, forkey(left));

pre_file_liens_main := project((HOGAN_main(tmsid not in Liensv2.Suppress_TMSID)
                        + LiensV2.file_ILFDLN_main(tmsid not in Liensv2.Suppress_TMSID)
						+ LiensV2.file_NYC_main(tmsid not in Liensv2.Suppress_TMSID)
						+ LiensV2.file_NYFDLN_main(tmsid not in Liensv2.Suppress_TMSID)
						+ LiensV2.file_SA_main(tmsid not in Liensv2.Suppress_TMSID)
						+ LiensV2.file_chicago_law_main(tmsid not in Liensv2.Suppress_TMSID)
						+ LiensV2.file_CA_federal_main(tmsid not in Liensv2.Suppress_TMSID)
						+ LiensV2.file_Superior_main(tmsid not in Liensv2.Suppress_TMSID)
            + LiensV2.file_MA_main(tmsid not in Liensv2.Suppress_TMSID)), 
						transform({liensv2.Layout_liens_main_module.layout_liens_main }, 
 self.tmsid :=  ut.fnTrim2Upper(left.tmsid ), 
 self.rmsid :=  ut.fnTrim2Upper(left.rmsid ),
 self. record_code  :=  ut.fnTrim2Upper(left.record_code ),
 self.date_vendor_removed :=  ut.fnTrim2Upper(left.date_vendor_removed ),
 self.filing_jurisdiction :=  ut.fnTrim2Upper(left.filing_jurisdiction ),
 self.filing_state :=  ut.fnTrim2Upper(left.filing_state ),
 self.orig_filing_number:=  ut.fnTrim2Upper(left.orig_filing_number ) ,
 self.orig_filing_type :=  ut.fnTrim2Upper(left.orig_filing_type ),
 self.orig_filing_date :=  ut.fnTrim2Upper(left.orig_filing_date ),
 self.orig_filing_time :=  ut.fnTrim2Upper(left.orig_filing_time ),
 self.case_number  :=  ut.fnTrim2Upper(left.case_number ) ,
 self.filing_number :=  ut.fnTrim2Upper(left.filing_number ),
 self.filing_type_desc :=  ut.fnTrim2Upper(left.filing_type_desc ),
 self.filing_date :=  ut.fnTrim2Upper(left.filing_date ),
 self.filing_time :=  ut.fnTrim2Upper(left.filing_time ),
 self.vendor_entry_date :=  ut.fnTrim2Upper(left.vendor_entry_date ),
 self.judge :=  ut.fnTrim2Upper(left.judge ),
 self.case_title:=  ut.fnTrim2Upper(left.case_title ) ,
 self.filing_book :=  ut.fnTrim2Upper(left.filing_book ),
 self.filing_page :=  ut.fnTrim2Upper(left.filing_page ),
 self.release_date :=  ut.fnTrim2Upper(left.release_date ),
 self.amount:=  ut.fnTrim2Upper(left.amount ) ,
 self.eviction:=  ut.fnTrim2Upper(left.eviction ) ,
 self.satisifaction_type :=  ut.fnTrim2Upper(left.satisifaction_type ),
 self.judg_satisfied_date :=  ut.fnTrim2Upper(left.judg_satisfied_date ),
 self.judg_vacated_date :=  ut.fnTrim2Upper(left.judg_vacated_date ),
 self.tax_code :=  ut.fnTrim2Upper(left.tax_code ),
 self.irs_serial_number:=  ut.fnTrim2Upper(left.irs_serial_number ) ,
 self.effective_date :=  ut.fnTrim2Upper(left.effective_date ),
 self.lapse_date :=  ut.fnTrim2Upper(left.lapse_date ),
 self.accident_date:=  ut.fnTrim2Upper(left.accident_date ) ,
 self.sherrif_indc:=  ut.fnTrim2Upper(left.sherrif_indc ) ,
 self.expiration_date :=  ut.fnTrim2Upper(left.expiration_date ),
 self.agency :=  ut.fnTrim2Upper(left.agency ),
 self.agency_city:=  ut.fnTrim2Upper(left.agency_city ) ,
 self.agency_state :=  ut.fnTrim2Upper(left.agency_state ),
 self.agency_county:=  ut.fnTrim2Upper(left.agency_county ) ,
 self.legal_lot :=  ut.fnTrim2Upper(left.legal_lot ),
 self.legal_block:=  ut.fnTrim2Upper(left.legal_block ) ,
 self.legal_borough:=  ut.fnTrim2Upper(left.legal_borough ) ,
 self.certificate_number:=  ut.fnTrim2Upper(left.certificate_number ), self := left)); 
 
pre_file_liens_main_dedup := dedup(sort(distribute(pre_file_liens_main,hash(tmsid)), 
 tmsid,
 rmsid,
 record_code ,
 date_vendor_removed ,
 filing_jurisdiction ,
 filing_state ,
 orig_filing_number ,
 orig_filing_type ,
 orig_filing_date ,
 orig_filing_time ,
 case_number   ,
 filing_number ,
 filing_type_desc ,
 filing_date ,
 filing_time ,
 vendor_entry_date ,
 judge ,
 case_title ,
 filing_book ,
 filing_page ,
 release_date ,
 amount ,
 eviction ,
 satisifaction_type ,
 judg_satisfied_date ,
 judg_vacated_date ,
 tax_code ,
 irs_serial_number ,
 effective_date ,
 lapse_date ,
 accident_date ,
 sherrif_indc ,
 expiration_date ,
 agency ,
 agency_city ,
 agency_state ,
 agency_county ,
 legal_lot ,
 legal_block ,
 legal_borough ,
 certificate_number ,filing_status[1].filing_status,filing_status[1].filing_status_desc,-process_date,local),record, except process_date,local); 

//Add persistent record id 
Main_puid := project(pre_file_liens_main_dedup , transform({liensv2.Layout_liens_main_module.layout_liens_main} ,

											self.persistent_record_id := 	hash64(  trim(left.tmsid,left,right)+ ','+
																									  trim(left.rmsid,left,right)+  ','+
																									  trim(left.record_code,left,right)+  ','+
																									  trim(left.date_vendor_removed ,left,right)+  ','+
																									  trim(left.filing_jurisdiction,left,right)+  ','+
																									  trim(left.filing_state ,left,right)+  ','+
																									  trim(left.orig_filing_number ,left,right)+  ','+
																									  trim( left.orig_filing_type ,left,right)+  ','+
																										trim( left.orig_filing_date ,left,right)+  ','+
																										trim( left.orig_filing_time ,left,right)+ ','+ 
																										trim( left.case_number   ,left,right)+  ','+
																										trim( left.filing_number ,left,right)+  ','+
																										trim( left.filing_type_desc ,left,right)+  ','+
																										trim( left.filing_date ,left,right)+  ','+
																										trim( left.filing_time ,left,right)+  ','+
																										trim( left.vendor_entry_date ,left,right)+  ','+
																										trim( left.judge ,left,right)+  ','+
																										trim( left.case_title ,left,right)+  ','+
																										trim( left.filing_book ,left,right)+  ','+
																										trim( left.filing_page ,left,right)+  ','+
																										trim( left.release_date ,left,right)+  ','+
																										trim( left.amount ,left,right)+  ','+
																										trim( left.eviction ,left,right)+  ','+
																										trim( left.satisifaction_type ,left,right)+  ','+
																										trim( left.judg_satisfied_date ,left,right)+  ','+
																										trim( left.judg_vacated_date ,left,right)+  ','+
																										trim( left.tax_code ,left,right)+  ','+
																										trim( left.irs_serial_number ,left,right)+  ','+
																										trim( left.effective_date ,left,right)+  ','+
																										trim( left.lapse_date ,left,right)+  ','+
																										trim( left.accident_date ,left,right)+  ','+
																										trim( left.sherrif_indc ,left,right)+  ','+
																										trim( left.expiration_date ,left,right)+  ','+
																										trim( left.agency ,left,right)+  ','+
																										trim( left.agency_city ,left,right)+  ','+
																										trim( left.agency_state ,left,right)+  ','+
																										trim( left.agency_county ,left,right)+  ','+
																										trim( left.legal_lot ,left,right)+  ','+
																										trim( left.legal_block ,left,right)+  ','+
																										trim( left.legal_borough ,left,right)+  ','+
																										trim( left.certificate_number ,left,right)+
																										trim(left.filing_status[1].filing_status ,left,right)+trim(left.filing_status[1].filing_status_desc,left,right)), 

self := left)); 

export file_liens_main := project(Main_puid, 
						transform(liensv2.Layout_liens_main_module.layout_liens_main, 
						self.orig_filing_date := if(left.orig_filing_date <= stringlib.GetDateYYYYMMDD(),left.orig_filing_date, ''),
						self := left))(NOT regexfind('CAALAC1',tmsid)):persist('~thor_data400::Liens::main::PUID');