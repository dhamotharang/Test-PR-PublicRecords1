// The macro was copied from Scrubs_Vina.Proc_Scrubs_Report and adjusted
IMPORT ut, Orbit3SOA, SALT33, _Control, Scrubs, Scrubs_Marriage_Divorce_V2, std, tools;
EXPORT PostBuildScrubs(string filedate, string emailList='') := FUNCTION

return Scrubs.ScrubsPlus('Marriage_Divorce_V2','Scrubs_Marriage_Divorce_V2','Scrubs_Marriage_Divorce_V2','',filedate,emailList);

end;
