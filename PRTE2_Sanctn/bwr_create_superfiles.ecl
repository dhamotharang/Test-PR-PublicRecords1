import promotesupers, roxiekeybuild, prte2_sanctn;

promotesupers.mac_create_superfiles(prte2_sanctn.constants.base_prefix_name + 'incident');
promotesupers.mac_create_superfiles(prte2_sanctn.constants.base_prefix_name + 'license');
promotesupers.mac_create_superfiles(prte2_sanctn.constants.base_prefix_name + 'party');
promotesupers.mac_create_superfiles(prte2_sanctn.constants.base_prefix_name + 'party_aka_dba');
promotesupers.mac_create_superfiles(prte2_sanctn.constants.base_prefix_name + 'rebuttal');

//roxie keys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'casenum');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'incident_midex');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'incident');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'license_midex');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'license_nbr');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'midex_rpt_nbr');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'nmls_id');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'nmls_midex');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'party_aka_dba');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'party');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'rebuttal');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'ssn4');

//boolean keys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'dictindx3');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'docref.docref');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'dtldictx');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'exkeyi');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'exkeyo');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'nidx3');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'xdstat2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn', 'xseglist');

 
//autokeys 
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'addressb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'citystnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'fein');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'fein2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'nameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'namewords2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'phone2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'phoneb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'stnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::autokey', 'zipb2');
