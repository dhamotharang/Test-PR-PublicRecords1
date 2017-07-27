import iesp,official_records,ut,suppress,AutoStandardI;

export Report_Records := module
	export params := interface(AutoStandardI.InterfaceTranslator.application_type_val.params)
		export string60 OfficialRecordId  := '';
	end;
	
	export val(params in_mod) := function

	  // Assign official record id that was input to attribute for
		// matching on in multiple places below.
    raw_orid := if(in_mod.OfficialRecordId<>'',dataset([{in_mod.OfficialRecordId}], {string60 orid}));
		Suppress.MAC_Suppress(raw_orid, in_orid,in_mod.applicationtype,,,Suppress.Constants.DocTypes.OfficialRecord,orid);

	  // Used to replace spaces in date strings with zeroes so cast to integer works Ok,
	  // since some dates only contain a yyyy or a yyyymm.
    fixed_date(string8 dtin) := StringLib.StringFindReplace(dtin, ' ', '0');

    //******** Party file Transform
	  iesp.officialrecord.t_OfficialRecParty party_file_xform(
                                         official_records.Key_Party_ORID l) := transform
		  // Only possible master_party_type_cd values are 1, 5 or 9 as set in 
			// official_records.Out_Roxie_Party.
			// "9" is the default set when the entity_type_desc not one of the known values.
			// So if the value is not 1 or 5, the entity_type_desc is output in case it 
			// contains any descriptive text, even though it wasn't known in 
			// official_records.Out_Roxie_Party.
		  self.PartyType := map(l.master_party_type_cd = '1' => 'Grantor',
													  l.master_party_type_cd = '5' => 'Grantee',
													  l.entity_type_desc),
		  self.Name      := l.entity_nm
    end;

    // **************** MAIN TRANSFORM ****************
    //******** Document File 
		iesp.officialrecord.t_OfficialRecReportRecord doc_file_xform(
                                      official_records.Key_Document_ORID l) := transform
					
			 self.FilingDate       := iesp.ECL2ESP.toDate ((integer4) fixed_date(l.doc_filed_dt)),
	     self.County                 := l.county_name,
	     self.State                  := l.state_origin,
	     self.StateName              := ut.St2Name(l.state_origin),
	     self.InstrumentFilingNumber := l.doc_instrument_or_clerk_filing_num,
	     self.Description            := l.legal_desc_1,
	     self.DocumentType           := l.doc_type_desc,
	     self.DocumentPages          := l.doc_page_count,
	     self.BookType               := l.book_type_desc,
	     self.BookNumber             := l.book_num,
	     self.PageNumber             := l.page_num,
	     self.ConsiderationAmount    := l.consideration_amt,
	     self.TransferAmount         := l.transfer_,
	     self.MortgageAmount         := l.mortgage,
	     self.IntangibleTaxAmount    := l.intangible_tax_amt,
	     self.ExecutionDate          := iesp.ECL2ESP.toDate ((integer4) l.execution_dt),
	     self.Amendment              := l.doc_amend_desc,
	     self.PriorDocumentNumber    := l.prior_doc_file_num,
	     self.PriorDocumentType      := l.prior_doc_type_desc,
	     self.PriorBookNumber        := l.prior_book_num,
	     self.PriorBookType          := l.prior_book_type_desc,
	     self.PriorPageNumber        := l.prior_page_num,
			// For Parties data, use a project to do a keyed look up against the Key Party file
			// using the orid and also matching on the document-type.  
			// Then sort all the parties first in descending order by PartyType (i.e. Grantor then
			// Grantee); then secondly in alpha name order.
			// The "choosen" on the final result limits the party records currently to 300.
			// (see OFFRECS_MAX_COUNT_PARTIES in iesp.Constants.)
	 	  self.Parties := choosen(sort(project(official_records.Key_Party_ORID(
	                                    keyed(l.official_record_key = official_record_key) and
																            l.doc_type_desc = doc_type_desc),
			                     			       party_file_xform(left)),
											            -PartyType,Name),
													 iesp.Constants.OFFRECS_MAX_COUNT_PARTIES)
    end;
	
	rec_proj := join(
		in_orid, official_records.Key_Document_ORID,
		keyed(left.orid = right.official_record_key),
		doc_file_xform(right),
		limit(Constants.MAX_RECS_ON_JOIN,SKIP)
	);
	
  //Uncomment lines below as needed to assist in debugging
	//output(in_orid,named('rr_in_orid'));
  //output(recs_proj, named('rr_recs_proj'));

  return rec_proj;

  end;

end;