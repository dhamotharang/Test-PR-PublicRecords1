/*2005-08-11T16:07:33Z (Chad Morton)
goes wi prop new .6 and .7
*/
IMPORT Business_Header, doxie_cbrs;

EXPORT fn_getSmallerSupergroup
(DATASET(doxie_cbrs.layout_supergroup) thegroupids, UNSIGNED4 maxsg) :=
FUNCTION

outrec := RECORD
  doxie_cbrs.layout_supergroup;
  UNSIGNED seq := 0;
  UNSIGNED6 true_group;
END;
bhkr := Business_Header.Key_Business_Relatives;

outrec xf_l0(business_header.key_bh_supergroup_bdid r) := TRANSFORM
  SELF.group_id := r.bdid;
  SELF.level := 0;
  SELF.true_group := r.group_id;
  SELF := r;
END;
outrec xf_l12(outrec l, bhkr r, UNSIGNED1 lev) := TRANSFORM
  SELF.group_id := l.group_id;
  SELF.level := lev;
  SELF.bdid := r.bdid2;
  SELF := l;
END;

//** do the joins and keep out dups

//***** TRUE GROUP BECOMES THE GROUPID WHEN THEGROUPIDS ARE TREATED AS BDIDS
L0 :=
  JOIN(
    thegroupids,
    business_header.key_bh_supergroup_bdid,
    LEFT.bdid = RIGHT.bdid,
    xf_l0(RIGHT),
    KEEP(1), LIMIT(0));
    
//****** FIND ALL THE BDIDS WITHIN EACH GROUP FROM L0
L0_supergroup :=
  JOIN(
    l0,
    business_header.Key_BH_SuperGroup_GroupID,
    LEFT.true_group = RIGHT.group_id,
    TRANSFORM(
      {UNSIGNED6 bdid},
      SELF.bdid := RIGHT.bdid),
    KEEP(1000));
    
//****** GET THE CORRECT RELATIVES AND BE SURE THEY ARE WITHIN LO_SUPERGROUP
L1 :=
  NOFOLD(JOIN(
    JOIN(
      DEDUP(
        SORT(
          L0,
          group_id,
          bdid,
          level),
        group_id,
        bdid),
      bhkr,
      KEYED(LEFT.bdid=RIGHT.bdid1) AND
      business_header.mac_isGroupRel(RIGHT),
      xf_l12(LEFT,RIGHT,1),
      LIMIT(10000,SKIP),
      KEEP(1000)),
    l0_supergroup,
    LEFT.bdid = RIGHT.bdid,
    TRANSFORM(
      outrec,
      SELF := LEFT),
    LIMIT(10000,SKIP),
    KEEP(1000)));
    
// Eliminate those that already have enough candidates from doing a second join level.
L1_under_maxsg :=
  JOIN(
    l1,
    table(
      DEDUP(
        SORT(
          L1,
          group_id,
          bdid,
          level),
        group_id,
        bdid),
      {
        group_id,
        cnt:=COUNT(GROUP)},
      group_id)(
        cnt >= maxsg), //those with too many are used IN the LEFT only JOIN
    LEFT.group_id=RIGHT.group_id,
    TRANSFORM(
      outrec,
      SELF:=LEFT),
    LEFT only);

//****** SECOND BOUNCE
L2 :=
  JOIN(
    JOIN(
      DEDUP(
        SORT(
          L1_under_maxsg,
          group_id,
          bdid,
          level),
        group_id,
        bdid),
      bhkr,
      KEYED(LEFT.bdid=RIGHT.bdid1) AND
      RIGHT.bdid2 NOT IN SET(l1,bdid) AND
      business_header.mac_isGroupRel(RIGHT),
      xf_l12(LEFT,RIGHT,2),
      LIMIT(10000,SKIP),
      KEEP(1000)),
    l0_supergroup,
    LEFT.bdid = RIGHT.bdid,
    TRANSFORM(
      outrec,
      SELF := LEFT),
    LIMIT(10000,SKIP),
    KEEP(1000));
    
AllLevs := GROUP(SORT(DEDUP(SORT(L0 + L1 + L2,group_id,bdid,level),group_id,bdid),group_id,level,bdid),group_id);

outrec xf_iter(outrec l, outrec r) := TRANSFORM
  SELF.seq := l.seq + 1;
  SELF := r;
END;

AllLevsSeq := GROUP(ITERATE(AllLevs,xf_iter(LEFT,RIGHT)));

doxie_cbrs.layout_supergroup xf_proj(outrec l) := TRANSFORM
  SELF.group_id := 0;
  SELF := l;
END;
AllLevsTrim := SORT(DEDUP(SORT(PROJECT(AllLevsSeq(seq <= maxsg),xf_proj(LEFT)),bdid,level),bdid),level,bdid);

RETURN AllLevsTrim;

END;



