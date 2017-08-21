Import Busreg;
Export as_header := module
 	EXPORT new_business_header := Busreg.fBusReg_As_Business_Header(files.DS_busreg_company(BDID>0),true); 
	EXPORT new_business_linking := Busreg.fBusReg_As_Business_Linking(files.DS_busreg_company(BDID>0),files.DS_busreg_contacts); 
  EXPORT new_business_contact := Busreg.fBusReg_As_Business_contact(files.DS_busreg_company(BDID>0),files.DS_busreg_contacts,true); 

End;