import promotesupers, roxiekeybuild, prte2_sanctn_np;

promotesupers.mac_create_superfiles(prte2_sanctn_np.constants.base_prefix_name + 'incident');
promotesupers.mac_create_superfiles(prte2_sanctn_np.constants.base_prefix_name + 'license_nbr');
promotesupers.mac_create_superfiles(prte2_sanctn_np.constants.base_prefix_name + 'party');
promotesupers.mac_create_superfiles(prte2_sanctn_np.constants.base_prefix_name + 'party_aka_dba');
promotesupers.mac_create_superfiles(prte2_sanctn_np.constants.base_prefix_name + 'incident_bip');
promotesupers.mac_create_superfiles(prte2_sanctn_np.constants.base_prefix_name + 'incidentcode');
promotesupers.mac_create_superfiles(prte2_sanctn_np.constants.base_prefix_name + 'incidenttext');
promotesupers.mac_create_superfiles(prte2_sanctn_np.constants.base_prefix_name + 'partytext');


roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'incident');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'incidentcode');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'incidenttext');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'license_midex');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'license_nbr');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'incident_linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'party_linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'midex_rpt_nbr');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'nmls_id');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'nmls_midex');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'party_aka_dba');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'party');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'partytext');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'ssn4');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'tin');

//boolean keys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'dictindx3');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'docref.docref');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'dtldictx');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'exkeyi');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'exkeyo');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'nidx3');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'xdstat2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np', 'xseglist');

 
//autokeys 
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'addressb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'citystnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'fein');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'fein2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'nameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'namewords2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'phone2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'phoneb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'stnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sanctn::np::autokey', 'zipb2');
