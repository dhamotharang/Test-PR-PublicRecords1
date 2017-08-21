import business_header,ut;

export Vehicle_as_Business_Contact
 :=	fVehicle_as_Business_Contact(VehLic.File_Base_Vehicles_Prod)
 :	persist(business_header.Bus_Thor + 'persist::VehLic::Vehicle_as_Business_Contact')
 ;
