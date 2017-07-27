import iesp;

export ECL2ESP_test := MODULE


 // EXPORT SetInputAddress (iesp.instantid.t_UniversalAddress2 xml_in) := FUNCTION
    // string50 Address1 := global(xml_in).Address1;	// check the size of these fields, they are just guesses for now
    // #stored ('Address1', Address1);
    // string50 Address2 := global(xml_in).Address2;
    // #stored ('Address2', Address2);
    // string50 Address3 := global(xml_in).Address3;
    // #stored ('Address3', Address3);
    // string50 Address4 := global(xml_in).Address4;
    // #stored ('Address4', Address4);
    // string50 Region := global(xml_in).Region;
    // #stored ('Region', Region);
    // string20 Principality := global(xml_in).Principality;
    // #stored ('Principality', Principality);
    // string20 Premise := global(xml_in).Premise;
    // #stored ('Premise', Premise);
    // string8 SubBuildingNumber := global(xml_in).SubBuildingNumber;
    // #stored ('SubBuildingNumber', SubBuildingNumber);
    // string5 SubStreet := global(xml_in).SubStreet; 
    // #stored('SubStreet',SubStreet);
    // string50 SubCity := global(xml_in).SubCity; 
    // #stored('SubCity',SubCity);
    // return output (dataset ([],{integer x}), named('__internal__'), extend);
  // END;
	
	
  EXPORT SetInputAddress (iesp.share.t_Address xml_in) := FUNCTION
    string28 streetName := global(xml_in).StreetName;
    #stored ('prim_name', streetName);
    string10 streetNumber := global(xml_in).StreetNumber;
    #stored ('prim_range', streetNumber);
    string2 streetPreDirection := global(xml_in).StreetPreDirection;
    #stored ('predir', streetPreDirection);
    string2 streetPostDirection := global(xml_in).StreetPostDirection;
    #stored ('postdir', streetPostDirection);
    string4 streetSuffix := global(xml_in).StreetSuffix;
    #stored ('suffix', streetSuffix);
      // string10 UnitDesignation {xpath('UnitDesignation')};
    string8 UnitNumber := global(xml_in).UnitNumber;
    #stored ('sec_range', UnitNumber);
    string60 in_streetAddress1 := global(xml_in).StreetAddress1;
    string60 in_streetAddress2 := global(xml_in).StreetAddress2;
    string addr := trim (in_streetAddress1) + ' ' + trim (in_streetAddress2);
    #stored('Addr',addr);
    string2 State := global(xml_in).State;
    #stored ('State', State);
    string25 City := global(xml_in).City;
    #stored ('City', City);
    string5 zip5 := global(xml_in).Zip5; 
    #stored('zip',zip5);
    // string4 Zip4 {xpath('Zip4')};
    // string18 County {xpath('County')};
    // string6 PostalCode {xpath('PostalCode')};
    string50 StateCityZip := global(xml_in).StateCityZip; 
    #stored('StateCityZip',StateCityZip);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  END;
	
END;