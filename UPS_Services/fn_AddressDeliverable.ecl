IMPORT iesp, address;

EXPORT fn_AddressDeliverable(iesp.share.t_Address addr) := FUNCTION
  addrStreet := IF (addr.StreetAddress1 <> '',
                    addr.StreetAddress1,
                    Address.Addr1FromComponents(addr.StreetNumber,
                                                addr.StreetPreDirection,
                                                addr.StreetName,
                                                addr.StreetSuffix,
                                                addr.StreetPostDirection,
                                                addr.UnitDesignation,
                                                addr.UnitNumber));

  addrCityStZip := Address.Addr2FromComponents(addr.City,
                                               addr.State,
                                               addr.Zip5);

  addrClean := Address.GetCleanAddress(addrStreet,
                                       addrCityStZip,
                                       address.Components.Country.US).results;

//output(addrStreet);
//output(addrCityStZip);
//output(addrClean);

  deliverable := IF(addrClean.zip4 = '', FALSE, TRUE);
  RETURN deliverable;
END;
