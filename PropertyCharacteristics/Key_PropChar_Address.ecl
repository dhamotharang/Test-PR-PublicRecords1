import	doxie,ut;

dPropertyInfo	:=	PropertyCharacteristics.Files.Base.Property(prim_name	!=	''	and	prim_range	!=	''	and	zip	!=	'');

export	Key_PropChar_Address	:=	index(	dPropertyInfo,
																					{prim_name,prim_range,zip,predir,postdir,addr_suffix,sec_range},
																					{property_rid},
																					PropertyCharacteristics.Constants.CLUSTER+'key::propertyinfo::'	+	doxie.Version_SuperKey	+	'::address'
																				);