IMPORT $;

inFile := $.Layouts.i_ParcelNum;

EXPORT Key_Foreclosure_ParcelNum := INDEX(
  {inFile.parcel_number_parcel_id}, 
  {inFile.fid}, 
  $.names().i_foreclosure_parcelnum
  );
