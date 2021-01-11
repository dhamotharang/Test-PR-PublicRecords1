// ================================================================================
// ======   RETURNS FORECLOSURE/NOD DATA FOR A GIVEN FORECLOSURE_ID          ======
// ======   IN ESP-COMPLIANT WAY.                                            ======
// ================================================================================
IMPORT AutoStandardI, BIPV2, dx_Property, Foreclosure_Services, iesp, topbusiness_services;

EXPORT ForeclosureNODSource_Records(
  dataset(topbusiness_services.Layouts.rec_input_ids_wSrc) in_docids,
  topbusiness_services.SourceService_Layouts.OptionsLayout inoptions,
	boolean IsFCRA = false,
	boolean IsNod = false
  ) 
 := MODULE
 
	// For in_docids records that don't have IdValue's retrieve them from linkid file
	 in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));

       in_docs_linkonly2 := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
																																		SELF := LEFT,
																																		SELF := []));																																		
	
       ds_forekeys := if (~(IsNod), PROJECT(dx_Property.Key_Foreclosure_Linkids.kfetch2(in_docs_linkonly2,
	      inoptions.fetch_level,,  topbusiness_services.constants.ForeclosureSrcDocsKfetchMaxLimit,
                               bipv2.idconstants.JoinTypes.LimitTransformJoin),                           
																TRANSFORM(topbusiness_services.Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.foreclosure_id,
																					SELF := LEFT,
																					SELF := []))
                                          );
																					
       ds_nodkeys := if (isNod, PROJECT(dx_Property.Key_NOD_Linkids.kfetch(in_docs_linkonly,topbusiness_services.Constants.sourceLinkIdLevel, ,                             
                                topbusiness_services.constants.NodSrcDocskfetchMaxLimit), 
																TRANSFORM(topbusiness_services.Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.foreclosure_id,
																					SELF := LEFT,
																					SELF := []))
                                         );                                         
	
	  fid_keys_comb := IF(IsNod,in_docids+ds_nodkeys,in_docids+ds_forekeys);
	 fid_keys := PROJECT(fid_keys_comb(IdValue != ''),TRANSFORM(Foreclosure_Services.Layouts.layout_fid,SELF.fid := LEFT.IdValue, SELF := []));
	
	 fid_keys_dedup := dedup(sort(fid_keys,fid), fid);
     fid_keys_dedupSlimFore := choosen( fid_keys_dedup, topbusiness_services.constants.ForeclosureSourceDocsFidLimit);
     fid_keys_dedupSlimNod :=  choosen(fid_keys_dedup,  topbusiness_services.constants.NodSourceDocsFidLimit);
     fid_keys_dedupSlim := if (isNod, fid_keys_dedupSlimNod, fid_keys_dedupSlimFore);

	gmod := AutoStandardI.GlobalModule();
	in_mod := MODULE(Foreclosure_Services.Raw.params);
		EXPORT string5 industry_class := gmod.IndustryClass;
		EXPORT string32 application_type := gmod.ApplicationType;
		EXPORT string ssn_mask := gmod.ssnmask;
	END;
	// Get the foreclosure or Nod raw data from the appropriate view.
	Foreclosure_sourceview := Foreclosure_Services.raw.REPORT_VIEW.by_fid (fid_keys_dedupSlim, in_mod, IsNod, inoptions.IncludeVendorSourceB);

	// Add linkids to the output. 
     SHARED foreclosure_sourceview_wLinkIds := JOIN(Foreclosure_sourceview,fid_keys_comb,
																									LEFT.ForeclosureID = RIGHT.IdValue,
																									TRANSFORM(iesp.foreclosure.t_ForeclosureReportRecord,
																										SELF.BusinessIds.DotID 		:= RIGHT.DotID;
																										SELF.BusinessIds.EmpID 		:= RIGHT.EmpID;
																										SELF.BusinessIds.POWID 		:= RIGHT.POWID;
																										SELF.BusinessIds.ProxID 	:= RIGHT.ProxID;
																										SELF.BusinessIds.SELEID 	:= RIGHT.SELEID;  
																										SELF.BusinessIds.OrgID 		:= RIGHT.OrgID;
																										SELF.BusinessIds.UltID 		:= RIGHT.UltID;
																										SELF.IdValue	:= RIGHT.IdValue;
																										SELF := LEFT,
																										SELF := []),
																									KEEP(1));   // For cases in which a idvalue has multiple linkids
		
	SHARED topbusiness_services.SourceCount_Layouts.SourceDetailsLayout xform_Details(iesp.foreclosure.t_ForeclosureReportRecord L) := TRANSFORM
			normDate_iesp(iesp.share.t_Date d) := (unsigned)(d.Year*10000 + d.Month*100 + d.Day);
			
			self.src			:= IF(IsNod,'NOD','FOR');
			self.src_desc := IF(IsNod,'Notice Of Defaults','Foreclosure Records');
			self.hasName 	:= exists(L.Defendants(Name.Last<>'' or Name.First<>''));
			self.hasSSN  	:= exists(L.Defendants(SSN<>''));
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.SiteAddress.State<>'' or L.SiteAddress.Zip5<>'');
		  self.hasPhone := false;
			self.dt_first_seen := IF(IsNod,normDate_iesp(L.FilingDate),normDate_iesp(L.RecordingDate));
			self.dt_last_seen := IF(IsNod,normDate_iesp(L.FilingDate),normDate_iesp(L.RecordingDate));
			self := [];
	END;	
	EXPORT SourceDetailInfo := project(foreclosure_sourceview_wLinkIds,xform_Details(LEFT));
	EXPORT SourceView_Recs := foreclosure_sourceview_wLinkIds;
  EXPORT SourceView_RecCount := COUNT(foreclosure_sourceview_wLinkIds);
	
END;
