/* *********************************************************************************************
Copying the details in PropertyCharacteristics.Key_PropChar_RID
********************************************************************************************* */

IMPORT PRTE_CSV, PropertyCharacteristics, ut;

// This was originally all in NEW_process_build_propertyinfo, so search history there to see older changes

EXPORT key_PropertyInfo_rid(STRING Filedate) := FUNCTION

		All_Expanded := Get_Payload.All_Expanded;
		Boca_Layout := PropertyCharacteristics.Layouts.Base;
		
		// Reformat to bring the dataset to the payload index layout ------------------------------------------
		Boca_Layout tFormat2Payload(All_Expanded	pInput)	:= TRANSFORM
		self.stories_type := if(	regexfind('^[0-9]+[.][0-9]*[0]*$',ut.CleanSpacesAndUpper(pInput.stories_type)),
																					(string)((real)pInput.stories_type),
																					pInput.stories_type
																				);
		self	:=	pInput;
		self	:=	[];
		END;
		keyReadyData	:=	dedup(distribute(project(All_Expanded,tFormat2Payload(left)), 
																	hash32(property_rid)),property_rid,all,local);
		// -----------------------------------------------------------------------------------------------------
		STRING keyFileName := Files.BuildKeyRIDName(Filedate);
		
		RETURN index(keyReadyData,
										{property_rid},
										{keyReadyData},
										keyFileName);

END;