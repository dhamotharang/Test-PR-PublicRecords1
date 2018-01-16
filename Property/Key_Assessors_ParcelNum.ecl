import doxie,Data_Services;

df := property.File_Fares_Assessor(unformatted_apn != '', fares_id != '');

export Key_Assessors_ParcelNum := index(df,{unformatted_apn},{fares_id},Data_Services.Data_location.Prefix()+'thor_data400::key::assessors_parcelNum_' + doxie.Version_SuperKey);
