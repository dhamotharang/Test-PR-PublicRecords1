import doxie;

df := PROJECT(domains.File_Whois_Base, TRANSFORM(domains.Layout_Whois_Base, SELF := LEFT));

export Key_Whois_Bdid := index(df(bdid != 0),{bdid},{df},'~thor_Data400::key::whois_bdid_' + doxie.Version_SuperKey);
