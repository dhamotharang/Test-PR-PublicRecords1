/*

  ABBR on corp legal name is not really going to be effective since the preprocessing of name sorts it alphabetically.  This means that if the original order of the words was not alphabetical, this will not work.  Maybe should take it out, or not sort the name.
    or do it on raw company name, and add a conditional force on corp legal name if company name matches.
  hyphen1 on corp legal name.  seems to help slightly, but more than doubles build time.
  better way to do contact name than attribute file?
  blank address records in full file
  LEXISNEXIS RISK SOLUTIONS INC. - MINNEAPOLIS, 100 5TH 300 MINNEAPOLIS MN 55402 with enterprise number of 1787604 are not linking together in the full file run.  Why?
  some overlinking on cnp_btype
  NATIONAL SAFETY ALLIANCE CORP vs NATIONAL SAFETY ALLIANCE INCORPORATED .  INC and CORP mean the same thing, don't they?  Maybe we should map them to the same value? Proxid 56091694 in full file.  The cnp_btype is overlinked in this example, but if it
  were not overlinked, these two records would not come together because their cnp_btype is different.  Also, what about company -> CO.  Is that a legal btype?  should it be mapped to the same as corporation and incorporated, or should it be blank because
  a company can be any of them(llp,llc,corp,inc, etc)
  proxid: 56091636.  LEXISNEXIS SCREENING SOLUTIONS  is considered a dba name, while LEXISNEXIS SCREENING SOLUTIONS INC is considered a corp legal name.  Even though LEXISNEXIS SCREENING SOLUTIONS INC turns into the same LEXISNEXIS SCREENING SOLUTIONS when
  mapped to the corp legal name field.  
  proxids 42628322,42629065 not link.  they should though.  lexis at 10880 WILSHIRE LOS ANGELES CA 90024.  they even share a duns 786907225.
  915157772,969286382 .. both have LEXISNEXIS RISK SOLUTIONS GA INC  at 1105 MARKET WILMINGTON DE 19801.  the sec range is different, but the name is the same, so the conditional force should allow them to come together.
  1118734937,497294403,1118734934 should come together.  lexis,inc at 1105 MARKET 501 WILMINGTON DE 19801.
  1118734986,1118735106,130758699,1118735034.  lexisnexis examen inc @ 1105 MARKET 501 WILMINGTON DE 19801.  should come together, but don't


  micro file:
402664,2987436

*/