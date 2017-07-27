Import Data_Services, doxie;

base := PROJECT(GSA.File_GSA_Base, TRANSFORM(GSA.Layouts_GSA.layout_Base_Old, SELF := LEFT));

export Key_GSA_gsa_id := index(base,
							  {gsa_id},
							  {base},
							  Data_Services.Data_location.Prefix('GSA')+'thor_data400::key::gsa::'+doxie.Version_SuperKey+'::gsa_id');