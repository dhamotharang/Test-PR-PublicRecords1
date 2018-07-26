import ut, scrubs, _control,Orbit3SOA, SALT33,tools,std,scrubs_infutor_narc;

EXPORT PostBuildScrubs(string filedate,string emailList='') := FUNCTION

return	Scrubs.ScrubsPlus('Infutor_Narc','Scrubs_Infutor_Narc','Scrubs_Infutor_Narc_Base','Base',filedate,emaillist);

end;
