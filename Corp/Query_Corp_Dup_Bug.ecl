corpy_base := corp.File_Corp_base;
corpy_out := corp.File_Corp_out;
corpy_cont_base := corp.File_Corp_Cont_Base;

output('corp base records follow');
output(corpy_base(corp_orig_sos_charter_nbr = 'X00029490' or corp_orig_sos_charter_nbr = 'X00340471' or corp_orig_sos_charter_nbr = 'X00201440' or corp_orig_sos_charter_nbr = 'X00097995' or corp_orig_sos_charter_nbr = 'X00379783'));
output('corp out records follow');
output(corpy_out(corp_orig_sos_charter_nbr = 'X00029490' or corp_orig_sos_charter_nbr = 'X00340471' or corp_orig_sos_charter_nbr = 'X00201440' or corp_orig_sos_charter_nbr = 'X00097995' or corp_orig_sos_charter_nbr = 'X00379783'));

