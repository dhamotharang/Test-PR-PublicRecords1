// The macro was copied from Scrubs_Vina.Proc_Scrubs_Report and adjusted
IMPORT ut, Orbit3SOA, SALT33, _Control, Scrubs, Scrubs_Prof_License_Mari, std, tools;

EXPORT PostBuildScrubs(string filedate, string emailList='') := FUNCTION

return Scrubs.ScrubsPlus('BKForeclosure_Reo','Scrubs_BKForeclosure_Reo','Scrubs_BKForeclosure_Reo','',filedate,emailList,false);

end;
