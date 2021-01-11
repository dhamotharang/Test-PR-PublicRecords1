EXPORT consts := MODULE
  // LAYOUT ROLLUP CONSTANTS
  EXPORT NAMES_PER_PARTY := 5;
  EXPORT ADDRESSES_PER_PARTY := 5;
  EXPORT PHONES_PER_PARTY := 5;
  EXPORT EMAILS_PER_PARTY := 5;
  EXPORT PARTIES_PER_ROLLUP := 10;
  EXPORT STATUSES_PER_ROLLUP := 20;
  EXPORT COMMENTS_PER_ROLLUP := 20;
  EXPORT DOCKETS_PER_ROLLUP := 10000;
  // last 4 digits of SSN search
  EXPORT MAX_SSN4 := 3000;
  EXPORT MAX_PER_COURT_CASE_LOOKUP := 1; // There should only be 1 RECORD per court ID / CASE number lookup
  EXPORT KEEP_LIMIT := 1000;
  EXPORT STRING2 CASETYPE_BANKRUPTCY := 'BK';
  
  /* From Data Fab: T - represents Trustee A1 - attorney1,
      A2 - attorney2, T1 - trustee1, D - Debtor.
      The code is usually uses name_type[1] to look for A,T,D. */
  EXPORT NAME_TYPES := MODULE
    EXPORT STRING1 ATTORNEY := 'A';
    EXPORT STRING1 DEBTOR := 'D';
    EXPORT STRING1 TRUSTEE := 'T';
  END;
      
  EXPORT SET OF STRING2 DEBTOR_TYPES := ['P','S','PA','SA'];
END;
