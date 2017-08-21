import ut, scrubs, _control,Orbit3SOA, SALT36,std,tools;

EXPORT PostBuildScrubs(string filedate ,string EmailList='') := FUNCTION

return ordered(
								scrubs.ScrubsPlus('American_Student_List','Scrubs_American_Student_List','Scrubs_American_Student_List','',filedate,emailList,false),
								Scrubs.ScrubsPlus('American_Student_List','Scrubs_American_Student_List','Scrubs_American_Student_List_Input','Input',filedate,emailList,false)
							);

end;