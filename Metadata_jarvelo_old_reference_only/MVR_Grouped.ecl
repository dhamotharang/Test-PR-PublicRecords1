export MVR := 'todo';

dVehicles := vehlic.File_Base_Vehicles_Dev(orig_state='CT');

/////////////////

rDate1WithYear := record dVehicles.orig_state;

       string4 YEAR := dVehicles.REGISTRATION_EFFECTIVE_DATE[1..4];
			 
			 end;

dDate1WithYear := table(dVehicles,rDate1WithYear);

rTable1 := record dDate1WithYear.orig_state;

       dDate1WithYear.YEAR;

       unsigned8 Total := count(group);

			 end;

dTable1 := table(dDate1WithYear, rTable1,orig_state,YEAR,few);

output(sort(dTable1,orig_state,YEAR),all,named('REGISTRATION_EFFECTIVE_DATE'));

/////////////////

/////////////////

rDate2WithYear := record dVehicles.orig_state;

       string4 YEAR := dVehicles.TITLE_ISSUE_DATE[1..4];

			 end;

dDate2WithYear := table(dVehicles,rDate2WithYear);

rTable2 := record dDate2WithYear.orig_state;

       dDate2WithYear.YEAR;

       unsigned8 Total := count(group);

			 end;


dTable2 := table(dDate2WithYear, rTable2,orig_state,YEAR,few);

output(sort(dTable2,orig_state,YEAR),all,named('TITLE_ISSUE_DATE'));
