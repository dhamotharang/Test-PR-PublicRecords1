//EXPORT file_liens_main_id := 'todo';
import liensv2;

key_in := liensv2.key_liens_main_ID_FCRA;



layout_out := RECORD
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
  unsigned8 persistent_record_id;
  //DATASET(layout_filing_status) filing_status;
	 string filing_status;
   string filing_status_desc;

  //unsigned8 __internal_fpos__;
 END;




 layout_out makekey (key_in  l) := transform
self.tmsid:=	l.tmsid;
self.rmsid:=	l.rmsid;
self.process_date:=	l.process_date;
self.record_code:=	l.record_code;
self.date_vendor_removed:=	l.date_vendor_removed;
self.filing_jurisdiction:=	l.filing_jurisdiction;
self.filing_state:=	l.filing_state;
self.orig_filing_number:=	l.orig_filing_number;
self.orig_filing_type:=	l.orig_filing_type;
self.orig_filing_date:=	l.orig_filing_date;
self.orig_filing_time:=	l.orig_filing_time;
self.case_number:=	l.case_number;
self.filing_number:=	l.filing_number;
self.filing_type_desc:=	l.filing_type_desc;
self.filing_date:=	l.filing_date;
self.filing_time:=	l.filing_time;
self.vendor_entry_date:=	l.vendor_entry_date;
self.judge:=	l.judge;
self.case_title:=	l.case_title;
self.filing_book:=	l.filing_book;
self.filing_page:=	l.filing_page;
self.release_date:=	l.release_date;
self.amount:=	l.amount;
self.eviction:=	l.eviction;
self.satisifaction_type:=	l.satisifaction_type;
self.judg_satisfied_date:=	l.judg_satisfied_date;
self.judg_vacated_date:=	l.judg_vacated_date;
self.tax_code:=	l.tax_code;
self.irs_serial_number:=	l.irs_serial_number;
self.effective_date:=	l.effective_date;
self.lapse_date:=	l.lapse_date;
self.accident_date:=	l.accident_date;
self.sherrif_indc:=	l.sherrif_indc;
self.expiration_date:=	l.expiration_date;
self.agency:=	l.agency;
self.agency_city:=	l.agency_city;
self.agency_state:=	l.agency_state;
self.agency_county:=	l.agency_county;
self.legal_lot:=	l.legal_lot;
self.legal_block:=	l.legal_block;
self.legal_borough:=	l.legal_borough;
self.certificate_number:=	l.certificate_number;
self.persistent_record_id:=	l.persistent_record_id;
self.filing_status:=	l.filing_status.filing_status;
self.filing_status_desc:=	l.filing_status.filing_status_desc;
//self.__internal_fpos__:=	l.__internal_fpos__;
//self.__internal_fpos__:=	l.__internal_fpos__;

end;

export file_liens_main_id := project(key_in,makekey(left));
//output(file_liens_main_id);
