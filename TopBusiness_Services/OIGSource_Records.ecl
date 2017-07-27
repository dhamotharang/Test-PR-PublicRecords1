// ================================================================================
// ===== RETURNS OIG member Source Doc and Source Count Info
// ================================================================================
IMPORT BIPV2, OIG, ut, iesp, MDR, Codes;

EXPORT OIGSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
	
	// There isn't any unique id key file to build the source doc from, for this reason
	// the payload file of the linkids key file will be used.
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get OIG data
  SHARED oig_recs := OIG.Key_OIG_LinkIDs.keyfetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level,,
	      TopBusiness_Services.Constants.SlimKeepLimit);
 		
		iesp.topbusinessOtherSources.t_OtherContact xform_contacts(recordof(oig_recs) L) := TRANSFORM
		SELF.UniqueId						:= (STRING) L.did;
		SELF.Name.First  				:= L.fname;
	  SELF.Name.Middle 				:= L.mname;
		SELF.Name.Last 					:= L.lname;  
		SELF.Name.Suffix 				:= L.name_suffix;  	
		SELF.Name.Prefix 				:= L.title;
		SELF.Title							:= L.specialty;
		SELF.SSN								:= L.ssn;
		SELF.DOB								:= iesp.ECL2ESP.toDate((INTEGER)L.dob);
		SELF := [];
  end;
	
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(oig_recs) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.Source 								:= MDR.sourceTools.src_OIG;
		SELF.CompanyName        		:= L.busname;
    SELF.BusinessDescription		:= L.general;		
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.prim_name,L.prim_range,L.predir,L.postdir,L.addr_suffix,L.unit_desig,L.sec_range,
															L.v_city_name,L.st,L.zip,L.zip4,'');
	
		SELF.Contacts := PROJECT(L, xform_contacts(LEFT));
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(oig_recs) L) := TRANSFORM
			self.src			:= MDR.sourceTools.src_OIG;
			self.src_desc := 'OIG';
			self.hasName 	:= (L.busname<>'');
			self.hasSSN  	:= (L.ssn<>'');
			self.hasDOB  	:= (L.dob<>'');
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.prim_name<>'');
		  self.hasPhone := false;
			self.dt_first_seen := ut.NormDate((unsigned)L.dt_first_seen);
			self.dt_last_seen := ut.NormDate((unsigned)L.dt_last_seen);
			self := [];
	END;
	
	EXPORT SourceDetailInfo := PROJECT(oig_recs,xform_Details(LEFT));
	SourceView_RecsIesp := PROJECT(oig_recs, toOut(left));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);
	
END;