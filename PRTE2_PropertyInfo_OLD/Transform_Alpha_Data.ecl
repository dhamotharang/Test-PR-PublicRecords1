// REWRITE OF PRTE2_PropertyInfo.Transform_Data which did LOTS of conversion from the old Gateway file
// to the new PropertyExpandedRec layout.  This removed all that conversion and just keeping:
// * renew clean address information in case a spreadsheet change altered an address.

IMPORT address, ut;

EXPORT Transform_Alpha_Data := MODULE

		PropertyInfoRecN := Layouts.PropertyExpandedRec;
		string8 today_date := ut.GetDate; 

		EXPORT PropertyInfoRecN  Prepare_Alpharetta_Data (layouts.PropertyExpandedRec L, Integer C) := TRANSFORM
				string clean_address := address.CleanAddress182(trim(l.property_street_address), trim(l.property_city_state_zip) );
				SELF.prim_name  				:= clean_address [13..40];
				SELF.prim_range					:= clean_address [1..10];
				self.predir     				:= clean_address[11..12];
				self.addr_suffix 				:= clean_address [41..44];
				self.postdir       			:= clean_address [45..46];
				self.unit_desig    			:= clean_address [47..56];
				// SELF.sec_range  				:= L.Apt;
				SELF.p_city_name 				:= clean_address[65..89];
				SELF.v_city_name 				:= clean_address[90..114];
				SELF.st         				:= IF(clean_address [115..116] > ' ',clean_address [115..116],L.st);
				z1 						 					:= clean_address[117..121];
				z2         		 					:= (integer) z1; 
				self.zip    		 				:= (string5) INTFORMAT(z2,5,1);
				self.zip4       				:= (string) clean_address[122..125];
				SELF.property_street_address := TRIM(self.prim_range) + ' ' + TRIM(self.prim_name) + ' ' +TRIM(self.addr_suffix);
				SELF.property_city_state_zip := TRIM(self.v_city_name) + ' ' + TRIM(self.st) + ' ' + TRIM(self.zip);
				SELF.msa        				:= clean_address [167..170];
				SELF.err_stat   				:= clean_address[179..182];
				SELF.cart       				:= clean_address[126..129];
				SELF.cr_sort_sz 				:= clean_address[130];
				SELF.lot        				:= clean_address[131..134];
				SELF.lot_order  				:= clean_address[135];
				SELF.dbpc       				:= clean_address[136..137];
				SELF.chk_digit  				:= clean_address[138];
				SELF.rec_type   				:= clean_address[139..140];
				SELF.county     				:= clean_address[141..145];
				self.geo_lat    				:= clean_address[146..155];
				self.geo_long   				:= clean_address[156..166];
				SELF.geo_blk    				:= clean_address[171..177];
				SELF.geo_match  				:= clean_address[178];				
				SELF := L;
				SELF := [];
		END;

/*
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