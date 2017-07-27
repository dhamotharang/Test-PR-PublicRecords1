import doxie;

df := property.File_Fares_Assessor(unformatted_apn != '', fares_id != '');

export Key_Assessors_ParcelNum := index(df,{unformatted_apn},{fares_id},'~thor_Data400::key::assessors_parcelNum_' + doxie.Version_SuperKey);
