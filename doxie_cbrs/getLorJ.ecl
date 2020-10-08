IMPORT STD;
setLtypes := [
'CT',
'FT',
'IL',
'ML',
'ST',
'CE',
'FE',
'CR',
'FR',
'IR',
'MM',
'SE',
'SR',
'CF',
'SZ',
'TW',
'WE',
'WR',
'TZ'

];

setJtypes := [
'AC',
'AJ',
'AP',
'AS',
'BN',
'CJ',
'CP',
'CS',
'DD',
'DJ',
'FC',
'FD',
'FF',
'FJ',
'FN',
'FO',
'JF',
'JP',
'SC',
'CD',
'DF',
'DS',
'FK',
'FL',
'FP',
'FV',
'RC',
'RD',
'RL',
'RM',
'RS',
'VJ'

];

EXPORT getLorJ(STRING2 thetype, STRING filingtype_desc) :=
  MAP(thetype IN setLtypes OR STD.STR.Contains(filingtype_desc, 'LIEN', TRUE)
                     OR STD.STR.Contains(filingtype_desc, 'LOAN', TRUE)
               OR STD.STR.Contains(filingtype_desc, 'WARRANT', TRUE)
               OR STD.STR.Contains(filingtype_desc, 'TAX', TRUE)=> 'L',
               
    thetype IN setJtypes OR STD.STR.Contains(filingtype_desc, 'JUDGMENT', TRUE)
                 OR STD.STR.Contains(filingtype_desc, 'CIVIL', TRUE) => 'J',
      '');

//originally from bug 14142
/*
//LIENS
Tax Lien Filing CT COUNTY TAX LIEN
Tax Lien Filing FT FEDERAL TAX LIEN
Tax Lien Filing IL CITY TAX LIEN
Tax Lien Filing ML MECHANICS LIEN
Tax Lien Filing ST STATE TAX LIEN
Tax Lien Disposition CE FILED IN ERROR-COUNTY TAX LIEN
Tax Lien Disposition FE FILED IN ERROR-FED TAX LIEN
Tax Lien Disposition CR COUNTY TAX LIEN RELEASE
Tax Lien Disposition FR FEDERAL TAX LIEN RELEASE
Tax Lien Disposition IR CITY TAX LIEN RELEASE
Tax Lien Disposition MM MECHANICS LIEN RELEASE
Tax Lien Disposition SE FILED IN ERROR-ST TAX LIEN
Tax Lien Disposition SR STATE TAX LIEN RELEASE
Tax Lien Update CF CORRECTED FEDERAL TAX LIEN
Tax Lien Update SZ STATE TAX LIEN RENEWAL
Tax Lien Filing TW STATE TAX WARRANT
Tax Lien Disposition WE FILED IN ERROR-ST TAX WARRANT
Tax Lien Disposition WR STATE TAX WARRANT RELEASE
Tax Lien Update TZ STATE TAX WARRANT RENEWED

//JUDGEMENTS
Civil Judgement Filing AC RENEW/REOPEN CIVIL JUDGEMENT
Civil Judgement Filing AJ JUDGEMENT LIEN
Civil Judgement Filing AP APPEALED JUDGMENT
Civil Judgement Filing AS RENEW/REOPEN SMALL CLAIM JUDGM
Civil Judgement Filing BN CIVIL NEW FILING
Civil Judgement Filing CJ CIVIL JUDGMENT
Civil Judgement Filing CP CHILD SUPPORT PAYMENT
Civil Judgement Filing CS CIVIL SPECIAL JUDGMENT
Civil Judgement Filing DD DOMESTIC JUDGMENT IN DIVORCE
Civil Judgement Filing DJ DEFICIENCY JUDGMENT
Civil Judgement Filing FC FORECLOSURE (JUDGMENT)
Civil Judgement Filing FD FORCIBLE ENTRY/DETAINER
Civil Judgement Filing FF FORECLOSURE NEW FILING
Civil Judgement Filing FJ FEDERAL COURT JUDGMENT
Civil Judgement Filing FN FEDERAL COURT NEW FILING
Civil Judgement Filing FO FED COURT NEW FILING (DAP)
Civil Judgement Filing JF JUDGEMENT OF FORFEITURE
Civil Judgement Filing JP JUDGEMENT OF POSSESSION
Civil Judgement Filing SC SMALL CLAIMS JUDGMENT
Civil Judgement Disposition CD CIVIL DISMISSAL
Civil Judgement Disposition DF FORECLOSURE DISMISSED
Civil Judgement Disposition DS DOMESTIC RELEASE IN DIVORCE
Civil Judgement Disposition FK FEDERAL COURT DISMISSAL
Civil Judgement Disposition FL FEDERAL COURT SATISFACTION
Civil Judgement Disposition FP FORECLOSURE SATISFIED
Civil Judgement Disposition FV FEDERAL COURT CHANGE OF VENUE
Civil Judgement Disposition RC CHILD SUPPORT PAYMENT RELEASE
Civil Judgement Disposition RD FORCIBLE ENTRY/DETAINER RELEAS
Civil Judgement Disposition RL CIVIL JUDGMENT RELEASE
Civil Judgement Disposition RM CIVIL SPECIAL JUDGMENT RELEASE
Civil Judgement Disposition RS SMALL CLAIMS JUDGMENT RELEASE
Civil Judgement Disposition VJ VACATED JUDGMENT
*/
