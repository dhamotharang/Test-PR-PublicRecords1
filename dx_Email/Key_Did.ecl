IMPORT $, Data_Services, Doxie;

inFile := $.Layouts.i_DID;    
			   
EXPORT Key_Did(boolean isFCRA = false) := INDEX({infile.did, infile.email_rec_key}
																								,inFile
																								,IF(isFCRA,
																										Data_Services.Data_location.Prefix('Email_Data')+'thor_200::key::email_datav2::fcra::'+doxie.Version_SuperKey+'::did'
																										,Data_Services.Data_location.Prefix('Email_Data')+'thor_200::key::email_dataV2::'+doxie.Version_SuperKey+'::did')
																								);

