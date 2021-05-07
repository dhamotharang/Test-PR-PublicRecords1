IMPORT iesp,  dx_official_records, ut, suppress, AutoStandardI, STD;

EXPORT Report_Records := MODULE
  EXPORT params := INTERFACE(AutoStandardI.InterfaceTranslator.application_type_val.params)
    EXPORT STRING60 OfficialRecordId := '';
  END;
  
  EXPORT val(params in_mod) := FUNCTION

    // Assign official record id that was input to attribute for
    // matching on in multiple places below.
    raw_orid := IF(in_mod.OfficialRecordId<>'',DATASET([{in_mod.OfficialRecordId}], {STRING60 orid}));
    Suppress.MAC_Suppress(raw_orid, in_orid,in_mod.applicationtype,,,Suppress.Constants.DocTypes.OfficialRecord,orid);

    // Used to replace spaces in date strings with zeroes so cast to integer works Ok,
    // since some dates only contain a yyyy or a yyyymm.
    fixed_date(STRING8 dtin) := STD.Str.FindReplace(dtin, ' ', '0');

    //******** Party file Transform
    iesp.officialrecord.t_OfficialRecParty party_file_xform(
                                         dx_official_records.Key_Party_ORID l) := TRANSFORM
      // Only possible master_party_type_cd values are 1, 5 or 9 as set in
      // official_records.Out_Roxie_Party.
      // "9" is the default set when the entity_type_desc not one of the known values.
      // So if the value is not 1 or 5, the entity_type_desc is output in case it
      // contains any descriptive text, even though it wasn't known in
      // official_records.Out_Roxie_Party.
      SELF.PartyType := MAP(l.master_party_type_cd = '1' => 'Grantor',
                            l.master_party_type_cd = '5' => 'Grantee',
                            l.entity_type_desc),
      SELF.Name := l.entity_nm
    END;

    // **************** MAIN TRANSFORM ****************
    //******** Document File
    iesp.officialrecord.t_OfficialRecReportRecord doc_file_xform(
        dx_official_records.Key_Document_ORID l) := TRANSFORM
          
      SELF.FilingDate := iesp.ECL2ESP.toDate ((INTEGER4) fixed_date(l.doc_filed_dt));
      SELF.County := l.county_name;
      SELF.State := l.state_origin;
      SELF.StateName := ut.St2Name(l.state_origin);
      SELF.InstrumentFilingNumber := l.doc_instrument_or_clerk_filing_num;
      SELF.Description := l.legal_desc_1;
      SELF.DocumentType := l.doc_type_desc;
      SELF.DocumentPages := l.doc_page_count;
      SELF.BookType := l.book_type_desc;
      SELF.BookNumber := l.book_num;
      SELF.PageNumber := l.page_num;
      SELF.ConsiderationAmount := l.consideration_amt;
      SELF.TransferAmount := l.transfer_;
      SELF.MortgageAmount := l.mortgage;
      SELF.IntangibleTaxAmount := l.intangible_tax_amt;
      SELF.ExecutionDate := iesp.ECL2ESP.toDate ((INTEGER4) l.execution_dt);
      SELF.Amendment := l.doc_amend_desc;
      SELF.PriorDocumentNumber := l.prior_doc_file_num;
      SELF.PriorDocumentType := l.prior_doc_type_desc;
      SELF.PriorBookNumber := l.prior_book_num;
      SELF.PriorBookType := l.prior_book_type_desc;
      SELF.PriorPageNumber := l.prior_page_num;
      // For Parties data, use a project to do a keyed look up against the Key Party file
      // using the orid and also matching on the document-type.
      // Then sort all the parties first in descending order by PartyType (i.e. Grantor then
      // Grantee); then secondly in alpha name order.
      // The "choosen" on the final result limits the party records currently to 300.
      // (see OFFRECS_MAX_COUNT_PARTIES in iesp.Constants.)
      SELF.Parties := CHOOSEN(SORT(PROJECT(dx_official_records.Key_Party_ORID(
                                  KEYED(l.official_record_key = official_record_key) AND
                                        l.doc_type_desc = doc_type_desc),
                                    party_file_xform(LEFT)),
                              -PartyType,Name),
                          iesp.Constants.OFFRECS_MAX_COUNT_PARTIES)
    END;
  
  rec_proj := JOIN(
    in_orid, dx_official_records.Key_Document_ORID,
    KEYED(LEFT.orid = RIGHT.official_record_key),
    doc_file_xform(RIGHT),
    LIMIT(Constants.MAX_RECS_ON_JOIN,SKIP)
  );
  
  //Uncomment lines below as needed to assist in debugging
  //output(in_orid,named('rr_in_orid'));
  //output(recs_proj, named('rr_recs_proj'));

  RETURN rec_proj;

  END;

END;
