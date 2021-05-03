
import strata, BIPV2_Files,BIPv2_HRCHY,BIPV2,SALT28,ut;

EXPORT fieldStats_IDcounts(

   dataset(BIPV2.CommonBase.layout ) pInfile        = BIPV2.CommonBase.DS_CLEAN
  ,dataset(BIPV2.CommonBase.layout ) pInfileFather  = bipv2.CommonBase.DS_LOCAL_STATIC_CLEAN
   

) := module


/* bug 128898
Per ProxID, SELE, ORG, ULT, POW, Contact

Avg # of records per ID
Median # of records per ID
Largest number of records per ID

Total records per ID
Broken down into buckets
-1
-2 to 4
-5 to 19
-20 to 49
-50 to 99
-100 to 249
-250 to 999
-1000 to 9999
-10000 to 99999
-100000 to 999999
-1000000 to X
*/


fIDCounts(dataset({SALT28.UIDType ID}) ids, string s) := //must be distributed by your ID!!  if i do it for you, it's slower (dist by ult and then org makes no sense)
FUNCTION

	r := record
		ids.id;
		cnt := count(group);
	end;
	
	t := table(sort(ids, id, local), r, id, local);
	
	outr := record
		string ID;

		real average_count;
		unsigned6 median_count;
		unsigned6 max_count;
		unsigned6 total_count;
		unsigned6 total_IDs;
		unsigned6 sum_buckets;
		unsigned6 count_1;
		unsigned6 count_2_to_4;
		unsigned6 count_5_to_19;
		unsigned6 count_20_to_49;
		unsigned6 count_50_to_99;
		unsigned6 count_100_to_249;
		unsigned6 count_250_to_999;
		unsigned6 count_1000_to_9999;
		unsigned6 count_10000_to_99999;
		unsigned6 count_100000_to_999999;
		unsigned6 count_1000000_plus;
		
	end;
	
	//true median causes skew, so lets try it with a sample
	onemillion := 1000000;
	e := enth(t, onemillion);
	
	return 
	project(
		dataset([{1}], {unsigned a}),
		transform(
			outr,
			self.ID := s;
			self.total_count := sum(t, cnt);
			self.total_IDs := count(t);
			self.average_count := ave(t, cnt);
			// self.median_count := sort(t, cnt)[(unsigned6)(count(t)/2)].cnt;
			self.median_count := sort(e, cnt)[(unsigned6)(count(e)/2)].cnt;
			self.max_count := max(t, cnt);
			
			self.count_1 											:= count(t(cnt = 1));
			self.count_2_to_4 								:= count(t(cnt between 2 and 4));
			self.count_5_to_19 								:= count(t(cnt between 5 and 19));
			self.count_20_to_49 							:= count(t(cnt between 20 and 49));
			self.count_50_to_99 							:= count(t(cnt between 50 and 99));
			self.count_100_to_249 						:= count(t(cnt between 100 and 249));
			self.count_250_to_999 						:= count(t(cnt between 250 and 999));
			self.count_1000_to_9999 					:= count(t(cnt between 1000 and 9999));
			self.count_10000_to_99999 				:= count(t(cnt between 10000 and 99999));
			self.count_100000_to_999999 			:= count(t(cnt between 100000 and 999999));
			self.count_1000000_plus 					:= count(t(cnt >= 1000000));
			
			self.sum_buckets := 
				self.count_1+self.count_2_to_4+self.count_5_to_19+self.count_20_to_49+self.count_50_to_99+self.count_100_to_249
				+self.count_250_to_999+self.count_1000_to_9999+self.count_10000_to_99999+self.count_100000_to_999999+self.count_1000000_plus; 	
		)
	);

END;

pInfileIDs := project(pInfile, {bipv2.IDlayouts.l_header_ids, pInfile.lgid3, pInfile.cnt_prox_per_lgid3});
distult := distribute(pInfileIDs(ultid > 0), hash(ultid));
dsult := 	project(distult(ultid > 0), 	transform({SALT28.UIDType ID}, self.ID := left.ultid));
dsorg := 	project(distult(orgid > 0), 	transform({SALT28.UIDType ID}, self.ID := left.orgid));
dssele := project(distult(seleid > 0), 	transform({SALT28.UIDType ID}, self.ID := left.seleid));
dslgid3:= project(distult(cnt_prox_per_lgid3>1), 	transform({SALT28.UIDType ID}, self.ID := left.lgid3));
dsprox := project(distult(proxid > 0), 	transform({SALT28.UIDType ID}, self.ID := left.proxid));
dsemp := 	project(distult(empid > 0), 	transform({SALT28.UIDType ID}, self.ID := left.empid));//pretty sure emp will be within an ult
//now we need a new dist
distpow := distribute(pInfileIDs(powid > 0), hash(powid));
dspow := 	project(distult(powid > 0), 	transform({SALT28.UIDType ID}, self.ID := left.powid));

IDCounts := 
 fIDCounts(dsult, 	'UltID')
+fIDCounts(dsorg, 	'OrgID')
+fIDCounts(dssele, 	'SeleID')
+fIDCounts(dslgid3, 'LGID3')
+fIDCounts(dsprox, 	'ProxID')
+fIDCounts(dsemp, 	'EmpID')
+fIDCounts(dspow, 	'PowID');

export buckets := IDCounts;



ds_header := pInfile;
dd_lgid3 := dedup(ds_header(cnt_prox_per_lgid3>1), lgid3, all);
shared t_lgid3 := table(dd_lgid3,{lgid3,seleid,cnt_prox_per_lgid3});
shared xtab := table(t_lgid3, {cnt_prox_per_lgid3, unsigned num_lgid3:=count(group)}, cnt_prox_per_lgid3);
	
export TotalProxIDsInLGID3 := sum(t_lgid3,cnt_prox_per_lgid3);
export XTabProxIDsInLGID3  := choosen(sort(xtab,-cnt_prox_per_lgid3),1000);

ds_header := pInfile;
dd_seleid := dedup(ds_header(nodes_total>1), seleid, all);
shared t_seleid := table(dd_seleid,{seleid,nodes_total});
shared xtabs := table(t_seleid, {nodes_total, unsigned num_seleid:=count(group)}, nodes_total);
	
export TotalProxIDsInHrchy := sum(t_seleid,nodes_total);
export XTabProxIDsInHrchy  := choosen(sort(xtabs,-nodes_total),1000);





old0 := project(pInfileFather/*during the build this will contain the previous base file*/,transform(bipv2.CommonBase.layout,self := left,self := []));//change to static so it works when we change the layout, but project to new layout//the old header is the one in the superfile this time.  the new one is just now building cuz we are inside the build.
new := pInfile;
old := if(count(new) < 100000, choosen(old0, count(new)), old0);//this line just allows me to test on a smaller dataset.  assumes in new has < 100k, then we are testing.

fmac(id) := 
FUNCTIONMACRO
	j := 
	join(
		dedup(sort(distribute(old, hash(id)), id, local), id, local),
		dedup(sort(distribute(new, hash(id)), id, local), id, local),
		left.id = right.id,
		transform(
			{old.id, boolean found, boolean sameIDs, boolean sameUltIDs, boolean sameOrgIDs, boolean sameSELEIDs, boolean sameProxIDs, boolean samePOWIDs, boolean sameEmpIDs},
			self.id := left.id;
			self.found := right.rcid > 0;
			
			self.sameUltIDs 	:= self.found and left.UltID = right.UltID;  
			self.sameOrgIDs 	:= self.found and left.OrgID = right.OrgID;
			self.sameSELEIDs 	:= self.found and left.SELEID = right.SELEID;
			self.sameProxIDs 	:= self.found and left.ProxID = right.ProxID;
			self.samePOWIDs 	:= self.found and left.PowID = right.PowID;
			self.sameEmpIDs 	:= self.found and left.EmpID = right.EmpID; 
			 
			self.sameIDs := self.sameUltIDs and self.sameOrgIDs and self.sameSELEIDs and self.sameProxIDs and self.samePOWIDs and self.sameEmpIDs;	 
		),
		local,
		left outer
	);
		
		r := record
		string10 IDtype := #text(id);
		pct_measured 			:= 100 * count(group, j.found) 				/ count(group);
		pct_sameIDs 			:= 100 * count(group, j.sameIDs) 			/ count(group, j.found);
		pct_sameUltIDs 		:= 100 * count(group, j.sameUltIDs) 	/ count(group, j.found);
		pct_sameOrgIDs 		:= 100 * count(group, j.sameOrgIDs) 	/ count(group, j.found);
		pct_sameSELEIDs 	:= 100 * count(group, j.sameSELEIDs) 	/ count(group, j.found);
		pct_sameProxIDs 	:= 100 * count(group, j.sameProxIDs) 	/ count(group, j.found);
		pct_samePOWIDs 		:= 100 * count(group, j.samePOWIDs) 	/ count(group, j.found);
		pct_sameEmpIDs 		:= 100 * count(group, j.sameEmpIDs) 	/ count(group, j.found);
	end;
		return table(j, r, few);
ENDMACRO;

export Change :=  fmac(rcid) + fmac(seleid) + fmac(proxid);

		export layout_change := 
    record
      string10 IDtype ;
      real8 pct_measured 			;
      real8 pct_sameIDs 			;
      real8 pct_sameUltIDs 		;
      real8 pct_sameOrgIDs 		;
      real8 pct_sameSELEIDs 	;
      real8 pct_sameProxIDs 	;
      real8 pct_samePOWIDs 		;
      real8 pct_sameEmpIDs 		;
	end;

end;//fieldStats_IDcounts