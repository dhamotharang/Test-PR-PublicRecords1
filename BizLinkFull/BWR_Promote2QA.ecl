//ModifiedBy:vern_p bentley
//ModifiedDate:2015-10-27T18:22:44Z
//Description:migrated from Dataland for BIPV2 Sprint 1
import BIPV2,BizLinkFull,tools;
sequential(
   BizLinkFull.Promote().built2QA
	,BizLinkFull.Promote(,'BizLinkFull',pCluster := tools.fun_Groupname('20')).Built2QA
	,BizLinkFull.Promote(,'BizLinkFull',pCluster := tools.fun_Groupname('84')).Built2QA
	,BizLinkFull.Promote(,'BizLinkFull',pCluster := tools.fun_Groupname('92')).Built2QA
	,BizLinkFull.Promote(,'BizLinkFull',pCluster := tools.fun_Groupname('30')).Built2QA
);

