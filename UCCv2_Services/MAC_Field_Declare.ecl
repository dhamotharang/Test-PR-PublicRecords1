IMPORT doxie;
EXPORT MAC_Field_Declare := MACRO
  doxie.MAC_Header_Field_Declare();
  BOOLEAN incMultSecured := FALSE : STORED('IncludeMultipleSecured');
  BOOLEAN retRolledDebtors := FALSE : STORED('ReturnRolledDebtors');
ENDMACRO;
