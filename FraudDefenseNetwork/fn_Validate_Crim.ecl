import dops;
EXPORT fn_Validate_Crim(string filedate) := module 
#OPTION('outputlimit',100);

emailsToNotify 	:= 'Harry.Gist@lexisnexis.com,Sudhir.Kasavajjala@lexisnexis.com';
prod_version 		:= dops.GetBuildVersion('DOCKeys','B','N','P'); // boca, non-FCRA,production

cert_version 		:= dops.GetBuildVersion('DOCKeys','B','N','C'); // cert

ds := dataset('~thor_data400::fdn::crim_version',{string version},thor,opt);


certAndProdVersionsAreTheSame := if ( count(ds) > 0 , (prod_version=cert_version) and (cert_version not in Set(ds,version)) , (prod_version=cert_version)) ;


build_crim := FraudDefenseNetwork.Build_Base_TextMinedCrim(filedate,,true).all;

export run_build := if ( certAndProdVersionsAreTheSame , Sequential( build_crim,set_crim_version(cert_version)), Output('No CRIM Build needed'));
end;
