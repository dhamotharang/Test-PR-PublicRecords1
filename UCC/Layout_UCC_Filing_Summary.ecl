EXPORT Layout_UCC_Filing_Summary := RECORD
STRING2  file_state;
STRING18 orig_filing_num;
STRING4  filing_count := '';      // Unique filing events (file_state, orig_filing_num,
                                  // filing_date, filing type
STRING4  document_count := '';    // Unique document events (file_state, orig_filing_num,
                                  // filing_date, filing type, document_num
STRING3  debtor_count := '';      // Current debtor parties
STRING3  secured_count := '';     // Current secured and assignee parties
STRING25 collateral_code := '';   // Current collateral code
END;