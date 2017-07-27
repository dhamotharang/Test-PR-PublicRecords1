export layout_bda_premium := record
     layout_eah_premium;
	layout_bda_business_best;
	string20  exactSales := '';
	string20  salesMin := '';
	string20  salesMax := '';
	string4   sic := '';
	string1   bankrupt_flag := '';
	string60  orgType := '';
	string1   home_based_flag := '';
	string10  exactEmplCnt := '';
	string10  emplCntMin := '';
	string10  emplCntMax := '';
	string20  taxLienAmount := '';
end;