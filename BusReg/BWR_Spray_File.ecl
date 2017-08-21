import _control,busreg;
FileDate :='20170801';  //vendor raw input folder date 
Busreg.fSprayFiles(
	 pServerIP		 := _control.IPAddress.edata10
	,pDirectory		:= '/prod_data_build_10/production_data/business_headers/accutrend/out/'+filedate
	,pFilename		 := 'accutrend.input.*txt'
	,pversion    := FileDate     
	,pGroupName		:= busreg._dataset().groupname																		
	,pIsTesting		:= false
	,pOverwrite		:= false
	,pNameOutput	:= busreg._Dataset().Name + ' Spray Info'	
	,PEmailList  := Email_Notification_Lists.ScrubsPlus
);                                                                                  
