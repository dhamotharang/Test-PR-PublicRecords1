IMPORT scrubs, scrubs_vendor_src, std, ut, tools;


EXPORT Vendor_Src_ScrubsPlus(string pversion, string emailList) := function

return sequential (
										scrubs.ScrubsPlus('Vendor_Src','Scrubs_Vendor_Src','Scrubs_Bankruptcy','Bankruptcy',pversion,emailList, FALSE),
										scrubs.ScrubsPlus('Vendor_Src','Scrubs_Vendor_Src','Scrubs_Base','Base',pversion,emailList, FALSE),
										scrubs.ScrubsPlus('Vendor_Src','Scrubs_Vendor_Src','Scrubs_CollegeLocator','CollegeLocator',pversion,emailList, FALSE),
										scrubs.ScrubsPlus('Vendor_Src','Scrubs_Vendor_Src','Scrubs_CourtLocator','CourtLocator',pversion,emailList, FALSE),
										scrubs.ScrubsPlus('Vendor_Src','Scrubs_Vendor_Src','Scrubs_Lien','Lien',pversion,emailList, FALSE),
										scrubs.ScrubsPlus('Vendor_Src','Scrubs_Vendor_Src','Scrubs_MasterList','MasterList',pversion,emailList, FALSE),
										scrubs.ScrubsPlus('Vendor_Src','Scrubs_Vendor_Src','Scrubs_Orbit','Orbit',pversion,emailList, FALSE),
										);
										
end;