EXPORT Reinstate_Billing_Address (DATASET(Layout_HealthFacility) Input, DATASET(Layout_HealthFacility) Link_File) := FUNCTION
	
	D_Input := DISTRIBUTE (Input,HASH32(RID));
	D_Link  := DISTRIBUTE (Link_File,HASH32(RID));
	
	Billing_Address := JOIN (D_Link,D_Input,LEFT.RID = RIGHT.RID,TRANSFORM(Layout_HealthFacility,
		SELF.PRIM_RANGE										:=	RIGHT.PRIM_RANGE; 
		SELF.PREDIR												:=	RIGHT.PREDIR;
		SELF.PRIM_NAME										:=	RIGHT.PRIM_NAME;
		SELF.ADDR_SUFFIX									:=	RIGHT.ADDR_SUFFIX;
		SELF.POSTDIR											:=	RIGHT.POSTDIR;
		SELF.UNIT_DESIG										:=	RIGHT.UNIT_DESIG;
		SELF.SEC_RANGE										:=	RIGHT.SEC_RANGE;
		SELF.P_CITY_NAME									:=	RIGHT.P_CITY_NAME;
		SELF.V_CITY_NAME									:=	RIGHT.V_CITY_NAME;
		SELF.ST														:=	RIGHT.ST;
		SELF.ZIP													:=	RIGHT.ZIP;
		SELF := LEFT;),LOCAL);
	OUTPUT (COUNT(D_Input),NAMED('D_Input'));
	OUTPUT (COUNT(D_Link),NAMED('D_Link'));
	RETURN DISTRIBUTE (Billing_Address,HASH32(LNPID));
END;
