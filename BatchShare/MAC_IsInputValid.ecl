//This Function Macro validates the minimal input criteria per validMinInput_enum defined in BatchShare.Constants
EXPORT MAC_IsInputValid(ds_in,valMinInput_enum):=FUNCTIONMACRO
IMPORT BatchShare,ut;

	c_enum :=BatchShare.Constants.Valid_Min_Cri;
	//FILTERS
	has_Name     := ds_in.name_first<>'' AND ds_in.name_last<>'';
	has_Address  := (ds_in.prim_range<>'' OR ut.isPOBox(ds_in.prim_name) OR ut.isRR(ds_in.prim_name))
									 AND ds_in.prim_name<>''
									 AND ((ds_in.p_city_name<>'' AND ds_in.st<>'') OR ds_in.z5<>'');
	has_SSN      := (UNSIGNED)ds_in.SSN<>0;
	has_DOB      := (UNSIGNED)ds_in.DOB<>0;
	has_DID      := ds_in.DID<>0;
	RETURN CASE(valMinInput_enum
							,c_enum.DID                                 => has_DID
							,c_enum.DID_OR_Name_Address                 => has_DID OR (has_Name AND has_Address)
							,c_enum.DID_OR_Name_WITH_DOB_OR_SSN         => has_DID OR (has_Name AND (has_SSN OR has_DOB))
							,c_enum.DID_OR_Name_Address_WITH_DOB_OR_SSN => has_DID OR (has_Name AND has_Address AND (has_SSN OR has_DOB))
							,FALSE);
ENDMACRO;