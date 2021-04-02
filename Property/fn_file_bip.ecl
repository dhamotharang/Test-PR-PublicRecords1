IMPORT $, dx_Property;

EXPORT fn_file_bip(STRING DeedType) := FUNCTION

file_in := IF(DeedType = 'NOD',
							Property.File_Foreclosure_Normalized(TRIM(deed_category)IN Category_filter.NOD AND TRIM(foreclosure_id,LEFT,RIGHT) NOT IN Suppress_FID),
							Property.File_Foreclosure_Normalized(TRIM(deed_category)IN Category_filter.Foreclosure AND TRIM(foreclosure_id,LEFT,RIGHT) NOT IN Suppress_FID)
							);

pFileIn := DEDUP(SORT(PROJECT(file_in(site_prim_name<>'' and site_zip<>''),dx_Property.Layouts.BIP_layout),RECORD,-source_rec_id),RECORD, EXCEPT source_rec_id);

RETURN pFileIn(UltID > 0);

END;