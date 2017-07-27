#workunit('name', 'Build Whois Out File ' + Domains.Whois_Build_Date);

// Output Whois File
Domains.Layout_Whois_BDID_Out  FormatWhoisOutput(Domains.Layout_Whois_BDID L) := TRANSFORM
SELF.bdid := IF(L.bdid <> 0, INTFORMAT(L.bdid, 12, 1), '');
SELF := L;
END;

Whois_Out := PROJECT(Domains.File_Whois_BDID, FormatWhoisOutput(LEFT));

OUTPUT(Whois_Out,,'OUT::Whois_' + Domains.Whois_Build_Date, OVERWRITE);