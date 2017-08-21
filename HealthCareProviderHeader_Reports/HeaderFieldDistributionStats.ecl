IMPORT HealthCareProvider, ut;
EXPORT HeaderFieldDistributionStats (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Header_DS) := FUNCTION
	
	Good_License_DS	:=	Header_DS (C_LIC_NBR_FLAG = 'G');
	
	Dedup_Lic_DS		:=	DEDUP(SORT (Good_License_DS,LNPID,LIC_NBR,LIC_STATE,LOCAL),LNPID,LIC_NBR,LIC_STATE,LOCAL);
	
	License_By_State := TABLE (Dedup_Lic_DS,{LIC_STATE,LIC_Count := COUNT(GROUP)}, LIC_STATE, MERGE);
	
	Valid_Lic_By_State := OUTPUT (SORT(License_By_State,LIC_STATE),NAMED('Valid_License_Nbr_By_State'));

	Good_DEA_DS	:=	Header_DS (DEA_NUMBER_FLAG IN ['O','G']);
	
	Dedup_DEA_DS		:=	DEDUP(SORT (Good_DEA_DS,LNPID,DEA_NUMBER,ST,LOCAL),LNPID,DEA_NUMBER,ST,LOCAL);
	
	DEA_By_State := TABLE (Dedup_DEA_DS,{ST,DEA_Count := COUNT(GROUP)}, ST, MERGE);
	
	Valid_DEA_By_State := OUTPUT (SORT(DEA_By_State,ST),NAMED('Valid_DEA_Nbr_By_State'));

	Good_DOB_DS	:=	Header_DS (DOB_FLAG = 'G');
	
	Dedup_DOB_DS		:=	DEDUP(SORT (Good_DOB_DS,LNPID,DOB,ST,LOCAL),LNPID,DOB,ST,LOCAL);
	
	DOB_By_State := TABLE (Dedup_DOB_DS,{ST,DOB_Count := COUNT(GROUP)}, ST, MERGE);
	
	Valid_DOB_By_State := OUTPUT (SORT(DOB_By_State,ST),NAMED('Valid_DOB_By_State'));

	Good_NPI_DS	:=	Header_DS (NPI_NUMBER_FLAG IN ['O','G']);
	
	Dedup_NPI_DS		:=	DEDUP(SORT (Good_NPI_DS,LNPID,NPI_NUMBER,ST,LOCAL),LNPID,NPI_NUMBER,ST,LOCAL);
	
	NPI_By_State := TABLE (Dedup_NPI_DS,{ST,NPI_Count := COUNT(GROUP)}, ST, MERGE);
	
	Valid_NPI_By_State := OUTPUT (SORT(NPI_By_State,ST),NAMED('Valid_NPI_By_State'));
	
	State_DOB_Ds := PROJECT (DEDUP(SORT(DEDUP(SORT(Header_DS (DOB_FLAG = 'G'),LNPID,LOCAL),DOB,LOCAL),DOB),DOB),TRANSFORM(HealthCareProviderHeader_Reports.Layouts.State_Age_Rec, SELF.Age := ut.GetAge(INTFORMAT(LEFT.DOB,8,1)); SELF := LEFT;));

	S_State_DOB_DS	:=	SORT (State_DOB_Ds,ST,Age);
	
	Age_Breakdown := RECORD
		State 				:= 	S_State_DOB_DS.ST;
		Age_1_to_14 	:=	COUNT (GROUP,S_State_DOB_DS.Age >= 1  AND S_State_DOB_DS.Age <= 14);
		Age_15_to_19 	:=	COUNT (GROUP,S_State_DOB_DS.Age >= 15 AND S_State_DOB_DS.Age <= 19);
		Age_20_to_24 	:=	COUNT (GROUP,S_State_DOB_DS.Age >= 20 AND S_State_DOB_DS.Age <= 24);
		Age_25_to_29 	:=	COUNT (GROUP,S_State_DOB_DS.Age >= 25 AND S_State_DOB_DS.Age <= 29);
		Age_30_to_34 	:=	COUNT (GROUP,S_State_DOB_DS.Age >= 30 AND S_State_DOB_DS.Age <= 34);
		Age_35_to_39 	:=	COUNT (GROUP,S_State_DOB_DS.Age >= 35 AND S_State_DOB_DS.Age <= 39);
		Age_40_to_44 	:=	COUNT (GROUP,S_State_DOB_DS.Age >= 40 AND S_State_DOB_DS.Age <= 44);
		Age_45_to_49 	:=	COUNT (GROUP,S_State_DOB_DS.Age >= 45 AND S_State_DOB_DS.Age <= 49);
		Age_50_to_54 	:=	COUNT (GROUP,S_State_DOB_DS.Age >= 50 AND S_State_DOB_DS.Age <= 54);
		Age_50_to_59 	:=	COUNT (GROUP,S_State_DOB_DS.Age >= 55 AND S_State_DOB_DS.Age <= 59);
		Age_GT_59			:=	COUNT (GROUP,S_State_DOB_DS.Age > 59);
	END;
	
	State_Age_Ds := SORT (TABLE (S_State_DOB_Ds,Age_Breakdown,ST),STATE);
	
	State_Age_Distribution := OUTPUT (SORT(State_Age_Ds,STATE),NAMED('State_Age_Distribution'));
	
	Lic_Type_Stats := OUTPUT (SORT(TABLE (Header_DS(LIC_Type <> ''),{LIC_STATE, Lic_Type, cnt := COUNT(GROUP)},LIC_STATE,LIC_Type,MERGE),LIC_STATE,LIC_TYPE),,'~thor::lic_type::stats',compressed,overwrite,expire(10));
	
	RETURN SEQUENTIAL (Valid_Lic_By_State,Valid_DEA_By_State,Valid_DOB_By_State,Valid_NPI_By_State,State_Age_Distribution,Lic_Type_Stats);
END;
