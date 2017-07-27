import BIPV2_Files, BIPV2;
l_base := BIPV2.CommonBase.Layout;
ds_null := dataset([],l_base);
export idIntegrity(dataset(l_base) ds_in_raw=ds_null, boolean verbose=false) := module
	export custom(Patched_Infile,rid,did,outPrefix='',verbose=false,use_parent=false,pid='',pOutput_Dataset=false) := functionmacro
		
		p := if(#text(outPrefix)<>'',outPrefix+'_','');
		lay_ds := {unsigned6 DuplicateRids0,unsigned6 DidsNoRid0,unsigned6 DidsAboveRid0,unsigned6 DidsMultiParent0 := 0,unsigned6 ParentNoDid0 := 0,unsigned6 ParentAboveDid0 := 0};
		PostPatchIdCount := count(table(Patched_Infile(did<>0),{did},did,merge)); // same as SUM(hygiene(Patched_Infile).ClusterCounts, NumberOfClusters)
		NullRids0 := COUNT(Patched_Infile(rid=0)); // Should be zero
		NullDids0 := COUNT(Patched_Infile(did=0)); // Should be zero
		DuplicateRids0 := COUNT(Patched_Infile) - COUNT(DEDUP(Patched_Infile,rid,ALL)); // Should be zero
		DidsNoRid0 := PostPatchIdCount - COUNT(Patched_Infile(did=rid)); // Should be zero
		DidsAboveRid0 := COUNT(Patched_Infile(did>rid)); // Should be zero
		o1 := if(verbose,output(PostPatchIdCount, named(p+'PostPatchIdCount')));
		o2 := if(verbose,output(NullRids0, named(p+'NullRids0')));
		o3 := if(verbose,output(NullDids0, named(p+'NullDids0')));
		o4 := output(DuplicateRids0, named(p+'DuplicateRids0'));
		o5 := output(DidsNoRid0, named(p+'DidsNoRid0'));
		o6 := output(DidsAboveRid0, named(p+'DidsAboveRid0'));
    ods := output(dataset([{DuplicateRids0,DidsNoRid0,DidsAboveRid0}],lay_ds) ,named(p+'ChecksDs'));
		o  := parallel(o1,o2,o3,o4,o5,o6);
    o_ := parallel(o1,o2,o3,o4,o5,o6,ods);
		#if(use_parent)
    
      tDidsMultiParent0 := table(table(Patched_Infile(pid<>0),{did,pid},did,pid,merge), {did, cnt:=count(group)}, did)(cnt>1);
			DidsMultiParent0 := count(tDidsMultiParent0);
			tParentIdCount := table(Patched_Infile(pid<>0),{pid},pid,merge);
			ParentIdCount := count(tParentIdCount);
			tParentNoDid0 := table(Patched_Infile(pid<>0,pid=did),{pid},pid,merge);
			ParentNoDid0 := ParentIdCount - count(tParentNoDid0);
			tParentAboveDid0 := Patched_Infile(pid>did);
			ParentAboveDid0 := count(tParentAboveDid0);
      #IF(pOutput_Dataset)
        return dataset([{DuplicateRids0,DidsNoRid0,DidsAboveRid0,DidsMultiParent0,ParentNoDid0,ParentAboveDid0}],lay_ds);
      #ELSE
        o7 := output(DidsMultiParent0, named(p+'DidsMultiParent0'));
        o8 := output(ParentNoDid0, named(p+'ParentNoDid0'));
        o9 := output(ParentAboveDid0, named(p+'ParentAboveDid0'));
        ods2 := output(dataset([{DuplicateRids0,DidsNoRid0,DidsAboveRid0,DidsMultiParent0,ParentNoDid0,ParentAboveDid0}],lay_ds) ,named(p+'ChecksDs'));
        return parallel(o,o7,o8,o9,ods2
        //start -  just for finding specific errors in your file
        // ,output(join(tParentIdCount,tParentNoDid0,left.pid=right.pid, left only, hash), named(p+'sampleParentNoDid0'))
        // ,output(tDidsMultiParent0, named(p+'tDidsMultiParent0'))
        // ,output(tParentIdCount, named(p+'tParentIdCount'))
        // ,output(tParentNoDid0, named(p+'tParentNoDid0'))
        // ,output(tParentAboveDid0, named(p+'tParentAboveDid0'))
        //end -  just for finding specific errors in your file
        );
      #END
		#else
      #IF(pOutput_Dataset)
        return dataset([{DuplicateRids0,DidsNoRid0,DidsAboveRid0}],lay_ds);        
      #ELSE
        return o_;
      #END
		#end
	endmacro;
	// Thin the input to fields relevant to id integrity.  GLOBAL so we don't hit the original dataset repeatedly.
	shared ds_in	:= table(ds_in_raw, {rcid,dotid,proxid,lgid3,powid,empid,orgid,ultid,seleid}) : global;
	
	export dot				:= custom(ds_in,rcid,dotid,'dot',verbose,true,proxid);
	export dot_emp		:= custom(ds_in,rcid,dotid,'dot_emp',verbose,true,empid);
	export prox				:= custom(ds_in,rcid,proxid,'prox',verbose,true,orgid);
	export prox_lgid3	:= custom(ds_in,rcid,proxid,'prox_lgid3',verbose,true,lgid3);
	export prox_pow		:= custom(ds_in,rcid,proxid,'prox_pow',verbose,true,powid);
	export prox_sele	:= custom(ds_in,rcid,proxid,'prox_sele',verbose,true,seleid);
	export lgid3			:= custom(ds_in,rcid,lgid3,'lgid3',verbose,true,orgid);
	export lgid3_sele	:= custom(ds_in,rcid,lgid3,'lgid3_sele',verbose,true,seleid);
	export pow				:= custom(ds_in,rcid,powid,'pow',verbose,true,orgid);
	export emp				:= custom(ds_in,rcid,empid,'emp',verbose,true,orgid);
	export emp_sele		:= custom(ds_in,rcid,empid,'emp',verbose,true,seleid);
	export sele				:= custom(ds_in,rcid,seleid,'sele',verbose,true,orgid);
	export org				:= custom(ds_in,rcid,orgid,'org',verbose,true,ultid);
	export ult				:= custom(ds_in,rcid,ultid,'ult',verbose);
	export omni_lgid3	:= sequential(dot, prox_lgid3, lgid3, org, ult);
	export omni_pow		:= sequential(dot, prox_pow, pow, org, ult);
	export omni_emp		:= sequential(dot_emp, emp, org, ult);
	export omni_sele	:= sequential(dot, prox_sele, sele, org, ult);
	export omni				:= sequential(dot, prox, org, ult);
	export mini				:= sequential(dot, custom(ds_in,rcid,proxid,'prox',verbose));
	// Run BIPV2_DotID.Fields.UIDConsistency(PROJECT(ds,BIPV2_DotID.Layout_DOT)).Advanced0, run this, and you've got full coverage of the BIP ids.
	export fullBIP := parallel(prox_sele, lgid3_sele, emp_sele, sele, pow);
	
	
	// id order in these macros is rid-mid-did-pid -- we are working on the did, and mid may or may not exist
	export explode_DidsNoRid0(ds,rid,did,mid='') := functionmacro
		local t := table(ds(did<>0), {did, unsigned6 minrid:=min(group,rid)}, did, merge);
		local bad := t(did<>minrid);
		// return BIPV2_tools.idIntegrity().explode_bad(ds,bad,rid,did,mid='');
		return join(
			ds, bad,
			left.did=right.did,
			transform(recordof(left), self.did:=if(right.did=0, left.did,
				#if(#text(mid)<>'')
					left.mid
				#else
					left.rid
				#end
			), self:=left),
			left outer, lookup);
	endmacro;
	
	export explode_2parent(ds,rid,did,pid,mid='') := functionmacro
		local t1 := table(ds(did<>0,pid<>0), {did, pid}, did, pid, merge);
		local t2 := table(t1, {did, unsigned6 min_pid:=min(group,pid), unsigned num_pid:=count(group)}, did, merge);
		local bad := t2(num_pid>1);
		// return BIPV2_tools.idIntegrity().explode_bad(ds,bad,rid,did,mid='');
		return join(
			ds, bad,
			left.did=right.did,
			transform(recordof(left), self.did:=if(right.did=0, left.did,
				#if(#text(mid)<>'')
					left.mid
				#else
					left.rid
				#end
			), self:=left),
			left outer, lookup);
	endmacro;
	
	export explode_bad(ds,bad,rid,did,mid='') := functionmacro
		return join(
			ds, bad,
			left.did=right.did,
			transform(recordof(left), self.did:=if(right.did=0, left.did,
				#if(#text(mid)<>'')
					left.mid
				#else
					left.rid
				#end
			), self:=left),
			left outer, lookup);
	endmacro;
	
	export rebase(ds,rid,did) := functionmacro
		local t := table(ds(did<>0), {did, unsigned6 minrid:=min(group,rid)}, did, merge);
		local bad := t(did<>minrid);
		return join(
			ds, bad,
			left.did=right.did,
			transform(recordof(left), self.did:=if(right.did=0, left.did, right.minrid), self:=left),
			left outer, lookup);
	endmacro;
	
	export rebase_prox_up(ds) := functionmacro
		local _fix1 := BIPV2_tools.idIntegrity().rebase(ds,rcid,proxid);
		local _fix2 := BIPV2_tools.idIntegrity().rebase(_fix1,rcid,lgid3);
		local _fix3 := BIPV2_tools.idIntegrity().rebase(_fix2,rcid,orgid);
		local _fix4 := BIPV2_tools.idIntegrity().rebase(_fix3,rcid,ultid);
		return _fix4;
	endmacro;
	export patch_preDid(ds) := functionmacro
		return BIPV2_tools.idIntegrity().explode_DidsNoRid0(ds,rcid,dotid);
	endmacro;
	
	export patch_postDid(ds) := functionmacro
		// fix id integrity of input -- taken mostly from BIPV2_ProxID.Patch_Proxids
		local fix1 := project(ds, transform(recordof(ds), self.proxid:=if(left.proxid=0,left.dotid,left.proxid), self:=left));
		local fix2 := BIPV2_tools.idIntegrity().explode_DidsNoRid0(fix1,rcid,proxid,dotid);
		local ds_thin	:= table(fix2, {dotid, proxid}, dotid, proxid, merge);
		local ds_bad	:= join(ds_thin, ds_thin, left.dotid=right.dotid and left.proxid<>right.proxid, transform(left));
		ds_bad toPatch(ds_bad L, ds_bad R) := 
		transform
			self.dotid  := L.dotid;
			self.proxid := ut.Min2(L.proxid,R.proxid);
		end;
		local patchfile := rollup(sort(ds_bad,dotid,proxid), dotid, toPatch(left,right));
		// salt26.MAC_Reassign_UID(fix2,patchfile,proxid,dotid,ds_patched1);
		return join(fix2, patchfile, left.dotid=right.dotid, transform(recordof(ds),self.proxid:=if(right.proxid<>0,right.proxid,left.proxid),self:=left), left outer, hash);
	endmacro;
	
	EXPORT blank_above_lgid3(ds) := FUNCTIONMACRO
		ds doReset(ds L) := TRANSFORM		
			SELF.seleid := 0;
			SELF.orgid := 0;
			SELF.ultid := 0;
			SELF.powid := 0;
			SELF.empid := 0;
			SELF := L;
		END;
		RETURN PROJECT(ds, doReset(LEFT));
	ENDMACRO;	
	
end;
