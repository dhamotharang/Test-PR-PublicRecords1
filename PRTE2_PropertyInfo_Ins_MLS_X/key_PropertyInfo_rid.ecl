/* ************************************************************************************************************************
**********************************************************************************************
***** MLS CONVERSION NOTES:
**********************************************************************************************
OLDER NOTES:
Copying the main details in PropertyCharacteristics.Key_PropChar_RID
************************************************************************************************************************ */

IMPORT PRTE_CSV, PropertyCharacteristics, ut;

EXPORT key_PropertyInfo_rid(STRING Filedate, DATASET(Layouts.Boca_Official_Layout) InData, BOOLEAN foreignProd=FALSE) := FUNCTION

		All_Expanded := InData;

		//TODO - old code with stories_type - figure out what they were doing here - should be in Transforms?
		// Reformat to bring the dataset to the payload index layout ------------------------------------------
		All_Expanded tFormat2Payload(All_Expanded	pInput)	:= TRANSFORM
				self.stories_type := if(	regexfind('^[0-9]+[.][0-9]*[0]*$',ut.CleanSpacesAndUpper(pInput.stories_type)),
																					(string)((real)pInput.stories_type),
																					pInput.stories_type);
				self	:=	pInput;
				self	:=	[];
		END;
		keyReadyData	:=	dedup(distribute(project(All_Expanded,tFormat2Payload(left)), 
																	hash32(property_rid)),property_rid,all,local);
		// -----------------------------------------------------------------------------------------------------
		// If foreignProd not specified as true then just build the key name for whatever environment you are in.
		// only used for reading the foreign key
		// -----------------------------------------------------------------------------------------------------
		STRING keyFileName := IF(foreignProd,Files.BuildKeyRIDNameProd(Filedate),Files.BuildKeyRIDName(Filedate));
		
		RETURN index(keyReadyData,
										{property_rid},
										{keyReadyData},
										keyFileName);

END;