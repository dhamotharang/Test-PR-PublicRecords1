dict := DICTIONARY(LookupFiles.dsOFACSanctionCodes, {SanctionCode => SanctionName});

EXPORT CodetoSanctionNames(string code) := dict[code].SanctionName;