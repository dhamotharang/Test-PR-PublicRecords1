// ================================================================================
// ===== RETURNS FDIC Member Source Docs and Count Info 
// ================================================================================
IMPORT BIPV2, govdata, iesp, ut, mdr;

EXPORT FDICSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// There isn't any unique id key file for fdic member to build the source doc from, for this reason
	// the payload file of the linkid key file will be used.
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get fdic data
  fdic_recs := govdata.key_fdic_LinkIDs.KeyFetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level,,
																									TopBusiness_Services.Constants.SlimKeepLimit);
 	
	// Match on idvalue and idtype if one is passed, if none is passed then match only on linkids..
	SHARED fdic_idValue := JOIN(fdic_recs,in_docids,
										BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
										(left.fed_rssd = right.IdValue OR	right.IdValue = ''),
										TRANSFORM(LEFT));
	
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(fdic_idValue) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.Source 								:= MDR.sourceTools.src_FDIC;
		SELF.IDValue								:= L.fed_rssd;
		SELF.CompanyName        		:= L.name;
		SELF.URL										:= L.webaddr;
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.prim_name,L.prim_range,L.predir,L.postdir,
															L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,
															L.st,L.zip,L.zip4,'');
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(fdic_idValue) L) := TRANSFORM
			self.src			:= 'FDIC';
			self.src_desc := 'FDIC';
			self.hasName 	:= (L.chrtagnt<>'' or 
			                  L.insagnt1<>'' or L.insagnt2<>''  or
												L.name<>''     or
												L.regagnt<>''); 
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.address<>'' or 
			                  L.stcnty<>'' or L.zip<>'' or
												L.st<>''     or L.zip5<>'');
		  self.hasPhone := false;
			self.dt_first_seen := ut.NormDate((unsigned)ut.convertdate(L.insdate,'%Y-%m-%d'));
			self.dt_last_seen := ut.NormDate((unsigned)L.process_date);
			self := [];
	END;

	EXPORT SourceDetailInfo := PROJECT(fdic_idValue,xform_Details(LEFT));
	SourceView_RecsIesp := PROJECT(fdic_idValue, toOut(left));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;