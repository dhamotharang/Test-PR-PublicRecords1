IMPORT $, Data_Services, Doxie;

inFile := $.Layouts.i_domain_lkp;

EXPORT Key_domain_lkp()    :=  INDEX({inFile.domain_name}
													  	  	,inFile
														  	  ,Data_Services.Data_location.Prefix('Email_Data')+'thor_data400::key::email_dataV2::'+doxie.Version_SuperKey+'::Domain_lkp');
															
															
