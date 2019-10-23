#workunit('name','BIPV2 proxid Relationships micro lowlevel');
import bipv2,BIPV2_ProxID,Business_DOT_SALT_micro12,BIPV2_Tools;
dinput 						:= BIPV2_ProxID.In_DOT_Base;
dlegalentityrels 	:= BIPV2_ProxID.relationships(dinput).SAMELEGALENTITY_links	;
BIPV2.mac_Patch_ClusterId(dinput ,dpatchlegalentitycluster 	,dbadlegalentityrels 	,DOTid,proxid,dlegalentityrels	,DOTid1,DOTid2);
dpatchlegalentitycluster_proj := project(dpatchlegalentitycluster(proxid = 0),transform(recordof(dpatchlegalentitycluster),self.proxid := left.dotid,self := left))
+ dpatchlegalentitycluster(proxid != 0);
BIPV2_ProxID.Proc_Iterate('1').RelationshipKeys;
BIPV2_ProxID.Proc_Iterate('1').DebugKeys;
output(choosen(dinput																						,300),named('dinput'									),all);
output(choosen(dlegalentityrels(Total_Score < 20							)	,500),named('LegalEntityLessThan20'		),all);
output(choosen(dlegalentityrels(Total_Score between 20 and 24	)	,500),named('LegalEntity20To24'				),all);
output(choosen(dlegalentityrels(Total_Score between 25 and 29	)	,500),named('LegalEntity25To29'				),all);
output(choosen(dlegalentityrels(Total_Score > 29							)	,500),named('LegalEntityGreaterThan29'),all);
output(dpatchlegalentitycluster_proj		,,'~thor_data400::base::BIPV2_ProxID::legalentity_patched_file_filt'	,__compressed__,overwrite);
output(dbadlegalentityrels 							,,'~thor_data400::base::BIPV2_ProxID::badlegalentity_rels'						,__compressed__,overwrite);
////////////////extra outputs
p := project(dpatchlegalentitycluster_proj, transform(BIPV2_ProxID.layouts.dot_base, self.dotid := left.proxid, self := left));
//Business_DOT_SALT_micro12._Proc_Extra_Debug(p).out_all;
BIPV2_Tools.CompareProxid(dpatchlegalentitycluster_proj);
dAggLexis 	:= BIPV2_Tools.AggregateProxidElements(dpatchlegalentitycluster_proj,true);
dAggOverall := BIPV2_Tools.AggregateProxidElements(dpatchlegalentitycluster_proj,false);
output(choosen(dAggLexis		,1000)	,named('LexisproxidsWithMostUniqueData'				),all);
output(enth		(dAggLexis		,1000)	,named('LexisproxidsEnth1000'									),all);
output(choosen(dAggOverall	,1000)	,named('OverallproxidsWithMostUniqueData'			),all);
output(enth		(dAggOverall	,1000)	,named('EnthOverallproxidsWithMostUniqueData'	),all);
