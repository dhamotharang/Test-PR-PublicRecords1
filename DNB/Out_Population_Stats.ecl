import Business_Header;

export Out_Population_Stats(

	string pversion

) :=
function

		dasbh := fDNB_As_Business_Header	(File_DNB_Base_Plus					);
		
		return Business_Header.fAsBusinessHeaderStats(
						dasbh 																				//pInput
					 ,'DNB'                       									//pBuildName
					 ,pversion                    									//pVersion
					 ,'DATA'                      									//pBuildSubset			
					 ,'AsBusinessHeader'      											//pBuildView				
					 ,'Population'                									//pBuildType				
					 ,Email_Notification_Lists.SprayCompletion      //pEmailNotifyList	
					 ,false                       									//pTranslateSource	
					);


end;