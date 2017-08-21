export Criminal_Appeal_Grouped := 'todo';

dDev	:=	CrimSrch.file_court_offenses(vendor='29');

 

rDate1WithYear

 :=

			record

      dDev.vendor;

      string4 YEAR := dDev.appeal_date[1..4];

			end;

dDate1WithYear := table(dDev,rDate1WithYear);

rTable1 := record dDate1WithYear.vendor;

      dDate1WithYear.YEAR;

      unsigned8 Total := count(group);
 
      end;

dTable1 := table(dDate1WithYear,rTable1,vendor,YEAR,few);

output(sort(dTable1,vendor,YEAR),all,named('appeal_date'));