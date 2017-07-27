// ================================================================================
// ===== RETURNS Ingenix Sanction Source Count Info, currently no source docs are returned
// ================================================================================
IMPORT BIPV2, Ingenix_NatlProf, ut;

EXPORT SanctionSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// Get the source docs via the linkid file.
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get sanction data
  SHARED sanct_recs := Ingenix_NatlProf.Key_Sanctions_LinkIds.keyfetch(DEDUP(in_docs_linkonly,ALL),Constants.sourceLinkIdLevel);
 		
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(sanct_recs) L) := TRANSFORM
			self.src			:= 'SANC';
			self.src_desc := 'Sanctions';
			self.hasName 	:= (L.sanc_busnme<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.ProvCo_Address_Clean_st<>'' or L.ProvCo_Address_Clean_zip<>'');
		  self.hasPhone := false;
			self.dt_first_seen := ut.NormDate((unsigned)L.date_first_seen);
			self.dt_last_seen := ut.NormDate((unsigned)L.date_last_seen);
			self := [];
	END;
	
	EXPORT SourceDetailInfo := project(sanct_recs,xform_Details(LEFT));
	EXPORT SourceView_Recs := '';
  EXPORT SourceView_RecCount := COUNT(sanct_recs);

END;