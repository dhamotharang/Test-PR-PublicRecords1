EXPORT Orbit_Layouts := MODULE
  EXPORT AdditionalNamespacesLayout := RECORD
    STRING arr_namespace {xpath('@xmlns:arr')} := 'http://schemas.microsoft.com/2003/10/Serialization/Arrays';
    STRING orb_namespace {xpath('@xmlns:orb')} := 'http://schemas.datacontract.org/2004/07/OrbitDataContractsV2';
    STRING i_namespace {xpath('@xmlns:i')} := 'http://www.w3.org/2001/XMLSchema-instance';
		STRING lex_namespace {xpath('@xmlns:lex')} := 'http://lexisnexis.com/';
  END;
END;