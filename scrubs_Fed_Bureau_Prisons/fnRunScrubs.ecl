IMPORT ut,scrubs_Fed_Bureau_Prisons,scrubs,std,tools;

EXPORT fnRunScrubs(string pVersion, string emailList='') := function

return scrubs.ScrubsPlus('Fed_Bureau_Prisons','scrubs_Fed_Bureau_Prisons','ScrubsAlerts_Federal_Bureau_Prisons','raw',pVersion,emailList,false);
          //               DatasetName,     ScrubsModule,          ScrubsProfileName,       scope 


end;

