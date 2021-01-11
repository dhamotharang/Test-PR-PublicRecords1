matched_party_name_rec := RECORD
    string5 title;
    string20 fname;
    string20 mname;
    string20 lname;
    string5 name_suffix;
    string200 cname;
   END;

matched_party_address_rec := RECORD
    string orig_address1;
    string orig_address2;
    string10 prim_range;
    string2 predir;
    string28 prim_name;
    string4 addr_suffix;
    string2 postdir;
    string10 unit_desig;
    string8 sec_range;
    string25 p_city_name;
    string25 v_city_name;
    string2 st;
    string5 zip;
    string4 zip4;
   END;

matched_party_rec := RECORD
   string1 party_type;
   matched_party_name_rec parsed_party;
   matched_party_address_rec address;
  END;

layout_filing_status := RECORD,maxlength(10000)
   string filing_status;
   string filing_status_desc;
  END;

record__5 := RECORD
    unsigned8 statementid{xpath('StatementId')};
   END;
statementidrec := RECORD(record__5)
   string5 recordtype{xpath('StatementType')};
  END;

layout_lien_party_parsed := RECORD
    string12 did;
    string12 bdid;
    unsigned6 dotid;
    unsigned6 empid;
    unsigned6 powid;
    unsigned6 proxid;
    unsigned6 seleid;
    unsigned6 orgid;
    unsigned6 ultid;
    string9 ssn;
    string9 tax_id;
    string person_filter_id;
    string5 title;
    string20 fname;
    string20 mname;
    string20 lname;
    string5 name_suffix;
    string3 name_score;
    string200 cname;
    boolean hascriminalconviction;
    boolean issexualoffender;
    DATASET(statementidrec) statementids{xpath('StatementIdRecs/StatementIdRec')};
    boolean isdisputed{xpath('IsDisputed')};
   END;

layout_lien_party_phone := RECORD
     string15 phone;
    END;

layout_lien_party_address := RECORD
    string orig_address1;
    string orig_address2;
    string10 prim_range;
    string2 predir;
    string28 prim_name;
    string4 addr_suffix;
    string2 postdir;
    string10 unit_desig;
    string8 sec_range;
    string25 p_city_name;
    string25 v_city_name;
    string2 st;
    string5 zip;
    string4 zip4;
    string5 county;
    string4 msa;
    string18 county_name;
    DATASET(layout_lien_party_phone) phones{maxcount(5)};
   END;

layout_lien_party := RECORD
   string120 orig_name;
   DATASET(layout_lien_party_parsed) parsed_parties{maxcount(10)};
   DATASET(layout_lien_party_address) addresses{maxcount(10)};
   unsigned8 persistent_record_id;
  END;

layout_lien_history := RECORD
   string20 filing_number;
   string50 filing_type_desc;
   string8 orig_filing_date;
   string8 filing_date;
   string10 filing_time;
   string10 filing_book;
   string10 filing_page;
   string60 agency;
   string2 agency_state;
   string35 agency_city;
   string35 agency_county;
   unsigned8 persistent_record_id;
   DATASET(statementidrec) statementids{xpath('StatementIdRecs/StatementIdRec')};
   boolean isdisputed{xpath('IsDisputed')};
  END;

layout := RECORD
  unsigned6 did;
  integer8 fcrapurpose;
  string ln_matchkey;
  integer8 output_seq_no;
  unsigned2 penalt;
  matched_party_rec matched_party;
  string50 tmsid;
  string50 rmsid;
  string50 filing_jurisdiction;
  string21 filing_jurisdiction_name;
  string2 filing_state;
  string20 orig_filing_number;
  string30 orig_filing_type;
  string8 orig_filing_date;
  string10 orig_filing_time;
  string25 case_number;
  string40 certificate_number;
  string20 tax_code;
  string11 irs_serial_number;
  string8 release_date;
  string15 amount;
  string15 eviction;
  string8 judg_satisfied_date;
  string8 judg_vacated_date;
  string100 judge;
  string6 legal_lot;
  string6 legal_block;
  boolean multiple_debtor;
  DATASET(layout_filing_status) filing_status{maxcount(10)};
  unsigned8 persistent_record_id;
  DATASET(statementidrec) statementids{xpath('StatementIdRecs/StatementIdRec')};
  boolean isdisputed{xpath('IsDisputed')};
  DATASET(layout_lien_party) debtors{maxcount(25)};
  DATASET(layout_lien_party) creditors{maxcount(25)};
  DATASET(layout_lien_party) attorneys{maxcount(25)};
  DATASET(layout_lien_party) thds{maxcount(25)};
  DATASET(layout_lien_history) filings{maxcount(15)};
  string30 acctno;
  boolean isdeepdive;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  string errorcode;
 END;


// file := '~wema::out::fcra::liensv2service::w20201211-120904';
file := '';

ds := dataset(file,layout,thor);
ds;

main_lien := RECORD
  unsigned6 did;
  string ln_matchkey;
  string50 tmsid;
  string50 rmsid;
  string50 filing_jurisdiction;
  string2 filing_state;
  string20 orig_filing_number;
  string30 orig_filing_type;
  string8 orig_filing_date;
  string25 case_number;
  string40 certificate_number;
  string11 irs_serial_number;
  string8 release_date;
  string15 amount;
	string15 eviction;
  string8 judg_satisfied_date;
  string8 judg_vacated_date;
  unsigned8 main_persistent_record_id;
  boolean main_isdisputed;
   string20 filing_number;
   string50 filing_type_desc;
   string8 filing_date;
   string10 filing_book;
   string10 filing_page;
   string60 agency;
   string2 agency_state;
   string35 agency_city;
   string35 agency_county;
   boolean filing_isdisputed;
end;


main_lien norm_chld(layout L, layout_lien_history R) := TRANSFORM
                self.did := L.did;
								self.ln_matchkey := L.ln_matchkey;
								self.tmsid := L.tmsid;
								self.rmsid := L.rmsid;
								self.filing_jurisdiction := L.filing_jurisdiction;
								self.filing_state := L.filing_state;
								self.orig_filing_number := L.orig_filing_number;
								self.orig_filing_type := L.orig_filing_type;
								self.orig_filing_date := L.orig_filing_date;
								self.case_number := L.case_number;
								self.certificate_number := L.certificate_number;
								self.irs_serial_number := L.irs_serial_number;
								self.release_date := L.release_date;
								self.amount := L.amount;
								self.eviction := L.eviction;								
								self.judg_satisfied_date := L.judg_satisfied_date;
								self.judg_vacated_date := L.judg_vacated_date;
								self.main_persistent_record_id := L.persistent_record_id;
								self.main_isdisputed  := L.isdisputed;
								self.filing_number := R.filing_number;
								self.filing_type_desc := R.filing_type_desc;
								self.filing_date := R.filing_date;
								self.filing_book := R.filing_book;
								self.filing_page := R.filing_page;
								self.agency := R.agency;
								self.agency_state := R.agency_state;
								self.agency_city := R.agency_city;
								self.agency_county := R.agency_county;
								self.filing_isdisputed := R.isdisputed;
END;

ds_2 := NORMALIZE(ds, LEFT.filings, norm_chld(LEFT, RIGHT));
ds_2;

		// final_output := output(ds_with_extras,, outfile_name, thor,compressed, OVERWRITE);
		final_output := output(ds_2,, '~wema::out::FCRA::LiensV2Service::'+thorlib.wuid()+'_flatten', CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')), OVERWRITE);

		
Return final_output;	
