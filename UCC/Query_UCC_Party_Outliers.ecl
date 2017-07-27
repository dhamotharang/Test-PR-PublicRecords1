UCC_Parties := UCC.File_UCC_Expanded_Party;

Layout_UCC_Slim := RECORD
STRING2   file_state;
STRING18  orig_filing_num;
STRING4   fk_filing_type;
STRING8   fk_filing_date;
STRING18  fk_document_num;
END;

Layout_UCC_Slim SlimUCC(UCC.Layout_UCC_Expanded_Party L) := TRANSFORM
SELF := L;
END;

UCC_Slim := PROJECT(UCC_Parties(file_state='KY'), SlimUCC(LEFT));

Layout_UCC_Stat := RECORD
UCC_Slim.file_state;
UCC_Slim.orig_filing_num;
UCC_Slim.fk_filing_type;
UCC_Slim.fk_filing_date;
UCC_Slim.fk_document_num;
reccnt := COUNT(GROUP);
END;

UCC_Stat := TABLE(UCC_Slim, Layout_UCC_Stat, file_state, orig_filing_num, fk_filing_type, fk_filing_date, fk_document_num);

UCC_Stat_Sort := SORT(UCC_Stat, -reccnt);

OUTPUT(CHOOSEN(UCC_Stat_Sort, 1000));