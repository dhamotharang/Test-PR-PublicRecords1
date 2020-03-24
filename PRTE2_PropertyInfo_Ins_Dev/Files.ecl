IMPORT PRTE2_Common,PropertyCharacteristics;

EXPORT Files := MODULE

	EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;

	EXPORT Live_Real_Base_Name		:= Add_Foreign_prod('~thor_data400::base::propertyinfo');
	EXPORT Live_Real_Base_DS_Prod	:= DATASET(Live_Real_Base_Name,Layouts.Live_ProdData_Base,THOR);

	// will have to run these in PROD Thor ... Or below create a Key definition with the Add_Foreign_Prod for the name 
	EXPORT RealProdAddrKey := PropertyCharacteristics.Key_PropChar_Address;
	EXPORT RealProdRidKey 	:= PropertyCharacteristics.Key_PropChar_RID;

	SHARED CTRidKeyName := '~prte::key::propertyinfo::qa::rid';
	SHARED CTAddrKeyName := '~prte::key::propertyinfo::qa::address';
	SHARED CTRidKeyNameProd := Add_Foreign_prod(CTRidKeyName);
	SHARED CTAddrKeyNameProd := Add_Foreign_prod(CTAddrKeyName);

	EXPORT CT_Addr_Key := Index(RealProdAddrKey, CTAddrKeyName);		
	EXPORT CT_Rid_Key := Index(RealProdRidKey, CTRidKeyName);		
	EXPORT CT_Addr_KeyProd := Index(RealProdAddrKey, CTAddrKeyNameProd);		
	EXPORT CT_Rid_KeyProd := Index(RealProdRidKey, CTAddrKeyNameProd);		
	
END;