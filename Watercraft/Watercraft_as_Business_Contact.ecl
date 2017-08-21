#OPTION('multiplePersistInstances',FALSE);
import business_header, ut;

export Watercraft_as_Business_Contact :=
	fWatercraft_as_Business_Contact(Watercraft.File_Base_Search_Prod(source_code != 'W1')) 
 :persist(business_header.Bus_Thor() + 'persist::Watercraft::Watercraft_as_Business_Contact');
