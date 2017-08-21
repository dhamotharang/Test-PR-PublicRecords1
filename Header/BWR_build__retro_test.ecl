// Header.Mod_FCRA_Header_EN_retro_test.scored;

a:=distribute(header.Mod_FCRA_Header_EN_retro_test.best_file,hash(random())) : persist('~thor_data::persist::retro_test_best');
b:=distribute(header.Mod_FCRA_Header_EN_retro_test.address_file,hash(random())) : persist('~thor_data::persist::retro_test_addr');
c:=distribute(header.Mod_FCRA_Header_EN_retro_test.ssn_file,hash(random())) : persist('~thor_data::persist::retro_test_ssn');

ut.MAC_SF_BuildProcess(a,'~thor400_data::Experian_Extract::identity',aa,csvout:=true,pcompress:=true);
ut.MAC_SF_BuildProcess(b,'~thor400_data::Experian_Extract::address',bb,csvout:=true,pcompress:=true);
ut.MAC_SF_BuildProcess(c,'~thor400_data::Experian_Extract::ssn',cc,csvout:=true,pcompress:=true);
aa;bb;cc;

// i:=choosen(distribute(header.Mod_FCRA_Header_EN_retro_test.files.identity,hash(random())),1000000);
// a:=choosen(distribute(header.Mod_FCRA_Header_EN_retro_test.files.address,hash(random())),1000000);
// s:=choosen(distribute(header.Mod_FCRA_Header_EN_retro_test.files.ssn,hash(random())),1000000);
// output(i,,'~thor400_data::Experian_Extract::identity_sample_rnd',compressed,overwrite,csv(quote('"'),heading(single)));
// output(a,,'~thor400_data::Experian_Extract::address_sample_rnd',compressed,overwrite,csv(quote('"'),heading(single)));
// output(s,,'~thor400_data::Experian_Extract::ssn_sample_rnd',compressed,overwrite,csv(quote('"'),heading(single)));

// Header.Mod_FCRA_Header_EN_retro_test.EN_only_entities : persist('~thor_data::persist::Experian_Extract_EN_only_entities');
// Header.Mod_FCRA_Header_EN_retro_test.EN_only_ssn : persist('~thor_data::persist::Experian_Extract_EN_only_ssn');
// Header.Mod_FCRA_Header_EN_retro_test.EN_only_addr : persist('~thor_data::persist::Experian_Extract_EN_only_addr');

// Header.Mod_FCRA_Header_EN_retro_test.Gov_only_entities : persist('~thor_data::persist::Experian_Extract_Gov_only_entities');
// Header.Mod_FCRA_Header_EN_retro_test.Gov_only_ssn : persist('~thor_data::persist::Experian_Extract_Gov_only_ssn');
// Header.Mod_FCRA_Header_EN_retro_test.Gov_only_addr : persist('~thor_data::persist::Experian_Extract_Gov_only_addr');

// Header.Mod_FCRA_Header_EN_retro_test.NonGov_only_entities : persist('~thor_data::persist::Experian_Extract_NonGov_only_entities');
// Header.Mod_FCRA_Header_EN_retro_test.NonGov_only_ssn : persist('~thor_data::persist::Experian_Extract_NonGov_only_ssn');
// Header.Mod_FCRA_Header_EN_retro_test.NonGov_only_addr : persist('~thor_data::persist::Experian_Extract_NonGov_only_addr');

