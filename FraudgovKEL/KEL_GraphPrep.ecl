
EXPORT KEL_GraphPrep := MODULE

  IMPORT FraudgovKEL, FraudGovPlatform_Analytics, FraudGovPlatform, Data_services, Std;

  SHARED EntityEventPivot := FraudgovKEL.KEL_EventPivot.EventPivotShell;

  // build only for profile records in pivot
  EXPORT LinksPrep := JOIN(EntityEventPivot(iscurrent = 1), EntityEventPivot, 
                   LEFT.customerid = RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND LEFT.recordid=RIGHT.recordid AND LEFT.entitycontextuid != RIGHT.entitycontextuid AND 
                   (LEFT.entitytype != 1 AND RIGHT.entitytype = 1 OR LEFT.entitytype = 1 AND RIGHT.entitytype != 1),
                   TRANSFORM({LEFT.customerid, LEFT.industrytype, STRING treeuid, RIGHT.entitycontextuid, LEFT.t_actdtecho}, SELF.treeuid := LEFT.entitycontextuid, SELF.entitycontextuid := RIGHT.entitycontextuid, SELF := LEFT), HASH);
 
  // Zero Degree
  SHARED Links0 := PROJECT(DEDUP(SORT(LinksPrep, customerid, industrytype, treeuid, LOCAL), customerid, industrytype, treeuid, LOCAL), TRANSFORM(RECORDOF(LEFT), SELF.entitycontextuid := LEFT.treeuid, SELF := LEFT));
  // 1st degree
  SHARED Links1Prep := JOIN(DISTRIBUTE(LinksPrep, HASH64(entitycontextuid)), 
					      DISTRIBUTE(LinksPrep, HASH64(treeuid)),
                   LEFT.customerid = RIGHT.customerid AND LEFT.industrytype = RIGHT.industrytype AND LEFT.entitycontextuid = RIGHT.treeuid AND LEFT.treeuid != RIGHT.entitycontextuid,
                   TRANSFORM(RECORDOF(LEFT), SELF.treeuid := LEFT.treeuid, SELF.entitycontextuid := RIGHT.entitycontextuid, SELF := LEFT), LOCAL);
				   				   
  EXPORT Links1 := DEDUP(SORT(DISTRIBUTE(Links1Prep, HASH64(treeuid)), customerid, industrytype, treeuid, entitycontextuid), customerid, industrytype, treeuid, entitycontextuid);
                     
  EXPORT LinksFinal := DEDUP(SORT(DISTRIBUTE(Links0 + LinksPrep + Links1, HASH32(treeuid)), customerid, industrytype, treeuid, entitycontextuid, -t_actdtecho, LOCAL), customerid, industrytype, treeuid, entitycontextuid, LOCAL)
                  : PERSIST('~fraudgov::temp::fraudgov::temp::persist::links');

  GraphFinal := JOIN(LinksFinal, EntityEventPivot(aotcurrprofflag=1), LEFT.customerid = RIGHT.customerid AND LEFT.industrytype = RIGHT.industrytype AND LEFT.entitycontextuid = RIGHT.entitycontextuid, 
                  TRANSFORM({LEFT.customerid, LEFT.industrytype, LEFT.treeuid, LEFT.entitycontextuid, RIGHT.t_actdtecho, RIGHT.entitytype, RIGHT.label, 
                    RIGHT.riskindx, RIGHT.aotkractflagev, RIGHT.aotsafeactflagev, RIGHT.personeventcount,
                    RIGHT.t_inpclndobecho, RIGHT.t1L_iddeceasedflag, RIGHT.aotidactcntev, RIGHT.deceaseddate, RIGHT.T1_MinorIDFlag, RIGHT.t_inagencyflag}, 
                    SELF.customerid := LEFT.customerid, SELF.treeuid := LEFT.treeuid, SELF.entitycontextuid := LEFT.entitycontextuid, SELF := RIGHT),
                 KEEP(1), HASH) : PERSIST('~fraudgov::temp::fraudgov::temp::persist::entities');

  EXPORT Vertices := GraphFinal;

  EdgesFinal := JOIN(LinksFinal, LinksPrep(treeuid[2..3] = '01'), LEFT.customerid = RIGHT.customerid AND LEFT.industrytype = RIGHT.industrytype AND LEFT.entitycontextuid = RIGHT.treeuid,
                TRANSFORM({LEFT.customerid, LEFT.industrytype, LEFT.treeuid, STRING fromentitycontextuid, STRING toentitycontextuid, RIGHT.t_actdtecho}, 
                SELF.fromentitycontextuid := RIGHT.treeuid, SELF.toentitycontextuid := RIGHT.entitycontextuid, SELF.t_actdtecho := RIGHT.t_actdtecho, SELF := LEFT), HASH);
               // : PERSIST('~fraudgov::temp::fraudgov::temp::persist::edges');

  EXPORT Edges := EdgesFinal;	

END;

