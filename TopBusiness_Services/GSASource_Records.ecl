// ====================================================================================================
// ======   RETURNS General Service Administration Source records and count IN ESP-COMPLIANT WAY  =====
// ====================================================================================================
IMPORT GSA_Services, GSA, iesp, BIPV2, MDR, ut;

EXPORT GSASource_Records( 
  dataset(TopBusiness_Services.Layouts.rec_input_ids_wSrc) in_docids,
  TopBusiness_Services.SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// Use the linkid payload to build source doc
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get GSA data
  SHARED GSA_recs := GSA.Key_GSA_LinkIDs.kFetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level,,
	                                              TopBusiness_Services.Constants.SlimKeepLimit);
 
	// Match on idvalue and idtype if one is passed, if none is passed then match only on linkids.
  SHARED GSA_idValue := JOIN(GSA_recs,in_docids,
															 BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND                                                                               
															 ((string)left.gsa_id = right.IdValue OR right.IdValue = ''),
															 TRANSFORM(LEFT));
															 
	SHARED iesp.topbusinessOtherSources.t_OtherContact xform_contacts(recordof(GSA_idValue) L) := TRANSFORM
		SELF.Name.First  				:= L.fname;
	  SELF.Name.Middle 				:= L.mname;
		SELF.Name.Last 					:= L.lname;  
		SELF.Name.Suffix 				:= L.name_suffix;  	
		SELF.Name.Prefix				:= L.title;
		SELF := [];
  END;													 
	
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(GSA_idValue) L) := TRANSFORM
		TopBusiness_Services.IDMacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.IdValue								:= (string)L.gsa_id;
		SELF.Source 								:= MDR.sourceTools.src_GSA;
		SELF.CompanyName        		:= L.name;
		SELF.Address := iesp.ECL2ESP.setAddress(L.prim_name,L.prim_range,L.predir,L.postdir,
																		L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,
																		L.st,L.zip5,L.zip4,'',
																		If(L.prim_name = '',L.street1,''),
																		If(L.prim_name = '',L.street2,''),'');
		SELF.Contacts := IF(L.name_score <> '',PROJECT(L,xform_contacts(LEFT)),
																						ROW([],iesp.topbusinessOtherSources.t_OtherContact));
		SELF := [];
	END;
	
	SHARED TopBusiness_Services.SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(GSA_idValue) L) := TRANSFORM
			self.src			:= 'GSA';
			self.src_desc := 'General Service Administration';
			self.hasName 	:= (L.name<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.prim_name<>'' or L.street1<>'');
		  self.hasPhone := false;
			self.dt_first_seen := ut.NormDate((unsigned)L.actiondate);
			self.dt_last_seen := ut.NormDate((unsigned)L.dt_last_seen);
			self := [];
	END;

	EXPORT SourceDetailInfo 		:= PROJECT(GSA_idValue, xform_Details(LEFT));
	SourceView_RecsIesp 				:= PROJECT(GSA_idValue, toOut(left));
	EXPORT SourceView_Recs 			:= DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount 	:= COUNT(SourceView_Recs);

END;