
											 
IMPORT dx_PhoneFinderReportDelta, STD;
											 
ReportStructure:= RECORD
  STRING16 transaction_id;
  STRING32 transaction_date;
  STRING6 	transaction_time;
  STRING10 submitted_phonenumber;
  STRING16 company_Id;
  string16 risk_indicator;
END;

company_layout := RECORD
  STRING companyID;
END;


companyIds_original := DATASET([{'1010041'},
{'1536082'},
{'1538446'},
{'1538456'},
{'1538466'},
{'1538476'},
{'1538486'},
{'1538496'},
{'1538506'},
{'1538516'},
{'1538526'},
{'1538536'},
{'1538546'},
{'1538556'},
{'1538566'},
{'1538576'},
{'1538586'},
{'1538596'},
{'1538606'},
{'1538626'},
{'1538646'},
{'1538656'},
{'1538666'},
{'1538676'},
{'1538686'},
{'1538696'},
{'1538706'},
{'1538716'},
{'1538736'},
{'1538746'},
{'1540522'},
{'1546865'},
{'1548062'},
{'1548186'},
{'1550622'},
{'1554502'},
{'1554756'},
{'1554826'},
{'1556172'},
{'1556412'},
{'1556806'},
{'1557766'},
{'1561972'},
{'1563416'},
{'1569586'},
{'1572876'},
{'1588286'},
{'1599441'},
{'1600276'},
{'1607091'},
{'1609871'},
{'1619201'},
{'1622511'},
{'1623370'},
{'1626347'},
{'1629881'},
{'1637970'},
{'1638890'},
{'1640610'},
{'1641577'},
{'6677713'},
{'6681153'},
{'6706483'},
{'1569400'},
{'1531530'},
{'1537390'},
{'1533420'},
{'1538170'},
{'1537380'},
{'1532090'},
{'1532060'},
{'1532040'},
{'1531620'},
{'1532050'},
{'1538390'},
{'1569210'},
{'1564170'},
{'1564180'},
{'1564160'},
{'1564150'},
{'1531540'},
{'1640890'},
{'1641100'},
{'1641550'},
{'1642120'},
{'1642310'},
{'1646947'},
{'1647497'},
{'6715203'},
{'1631381'},
{'6714573'},
{'1556062'},
{'1665577'},
{'1681957'},
{'1581406'},
{'1681187'},
{'1703057'},
{'1709267'},
{'1561962'},
{'1712957'}
],company_layout);

companyIds_additional := DATASET([{'6715203'},
{'6714573'},
{'6706483'},
{'6681153'},
{'6677713'},
{'1712957'},
{'1709267'},
{'1703057'},
{'1681957'},
{'1681187'},
{'1665577'},
{'1647497'},
{'1642310'},
{'1641577'},
{'1641550'},
{'1640890'},
{'1640610'},
{'1638890'},
{'1631381'},
{'1629881'},
{'1626347'},
{'1623370'},
{'1622511'},
{'1619201'},
{'1607091'},
{'1600276'},
{'1588286'},
{'1581406'},
{'1572876'},
{'1569586'},
{'1569400'},
{'1569210'},
{'1564180'},
{'1564170'},
{'1564160'},
{'1564150'},
{'1563416'},
{'1561972'},
{'1561962'},
{'1556806'},
{'1554826'},
{'1010041'},
{'1531530'},
{'1531540'},
{'1531620'},
{'1532040'},
{'1532050'},
{'1532060'},
{'1532090'},
{'1536082'},
{'1537390'},
{'1538170'},
{'1538390'},
{'1546865'},
{'1554756'},
{'1599441'},
{'141H9F'},
{'1637970'},
{'1556412'},
{'1538706'},
{'1548062'},
{'1554502'},
{'1556062'},
{'1556172'},
{'1540522'},
{'1642120'}
],company_layout);

Today := STD.Date.Today();

Get_stats(DATASET(company_layout) companyIds) := FUNCTION

Yesterday := (STRING)STD.Date.AdjustDate(Today,,,-1);
Start_of_month := (STRING)STD.Date.AdjustDate(Today, 0, -1, 0)[1..6]+'01';

Transactions := dx_PhoneFinderReportDelta.Key_Transactions(company_id IN SET(companyIds, companyID) AND (transaction_date BETWEEN Start_of_month AND Yesterday));


dSorted := SORT(Transactions, transaction_date, company_id);


rDateCnt_Layout :=
RECORD
  dSorted.transaction_date;
  pii_fail_cnt := SUM(GROUP, IF(dSorted.submitted_phonenumber = '' AND dSorted.risk_indicator = 'FAIL', 1, 0));
  pii_no_fail_cnt := SUM(GROUP, IF(dSorted.submitted_phonenumber = '' AND dSorted.risk_indicator != 'FAIL', 1, 0));
  phone_fail_cnt := SUM(GROUP, IF(dSorted.submitted_phonenumber != '' AND dSorted.risk_indicator = 'FAIL', 1, 0));
  phone_no_fail_cnt := SUM(GROUP, IF(dSorted.submitted_phonenumber != '' AND dSorted.risk_indicator != 'FAIL', 1, 0));
END;

dDateCounts := TABLE(dSorted, rDateCnt_Layout, transaction_date, few);

Layout_Final :=
RECORD
  STRING32 transaction_date;
  INTEGER pii_fail_cnt;
  INTEGER pii_no_fail_cnt;
  INTEGER phone_fail_cnt;
  INTEGER phone_no_fail_cnt;
  DECIMAL5_2 pii_fail_percent;
  DECIMAL5_2 phone_fail_percent;
  DECIMAL5_2 total_fail_percent;
END;

ds_final := SORT(PROJECT(dDateCounts, TRANSFORM(Layout_Final, 
                                           SELF := LEFT,
                                           SELF.pii_fail_percent := (SELF.pii_fail_cnt/(SELF.pii_fail_cnt + SELF.pii_no_fail_cnt))*100,
                                           SELF.phone_fail_percent := (SELF.phone_fail_cnt/(SELF.phone_fail_cnt + SELF.phone_no_fail_cnt))*100,
                                           SELF.total_fail_percent := ((SELF.pii_fail_cnt + SELF.phone_fail_cnt)/(SELF.pii_fail_cnt + SELF.pii_no_fail_cnt + SELF.phone_fail_cnt + SELF.phone_no_fail_cnt))*100)),transaction_date);
RETURN ds_final;
END;

EXPORT GetBOFAReports (STRING Output_landingzone ,
                       STRING working_directory) := FUNCTION
											 
d_BOFA_BG :=  Get_stats(companyIds_original);
d_BOFA_additional_BG :=  Get_stats(companyIds_additional);



SEQUENTIAL(output(d_BOFA_BG,,'~thor_data400::BOFA_report'+(STRING)Today, CSV(HEADING(single),QUOTE('"')), OVERWRITE, COMPRESSED),
           FileServices.DeSpray('~thor_data400::BOFA_report'+(STRING)Today, Output_landingzone, working_directory +'Results.csv' ,,,,TRUE),
           output(d_BOFA_additional_BG,,'~thor_data400::BOFA_report_additional'+(STRING)Today, CSV(HEADING(single),QUOTE('"')), OVERWRITE, COMPRESSED),
           FileServices.DeSpray('~thor_data400::BOFA_report_additional'+(STRING)Today, Output_landingzone, working_directory +'Results_additional.csv' ,,,,TRUE));
RETURN d_BOFA_BG + d_BOFA_additional_BG;

END;
