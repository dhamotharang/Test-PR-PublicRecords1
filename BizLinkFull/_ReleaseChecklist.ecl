this needs to be returning actual orgid and utlid (either as bonus fields or as idparents) - check mapping in Business_Header_SS.MAC_Match_Flex_V2, outfile20 join
need another bagofwords option hacked in to j1 and jo of cnpname and _st? (should be ok if MOST used in bagofwords for cnpname)
and might need to hack MatchBagOfWords out of the atmosts in some j0 and j1 (or thor wont compile)
phone j0 and j1:  a) reduce atmost to 1000.  b) add phone 3 to atmost and recs filter and join condition (phone join TOO SLOW and adds very little value)
	c) add this:  AND ( LEFT.cnp_name = (TYPEOF(LEFT.cnp_name))'' OR RIGHT.cnp_name = (TYPEOF(RIGHT.cnp_name))'' OR SALT26.MatchBagOfWords(LEFT.cnp_name,RIGHT.cnp_name,0,1,0,0,0) > 0 	)		
put st = '' filter into cnpname so that it and cnpname_st are exclusive (in jo, j1, and rawfetch) - see 2013-02-06T16:53:17Z version of BizLinkFull.Key_BizHead_L_CNPNAME for reference

maxresults parameter to meow_biz
#ifs in calls to keys in BizLinkFull.MAC_MEOW_Biz_Batch (fixed in future versions of salt, probably after 2.6b2) - see version 2013-03-28T16:18:14Z of BizLinkFull.MAC_MEOW_Biz_Batch
	this is a performance enhancements...skips the Js when no value passed in to that field
keys renamed
BLFCM.Key_BizHead_L_ADDRESS2 (possibly others?) have a tendency to return and highlight data where ST is missing in the header.  this is the fix
	rawfetch change looks like this
      AND ( /*st = (TYPEOF(st))'' OR*/ param_st = (TYPEOF(st))'' OR st = param_st  )) 
	j0,j1 change looks like this
			AND ( LEFT.st = (TYPEOF(LEFT.st))'' OR /*RIGHT.st = (TYPEOF(RIGHT.st))'' OR*/ LEFT.st = RIGHT.st  )


TESTING:
	20k test run - BIPV2_Testing.BWR_XLink_Sample
	chad need to run his latency test on 100x roxie (which also looks for state mismatch problems)

AT THE LAST MINUTE BEFORE CHECK IN:
	run sample code in bipv2.idfunctions
	syntax check TopBusiness_Services.BusinessSearch

NOT CURRENTLY AN ISSUE BUT COULD BE WITH FUTURE LINKPATHS:
	if you have something like fixed:zip and optional:cnp_name (to let it be fuzzy), then you will want to manually enforce that cnp_name is not blank
