export UCC_Filings_Filings_Grouped := 'todo';

dDev	:=	UCC.File_UCC_Filing_Events_Temp(file_state='AK');

 

rDate1WithYear

 :=

			record

      dDev.file_state;

      string4 YEAR := dDev.filing_date[1..4];

			end;

dDate1WithYear := table(dDev,rDate1WithYear);

rTable1 := record dDate1WithYear.file_state;

      dDate1WithYear.YEAR;

      unsigned8 Total := count(group);
 
      end;

dTable1 := table(dDate1WithYear,rTable1,file_state,YEAR,few);

output(sort(dTable1,file_state,YEAR),all,named('filing_date'));