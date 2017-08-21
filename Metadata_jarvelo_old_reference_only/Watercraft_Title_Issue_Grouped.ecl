export Watercraft_Title_Issue_Grouped := 'todo';

dWatercraft := watercraft.File_Base_Main_prod(state_origin='DE');

 

rDate1WithYear

 :=

			record

      dWatercraft.state_origin;

      string4 YEAR := dWatercraft.title_issue_date[1..4];

			end;

dDate1WithYear := table(dWatercraft,rDate1WithYear);

rTable1 := record dDate1WithYear.state_origin;

      dDate1WithYear.YEAR;

      unsigned8 Total := count(group);
 
      end;

dTable1 := table(dDate1WithYear,rTable1,state_origin,YEAR,few);

output(sort(dTable1,state_origin,YEAR),all,named('title_issue_date'));