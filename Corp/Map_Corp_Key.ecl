import ut;

set_alpha := ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];

trim_leading_zeros(string str) := str[(1 + datalib.LeadMatch('0000000000', str))..];


// Create corp_key from Experian Corp data
export string30 Map_Corp_Key(string2 state_origin, string32  sos_ter_nbr) := 

ut.st2FipsCode(state_origin) + '-' + 

map(state_origin in ['AK', 'IA', 'OR', 'RI'] => trim(trim_leading_zeros(sos_ter_nbr)),
    state_origin = 'CA' => if(sos_ter_nbr[1] in set_alpha, trim(sos_ter_nbr[2..]), trim(sos_ter_nbr)),
    state_origin = 'SD' => trim(sos_ter_nbr[1..2] + '-' + sos_ter_nbr[3..]),
	state_origin = 'UT' => if (stringlib.stringfind(sos_ter_nbr, '-', 1) > 0, trim(sos_ter_nbr[1..(stringlib.stringfind(sos_ter_nbr, '-', 1) - 1)]), trim(sos_ter_nbr)),
	state_origin = 'WY' => trim(stringlib.stringfilterout(sos_ter_nbr, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
    trim(sos_ter_nbr));
