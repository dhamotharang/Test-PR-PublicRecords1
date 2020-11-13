IMPORT $, dx_Property;

dForeclosure := property.File_Foreclosure_Base_v2(TRIM(foreclosure_id,LEFT,RIGHT) NOT IN Suppress_FID AND parcel_number_parcel_id != '');

l_key	:= RECORD
	STRING45	parcel_number_parcel_id;
	STRING70 fid; //used for key index
END;

pFile	:= PROJECT(dForeclosure, TRANSFORM(l_key, SELF.fid := LEFT.foreclosure_id; SELF := LEFT));
	

//Filter invalid records, dedup
dedForeclosure := DEDUP(SORT(pFile,parcel_number_parcel_id,fid),parcel_number_parcel_id,fid);

EXPORT file_ParcelNum_Key := dedForeclosure;