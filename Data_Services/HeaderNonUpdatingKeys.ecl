export HeaderNonUpdatingKeys := macro
output(choosen(Header.key_fname_ngram,10));
output(choosen(Header.key_lname_ngram,10));
output(choosen(Header.key_Phonetic_equivs_fname,10));
output(choosen(Header.key_Phonetic_equivs_lname,10));
output(choosen(AddrFraud.Key_GeoInfo_Geolink,10));
output(choosen(AddrFraud.Key_GeoLink_LatLon,10));
output(choosen(AddrFraud.Key_Distance_GeoLinkToGeoLink,10));
output(choosen(AddrFraud.Key_GeoLinkDistance_GeoLink,10));
output(choosen(AddrFraud.Key_Distance_GeoLinkToGeoLink,10));
output(choosen(AddrFraud.Key_GeoLinkDistance_GeoLink,10));
output(choosen(Address_Attributes.key_sexoffender_geolink,10));
output(choosen(Address_Attributes.key_FireDepartment_geolink,10));

endmacro;