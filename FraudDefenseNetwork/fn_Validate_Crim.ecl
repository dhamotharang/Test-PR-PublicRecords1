import dops;
EXPORT fn_Validate_Crim(string filedate) := module 
#OPTION('outputlimit',100);

emailsToNotify 	:= 'Harry.Gist@lexisnexis.com,Sudhir.Kasavajjala@lexisnexis.com';
prod_version 		:= dops.GetBuildVersion('DOCKeys','B','N','P'); // boca, non-FCRA,production

cert_version 		:= dops.GetBuildVersion('DOCKeys','B','N','C'); // cert

ds := dataset('~thor_data400::fdn::crim_version',{string version},thor,opt);

ds1 := ds( version = cert_version );



certAndProdVersionsAreTheSame := (prod_version=cert_version) and (count(ds1) = 0) ;


build_crim := FraudDefenseNetwork.Build_Base_TextMinedCrim(filedate,,true).all;

export run_build := if ( certAndProdVersionsAreTheSame , Sequential( build_crim,set_crim_version(cert_version)), Output('No CRIM Build needed'));
end;
