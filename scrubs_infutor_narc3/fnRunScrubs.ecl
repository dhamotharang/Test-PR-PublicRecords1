IMPORT ut,scrubs_infutor_narc3,scrubs,std,tools;

EXPORT fnRunScrubs(string pVersion, string emailList='') := function
return scrubs.ScrubsPlus('infutor_narc3','scrubs_infutor_narc3','Scrubs_infutor_narc3_raw','raw',pVersion,emailList,false);
          //               DatasetName,     ScrubsModule,          ScrubsProfileName,       scope 
end;
