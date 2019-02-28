IMPORT scrubs,_Scrubs_VendorSrc_Base,std,ut,tools;

EXPORT IndvidualBaseFileScrubs(string pVersion, string emailList) := function

return sequential(

// EXPORT ScrubsPlus(DatasetName,ScrubsModule,ScrubsProfileName,ScopeName='',filedate,emailList='', UseOnFail=false)	:=	FUNCTIONMACRO 

                  scrubs.ScrubsPlus('Base','_Scrubs_VendorSrc_Base','','',pVersion,emailList,false));
									//scrubs.ScrubsPlus('Base','Scrubs_Base','Scrubs_Base_iConectivMain','iConnectivMain',pVersion,emailList,false),);
end;