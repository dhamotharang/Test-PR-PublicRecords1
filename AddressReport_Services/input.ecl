IMPORT AutoHeaderI, AutoStandardI, iesp, Relationship, doxie;

export input := MODULE
  
  EXPORT params := interface(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
                             AutoStandardI.LIBIN.PenaltyI_Addr.base,
                             doxie.IDataAccess)
    EXPORT string DataPermissionMask := ''; //INTERFACES: different definitions in base modules
  end;

  // adds "includes" specific for this service
  shared include := INTERFACE
    export boolean include_bankruptcy := false;
    export boolean include_driverslicenses := false;
    export boolean include_liensjudgments := false;
    export boolean include_motorvehicles := false;
    export boolean include_neighbors := false;
    export boolean include_properties := false;
    export boolean include_businesses := false;
    export boolean include_CensusData := false;
    export boolean Include_ResidentialPhones := false;
    export boolean Include_BusinessPhones := false;
    export boolean include_CriminalRecords := false;
    export boolean include_SexualOffenses := false;
    export boolean include_HuntingFishingLicenses := false;
    export boolean include_WeaponPermits := false;
    export boolean locationReport := false;
  end;

  export _addressreport := INTERFACE (params, include, Relationship.IParams.relationshipParams)
    export boolean useNewBusinessHeader := false;
    export string1 BusinessReportFetchLevel := 'S';
    //v--- added for Location Rpt 06/14/2016 chgs so can use hunting_fishing_services.Search_Records.params
    export string bdid;
    export unsigned2 penalty_threshold;
    export boolean SearchAroundAddress;
    export boolean setrepaddr;
    export unsigned1 setrepaddrbit;
  end;

   //***************************************************
  // iesp.ECL2ESP.SetInputAddress (ReportBy.Address);
  // Unfortunately I cannot use the standard ECL2ESP setIputAddress
  // because the input can be a single line or components and
  // I am using the clean address passing the single line address.
  //****************************************************
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
    string8 UnitNumber := global(xml_in).UnitNumber;
    #stored ('sec_range', UnitNumber);
    string60 in_streetAddress1 := global(xml_in).StreetAddress1;
    string60 in_streetAddress2 := global(xml_in).StreetAddress2;
    string addr_in := trim (in_streetAddress1) + ' ' + trim (in_streetAddress2);
    string addr := if(trim(addr_in)<>'',addr_in,
          (trim(streetNumber,left,right) + ' ' +
           trim(streetPreDirection,left,right) + ' ' +
                 trim(streetName,left,right) + ' ' +
           trim(streetSuffix) + ' ' +
           trim(streetPostDirection,left,right) + ' ' +
           trim(UnitNumber,left,right)));
    #stored('Addr',addr);
    string2 State := global(xml_in).State;
    #stored ('State', State);
    string25 City := global(xml_in).City;
    #stored ('City', City);
    string5 zip5 := global(xml_in).Zip5;
    #stored('zip',zip5);
    string50 StateCityZip := global(xml_in).StateCityZip;
    #stored('StateCityZip',StateCityZip);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  END;

END;
