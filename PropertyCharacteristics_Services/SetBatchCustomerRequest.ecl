IMPORT iesp;

// converts flat input batch record to the record containing esdl-style customer request

// template to read from the flat input layout containing:
//  30 iesp.property_info.t_PropertyDescription and
//  10 iesp.property_info.t_PropertyDescription structures
LOADXML('<xml/>');
#DECLARE(rows_characteristics);
#SET(rows_characteristics, '');

#DECLARE(rows_descriptions);
#SET(rows_descriptions, '');

#DECLARE (i);

#set (i, 1);
#loop
  #append (rows_characteristics, 
           '{L.Category_' + %'i'% + ', L.Material_' + %'i'% + ', L.Value_' + %'i'% + 
           ', L.Quality_' + %'i'% + ', L.Condition_' + %'i'% + ', L.Age_' + %'i'% + '}');
  #set (i, %i% + 1);
  #if (%i% > 30)
    #break
  #else
    #append (rows_characteristics, ',')
  #end
#end

#set (i, 1);
#loop
  #append (rows_descriptions, 
             '{L.Description_' + %'i'% + ', L.AdditionValue_' + %'i'% + ', L.AdditionQuality_' + %'i'% + 
             ', L.AdditionCondition_' + %'i'% + ', L.LivingAreaIndicator_' + %'i'% + '}');
  #set (i, %i% + 1);
  #if (%i% > 10)
    #break
  #else
    #append (rows_descriptions, ',')
  #end
#end

iesp.property_info.t_PropertyInformationReportBy SetReportBy (layouts.batch_in L) := transform
  Self.Name := iesp.ECL2ESP.SetName (L.first, L.middle, L.last, '', '', '');
  Self.NameID := ''; //string3 {xpath('NameID')};
  Self.dob      := [];
  Self.SSN      := '';
  Self.DLNumber := '';
  Self.DLState  := '';
  // take parts of address required for cleaning:
  Self.AddressInfo.City := L.City; 
  Self.AddressInfo.State := L.State;
  Self.AddressInfo.zip5 := L.zip5;
  Self.AddressInfo.StreetAddress1 := L.StreetAddress;
  Self.AddressInfo := [];

  Self.AddressID := '';// string3 AddressID {xpath('AddressID')};
  Self.PolicyNumber := '';// string20 PolicyNumber {xpath('PolicyNumber')};
  Self.QuoteBack := '';// string60 QuoteBack {xpath('QuoteBack')};
  Self.PropertyAttributes := L; //LivingAreaSF, Stories, Bedrooms, Baths, Fireplaces,
                                //Pool, AC, YearBuilt, SlopeCode, Slope, QualityOfStructCode,
                                // QualityOfStruct, ReplacementCostReportId, PolicyCoverageValue

  prop_characteristics := dataset ([%rows_characteristics%], iesp.property_info.t_PropertyCharacteristic);
  // ignore whole characteristics if category not provided
  Self.PropertyCharacteristics := prop_characteristics (Category != '');

  prop_descriptions := dataset ([%rows_descriptions%], iesp.property_info.t_PropertyDescription);
  Self.PropertyDescriptionSet := prop_descriptions (Description != '');
end;

export iesp.property_info.t_PropertyInformationRequest SetBatchCustomerRequest (layouts.batch_in L) := transform
  // TODO: clarify if anything is required except ReportBy
  // from parent definition
  Self.User := []; //t_User User {xpath('User')};
  Self.RemoteLocations := [];//dataset(t_StringArrayItem) RemoteLocations {xpath('RemoteLocations/Item'), MAXCOUNT(1)};//hidden[internal]
  Self.ServiceLocations := [];//dataset(t_ServiceLocation) ServiceLocations {xpath('ServiceLocations/ServiceLocation'), MAXCOUNT(1)};//hidden[internal]

  // t_PropertyInformationOptions Options {xpath('Options')}; == record (share.t_BaseOption)
  Self.Options := [];

  // t_InquiryInfo InquiryInfo {xpath('InquiryInfo')};
// export t_InquiryInfo := record
  // string15 SpecialBillId {xpath('SpecialBillId')};
  // string1 ReportType {xpath('ReportType')};
  // share.t_Date DateOfOrder {xpath('DateOfOrder')};
// end;
  Self.InquiryInfo := [];

  Self.ReportBy := row (SetReportBy (L));
end;
