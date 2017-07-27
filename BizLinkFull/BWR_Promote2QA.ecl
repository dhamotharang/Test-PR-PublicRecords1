import BIPV2,BizLinkFull,tools;

sequential(

   BizLinkFull.Promote().built2QA
	,BizLinkFull.Promote(,'bizlinkfull',pCluster := tools.fun_Groupname('20')).Built2QA
	,BizLinkFull.Promote(,'bizlinkfull',pCluster := tools.fun_Groupname('84')).Built2QA
	,BizLinkFull.Promote(,'bizlinkfull',pCluster := tools.fun_Groupname('92')).Built2QA
	,BizLinkFull.Promote(,'bizlinkfull',pCluster := tools.fun_Groupname('30')).Built2QA
);