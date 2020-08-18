
import $, BatchShare, ffd, liensv2, DeferredTask;

layout_main_raw  := liensv2.Layout_liens_main_module.layout_liens_main;
layout_party_raw := liensv2.Layout_liens_party;
layout_dte_case  := DeferredTask.Layouts.CaseLayout;
layout_dte_party := DeferredTask.Layouts.PartiesLayout;

export layout_liens_retrieval := module

 export search_recs := record
   unsigned6 did;
   layout_main_raw.tmsid;
   layout_main_raw.rmsid;
   layout_main_raw.AgencyID;
   layout_main_raw.agency;
   layout_main_raw.agency_county;
   layout_main_raw.agency_state;
   layout_main_raw.case_number;
   layout_main_raw.Filing_Type_ID;
   layout_main_raw.filing_type_desc;
   layout_main_raw.filing_jurisdiction;
   layout_main_raw.filing_number;
   layout_main_raw.filing_book;
   layout_main_raw.filing_page;
   layout_main_raw.filing_date;
   layout_main_raw.orig_filing_date;
   layout_main_raw.persistent_record_id;
   layout_main_raw.orig_rmsid;
   layout_main_raw.release_date;
   layout_main_raw.amount;
   layout_party_raw.title;
   layout_party_raw.fname;
   layout_party_raw.mname;
   layout_party_raw.lname;
   layout_party_raw.name_suffix;
   layout_party_raw.ssn;
   layout_party_raw.name_type;
   layout_party_raw.orig_full_debtorname;
   layout_party_raw.orig_name;
   layout_party_raw.orig_lname;
   layout_party_raw.orig_fname;
   layout_party_raw.orig_mname;
   layout_party_raw.orig_suffix;
   layout_party_raw.orig_address1;
   layout_party_raw.orig_address2;
   layout_party_raw.prim_range;
   layout_party_raw.predir;
   layout_party_raw.prim_name;
   layout_party_raw.addr_suffix;
   layout_party_raw.postdir;
   layout_party_raw.unit_desig;
   layout_party_raw.sec_range;
   layout_party_raw.p_city_name;
   layout_party_raw.st;
   layout_party_raw.zip;
   layout_party_raw.zip4;

   // for both main and debtor records
   boolean isDisputed := false;
   dataset(FFD.Layouts.StatementIdRec) StatementIds := dataset([],FFD.Layouts.StatementIdRec);
 end;

 export layout_workrec := record
  BatchShare.Layouts.ShareDid;
  BatchShare.Layouts.ShareAcct;
  BatchShare.Layouts.ShareName;
	BatchShare.Layouts.SharePII;
	BatchShare.Layouts.ShareAddress;
  layout_dte_party.ReleaseDate;
  layout_dte_party.FilingTypeId;
  layout_dte_party.Amount;
  boolean isOKCSuccess := false;
  integer error_code := 0;
 end;

 export final_rec := record

  unsigned6 did;
  layout_party_raw.fname;
  layout_party_raw.mname;
  layout_party_raw.lname;
  layout_party_raw.name_suffix;
  layout_party_raw.ssn;
  layout_party_raw.orig_address1;
  layout_party_raw.prim_range;
  layout_party_raw.predir;
  layout_party_raw.prim_name;
  layout_party_raw.addr_suffix;
  layout_party_raw.postdir;
  layout_party_raw.unit_desig;
  layout_party_raw.sec_range;
  layout_party_raw.p_city_name;
  layout_party_raw.st;
  layout_party_raw.zip;
  layout_party_raw.zip4;
  layout_main_raw.release_date;
  layout_main_raw.Filing_Type_ID;
  layout_main_raw.amount;
  layout_main_raw.filing_date;
  boolean isOKCSuccess := false;
  boolean isDisputed := false;
  dataset(FFD.Layouts.StatementIdRec) StatementIds := dataset([],FFD.Layouts.StatementIdRec);
  string error_code := '';
  string error_desc := '';
 end;



end;

