import	doxie,ut;

dPropertyInfo	:=	PropertyCharacteristics.Files.Base.Property;

export	Key_Best_PropAddr_RID	:=	index(	dPropertyInfo,
																					{property_rid},
																					{dPropertyInfo},
																					PropertyCharacteristics.Constants.CLUSTER+'key::propertyinfo::'	+	doxie.Version_SuperKey	+	'::rid');