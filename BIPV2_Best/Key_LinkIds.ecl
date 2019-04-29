IMPORT BIPV2, AutoStandardI, BizLinkFull, tools;
EXPORT Key_LinkIds := MODULE 
  // DEFINE THE INDEX
	shared superfile_name		      := keynames(,pUseOtherEnvironment := tools._Constants.IsDataland).LinkIds.qa;
	shared superfile_name_Built		:= keynames(,pUseOtherEnvironment := tools._Constants.IsDataland).LinkIds.built;
	shared superfile_name_father	:= keynames(,pUseOtherEnvironment := tools._Constants.IsDataland).LinkIds.father;
	shared Base_prep			:= Files().Base.Built;
  shared ds_commonbase  := table(bipv2.CommonBase.ds_clean,{seleid,seleid_status_private},seleid,seleid_status_private,merge);
  shared Base           := join(Base_prep ,ds_commonbase  ,left.seleid = right.seleid,transform(
     layouts.key
    ,self.isdefunct := if(right.seleid_status_private = 'D'           ,true   ,false)
    ,self.isactive  := if(right.seleid_status_private  in ['I','D']   ,false  ,true )
    ,self := left
  ),hash,keep(1),left outer);
  
	shared dkeybuild	:= project(Base, transform(layouts.key, self := left, self := []));
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(dkeybuild, k, superfile_name)
	export Key := k; // FOR DEBUG USE ONLY -- Do not reference this in production code!
	// export KeyPlus := BIPV2.mac_AddStatus(project(Key, {Key, string50 company_status_derived := ''})); //with company_status_derived, isactive, isdefunct
	export KeyPlus := project(Key, {Key, string50 company_status_derived := ''}); //with company_status_derived, isactive, isdefunct
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(dkeybuild, kbuilt, superfile_name_Built)
	export KeyBuilt := kbuilt; // FOR DEBUG USE ONLY -- Do not reference this in production code!
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(dkeybuild, kfather, superfile_name_father)
	export KeyFather := kfather; // FOR DEBUG USE ONLY -- Do not reference this in production code!
	shared dkeybuild_static	:= project(Base, transform(layouts.key_static, self := left, self := []));
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(dkeybuild_static, k, superfile_name)
	export Key_static := k;
  // -- allow for different versions to be accessed if needed(mostly for testing/research purposes)
  export key_       (string pversion = '',boolean pUseOtherEnvironment = tools._Constants.IsDataland) := tools.macf_FilesIndex('key'        ,keynames(pversion,pUseOtherEnvironment).LinkIds);
  export key_static_(string pversion = '',boolean pUseOtherEnvironment = tools._Constants.IsDataland) := tools.macf_FilesIndex('Key_static' ,keynames(pversion,pUseOtherEnvironment).LinkIds);
	// Apply restrictions -- may or may not filter the "sources" child dataset, depending on inputs
	shared restrict(ds, in_mod, permits, ds_src='', dnbWillMask=false, isDateFirstSeenExists=false) := functionmacro
		ds_filt := ds(BIPV2.mod_sources.isPermitted(in_mod,dnbWillMask).byBmap(permits));
		#IF(#TEXT(ds_src)='')
			return ds_filt;
		#ELSE
      // function instead of transform: need to check complicated SKIP condition.
			ds_filt xform (ds_filt L) := function
        #IF(isDateFirstSeenExists)
          unsigned4 dt_first_seen := L.dt_first_seen;
        #ELSE
          unsigned4 dt_first_seen := 0;
        #END
        ds_src_filt := L.ds_src (BIPV2.mod_sources.isPermitted(in_mod,dnbWillMask).bySource(source,vl_id,dt_first_seen));
        ds_filt xTransform := transform, skip (~exists(ds_src_filt))
  				self.ds_src := ds_src_filt;
	  			self := L;
		  	end;
        return xTransform;
      end;
			return project(ds_filt, xform(left)); //Using a SKIP in the transform was giving a syntax error and hence, had to use to this EXISTS filter condition
		#END
	endmacro;
	shared mask(ds, in_mod, permits) := functionmacro
		ds_masked := BIPV2.mod_sources.applyMasking(ds, in_mod, permits, '');
		return ds_masked;
	endmacro;
	
	// Removes record data matching the permit bitmask
	shared filterSrcCode(ds, permits, ds_src='', codeBmap) := functionmacro
		ds_filt := ds(permits & codeBmap <> 0);
		#IF(#TEXT(ds_src)='')
			return ds_filt;
		#ELSE
      // function instead of transform: need to check complicated SKIP condition.
			ds_filt xform (ds_filt L) := function
        ds_src_filt := L.ds_src (BIPV2.mod_sources.src2bmap(source) & codeBmap <> 0);
        ds_filt xTransform := transform, skip (~exists(ds_src_filt))
  				self.ds_src := ds_src_filt;
	  			self := L;
		  	end;
        return xTransform;
      end;
			return project(ds_filt, xform(left)); //Using a SKIP in the transform was giving a syntax error and hence, had to use to this EXISTS filter condition
		#END
	endmacro;

 export kfetch2_layout := {                          
							unsigned2 fetch_error_code;
							BIPV2.IDLayouts.l_xlink_ids2.UniqueID;
							KeyPlus};
							
	//DEFINE THE INDEX ACCESS
export kFetch2(
	dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs,
	string1 Level = BIPV2.IDconstants.Fetch_Level_ProxID, //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																							//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																									//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
	unsigned2 ScoreThreshold = 0,								//Applied at lowest level of ID
	BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
	boolean IncludeStatus = true,
	JoinLimit=25000,
	unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
	) :=
FUNCTION
	BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, ds_fetched, Level, JoinLimit, JoinType);
	// BIPV2.IDmacros.mac_IndexFetch(inputs, Key, ds_fetched, Level, 100);
	// apply restrictions in child datasets
	{ds_fetched, string50 company_status_derived := ''} apply_restrict(ds_fetched L) := transform
		// NOTE: These filter the "sources" child dataset when applicable, but not all sections have that
		self.company_name			:= mask(restrict(L.company_name, in_mod, company_name_data_permits, sources, true, true), in_mod, company_name_data_permits);
		self.company_address	:= mask(restrict(L.company_address, in_mod, company_address_data_permits,, true), in_mod, company_address_data_permits);
		self.company_phone		:= restrict(L.company_phone, in_mod, company_phone_data_permits,, true); // no mask required
		self.company_fein			:= restrict(L.company_fein, in_mod, company_fein_data_permits, sources);
		self.company_url			:= restrict(L.company_url, in_mod, company_url_data_permits);
		self.company_incorporation_date := restrict(L.company_incorporation_date, in_mod, company_incorporation_date_permits, sources);
		self.dba_name      := mask(restrict(L.dba_name, in_mod, dba_name_data_permits, , true), in_mod, dba_name_data_permits);
		self := L;
	end;
	ds_restricted := project(ds_fetched, apply_restrict(left));
	ds_wstatus := project(ds_restricted,transform(recordof(left),self.company_status_derived := '',self := left));//BIPV2.mac_AddStatus(ds_restricted);
	// output(ds_fetched, named('ds_fetched'));
	return if(IncludeStatus, ds_wstatus , project(ds_restricted, transform({recordof(ds_wstatus)}, self.isActive := false, self.IsDefunct := false, self := left)));
END;

export kFetch2Marketing(
	dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs,
	string1 Level = BIPV2.IDconstants.Fetch_Level_ProxID, 
	unsigned2 ScoreThreshold = 0,								
	BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
	boolean IncludeStatus = true,
	JoinLimit=25000,
	unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
	) :=
FUNCTION
	allowCodeBmap := BIPV2.mod_Sources.code2bmap(BIPV2.mod_Sources.code.MARKETING_UNRESTRICTED);
	ds := kfetch2(inputs, Level, ScoreThreshold, in_mod, IncludeStatus, JoinLimit, JoinType);
	recordof(ds) apply_src_filter(recordof(ds) L) := transform
		// NOTE: These filter the "sources" child dataset when applicable, but not all sections have that
		self.company_name			:= filterSrcCode(L.company_name,    company_name_data_permits,    sources, allowCodeBmap);
		self.company_address:= filterSrcCode(L.company_address, company_address_data_permits,        , allowCodeBmap);
		self.company_phone		:= filterSrcCode(L.company_phone,   company_phone_data_permits,          , allowCodeBmap);
		self.company_fein			:= filterSrcCode(L.company_fein,    company_fein_data_permits,    sources, allowCodeBmap);
		self.company_url			 := filterSrcCode(L.company_url,     company_url_data_permits,            , allowCodeBmap);
		self.company_incorporation_date := filterSrcCode(L.company_incorporation_date, company_incorporation_date_permits, sources, allowCodeBmap);
		self.dba_name       := filterSrcCode(L.dba_name,        dba_name_data_permits,               , allowCodeBmap);
		self := L;
	end;
	return project(ds, apply_src_filter(left));
END;

// Depricated version of the above kFetch2
export kFetch(
	dataset(BIPV2.IDlayouts.l_xlink_ids) inputs,
	string1 Level = BIPV2.IDconstants.Fetch_Level_ProxID, //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																							//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																									//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
	unsigned2 ScoreThreshold = 0,								//Applied at lowest level of ID
	BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
	boolean IncludeStatus = true,
	JoinLimit=25000
	) :=
FUNCTION
	inputs_for2 := PROJECT(inputs, BIPV2.IDlayouts.l_xlink_ids2);
	f2 := kFetch2(inputs_for2, Level, ScoreThreshold, in_mod, IncludeStatus, JoinLimit);
	RETURN PROJECT(f2, {RECORDOF(Key), string50 company_status_derived/*, boolean isActive, boolean isDefunct*/});
	
END;
export kFetchOutRec := recordof(kFetch(dataset([],BIPV2.IDlayouts.l_xlink_ids)));
END;
