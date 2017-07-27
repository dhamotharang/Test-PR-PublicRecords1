import ut,did_add;

//how many daily util files will be included
DaysToUse:=60;
//start date will be computed from the last header release date (note: not the header build date)
LastHeaderReleaseDate:=did_add.get_EnvVariable('header_file_version')[1..8];
FromDateInDays:=ut.DaysSince1900(LastHeaderReleaseDate[1..4],LastHeaderReleaseDate[5..6],LastHeaderReleaseDate[7..8]) - DaysToUse;
FromDate:=ut.DateFrom_DaysSince1900(FromDateInDays);
export StartDate := FromDate;