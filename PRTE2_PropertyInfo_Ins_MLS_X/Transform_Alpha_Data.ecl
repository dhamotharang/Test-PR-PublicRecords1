/* ************************************************************************************************************************
**********************************************************************************************
***** MLS CONVERSION NOTES:
**********************************************************************************************
OLDER NOTES:
Called during Get_Payload 

This is to do final conversion of the CSV base file into the Boca Compatible base file (someday the build may be Boca code)
After we do this conversion we should save a new Alpha_Base_File that in the future Boca build can read.
Till then our final build should read the DS saved by that name to be most compatible.
*************************************************************************************
April 2017 - this is gotten pretty minimal - but leaving it here because we may find more that needs preparing
************************************************************************************************************************ 
// OLD NOTES around 2014 - we removed a very poorly compatible gateway layout and moved to a more compatible layout
// REWRITE OF PRTE2_PropertyInfo_Ins.Transform_Data which did LOTS of conversion from the old Gateway file
// to the new PropertyExpandedRec layout.  This removed all that conversion and just keeping:
// * renew clean address information in case a spreadsheet change altered an address.
************************************************************************************************************************ */

IMPORT PRTE2_Common, address, ut;

EXPORT Transform_Alpha_Data := MODULE

		AlphaPropertyCSVRec := Layouts.AlphaPropertyCSVRec;
		Boca_Official_Layout := Layouts.Boca_Official_Layout;
		
		EXPORT Boca_Official_Layout  Prepare_Final_Layout (AlphaPropertyCSVRec L, Integer C) := TRANSFORM
				SELF := L;
				SELF := [];
		END;

END;