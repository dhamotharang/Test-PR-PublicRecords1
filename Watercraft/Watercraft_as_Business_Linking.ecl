#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header, ut;

EXPORT Watercraft_as_Business_Linking :=	
 fWatercraft_as_Business_Linking(Watercraft.File_Base_Search_Prod(source_code != 'W1'))
 :PERSIST(Business_Header.Bus_Thor(TRUE) + 'persist::Watercraft::Watercraft_as_Business_Linking'); //Set to TRUE for prod
