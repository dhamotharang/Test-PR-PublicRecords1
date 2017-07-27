IMPORT Data_Services, doxie;

base := PROJECT(GSA.File_GSA_Base(did != 0), TRANSFORM(GSA.Layouts_GSA.layout_Base_Old, SELF := LEFT));

EXPORT Key_GSA_DID := INDEX(base,
							              {DID},
							              {base},
							              Data_Services.Data_location.Prefix('GSA') +
															 'thor_data400::key::gsa::' + doxie.Version_SuperKey + '::did');