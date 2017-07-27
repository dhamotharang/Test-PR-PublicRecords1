import doxie;

df := property.File_Fares_Deeds(apn_parcel_number_unformatted != '', fares_id != '');

export Key_Deeds_ParcelNum := index(df,{apn_parcel_number_unformatted},{fares_id},'~thor_Data400::key::deeds_parcelNum_' + doxie.Version_SuperKey);
