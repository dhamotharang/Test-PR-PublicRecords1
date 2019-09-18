IMPORT doxie, property;

// Suppressing 4 Foreclosure IDs as part of dispute database Bug#: 60282 and bugzilla bug#: 170863
FC_ids := ['058118BANKOFAMERICA', '058118ESCOBARCARLOSG', '1079290090820TRUCAPREOCORP', '1079290090820TRUCAPGRANTORTRUST2010-1','14944559950000SOUTHERNBK&TRUST', '14944559950000RABIMIKE'];
dForeclosure := property.file_Foreclosure(TRIM(foreclosure_id, left, right) NOT IN FC_ids AND parcel_number_parcel_id != '');

//Filter invalid records, dedup
dedForeclosure := DEDUP(SORT(dForeclosure,parcel_number_parcel_id,foreclosure_id),parcel_number_parcel_id,foreclosure_id);

EXPORT Key_Foreclosure_ParcelNum := INDEX(dedForeclosure,{parcel_number_parcel_id},{string70 fid := foreclosure_id},'~thor_data400::key::foreclosure_parcelNum_' + doxie.Version_SuperKey);