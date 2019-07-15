// The macro was copied from Scrubs_Vina.Proc_Scrubs_Report and adjusted
IMPORT ut, Orbit3SOA, SALT33, _Control, Scrubs, Scrubs_OKC_Probate, std, tools;
EXPORT PostBuildScrubs(string filedate, string emailList='') := FUNCTION

return Scrubs.ScrubsPlus('OKC_Probate','Scrubs_OKC_Probate','Scrubs_OKC_Probate','',filedate,emailList);

end;
