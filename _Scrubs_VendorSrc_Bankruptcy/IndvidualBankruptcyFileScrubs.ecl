IMPORT scrubs, _Scrubs_VendorSrc_Bankruptcy,std,ut,tools;


EXPORT IndvidualBankruptcyFileScrubs(string pVersion, string emailList) := function
                                      
return  sequential(
                    scrubs.ScrubsPlus('Bankruptcy','_Scrubs_VendorSrc_Bankruptcy','Scrubs_Bankruptcy','',pVersion,emailList,false,false));
										
end;


