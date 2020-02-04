/* *********************************************************************
Hard code layouts etc so we can just run this BWR in Prod prior to migration
Then make saving this MV Base File a part of the build process.
********************************************************************* */
IMPORT promotesupers,PropertyCharacteristics,PRTE2_PropertyInfo;

tradematerials := RECORD
   string3 category;
   string3 material;
   real8 value;
   string1 quality;
   string1 condition;
   unsigned2 age;
  END;

MV_Base_Layout2 := RECORD
	PropertyCharacteristics.Layouts.Base;
END;
MV_BASE_NAME		:= '~prct::BASE::ct::propertyinfo::Alpha_MV_base';
All_Expanded := DATASET(MV_BASE_NAME, Layouts_MV.MV_Base_Layout, THOR); 
All_Expanded := PRTE2_PropertyInfo.Get_Payload.All_Expanded;
MV_Base_Layout trxData(All_Expanded L) := TRANSFORM
  Self.roof_type        := '';
  Self.src_roof_type    := '';
  Self.tax_dt_roof_type := '';	
	SELF.insurbase_codes := DATASET([],tradematerials);
	SELF := L;
END;
MV_Base_Final := PROJECT(All_Expanded,trxData(LEFT));
OUTPUT(MV_Base_Final);
OUTPUT(COUNT(MV_Base_Final));

MV_BASE_NAME		:= '~prct::BASE::ct::propertyinfo::Alpha_MV_base';
// promotesupers.mac_create_superfiles(MV_BASE_NAME);
PromoteSupers.Mac_SF_BuildProcess(MV_Base_Final, MV_BASE_NAME, build_base);
SEQUENTIAL(build_base);