IMPORT $, doxie, Data_Services;

inFile := $.Layouts.i_ParcelNum;

EXPORT Key_Foreclosure_ParcelNum := INDEX({inFile.parcel_number_parcel_id},{inFile.fid}
																					,Data_Services.Data_location.prefix('foreclosure') + 'thor_data400::key::foreclosure_parcelNum_' + doxie.Version_SuperKey);