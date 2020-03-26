import promotesupers, roxiekeybuild, prte2;

promotesupers.mac_create_superfiles(prte2.constants.Prefix +'in::american_student_list::student_list');
promotesupers.mac_create_superfiles(prte2.constants.Prefix +'in::american_student_list::student_list_Ins');


promotesupers.mac_create_superfiles(prte2.constants.Prefix +'base::american_student_list');


roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::american_student', 'did2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::american_student', 'american_list');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcra::american_student', 'did2');

 
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::american_student::autokey', 'address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::american_student::autokey', 'citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::american_student::autokey', 'name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::american_student::autokey', 'payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::american_student::autokey', 'phone2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::american_student::autokey', 'ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::american_student::autokey', 'stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::american_student::autokey', 'zip');


