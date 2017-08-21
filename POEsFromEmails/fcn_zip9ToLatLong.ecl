import Address;

  export fcn_zip9ToLatLong( string5 zip, string4 zip4 ) := FUNCTION
    string zip9 := IF(zip4<>'',zip+zip4,IF(zip<>'', zip+'0000', ''));
//    geo := IF( zip9 = '', '', Address.Zip9toGeo34(zip9) );
    geo := IF( zip9 = '', '', Address.Zip9ToGeo34(zip9) );
		return geo;
	END;
