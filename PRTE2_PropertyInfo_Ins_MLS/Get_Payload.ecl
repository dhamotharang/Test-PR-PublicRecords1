/* ************************************************************************************************************************
**********************************************************************************************
***** MLS CONVERSION NOTES:
**********************************************************************************************
OLDER NOTES:
// PRTE2_PropertyInfo_Ins_MLS.Get_Payload
// JOIN the existing Property Info key files into one expanded payload file. 
// Create a new payload with new Customer Test data
// (change 'propertybluebook' to 'propertyinfo').
************************************************************************************************************************ */

IMPORT PRTE2_Common,PRTE_CSV,PRTE, ut,NID,Doxie,address,_control,PRTE,iesp,ut,Doxie,address,STD,NID,AutoKeyB2,autokey,AutoKeyI;

EXPORT Get_payload := MODULE

		// NOTE: We discovered that the "Boca" base that was lost on edata12, was actually Linda's dataloaded by her
		// SO IT WAS NOT Boca data - we emptied the Boca Base file - someday when they want data for PropInfo they can add some
		SHARED AlphaPropertyCSVRec := Layouts.AlphaPropertyCSVRec_MLS;
		SHARED Boca_Official_Layout := Layouts.Boca_Official_Layout;

		// This should now be in the new layout AlphaPropertyCSVRec_MLS
		SHARED AlphaDS := Files.PII_ALPHA_BASE_SF_DS;

		SHARED Boca_Official_Layout  Prepare_Final_Layout (AlphaDS L) := TRANSFORM
				SELF := L;
				SELF := [];
		END;

//* Create new payload from Customer Test data	
	EXPORT All_Expanded := FUNCTION

			// next step simply TRANSFORMS to Boca_Official_Layout
			Reformat_DS 			:= PROJECT(AlphaDS, Prepare_Final_Layout (LEFT));
			// After this transform - this should now be in the new layout Boca_Official_Layout, SORT/DEDUP
			Sort_Reformat_DS  := SORT(Reformat_DS, RECORD, EXCEPT property_rid);
			Dedup_Reformat_DS := DEDUP(Sort_Reformat_DS, RECORD, EXCEPT property_rid);

			// ****************************************************************************************************
			// FEB 2020 - not needed really since we no longer "generate" new source records, but won't hurt either
			// ----- Renumber RIDs after the DEDUP just in case  -------------------------- 
			// TODO - if Boca ever adds data, talk to them about keeping RIDs unique so we don't clash
			Dedup_Reformat_DS  Resequence_AlphaDS (Dedup_Reformat_DS L, Integer C) := TRANSFORM
					self.property_rid   := (unsigned) Constants.ALPHA_RID_CONSTANT + C;
					SELF := L;
					SELF := [];
			END;		
			KeyPropertyInfo 	:= PROJECT(Dedup_Reformat_DS, Resequence_AlphaDS (Left, Counter));
			// ****************************************************************************************************
			
			RETURN KeyPropertyInfo;
	END;
	
END;
