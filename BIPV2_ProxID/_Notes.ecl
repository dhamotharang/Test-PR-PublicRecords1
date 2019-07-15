/*
  run iteration dataland of #45(use file from prod)
  using SALT 2.8B1
  take out iscorp
  
*/
/*
for foreign key overlinking--will still have to fix the overlinking with a patch outside of a build probably beforehand.
https://github.com/hpcc-systems/SALT/wiki/AttributeFiles
ATTRIBUTEFILE:ForeignCorpkey:NAMED(BIPV2_ProxID.file_Foreign_Corpkey):VALUES(company_charter_number<company_inc_state):FORCE(--,ALL):IDFIELD(Proxid):20,0
*/
/*
    20130212 iterations 1-24 b version after iteration 2?
    20130330 iterations 25-29 (exists an iteration 24 file which is patch applied to dot iteration 30)
                              (iteration 28 is result of hack basic match outside of SALT)
    20130521 iteration 30-35  (exists iteration 29 that is patch of dotfile)
                               iteration 30 is first DBA iteration
  20130212:
    total matches: 271,749,081 
    checked      :         178
    Bads+R/2     :           4
    error rate   :     2.2472%
  20130330:
    3 bad
    now do iteration 29:
      bad         : 2
      qeustionable: 1
  20130521(30-35):
    4/5 bad, 7 questionable for all iterations
    me: 1 bad, 2 questionable
    chad: 4 bad, 3 questionable
    
so, basically I need to:
  total up matchesperformed for all iterations
  also total up # matches per confidence level
  get percentage of total matches per confidence level(cumulative)
  how many records checked total
  then, find out how many bad & questionable(pass into function/macro) matches:  bads + questionable/2
    Error rate:
      divide (bads + r/2) / # of checked(for conf level)
      if no checked recs, then percentage for previous conf level / 2.
    NumErrors:
      Error Rate * num matches for that conf level
    Precision:
      total up all numerrors for all conf levels
      divide above by total number of matches
      1 - above result
  
  apply that to the 
  
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
