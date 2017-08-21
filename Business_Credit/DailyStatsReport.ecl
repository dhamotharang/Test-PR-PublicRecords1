import Business_Credit, ut;

EXPORT DailyStatsReport(string8 filedate = ut.GetDate) := function

Daily := Business_Credit.StatsReport(filedate,filedate,'Day');
Month	:= Business_Credit.StatsReport(filedate[1..6]+'01',filedate,'Month');
Current := Business_Credit.StatsReport('19000101',ut.GetDate,'Full_File');

return  sequential(Daily,Month,Current);
end;