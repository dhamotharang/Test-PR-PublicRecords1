// To add new jobs to monitor, add a record in jobds dataset below.

export monitor_jobs := module

export monitor_layout := record
	string jname := '';
	string thresholdval := '';
	string emaillist := '';
end;

export add_jobs_to_monitor := dataset([{'Bankruptcy FCRA Key Build','15','Anantha.Venkatachalam@lexisnexis.com,Christopher.Brodeur@lexisnexis.com,Joseph.Lezcano@lexisnexis.com'},
					{'Bankruptcy Stats and Update Dops','15','Anantha.Venkatachalam@lexisnexis.com,Christopher.Brodeur@lexisnexis.com,Joseph.Lezcano@lexisnexis.com'},
					{'BankruptcyV3/V2 Roxie Key Build','15','Anantha.Venkatachalam@lexisnexis.com,Christopher.Brodeur@lexisnexis.com,Joseph.Lezcano@lexisnexis.com'},
					{'BankruptcyV3 Spray','15','Anantha.Venkatachalam@lexisnexis.com,Christopher.Brodeur@lexisnexis.com,Joseph.Lezcano@lexisnexis.com'},
					{'BankruptcyV3-V2 Base File Build','15','Anantha.Venkatachalam@lexisnexis.com,Christopher.Brodeur@lexisnexis.com,Joseph.Lezcano@lexisnexis.com'},
					{'UCCV2 Build','0','BocaRoxiePackageTeam@lexisnexis.com'},
					{'National Crash build','0','BocaRoxiePackageTeam@lexisnexis.com'},
					{'ECrash Build All','0','BocaRoxiePackageTeam@lexisnexis.com'},
					{'ECrash V2 Roxie Key Build','0','BocaRoxiePackageTeam@lexisnexis.com'},
					{'BANKO ADDITIONAL EVENTS','0','BocaRoxiePackageTeam@lexisnexis.com'},
					{'Case Connect - Accurint Acc Logs','0','BocaRoxiePackageTeam@lexisnexis.com'},
					{'Daily Inquiry Update Tracking Keys','0','BocaRoxiePackageTeam@lexisnexis.com'},
					{'FEDEX-NOHIT Build','0','BocaRoxiePackageTeam@lexisnexis.com'},
					{'PhonesFeedback Daily Build','0','BocaRoxiePackageTeam@lexisnexis.com'},
					{'CourtLink Litigious Debtor Key Build','0','BocaRoxiePackageTeam@lexisnexis.com'},
					{'Utility Daily Spray','0','BocaRoxiePackageTeam@lexisnexis.com'}				
					],monitor_layout);

end;