import doxie;

df := PROJECT(domains.File_Whois_Base, TRANSFORM(domains.Layout_Whois_Base, SELF := LEFT));

export Key_Whois_Did := index(df(did != 0),{unsigned6 d := df.did},{df},'~thor_data400::key::whois_did_' + doxie.Version_SuperKey);
