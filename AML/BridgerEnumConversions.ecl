IMPORT STD;

EXPORT BridgerEnumConversions := MODULE

    SHARED DEFAULT_CODE := 999;


    EXPORT convertAddressType(STRING addrType) := CASE(STD.Str.ToUpperCase(TRIM(addrType)),
                                                        'NONE' => 0,
                                                        'CURRENT' => 1,
                                                        'MAILING' => 2,
                                                        'PREVIOUS' => 3,
                                                        'UNKNOWN' => 4,
                                                        DEFAULT_CODE); 


    EXPORT convertEntityType(STRING entityType) := CASE(STD.Str.ToUpperCase(TRIM(entityType)),
                                                        'NONE' => 0,
                                                        'UNKNOWN' => 1,
                                                        'INDIVIDUAL' => 2,
                                                        'BUSINESS' => 3,
                                                        'VESSEL' => 4,
                                                        'COUNTRY' => 5,
                                                        'UNSTRUCTURED' => 6,
                                                        'TEXT' => 7,
                                                        DEFAULT_CODE); 


    EXPORT convertEntityID(STRING entityID) := CASE(STD.Str.ToUpperCase(TRIM(entityID)),
                                                    'NONE' => 0,
                                                    'ACCOUNT' => 1,
                                                    'CEDULA' => 2,
                                                    'DRIVERSLICENSE' => 3,
                                                    'EIN' => 4,
                                                    'MEMBER' => 5,
                                                    'MILITARY' => 6,
                                                    'NATIONAL' => 7,
                                                    'NIT' => 8,
                                                    'OTHER' => 9,
                                                    'PASSPORT' => 10,
                                                    'SSN' => 11,
                                                    'TAXID' => 12,
                                                    'VISA' => 13,
                                                    'EFTCODE' => 14,
                                                    'ABAROUTING' => 15,
                                                    'ALIENREGISTRATION' => 16,
                                                    'CHIPSUID' => 17,
                                                    'DUNS' => 18,
                                                    'IBAN' => 19,
                                                    'SWIFTBIC' => 20,
                                                    'BANKIDENTIFIERCODE' => 21,
                                                    'BANKPARTYID' => 22,
                                                    'CUSTOMERNUMBER' => 23,
                                                    'GLN' => 24,
                                                    'IBEI' => 25,
                                                    'SWIFTBEI' => 26,
                                                    'PROPRIETARYUID' => 27,
                                                    DEFAULT_CODE); 


    EXPORT convertAdditionalInfoType(STRING infoType) := CASE(STD.Str.ToUpperCase(TRIM(infoType)),
                                                              'NONE' => 0,
                                                              'CITIZENSHIP' => 1,
                                                              'COMPLEXION' => 2,
                                                              'DISTINGUISHINGMARKS' => 3,
                                                              'DOB' => 4,
                                                              'EYECOLOR' => 5,
                                                              'HAIRCOLOR' => 6,
                                                              'HEIGHT' => 7,
                                                              'MOTHERSNAME' => 8,
                                                              'NATIONALITY' => 9,
                                                              'OCCUPATION' => 10,
                                                              'PLACEOFBIRTH' => 11,
                                                              'POSITION' => 12,
                                                              'RACE' => 13,
                                                              'VESSELCALLSIGN' => 14,
                                                              'VESSELFLAG' => 15,
                                                              'VESSELGRT' => 16,
                                                              'VESSELOWNER' => 17,
                                                              'VESSELTONNAGE' => 18,
                                                              'VESSELTYPE' => 19,
                                                              'WEIGHT' => 20,
                                                              'INCIDENT' => 21,
                                                              'OTHER' => 22,
                                                              'IPADDRESS' => 23,
                                                              DEFAULT_CODE); 
                                                              

    EXPORT convertAKAType(STRING akaType) := CASE(STD.Str.ToUpperCase(TRIM(akaType)),
                                                  'NONE' => 0,
                                                  'AKA' => 1,
                                                  'FKA' => 2,
                                                  'NKA' => 3,
                                                  DEFAULT_CODE);
                                                              

    EXPORT convertAKACategory(STRING akaCat) := CASE(STD.Str.ToUpperCase(TRIM(akaCat)),
                                                      'NONE' => 0,
                                                      'STRONG' => 1,
                                                      'WEAK' => 2,
                                                      DEFAULT_CODE);
                                                              







END;