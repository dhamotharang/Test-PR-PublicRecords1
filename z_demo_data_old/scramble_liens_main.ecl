import _control,liensv2;

// read these foreign for now, copy to demo doesn't work, layout disagreement --force ignore probably would fix it??

// fver := '20081113';

liensv2__layout_filing_status := RECORD
,maxLength(10000)
   string filing_status;
   string filing_status_desc;
  END;

local_main_layout := RECORD
,maxLength(32766)
  string50 tmsid;
  string50 rmsid;
  string process_date;
  string record_code;
  string date_vendor_removed;
  string filing_jurisdiction;
  string filing_state;
  string20 orig_filing_number;
  string orig_filing_type;
  string orig_filing_date;
  string orig_filing_time;
  string case_number;
  string20 filing_number;
  string filing_type_desc;
  string filing_date;
  string filing_time;
  string vendor_entry_date;
  string judge;
  string case_title;
  string filing_book;
  string filing_page;
  string release_date;
  string amount;
  string eviction;
  string satisifaction_type;
  string judg_satisfied_date;
  string judg_vacated_date;
  string tax_code;
  string irs_serial_number;
  string effective_date;
  string lapse_date;
  string accident_date;
  string sherrif_indc;
  string expiration_date;
  string agency;
  string agency_city;
  string agency_state;
  string agency_county;
  string legal_lot;
  string legal_block;
  string legal_borough;
  string certificate_number;
  DATASET(liensv2__layout_filing_status) filing_status;
 END;


//file_in:= dataset('~foreign::'+_control.IPAddress.prod_thor_dali+'::'+'~thor_200::base::demo_data_file_liens_main20080923a', LiensV2.layout_liens_main_module_for_hogan.layout_liens_main,thor);
// file_in:= dataset('~foreign::'+_control.IPAddress.prod_thor_dali+'::'+'~thor_200::base::demo_data_file_liens_main' +fver, local_main_layout,thor);
file_in:= dataset('~thor::base::demo_data_file_liens_main_prodcopy', local_main_layout,thor);

file_in to_scramble(file_in l) := transform
self.date_vendor_removed := fn_scramblepii('DOB',l.date_vendor_removed);
self.orig_filing_number := stringlib.stringfindreplace(stringlib.stringfindreplace(l.orig_filing_number,'1','3'),'2','4');
self.orig_filing_date := fn_scramblepii('DOB',l.orig_filing_date);
self.case_number:=stringlib.stringfindreplace(stringlib.stringfindreplace(l.case_number,'1','3'),'2','4');
self.filing_number:=stringlib.stringfindreplace(stringlib.stringfindreplace(l.filing_number,'1','3'),'2','4');
self.filing_date := fn_scramblepii('DOB',l.filing_date);
self.judge:= 'Hangem High';
self.case_title:= '';
self.filing_book:= stringlib.stringfindreplace(stringlib.stringfindreplace(l.filing_book,'1','3'),'2','4');
self.filing_page:= stringlib.stringfindreplace(stringlib.stringfindreplace(l.filing_page,'1','3'),'2','4');;
self.release_date := fn_scramblepii('DOB',l.release_date);
self.judg_satisfied_date := fn_scramblepii('DOB',l.judg_satisfied_date);
self.judg_vacated_date := fn_scramblepii('DOB',l.judg_vacated_date);
self.irs_serial_number := stringlib.stringfindreplace(stringlib.stringfindreplace(l.irs_serial_number,'1','3'),'2','4');
self.effective_date := fn_scramblepii('DOB',l.effective_date);
self.lapse_date := fn_scramblepii('DOB',l.lapse_date);
self.expiration_date := fn_scramblepii('DOB',l.expiration_date);
self.legal_lot := stringlib.stringfindreplace(stringlib.stringfindreplace(l.legal_lot,'1','3'),'2','4');
self.legal_block := stringlib.stringfindreplace(stringlib.stringfindreplace(l.legal_block,'1','3'),'2','4');
self := l;
end;

export scramble_liens_main := dedup(sort(project(file_in,to_scramble(left)),record),all);
