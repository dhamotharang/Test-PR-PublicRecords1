/*2016-01-04T22:41:07Z (John Freibaum)

*/

import roxiekeybuild,seed_files;

export proc_build_riskviewkeys(string filedate) := 
function

#workunit('name','Risk View Key Build')

roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskViewReport_keys.Summary,'~thor_data400::key::riskviewreport::summary','~thor_data400::key::riskviewreport::'+filedate+'::summary',a,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskViewReport_keys.AddressHistory,'~thor_data400::key::riskviewreport::addresshistory','~thor_data400::key::riskviewreport::'+filedate+'::addresshistory',b,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskViewReport_keys.RealProperty,'~thor_data400::key::riskviewreport::realproperty','~thor_data400::key::riskviewreport::'+filedate+'::realproperty',c,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskViewReport_keys.PersonalProperty,'~thor_data400::key::riskviewreport::personalproperty','~thor_data400::key::riskviewreport::'+filedate+'::personalproperty',d,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskViewReport_keys.filing,'~thor_data400::key::riskviewreport::filing','~thor_data400::key::riskviewreport::'+filedate+'::filing',e,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskViewReport_keys.Bankruptcy,'~thor_data400::key::riskviewreport::bankruptcy','~thor_data400::key::riskviewreport::'+filedate+'::bankruptcy',f,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskViewReport_keys.Criminal,'~thor_data400::key::riskviewreport::criminal','~thor_data400::key::riskviewreport::'+filedate+'::criminal',g,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskViewReport_keys.Education,'~thor_data400::key::riskviewreport::education','~thor_data400::key::riskviewreport::'+filedate+'::education',h,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskViewReport_keys.License,'~thor_data400::key::riskviewreport::license','~thor_data400::key::riskviewreport::'+filedate+'::license',i,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskViewReport_keys.BusinessAssociation,'~thor_data400::key::riskviewreport::businessassociation','~thor_data400::key::riskviewreport::'+filedate+'::businessassociation',j,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskViewReport_keys.LoanOffer,'~thor_data400::key::riskviewreport::loanoffer','~thor_data400::key::riskviewreport::'+filedate+'::loanoffer',k,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskViewReport_keys.CreditInquiry,'~thor_data400::key::riskviewreport::creditinquiry','~thor_data400::key::riskviewreport::'+filedate+'::creditinquiry',l,2);

roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskView2_Report_keys.Summary,'~thor_data400::in::riskview2report::summary','~thor_data400::key::riskview2report::'+filedate+'::summary',m,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskView2_Report_keys.addresshistory,'~thor_data400::in::riskview2report::addresshistory','~thor_data400::key::riskview2report::'+filedate+'::addresshistory',n,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskView2_Report_keys.realproperty,'~thor_data400::in::riskview2report::realproperty','~thor_data400::key::riskview2report::'+filedate+'::realproperty',o,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskView2_Report_keys.personalproperty,'~thor_data400::in::riskview2report::personalproperty','~thor_data400::key::riskview2report::'+filedate+'::personalproperty',p,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskView2_Report_keys.filing,'~thor_data400::in::riskview2report::filing','~thor_data400::key::riskview2report::'+filedate+'::filing',q,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskView2_Report_keys.bankruptcy,'~thor_data400::in::riskview2report::bankruptcy','~thor_data400::key::riskview2report::'+filedate+'::bankruptcy',r,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskView2_Report_keys.criminal,'~thor_data400::in::riskview2report::criminal','~thor_data400::key::riskview2report::'+filedate+'::criminal',s,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskView2_Report_keys.education,'~thor_data400::in::riskview2report::education','~thor_data400::key::riskview2report::'+filedate+'::education',t,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskView2_Report_keys.license,'~thor_data400::in::riskview2report::license','~thor_data400::key::riskview2report::'+filedate+'::license',u,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskView2_Report_keys.businessassociation,'~thor_data400::in::riskview2report::businessassociation','~thor_data400::key::riskview2report::'+filedate+'::businessassociation',v,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskView2_Report_keys.loanoffer,'~thor_data400::in::riskview2report::loanoffer','~thor_data400::key::riskview2report::'+filedate+'::loanoffer',w,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskView2_Report_keys.creditinquiry,'~thor_data400::in::riskview2report::creditinquiry','~thor_data400::key::riskview2report::'+filedate+'::creditinquiry',x,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.RiskView2_Report_keys.purchase,'~thor_data400::in::riskview2report::purchase','~thor_data400::key::riskview2report::'+filedate+'::purchase',y,2);

roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::riskviewreport::summary','~thor_data400::key::riskviewreport::'+filedate+'::summary',a1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::riskviewreport::addresshistory','~thor_data400::key::riskviewreport::'+filedate+'::addresshistory',b1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::riskviewreport::realproperty','~thor_data400::key::riskviewreport::'+filedate+'::realproperty',c1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::riskviewreport::personalproperty','~thor_data400::key::riskviewreport::'+filedate+'::personalproperty',d1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::riskviewreport::filing','~thor_data400::key::riskviewreport::'+filedate+'::filing',e1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::riskviewreport::bankruptcy','~thor_data400::key::riskviewreport::'+filedate+'::bankruptcy',f1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::riskviewreport::criminal','~thor_data400::key::riskviewreport::'+filedate+'::criminal',g1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::riskviewreport::education','~thor_data400::key::riskviewreport::'+filedate+'::education',h1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::riskviewreport::license','~thor_data400::key::riskviewreport::'+filedate+'::license',i1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::riskviewreport::businessassociation','~thor_data400::key::riskviewreport::'+filedate+'::businessassociation',j1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::riskviewreport::loanoffer','~thor_data400::key::riskviewreport::'+filedate+'::loanoffer',k1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::riskviewreport::creditinquiry','~thor_data400::key::riskviewreport::'+filedate+'::creditinquiry',l1);

roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::in::riskview2report::summary','~thor_data400::key::riskview2report::'+filedate+'::summary',m3);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::in::riskview2report::addresshistory','~thor_data400::key::riskview2report::'+filedate+'::addresshistory',n3);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::in::riskview2report::realproperty','~thor_data400::key::riskview2report::'+filedate+'::realproperty',o3);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::in::riskview2report::personalproperty','~thor_data400::key::riskview2report::'+filedate+'::personalproperty',p3);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::in::riskview2report::filing','~thor_data400::key::riskview2report::'+filedate+'::filing',q3);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::in::riskview2report::bankruptcy','~thor_data400::key::riskview2report::'+filedate+'::bankruptcy',r3);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::in::riskview2report::criminal','~thor_data400::key::riskview2report::'+filedate+'::criminal',s3);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::in::riskview2report::education','~thor_data400::key::riskview2report::'+filedate+'::education',t3);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::in::riskview2report::license','~thor_data400::key::riskview2report::'+filedate+'::license',u3);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::in::riskview2report::businessassociation','~thor_data400::key::riskview2report::'+filedate+'::businessassociation',v3);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::in::riskview2report::loanoffer','~thor_data400::key::riskview2report::'+filedate+'::loanoffer',w3);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::in::riskview2report::creditinquiry','~thor_data400::key::riskview2report::'+filedate+'::creditinquiry',x3);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::in::riskview2report::purchase','~thor_data400::key::riskview2report::'+filedate+'::purchase',y3);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskviewreport::summary','Q',a2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskviewreport::addresshistory','Q',b2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskviewreport::realproperty','Q',c2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskviewreport::personalproperty','Q',d2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskviewreport::filing','Q',e2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskviewreport::bankruptcy','Q',f2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskviewreport::criminal','Q',g2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskviewreport::education','Q',h2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskviewreport::license','Q',i2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskviewreport::businessassociation','Q',j2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskviewreport::loanoffer','Q',k2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskviewreport::creditinquiry','Q',l2);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskview2report::summary','Q',m2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskview2report::addresshistory','Q',n2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskview2report::realproperty','Q',o2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskview2report::personalproperty','Q',p2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskview2report::filing','Q',q2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskview2report::bankruptcy','Q',r2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskview2report::criminal','Q',s2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskview2report::education','Q',t2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskview2report::license','Q',u2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskview2report::businessassociation','Q',v2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskview2report::loanoffer','Q',w2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskview2report::creditinquiry','Q',x2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::riskview2report::purchase','Q',y2);

buildkey := parallel(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y);
movekey := sequential(a1,b1,c1,d1,e1,f1,g1,h1,i1,j1,k1,l1,m3,n3,o3,p3,q3,r3,s3,t3,u3,v3,w3,x3,y3);
movetoqa := sequential(a2,b2,c2,d2,e2,f2,g2,h2,i2,j2,k2,l2,m2,n2,o2,p2,q2,r2,s2,t2,u2,v2,w2,x2,y2);
dops_update := Roxiekeybuild.updateversion('RiskViewReportKeys',filedate,'skasavajjala@seisint.com',,'F');

return sequential(buildkey, movekey, movetoqa,dops_update);

end;