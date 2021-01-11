
IMPORT $, BatchShare, iesp, ffd, liensv2, DeferredTask;

layout_main_raw := liensv2.Layout_liens_main_module.layout_liens_main;
layout_party_raw := liensv2.Layout_liens_party;
layout_dte_case := DeferredTask.Layouts.CaseLayout;
layout_dte_party := DeferredTask.Layouts.PartiesLayout;

EXPORT layout_liens_retrieval := MODULE

 EXPORT search_recs := RECORD
   UNSIGNED6 did;
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
   BOOLEAN isDisputed := FALSE;
   DATASET(FFD.Layouts.StatementIdRec) StatementIds := DATASET([],FFD.Layouts.StatementIdRec);
 END;

 EXPORT layout_workrec := RECORD
  BatchShare.Layouts.ShareDid;
  BatchShare.Layouts.ShareAcct;
  BatchShare.Layouts.ShareName;
  BatchShare.Layouts.SharePII;
  BatchShare.Layouts.ShareAddress;
  layout_dte_party.ReleaseDate;
  layout_dte_party.FilingTypeId;
  layout_dte_party.Amount;
  BOOLEAN isOKCSuccess := FALSE;
  INTEGER error_code := 0;
 END;

 EXPORT final_rec := RECORD
  UNSIGNED6 did;
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
  BOOLEAN isOKCSuccess := FALSE;
  BOOLEAN isDisputed := FALSE;
  DATASET(FFD.Layouts.StatementIdRec) StatementIds := DATASET([],FFD.Layouts.StatementIdRec);
  STRING error_code := '';
  STRING error_desc := '';
 END;

 // test seed layouts
EXPORT layout_testseed_liens := RECORD
   STRING30 Seq;
   STRING8 DateFiled ;
   STRING2 LienTypeID;
   STRING15 Amount;
   STRING8 ReleaseDate;
   STRING120 Defendant ;
   STRING10 StreetNumber ;
   STRING2 StreetPreDirection ;
   STRING28 StreetName ;
   STRING4 StreetSuffix ;
   STRING2 StreetPostDirection ;
   STRING10 UnitDesignation ;
   STRING8 UnitNumber;
   STRING60 StreetAddress1;
   STRING60 StreetAddress2;
   STRING25 City;
   STRING2 State;
   STRING5 Zip5;
   STRING4 Zip4;
   STRING18 County ;
   STRING9 PostalCode ;
   STRING50 StateCityZip ;
   UNSIGNED ConsumerStatementId;
  END;

 EXPORT layout_testseed_search := RECORD
    STRING12 LexID;
    STRING9 SSN;
    DATASET(layout_testseed_liens) Liens;
    STRING4 Alert1;
    STRING4 Alert2;
    STRING4 Alert3;
    STRING4 Alert4;
    STRING4 Alert5;
    STRING4 Alert6;
    STRING4 Alert7;
    STRING4 Alert8;
    STRING4 Alert9;
    STRING4 Alert10;
    DATASET(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements;
 END;

END;

