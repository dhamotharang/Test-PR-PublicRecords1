﻿IMPORT FraudShared, FraudShared_Services, RiskIntelligenceNetwork_Services, STD;

EXPORT fn_GetEntityRecordIds( DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_batch_in,
                              STRING fraud_platform) := MODULE

  //Since its batch of 1 record, there will always be only one row of input.
  SHARED in_rec := ds_batch_in[1];

  SHARED BOOLEAN validInput(string s1) := s1 <> '';
  SHARED BOOLEAN validNumberInput(string i1) := (REAL) i1 > 0;
  
  SHARED FraudShared_Services.Layouts.Recid_rec fail_trans (FraudShared_Services.Layouts.BatchInExtended_rec L) := TRANSFORM
   SELF.acctno := L.acctno;
   SELF.record_id := 0;
   SELF := [];
  END;

  EXPORT GetHouseHoldIDs() := FUNCTION
    ds_householdid := IF(validNumberInput(in_rec.HouseholdId),
                        JOIN(ds_batch_in, FraudShared.Key_HouseholdID(fraud_platform),
                                KEYED(LEFT.HouseholdId = RIGHT.Household_ID),
                                 TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                  SELF.acctno := LEFT.acctno,
                                  SELF := RIGHT,
                                  SELF := LEFT,
                                  SELF := []),
                             LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                        dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_householdid;
  END;

  EXPORT GetCustomerPersonIds() := FUNCTION
    ds_CustomerPersonId := IF(validNumberInput(in_rec.CustomerPersonId),
                            JOIN(ds_batch_in, FraudShared.Key_CustomerID(fraud_platform),
                                  KEYED(LEFT.CustomerPersonId = RIGHT.customer_id),
                                   TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                    SELF.acctno := LEFT.acctno,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                  LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                            dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_CustomerPersonId;
  END;

  EXPORT GetAmountRangeIds() := FUNCTION
    ds_Amount_minOnly := JOIN(ds_batch_in, FraudShared.Key_AmountPaid(fraud_platform),
                              KEYED(LEFT.AmountMin <= RIGHT.Amount_Paid),
                                TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                    SELF.acctno := LEFT.acctno,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT)));

    ds_Amount_maxonly := JOIN(ds_batch_in, FraudShared.Key_AmountPaid(fraud_platform),
                                  KEYED(LEFT.AmountMax >= RIGHT.Amount_Paid),
                                   TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                    SELF.acctno := LEFT.acctno,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                  LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT)));

    ds_Amount_both := JOIN(ds_batch_in, FraudShared.Key_AmountPaid(fraud_platform),
                              KEYED(LEFT.AmountMin <= RIGHT.Amount_Paid) AND
                              KEYED(LEFT.AmountMax >= RIGHT.Amount_Paid),
                               TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                SELF.acctno := LEFT.acctno,
                                SELF := RIGHT,
                                SELF := LEFT,
                                SELF := []),
                              LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT)));

    ds_AmountRangeIds := MAP(validNumberInput(in_rec.AmountMin) AND NOT validNumberInput(in_rec.AmountMax) => ds_Amount_minOnly,
                             NOT validNumberInput(in_rec.AmountMin) AND validNumberInput(in_rec.AmountMax) => ds_Amount_maxonly,
                             validNumberInput(in_rec.AmountMin) AND validNumberInput(in_rec.AmountMax) => ds_Amount_both,
                             dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_AmountRangeIds;
  END;

  EXPORT GetBankNameIds() := FUNCTION
    ds_BankName := IF(validInput(in_rec.BankName),
                        JOIN(ds_batch_in, FraudShared.Key_BankName(fraud_platform),
                              KEYED(LEFT.BankName = RIGHT.bank_name),
                               TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                SELF.acctno := LEFT.acctno,
                                SELF := RIGHT,
                                SELF := LEFT,
                                SELF := []),
                              LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                        dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_BankName;
  END;

  EXPORT GetBankRoutingIds() := FUNCTION
    ds_BankRoutingIds := IF(validNumberInput(in_rec.bank_routing_number),
                            JOIN(ds_batch_in, FraudShared.Key_BankRoutingNumber(fraud_platform),
                                  KEYED(LEFT.bank_routing_number = RIGHT.bank_routing_number),
                                   TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                    SELF.acctno := LEFT.acctno,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                  LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                            dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_BankRoutingIds;
  END;

  EXPORT GetReportedDateIds() := FUNCTION
    ds_ReportedDate := IF(validInput(in_rec.TransactionStartDate) AND validInput(in_rec.TransactionEndDate),
                            JOIN(ds_batch_in, FraudShared.Key_ReportedDate(fraud_platform),
                                  KEYED(LEFT.TransactionStartDate <= RIGHT.reported_date) AND KEYED(LEFT.TransactionEndDate >= RIGHT.reported_date),
                                   TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                    SELF.acctno := LEFT.acctno,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                  LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                            dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_ReportedDate;
  END;

  EXPORT GetISPNameIds() := FUNCTION
    ds_ISPName := IF(validInput(in_rec.ISPName),
                      JOIN(ds_batch_in, FraudShared.Key_Isp(fraud_platform),
                            KEYED(LEFT.ISPName = RIGHT.isp),
                             TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                              SELF.acctno := LEFT.acctno,
                              SELF := RIGHT,
                              SELF := LEFT,
                              SELF := []),
                            LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                      dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_ISPName;
  END;

  EXPORT GetMACAddressIds() := FUNCTION
    ds_MACAddress := IF(validInput(in_rec.MACAddress),
                        JOIN(ds_batch_in, FraudShared.Key_MACAddress(fraud_platform),
                              KEYED(LEFT.MACAddress = RIGHT.mac_address),
                               TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                SELF.acctno := LEFT.acctno,
                                SELF := RIGHT,
                                SELF := LEFT,
                                SELF := []),
                              LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                        dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_MACAddress;
  END;

  EXPORT GetSerialNumberIds() := FUNCTION
    ds_SerialNumber := IF(validInput(in_rec.DeviceSerialNumber),
                          JOIN(ds_batch_in, FraudShared.Key_SerialNumber(fraud_platform),
                                KEYED(LEFT.DeviceSerialNumber = RIGHT.serial_number),
                                 TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                  SELF.acctno := LEFT.acctno,
                                  SELF := RIGHT,
                                  SELF := LEFT,
                                  SELF := []),
                                LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                          dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_SerialNumber;
  END;
  
  EXPORT GetEmail := FUNCTION
    ds_EmailIds := IF(validInput(in_rec.Email_Address),
                      JOIN(ds_batch_in, FraudShared.Key_Email(fraud_platform),
                            KEYED(LEFT.email_address = RIGHT.email_address),
                             TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                              SELF.acctno := LEFT.acctno,
                              SELF := RIGHT,
                              SELF := LEFT,
                              SELF := []),
                            LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                      dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_EmailIds;
  END;

  EXPORT GetEmailUserIds() := FUNCTION
    ds_EmailUserIds := IF(validInput(in_rec.Email_Address),
                          JOIN(ds_batch_in, FraudShared.Key_User(fraud_platform),
                                KEYED(HASH64(TRIM(regexfind('(.*)@(.*)$',LEFT.EMAIL_ADDRESS,1))) = RIGHT.hash64_user),
                                 TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                  SELF.acctno := LEFT.acctno,
                                  SELF := RIGHT,
                                  SELF := LEFT,
                                  SELF := []),
                                LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                          dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_EmailUserIds;
  END;

  EXPORT GetEmailDomainIds() := FUNCTION
    ds_EmailDomainIds := IF(validInput(in_rec.Email_Address),
                          JOIN(ds_batch_in, FraudShared.Key_Host(fraud_platform),
                                KEYED(HASH64(TRIM(regexfind('(.*)@(.*)$',LEFT.EMAIL_ADDRESS,2))) = RIGHT.hash64_host),
                                 TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                  SELF.acctno := LEFT.acctno,
                                  SELF := RIGHT,
                                  SELF := LEFT,
                                  SELF := []),
                                LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                          dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_EmailDomainIds;
  END;

  EXPORT GetCityStateIds() := FUNCTION
    ds_CityStateIds := IF(validInput(in_rec.p_city_name) AND validInput(in_rec.st),
                          JOIN(ds_batch_in, FraudShared.Key_CityState(fraud_platform),
                                KEYED(LEFT.p_city_name = RIGHT.p_city_name) AND
                                KEYED(LEFT.st = RIGHT.st),
                                 TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                  SELF.acctno := LEFT.acctno,
                                  SELF := RIGHT,
                                  SELF := LEFT,
                                  SELF := []),
                                LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                          dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_CityStateIds;
  END;

  EXPORT GetCountyIds() := FUNCTION
    ds_CountyIds := IF(validInput(in_rec.county_name),
                          JOIN(ds_batch_in, FraudShared.Key_County(fraud_platform),
                                KEYED(LEFT.county_name = RIGHT.county),
                                 TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                  SELF.acctno := LEFT.acctno,
                                  SELF := RIGHT,
                                  SELF := LEFT,
                                  SELF := []),
                                LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                          dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_CountyIds;
  END;

  EXPORT GetZipIds() := FUNCTION
    ds_ZipIds := IF(validNumberInput(in_rec.z5),
                          JOIN(ds_batch_in, FraudShared.Key_Zip(fraud_platform),
                                KEYED(LEFT.z5 = RIGHT.zip),
                                 TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                  SELF.acctno := LEFT.acctno,
                                  SELF := RIGHT,
                                  SELF := LEFT,
                                  SELF := []),
                                LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                          dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_ZipIds;
  END;

  EXPORT GetIP() := FUNCTION
    ds_IPIds := IF(validInput(in_rec.ip_address),
                  JOIN(ds_batch_in, FraudShared.Key_Ip(fraud_platform),
                        KEYED(LEFT.ip_address = RIGHT.ip_address),
                         TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                          SELF.acctno := LEFT.acctno,
                          SELF := RIGHT,
                          SELF := LEFT,
                          SELF := []),
                        LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                  dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_IPIds;
  END;  

  EXPORT GetIPRangeIds(unsigned1 octet1, unsigned1 octet2, unsigned1 octet3,
                        boolean isIPRange123, boolean isIPRange12, boolean isIPRange1) := FUNCTION

    ds_IPRangeIds123 := JOIN(ds_batch_in, FraudShared.Key_IPRange(fraud_platform),
                            KEYED(octet1 = RIGHT.octet1 AND octet2 = RIGHT.octet2 AND octet3 = RIGHT.octet3),
                             TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                              SELF.acctno := LEFT.acctno,
                              SELF := RIGHT,
                              SELF := LEFT,
                              SELF := []),
                            LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT)));

    ds_IPRangeIds12  := JOIN(ds_batch_in, FraudShared.Key_IPRange(fraud_platform),
                            KEYED(octet1 = RIGHT.octet1 AND octet2 = RIGHT.octet2),
                             TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                              SELF.acctno := LEFT.acctno,
                              SELF := RIGHT,
                              SELF := LEFT,
                              SELF := []),
                            LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT)));

    ds_IPRangeIds1   := JOIN(ds_batch_in, FraudShared.Key_IPRange(fraud_platform),
                            KEYED(octet1 = RIGHT.octet1),
                             TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                              SELF.acctno := LEFT.acctno,
                              SELF := RIGHT,
                              SELF := LEFT,
                              SELF := []),
                            LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT)));

    ds_IPRangeIds := MAP (validInput(in_rec.ip_address) AND isIPRange123 => ds_IPRangeIds123,
                          validInput(in_rec.ip_address) AND isIPRange12	=> ds_IPRangeIds12,
                          validInput(in_rec.ip_address) AND isIPRange1 => ds_IPRangeIds1,
                          DATASET([], FraudShared_Services.Layouts.Recid_rec));

    RETURN ds_IPRangeIds;
  END;

  EXPORT GetDriverLicenses() := FUNCTION

    ds_DriverLicenses := IF(validInput(in_rec.dl_number),
                            JOIN(ds_batch_in, FraudShared.Key_DriversLicense(fraud_platform),
                                  KEYED(LEFT.dl_number = RIGHT.drivers_license),
                                  TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                    SELF.acctno := LEFT.acctno,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                  LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                            dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_DriverLicenses;
  END;

  EXPORT GetBankAccountNumber() := FUNCTION

    ds_BankAccountNoIds := IF(validInput(in_rec.bank_account_number),
                            JOIN(ds_batch_in, FraudShared.Key_BankAccount(fraud_platform),
                                  KEYED(LEFT.bank_account_number = RIGHT.bank_account_number),
                                  TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                    SELF.acctno := LEFT.acctno,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                  LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT, fail_trans(LEFT))),
                            dataset([], FraudShared_Services.Layouts.Recid_rec));
    RETURN ds_BankAccountNoIds;
  END;

END;
