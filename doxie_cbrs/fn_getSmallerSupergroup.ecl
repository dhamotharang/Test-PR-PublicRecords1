/*2005-08-11T16:07:33Z (Chad Morton)
goes wi prop new .6 and .7
*/
import Business_Header, doxie_cbrs;

export fn_getSmallerSupergroup
(dataset(doxie_cbrs.layout_supergroup) thegroupids, unsigned4 maxsg) :=
FUNCTION

outrec := record
  doxie_cbrs.layout_supergroup;
	unsigned seq := 0;
	unsigned6 true_group;
end;
bhkr := Business_Header.Key_Business_Relatives;

outrec xf_l0(business_header.key_bh_supergroup_bdid r) := transform
  self.group_id := r.bdid;
	self.level := 0;
	self.true_group := r.group_id;
	self := r;
end;
outrec xf_l12(outrec l, bhkr r, unsigned1 lev) := transform
  self.group_id := l.group_id;
	self.level := lev;
	self.bdid := r.bdid2;
	self := l;
end;

//** do the joins and keep out dups

//***** TRUE GROUP BECOMES THE GROUPID WHEN THEGROUPIDS ARE TREATED AS BDIDS
L0 :=
	join(
		thegroupids,
		business_header.key_bh_supergroup_bdid,
		left.bdid = right.bdid,
		xf_l0(right),
		keep(1), limit(0));
		
//****** FIND ALL THE BDIDS WITHIN EACH GROUP FROM L0
L0_supergroup :=
	join(
		l0,
		business_header.Key_BH_SuperGroup_GroupID,
		left.true_group = right.group_id,
		transform(
			{unsigned6 bdid},
			self.bdid := right.bdid),
		keep(1000));
		
//****** GET THE CORRECT RELATIVES AND BE SURE THEY ARE WITHIN LO_SUPERGROUP
L1 := 
	nofold(join(
		join(
			dedup(
				sort(
					L0,
					group_id,
					bdid,
					level),
				group_id,
				bdid),
			bhkr,
			keyed(left.bdid=right.bdid1) and
			business_header.mac_isGroupRel(right),
			xf_l12(left,right,1),
			limit(10000,skip),
			keep(1000)),
		l0_supergroup,
		left.bdid = right.bdid,
		transform(
			outrec,
			self := left),
		limit(10000,skip),
		keep(1000)));
		
// Eliminate those that already have enough candidates from doing a second join level.
L1_under_maxsg :=
	join(
		l1,
		table(
			dedup(
				sort(
					L1,
					group_id,
					bdid,
					level),
				group_id,
				bdid),
			{
				group_id,
				cnt:=count(group)},
			group_id)(
				cnt >= maxsg), //those with too many are used in the left only join
		left.group_id=right.group_id,
		transform(
			outrec,
			self:=left),
		left only);

//****** SECOND BOUNCE	
L2 :=
	join(
		join(
			dedup(
				sort(
					L1_under_maxsg,
					group_id,
					bdid,
					level),
				group_id,
				bdid),
			bhkr,
			keyed(left.bdid=right.bdid1) and
			right.bdid2 not in set(l1,bdid) and
			business_header.mac_isGroupRel(right),
			xf_l12(left,right,2),
			limit(10000,skip),
			keep(1000)),
		l0_supergroup,
		left.bdid = right.bdid,
		transform(
			outrec,
			self := left),
		limit(10000,skip),
		keep(1000));
		
AllLevs := group(sort(dedup(sort(L0 + L1 + L2,group_id,bdid,level),group_id,bdid),group_id,level,bdid),group_id);

outrec xf_iter(outrec l, outrec r) := transform
  self.seq := l.seq + 1;
	self := r;
end;

AllLevsSeq := group(iterate(AllLevs,xf_iter(left,right)));

doxie_cbrs.layout_supergroup xf_proj(outrec l) := transform
  self.group_id := 0;
	self := l;
end;
AllLevsTrim := sort(dedup(sort(project(AllLevsSeq(seq <= maxsg),xf_proj(left)),bdid,level),bdid),level,bdid);

return AllLevsTrim;		 

END;



