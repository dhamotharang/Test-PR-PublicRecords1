IMPORT ut,doxie;

EXPORT bankruptcy_records_prs(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

br := doxie_cbrs.bankruptcy_records(bdids);

rec := RECORD , MAXLENGTH(200000)
  INTEGER penalt := 0;
  STRING20 filer_type_mapped;
  STRING20 court_state;
  STRING1 source;
  STRING5 court_code;
  STRING7 case_number;
  STRING25 orig_case_number;
  STRING12 id;
  STRING10 seq_number;
  STRING8 date_created;
  STRING8 date_modified;
  STRING50 court_name;
  STRING40 court_location;
  STRING8 case_closing_date;
  STRING3 chapter;
  STRING10 orig_filing_type;
  STRING12 filing_status;
  STRING3 orig_chapter;
  STRING8 orig_filing_date;
  STRING3 corp_flag;
  STRING8 meeting_date;
  STRING8 meeting_time;
  STRING90 address_341;
  STRING8 claims_deadline;
  STRING8 complaint_deadline;
  STRING8 disposed_date;
  STRING35 disposition;
  STRING8 converted_date;
  STRING8 reopen_date;
  STRING35 judge_name;
  STRING128 record_type;
  STRING8 date_filed;
  STRING5 assets_no_asset_indicator;
  STRING1 filing_type;
  STRING1 filer_type;
  STRING3 pro_se_ind;
  STRING5 judges_identification;
  STRING55 attorney_name;
  STRING10 attorney_phone;
  STRING65 attorney_company;
  STRING60 attorney_address1;
  STRING60 attorney_address2;
  STRING25 attorney_city;
  STRING2 attorney_st;
  STRING5 attorney_zip;
  STRING4 attorney_zip4;
  STRING55 attorney2_name;
  STRING10 attorney2_phone;
  STRING65 attorney2_company;
  STRING60 attorney2_address1;
  STRING60 attorney2_address2;
  STRING25 attorney2_city;
  STRING2 attorney2_st;
  STRING5 attorney2_zip;
  STRING4 attorney2_zip4;
  DATASET(doxie.layout_bk_child) debtor_records;
  BOOLEAN SelfRepresented; //to match accurint
  BOOLEAN AssetsForUnsecured;
END;

doxie.layout_bk_child tra0(doxie.layout_bk_child l) := TRANSFORM
  SELF.names := l.names(debtor_company <> '' AND debtor_fname = '' AND debtor_lname ='');
  SELF.debtor_ssn := '';
  SELF := l;
END;

//slim down and pull out person debtor info
rec tra(br l) := TRANSFORM
  SELF.debtor_records :=
    IF(doxie_cbrs.stored_ShowPersonalData_value,
       l.debtor_records,
       PROJECT(l.debtor_records((INTEGER)debtor_did = 0), tra0(LEFT)));
  SELF := l;
END;

brslim := PROJECT(br, tra(LEFT));

RETURN brslim;
END;
