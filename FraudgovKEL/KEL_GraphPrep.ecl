
  IMPORT KELOtto, FraudGovPlatform_Analytics, FraudGovPlatform, Data_services, Std;

  EntityEventPivot := FraudgovKEL.KEL_EventPivot.EventPivotShell;
	
	// build only for profile records in pivot
  LinksPrep := JOIN(EntityEventPivot(islastentityeventflag=1), EntityEventPivot, 
	               LEFT.customerid = RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND LEFT.recordid=RIGHT.recordid AND LEFT.entitycontextuid != RIGHT.entitycontextuid AND 
								 (LEFT.entitytype != 1 AND RIGHT.entitytype = 1 OR LEFT.entitytype = 1 AND RIGHT.entitytype != 1),
	               TRANSFORM({LEFT.customerid, LEFT.industrytype, STRING treeuid, RIGHT.entitycontextuid, LEFT.eventdate}, SELF.treeuid := LEFT.entitycontextuid, SELF.entitycontextuid := RIGHT.entitycontextuid, SELF := LEFT), HASH);
  
	LinksRec := RECORD
    UNSIGNED eventdate;
		STRING entitycontextuid;
  END;
	
  rEntityWithLinks := RECORD
    integer8 industrytype;
    integer8 customerid;	
    STRING entitycontextuid;
    DATASET(LinksRec) Links;
  END;
  
	LinksPrepGrouped := GROUP(SORT(DISTRIBUTE(LinksPrep, HASH32(treeuid)), industrytype, customerid, treeuid, LOCAL),  industrytype, customerid, treeuid);
	
  rEntityWithLinks tEntityWithLinks(LinksPrepGrouped l, DATASET(RECORDOF(LinksPrepGrouped)) r) := TRANSFORM
    SELF.industrytype := l.industrytype;
    SELF.customerid := l.customerid;
    SELF.entitycontextuid := l.treeuid;
    SELF.Links := PROJECT(r, TRANSFORM(LinksRec, SELF := LEFT));
  END;
	
  //Only Link from People to Elements	
  Links := ROLLUP(LinksPrepGrouped(entitycontextuid[2..3] != '01'), GROUP, tEntityWithLinks(LEFT,ROWS(LEFT)));

  // Zero Degree
	Links0 := PROJECT(DEDUP(SORT(LinksPrep, customerid, industrytype, treeuid, LOCAL), customerid, industrytype, treeuid, LOCAL), TRANSFORM(RECORDOF(LEFT), SELF.entitycontextuid := LEFT.treeuid, SELF := LEFT));
  // 1st degree
	
  Links1 := JOIN(LinksPrep, LinksPrep, 
	               LEFT.customerid = RIGHT.customerid AND LEFT.industrytype = RIGHT.industrytype AND LEFT.entitycontextuid = RIGHT.treeuid AND LEFT.treeuid != RIGHT.entitycontextuid,
	               TRANSFORM(RECORDOF(LEFT), SELF.treeuid := LEFT.treeuid, SELF.entitycontextuid := RIGHT.entitycontextuid, SELF := LEFT), HASH);

  Links2 := JOIN(Links1, LinksPrep, 
	               LEFT.customerid = RIGHT.customerid AND LEFT.industrytype = RIGHT.industrytype AND LEFT.entitycontextuid = RIGHT.treeuid AND LEFT.treeuid != RIGHT.entitycontextuid,
	               TRANSFORM(RECORDOF(LEFT), SELF.treeuid := LEFT.treeuid, SELF.entitycontextuid := RIGHT.entitycontextuid, SELF := LEFT), HASH);
	
//	output(Links1(customerid = 20989869 AND industrytype =	1014 and treeuid = '_092247340211570905463'), named('Links1'));
	
	LinksFinal := DEDUP(SORT(DISTRIBUTE(Links0 + LinksPrep + Links1 + Links2, HASH32(treeuid)), customerid, industrytype, treeuid, entitycontextuid, LOCAL), customerid, industrytype, treeuid, entitycontextuid, LOCAL);
//	output(SORT(LinksFinal, customerid, industrytype, treeuid)(customerid = 20989869 AND industrytype =	1014 and treeuid = '_092247340211570905463'), named('LinksFinal'));
	
	GraphFinal := JOIN(LinksFinal, EntityEventPivot, LEFT.customerid = RIGHT.customerid AND LEFT.industrytype = RIGHT.industrytype AND LEFT.entitycontextuid = RIGHT.entitycontextuid, KEEP(1), HASH);
	GraphFinalWithLinks := JOIN(GraphFinal, Links, LEFT.customerid = RIGHT.customerid AND LEFT.industrytype = RIGHT.industrytype AND LEFT.entitycontextuid = RIGHT.entitycontextuid, KEEP(1), LEFT OUTER, HASH);
//	output(SORT(GraphFinalWithLinks, customerid, industrytype, treeuid)(customerid = 20989869 AND industrytype =	1014 and treeuid = '_011039698450'), named('LinksFinalWithEntities1'));
//  output(SORT(GraphFinalWithLinks, customerid, industrytype, treeuid)(customerid = 20989869 AND industrytype =	1014 and treeuid = '_092247340211570905463'), named('LinksFinalWithEntities2'));

 // output(GraphFinalWithLinks,,'~fraudgov::rin2::graphprep', overwrite);
//	output(GraphFinalWithLinks(entitycontextuid[2..3] != '01'));
	
EXPORT KEL_GraphPrep := GraphFinalWithLinks;