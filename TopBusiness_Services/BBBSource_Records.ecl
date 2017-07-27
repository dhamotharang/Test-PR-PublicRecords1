// ================================================================================
// ===== RETURNS BBB member Source Doc and Source Count Info
// ================================================================================
IMPORT BIPV2, BBB2, ut, iesp, MDR;

EXPORT BBBSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
	
	// There isn't any unique id key file for bbb to build the source doc from, for this reason
	// the payload file of the linkids key file will be used.
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get bbb data
  bbb_recs := BBB2.Key_BBB_LinkIds.kfetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level,,
	                     TopBusiness_Services.Constants.SlimKeepLimit);
 	
	// Match on idvalue and idtype if one is passed, if none is passed then match only on linkids..
	SHARED bbb_idValue := JOIN(bbb_recs,in_docids,
										BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
										(((string) left.source_rec_id = right.IdValue AND 
										right.IdType = Constants.sourcerecid) OR
										(right.IdValue = '')),
										TRANSFORM(LEFT));
		
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(bbb_idValue) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.Source 								:= MDR.sourceTools.src_BBB_Member;
		SELF.CompanyName        		:= L.company_name;
		SELF.BusinessDescription		:= L.member_category;
		SELF.FilingDate							:= iesp.ECL2ESP.toDate((integer4) L.member_since_date);
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.prim_name,L.prim_range,L.predir,L.postdir,
															L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,
															L.st,L.zip,L.zip4,'');
		SELF.Phone									:= L.phone10;
		SELF.PhoneTypeDescription		:= L.phone_type;
		SELF.URL 										:= L.http_link;
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(bbb_idValue) L) := TRANSFORM
			self.src			:= 'BBBM';
			self.src_desc := 'Better Business Bureau Member';
			self.hasName 	:= (L.company_name<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.address<>'');
		  self.hasPhone := (L.phone<>'');
			self.dt_first_seen := ut.NormDate((unsigned)L.date_first_seen);
			self.dt_last_seen := ut.NormDate((unsigned)L.date_last_seen);
			self := [];
	END;
	
	EXPORT SourceDetailInfo := PROJECT(bbb_idValue,xform_Details(LEFT));
	SourceView_RecsIesp := PROJECT(bbb_idValue, toOut(left));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);
	
END;