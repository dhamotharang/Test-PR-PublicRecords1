// ================================================================================
// ===== RETURNS Business Header Source Count Info, currently no source docs are returned
// ================================================================================
IMPORT BIPV2, ut;

EXPORT BusHeadSource_Records (
 dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	//Use the bip linkid file to retreive records via linkids
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get bus head data
  SHARED bh_recs := BIPV2.Key_BH_Linking_Ids.kFetch(DEDUP(in_docs_linkonly,ALL),
            inoptions.fetch_level,,,TopBusiness_Services.Constants.BusHeaderKfetchMaxLimit);
 		
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(bh_recs) L) := TRANSFORM
			self.src			:= 'BFINDER';
			self.src_desc := 'Business Finder';
			self.hasName 	:= (L.company_name<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= (L.company_fein<>'');		
			self.hasAddr 	:= (L.st<>'' or L.zip<>'');
		  self.hasPhone := (L.company_phone<>'');
			self.dt_first_seen := ut.NormDate((unsigned)L.dt_first_seen);
			self.dt_last_seen := ut.NormDate((unsigned)L.dt_last_seen);
			self := [];
	END;
	
	EXPORT SourceDetailInfo := project(bh_recs,xform_Details(LEFT));
	EXPORT SourceView_Recs := '';
  EXPORT SourceView_RecCount := COUNT(bh_recs);

END;