/* ************************************************************************************************************************
This is to do final conversion of the CSV base file into the Boca Compatible base file (someday the build may be Boca code)
After we do this conversion we should save a new Alpha_Base_File that in the future Boca build can read.
Till then our final build should read the DS saved by that name to be most compatible.
*************************************************************************************
April 2017 - this is gotten pretty minimal - but leaving it here because we may find more that needs preparing
************************************************************************************************************************ */
// OLD NOTES around 2014 - we removed a very poorly compatible gateway layout and moved to a more compatible layout
// REWRITE OF PRTE2_PropertyInfo_Ins.Transform_Data which did LOTS of conversion from the old Gateway file
// to the new PropertyExpandedRec layout.  This removed all that conversion and just keeping:
// * renew clean address information in case a spreadsheet change altered an address.

IMPORT PRTE2_Common, address, ut;

EXPORT Transform_Alpha_Data := MODULE

		// tradematerial_Lay := Layouts.tradematerials;
		// SELF.insurbase_codes := DATASET([],tradematerial_Lay);  Terri says this is handled by the SELF := [];
		
		AlphaPropertyCSVRec := Layouts.AlphaPropertyCSVRec;
		Boca_Official_Layout := Layouts.Boca_Official_Layout;
		
		string8 today_date := PRTE2_Common.Constants.TodayString; 

		EXPORT Boca_Official_Layout  Prepare_Alpharetta_Data (AlphaPropertyCSVRec L, Integer C) := TRANSFORM
				SELF := L;
				SELF := [];
		END;

/* //TODO - do we want to do more tax_dt like this?
				SELF.tax_dt_air_conditioning_type := IF (L.air_conditioning_type='','',L.tax_dt_air_conditioning_type);
				SELF.tax_dt_basement_finish := IF (L.basement_finish='','',L.tax_dt_basement_finish);
				SELF.tax_dt_construction_type := IF (L.construction_type='','',L.tax_dt_construction_type);
				SELF.tax_dt_exterior_wall := IF (L.exterior_wall='','',L.tax_dt_exterior_wall);
				SELF.tax_dt_fireplace_type := IF (L.fireplace_type='','',L.tax_dt_fireplace_type);
				SELF.tax_dt_garage := IF (L.garage='','',L.tax_dt_garage);
				SELF.tax_dt_heating := IF (L.heating='','',L.tax_dt_heating);
				SELF.tax_dt_parking_type := IF (L.parking_type='','',L.tax_dt_parking_type);
				SELF.tax_dt_pool_type := IF (L.pool_type='','',L.tax_dt_pool_type);
				SELF.tax_dt_roof_cover := IF (L.roof_cover='','',L.tax_dt_roof_cover);
				SELF.tax_dt_foundation := IF (L.foundation='','',L.tax_dt_foundation);
				SELF.tax_dt_water := IF (L.water='','',L.tax_dt_water);
				SELF.tax_dt_sewer := IF (L.sewer='','',L.tax_dt_sewer);
				SELF.tax_dt_floor_type := IF (L.floor_type='','',L.tax_dt_floor_type);
				SELF.tax_dt_style_type := IF (L.style_type='','',L.tax_dt_style_type);
*/

END;