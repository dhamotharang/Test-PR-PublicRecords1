import roxiekeybuild,seed_files;

export Proc_RiskViewAttr_Keys(string filedate) :=
function


roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_RVAttributes,'abc','~thor_data400::key::testseed::'+filedate+'::rvattributes',a);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_RVAuto,'abc','~thor_data400::key::testseed::'+filedate+'::rvauto',b);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_RVBankcard,'abc','~thor_data400::key::testseed::'+filedate+'::rvbankcard',c);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_RVRetail,'abc','~thor_data400::key::testseed::'+filedate+'::rvretail',d);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_RVTelecom,'abc','~thor_data400::key::testseed::'+filedate+'::rvtelecom',p);

roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::rvattributes','~thor_data400::key::testseed::'+filedate+'::rvattributes',a1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::rvauto','~thor_data400::key::testseed::'+filedate+'::rvauto',b1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::rvbankcard','~thor_data400::key::testseed::'+filedate+'::rvbankcard',c1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::rvretail','~thor_data400::key::testseed::'+filedate+'::rvretail',d1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::rvtelecom','~thor_data400::key::testseed::'+filedate+'::rvtelecom',p1);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::rvattributes','Q',a2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::rvauto','Q',b2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::rvbankcard','Q',c2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::rvretail','Q',d2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::rvtelecom','Q',p2);

roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_RiskView,'abc','~thor_data400::key::testseed::'+filedate+'::riskview',q);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_RiskView2,'abc','~thor_data400::key::testseed::'+filedate+'::riskview2',rv2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_FCRA_GongHistory,'abc','~thor_data400::key::testseed::'+filedate+'::fcragonghistory',s);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_NCFInsurance,'abc','~thor_data400::key::testseed::'+filedate+'::ncfinsurance',ncf);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_MVRInsurance,'abc','~thor_data400::key::testseed::'+filedate+'::mvrinsurance',mvr);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_Boca_Shell(true),'abc','~thor_data400::key::testseed::'+filedate+'::boca_shell_fcra',bs);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_Boca_Shell4(true),'abc','~thor_data400::key::testseed::'+filedate+'::boca_shell4_fcra',bs4);

roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::riskview','~thor_data400::key::testseed::'+filedate+'::riskview',q1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::riskview2','~thor_data400::key::testseed::'+filedate+'::riskview2',mvrv2);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::fcragonghistory','~thor_data400::key::testseed::'+filedate+'::fcragonghistory',s1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::ncfinsurance','~thor_data400::key::testseed::'+filedate+'::ncfinsurance',mvncf);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::mvrinsurance','~thor_data400::key::testseed::'+filedate+'::mvrinsurance',mvmvr);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::boca_shell_fcra','~thor_data400::key::testseed::'+filedate+'::boca_shell_fcra',mvbs);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::boca_shell4_fcra','~thor_data400::key::testseed::'+filedate+'::boca_shell4_fcra',mvbs4);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::riskview','Q',q2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::riskview2','Q',mvqrv2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::fcragonghistory','Q',s2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::ncfinsurance','Q',mvqncf);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::mvrinsurance','Q',mvqmvr);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::boca_shell_fcra','Q',mvqmbs);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::boca_shell4_fcra','Q',mvqmbs4);

 buildkey := parallel(a,b,c,d,p,q,s,ncf,mvr,bs,bs4,rv2);
 movekey := sequential(a1,b1,c1,d1,p1,q1,s1,mvncf,mvmvr,mvbs,mvbs4,mvrv2);
 movetoqa := sequential(a2,b2,c2,d2,p2,q2,s2,mvqncf,mvqmvr,mvqmbs,mvqmbs4,mvqrv2);
 dops_update := Roxiekeybuild.updateversion('RiskviewseedKeys',filedate,'john.freibaum@lexisnexis.com',,'F');




return sequential(buildkey,movekey,movetoqa,dops_update);

end;
