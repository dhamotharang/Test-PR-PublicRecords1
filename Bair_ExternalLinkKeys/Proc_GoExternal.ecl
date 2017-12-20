export Proc_GoExternal(string pversion, boolean pUseDelta = false) := module
				BK0		:=	BUILDINDEX(Process_PS_Layouts.Key, KeyNames(pversion,pUseDelta).meow_logical, OVERWRITE);
				BK1		:=	BUILDINDEX(Key_Classify_PS_NAME.Key, KeyNames(pversion,pUseDelta).name_logical, OVERWRITE);
				BK2		:=	BUILDINDEX(Key_Classify_PS_ADDRESS.Key, KeyNames(pversion,pUseDelta).address_logical, OVERWRITE);
				BK3		:=	BUILDINDEX(Key_Classify_PS_DOB.Key, KeyNames(pversion,pUseDelta).dob_logical, OVERWRITE);
				BK4		:=	BUILDINDEX(Key_Classify_PS_ZIP_PR.Key, KeyNames(pversion,pUseDelta).zip_logical, OVERWRITE);
				BK5		:=	BUILDINDEX(Key_Classify_PS_DLN.Key, KeyNames(pversion,pUseDelta).dln_logical, OVERWRITE);
				BK6		:=	BUILDINDEX(Key_Classify_PS_PH.Key, KeyNames(pversion,pUseDelta).ph_logical, OVERWRITE);
				BK7		:=	BUILDINDEX(Key_Classify_PS_LFZ.Key, KeyNames(pversion,pUseDelta).lfz_logical, OVERWRITE);
				BK8		:=	BUILDINDEX(Key_Classify_PS_VIN.Key, KeyNames(pversion,pUseDelta).vin_logical, OVERWRITE);
				BK9		:=	BUILDINDEX(Key_Classify_PS_LEXID.Key, KeyNames(pversion,pUseDelta).lexid_logical, OVERWRITE);
				BK10	:=	BUILDINDEX(Key_Classify_PS_SSN.Key, KeyNames(pversion,pUseDelta).ssn_logical, OVERWRITE);
				BK11	:=	BUILDINDEX(Key_Classify_PS_LATLONG.Key, KeyNames(pversion,pUseDelta).latlong_logical, OVERWRITE);
				BK12	:=	BUILDINDEX(Key_Classify_PS_PLATE.Key, KeyNames(pversion,pUseDelta).plate_logical, OVERWRITE);
				BK13	:=	BUILDINDEX(Key_Classify_PS_COMPANY.Key, KeyNames(pversion,pUseDelta).company_logical, OVERWRITE);
				BK14	:=	BUILDINDEX(Key_Classify_PS_ADDRESS1.Key, KeyNames(pversion,pUseDelta).address1_logical, OVERWRITE);

						 
	EXPORT Proc_GoExternal1	:= sequential(parallel(
								BK0,BK1,BK2,BK3,BK4,BK5,BK6,BK7,BK8,BK9,BK10,BK11,BK12,BK13,BK14), createUpdateSuperFile(pversion,pUseDelta).updateAllSF
								);
	end;
	