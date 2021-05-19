import doxie_cbrs, ut, STD;

export filter_nonRecent(dataset(doxie_cbrs.layout_report) in_recs) := FUNCTION

cur_date := (STRING8) STD.Date.Today();
recent_limit := ut.DaysInNYears(7) - 30;   			// 6 years, 11 months
lien_recent_limit := ut.DaysInNYears(7) - 90;   // 6 years, 9 months
ca_unpaid_limit := ut.DaysInNYears(10);
ca_paid_limit := ut.DaysInNYears(7);


isRecent(string date, unsigned lim, boolean allowBlank = true) := (allowBlank and date = '') or 
                                                                  ut.DaysApart(cur_date, date) < lim; 
isRecentCont(string rel_date, string cont_date, unsigned lim) := 
  if(rel_date != '', ut.DaysApart(cur_date, rel_date) < lim,ut.DaysApart(cur_date, cont_date) < lim);
  

isLien(string desc) := STD.STR.Find(STD.STR.ToUpperCase(desc), 'LIEN',1)>0 or 
                      STD.STR.Find(STD.STR.ToUpperCase(desc), 'WARRANT',1)>0 or
                      STD.STR.Find(STD.STR.ToUpperCase(desc), 'TAX',1)>0;
                      
isPaid(string status, string desc) := (status = '' and desc = '') or
                                      STD.STR.Find(STD.STR.ToUpperCase(desc), 'SATISFIED',1)>0 or
                                      STD.STR.Find(STD.STR.ToUpperCase(desc), 'RELEASED',1)>0 or
                                      STD.STR.Find(STD.STR.ToUpperCase(desc), 'SETTLED',1)>0;

// sometimes a released lien is indicated in the filing_type rather than the filing_status (FEDERAL TAX LIEN RELEASE)
isReleased(string desc) := STD.STR.Find(STD.STR.ToUpperCase(desc),'RELEASE',1)>0;
                       
isRemoved(string desc) := STD.STR.Find(STD.STR.ToUpperCase(desc), 'REMOVED',1)>0 or
                       STD.STR.Find(STD.STR.ToUpperCase(desc), 'DISMISSED',1)>0 or
                       STD.STR.Find(STD.STR.ToUpperCase(desc), 'TRANSFER',1)>0;

comb_layout := doxie_cbrs.layout_report.liens_judgments_v2;

comb_layout projLJ(comb_layout l) := transform
  self.uccs := l.uccs(isRecent(orig_filing_date,recent_limit));

  // handle the liens
  liens := l.judgment_liens(isLien(orig_filing_type) or exists(filings(isLien(filing_type_desc))));
  
  // apply special rules for CA liens
  liens_ca := liens(filing_jurisdiction[1..2] = 'CA' or filing_state = 'CA');	


  liens_ca_paid := liens_ca(exists(filing_status(isPaid(filing_status,filing_status_desc))) or
                            exists(filings(isReleased(filing_type_desc))));
                            
  liens_ca_paid_recent := liens_ca_paid(isRecent(release_date, ca_paid_limit,false) or 
                                        isRecent(orig_filing_date, ca_unpaid_limit));
  
  liens_ca_unpaid := liens_ca(not (exists(filing_status(isPaid(filing_status,filing_status_desc))) or
                                   exists(filings(isReleased(filing_type_desc)))));
                              
  liens_ca_unpaid_recent := liens_ca_unpaid(isRecent(orig_filing_date, ca_unpaid_limit));
  
  liens_ca_recent := liens_ca_paid_recent + liens_ca_unpaid_recent;
  
  // apply general rules for the rest of the liens
  liens_rest := liens(not(filing_jurisdiction[1..2] = 'CA' or filing_state = 'CA'));

  liens_rest_paid := liens_rest(exists(filing_status(isPaid(filing_status,filing_status_desc))) or
                                exists(filings(isReleased(filing_type_desc))));
  liens_rest_paid_recent := liens_rest_paid(isRecentCont(release_date,MAX(orig_filing_date,MAX(filings,filing_date)),
                                                         lien_recent_limit));
  
  // never suppress unpaid liens
  liens_rest_unpaid := liens_rest(not (exists(filing_status(isPaid(filing_status,filing_status_desc))) or
                                       exists(filings(isReleased(filing_type_desc))) or
                                       exists(filing_status(isRemoved(filing_status_desc)))));

  liens_recent := liens_rest_paid_recent + liens_rest_unpaid + liens_ca_recent;

  // handle the judgments
  judg := l.judgment_liens(not isLien(orig_filing_type) and not exists(filings(isLien(filing_type_desc))));
  judg_recent := judg(isRecent(orig_filing_date,recent_limit));

  self.judgment_liens := sort(liens_recent + judg_recent,-orig_filing_date,record);
end;

doxie_cbrs.layout_report proj(doxie_cbrs.layout_report l) := transform
  self.liens_judgments_v2 := project(l.liens_judgments_v2, projLJ(LEFT));
  self := l;
end;

res := project(in_recs, proj(LEFT));

return res;

END;
