IMPORT AutoKey;

EXPORT layout_LatLong := record
  // NOTE: INDEX doesn't support keyed fields of type REAL or DECIMAL!  So, we
  //       will be scaling all lat/long values by 10^6, since we have values to
  //       six places (around a half a foot of error) in the rooftop library.
  integer4 lat;
  integer4 long;
  AutoKey.Layout_Zip and not [zip,minit];
end;