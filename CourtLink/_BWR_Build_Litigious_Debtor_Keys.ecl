pversion    := '20070912';     // modify to current date

#workunit('name', 'CourtLink Litigious Debtor Key Build ' + pversion);
CourtLink.Proc_Build_Keys(pversion): success(CourtLink.Send_Email(pversion).keysuccess), failure(CourtLink.Send_Email(pversion).keyfailure);