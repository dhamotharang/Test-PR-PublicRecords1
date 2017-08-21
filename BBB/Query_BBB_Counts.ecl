output('BBB Member base records: ' + count(bbb.File_BBB_Base));
output('BBB Non-member base records: ' + count(bbb.File_BBB_Non_Member_Base));
output('BBB Member base records with BDID: ' + count(bbb.File_BBB_Base(bdid != 0)));
output('BBB Non-member base records with BDID: ' + count(bbb.File_BBB_Non_Member_Base(bdid != 0)));
output('BBB member foreign base records: ' + count(bbb.File_BBB_Base(trim(country) != 'US')));
output('BBB Non-member foreign base records: ' + count(bbb.File_BBB_Non_Member_Base(trim(country) != 'US')));
output('BBB member domestic base records with BDID: ' + count(bbb.File_BBB_Base(trim(country) = 'US' and bdid != 0)));
