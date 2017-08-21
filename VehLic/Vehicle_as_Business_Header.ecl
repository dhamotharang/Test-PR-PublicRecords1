import business_header,business_header_ss,ut,mdr,Business_HeaderV2;

export Vehicle_as_Business_Header
 :=	fVehicle_as_Business_Header(Business_HeaderV2.Source_Files.Vehicles.BusinessHeader)
 :	persist(business_header._dataset().thor_cluster_Persists + 'persist::vehlic::Vehicle_as_Business_Header')
 ;

