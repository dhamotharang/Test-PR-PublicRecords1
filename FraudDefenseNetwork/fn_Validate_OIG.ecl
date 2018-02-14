import dops;

EXPORT fn_Validate_OIG (string filedate) := module 
#OPTION('outputlimit',100);


emailsToNotify 	:= 'Harry.Gist@lexisnexis.com,Sudhir.Kasavajjala@lexisnexis.com';
prod_version 		:= dops.GetBuildVersion('OIGKeys','B','N','P'); // boca, non-FCRA,production

cert_version 		:= dops.GetBuildVersion('OIGKeys','B','N','C'); // cert

ds := dataset('~thor_data400::fdn::oig_version',{string version},thor,opt);


certAndProdVersionsAreTheSame := if ( count(ds) > 0 , (prod_version=cert_version) and (cert_version not in Set(ds,version)) , (prod_version=cert_version)) ;


build_oig := FraudDefenseNetwork.Build_Base_OIG(filedate,,true).all;

export run_build := if ( certAndProdVersionsAreTheSame , Sequential( build_oig,set_oig_version(cert_version)), Output('No OIG Build needed'));
end;
