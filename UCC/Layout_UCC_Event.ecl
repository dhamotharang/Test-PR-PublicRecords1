EXPORT Layout_UCC_Event := RECORD
STRING2  file_state;
STRING1  rec_code;
STRING8  contrib_num1;
STRING8  contrib_num2;
STRING8  contrib_num3;
STRING4  value_2900;
STRING18 orig_filing_num;
STRING1  experian_rec_type;
STRING4  filing_type;
STRING18 document_num;
STRING8  filing_date;
STRING8  orig_filing_date;
STRING25 collateral_code;
STRING50 fk_debtor_orig_st;
STRING9  fk_filing_seq_num;
STRING15 filed_place;
STRING1  debtor_change;      // 'Y' or 'N' to indicate a debtor party change for this event
STRING1  secured_change;     // 'Y' or 'N' to indicate a secured or assignee party change for this event
END;