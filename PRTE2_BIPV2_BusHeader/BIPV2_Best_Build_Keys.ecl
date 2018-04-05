//EXPORT BIPV2_Best_Build_Keys := 'todo';
import doxie, Tools, BIPV2, BIPV2_Best;
export BIPV2_Best_Build_Keys(
   string                           pversion
  ,dataset(BIPV2_Best.Layouts.Base) pBestBase = PRTE2_BIPV2_BusHeader.Files(pversion).Base.BestFile.built
  ,dataset(bipv2.CommonBase.layout) pDs_Clean = PRTE2_BIPV2_BusHeader.File_DS_CLEAN
) :=
module
	shared Base     		  := BIPV2_Best.fn_Prep_Base_for_Key (pversion,pBestBase);
  shared ds_commonbase  := table(pDs_Clean,{seleid,seleid_status_private},seleid,seleid_status_private,merge);
  shared dkeybuild      := join(Base ,ds_commonbase  ,left.seleid = right.seleid,transform(
     BIPV2_Best.layouts.key
    ,self.isdefunct := if(right.seleid_status_private = 'D'           ,true   ,false)
    ,self.isactive  := if(right.seleid_status_private  in ['I','D']   ,false  ,true )
    ,self           := left
  ),hash,keep(1),left outer);//only 1 status per seleid
  
	// shared dkeybuild		:= project(Base, transform(layouts.key, self := left, self := []));
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(dkeybuild, key_build, keynames(pversion,false).Best_LinkIds.QA);
  
	shared BuildLinkIdsKey := tools.macf_writeindex('key_build,	keynames(pversion,false).Best_LinkIds.New');
	export full_build :=
	sequential(
		 parallel(
			BuildLinkIdsKey			
		 )
		,Promote(pversion).New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping PRTE2_BIPV2_BusHeader.BIPV2_Best_Build_Keys attribute')
	);
end;
