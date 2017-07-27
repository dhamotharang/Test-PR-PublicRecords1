corpy  := corp.Corp4_As_Corp;
corpy_cont := corp.Corp4_As_Corp_Contacts;

output('CA state record(s) removed leading alpha char from sos charter number');
output(corpy(corp_state_origin = 'CA' and corp_legal_name = 'ROB M. GRELLMAN, M.F.T., INC.'));
output('ID state record(s) removed leading zeroes from charter number, C00567 -> C567');
output(corpy(corp_state_origin = 'ID' and corp_legal_name = 'HARRIELL HAY AND STRAW'));
output('Example CA and ID records from corporate file');
output(enth(corpy(corp_state_origin = 'CA' or corp_state_origin = 'ID'), 1000), all);
output('Example records from all other states from corporate file');
output(enth(corpy(corp_state_origin != 'CA' and corp_state_origin != 'ID'), 1000), all);
