// implementation of 'Social Securtiy Number Randomization_Requirements_v1 8.docx' 
import Risk_Indicators;

// I will probably remove DID from the input after ensuring "searchLegacySSN" is not needed here
export GetSSNValidation (string9 _ssn) := function
  pocketbook_ssn := ['022281852','042103580','062360749','062360794','078051120','095073645',
    '128036045','135016629','141186941','165167999','165187999','165207999','165247999','189092294',
    '212097694','212099999','219099998','219099999','306302348','308125070','468288779','549241889'];

  boolean is_numeric        := REGEXFIND('^[0-9]{9}$', _ssn);
  boolean is_900_999        := _ssn[1] = '9';
  boolean is_666            := _ssn[1..3] = '666';
  boolean is_invalid_area   := _ssn[1..3] = '000';
  boolean is_invalid_group  := _ssn[4..5] = '00';
  boolean is_invalid_serial := _ssn[6..9] = '0000';
  boolean is_pocketbook     := _ssn IN pocketbook_ssn;

  // section 6.1.1.3
  boolean is_invalid := ~is_numeric OR is_900_999 OR is_666 OR is_invalid_area OR
                        is_invalid_group OR is_invalid_serial OR is_pocketbook;

  // section 6.1.3.4 -- must be cheked outside of this attribute
  // boolean legacy_found := Risk_Indicators.searchLegacySSN (_ssn, _did); 

  validation := module
    export boolean is_valid := ~is_invalid;
    export string GetCode (boolean is_valid, boolean is_legacy, boolean is_random) := MAP (
      ~is_valid => '0006', // SSN is invalid.
      is_legacy => '0160', // SSN is potentially randomized by the SSA, but invalid when first associated with the consumer.
      is_random => '0155', // SSN is potentially randomized by the SSA.
      ''); 
  end;

  return validation;
end;
