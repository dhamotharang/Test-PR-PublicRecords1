// ================================================================================
// ====== RETURNS D&B DMI Source Count Info, currently no raw source docs are returned.
// ================================================================================
// uses V1 layouts (both in ECL and ESP)

IMPORT iesp, doxie, DNB, DNB_DMI, BIPV2, ut;

EXPORT DNBDmiSource_Records ( 
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
	SourceService_Layouts.OptionsLayout inoptions,
	doxie.IDataAccess mod_access,
  boolean IsFCRA = false
) := MODULE
	
 SHARED Layout_DNB_Base_Linkids := record
		DNB.Layout_DNB_Base;
		BIPV2.IDlayouts.l_xlink_ids;
 end;


	// For in_docids records that don't have SourceDocIds (dunsNumbers) retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get dunsnumber keys
  SHARED ds_dmikeys := PROJECT(DNB_DMI.Key_LinkIds.kFetch(in_docs_linkonly, mod_access, inoptions.fetch_level),
																TRANSFORM(Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.rawfields.duns_number,
																					SELF := LEFT,
																					SELF := []));
	
	shared dmi_keys_comb := DEDUP(in_docids+ds_dmikeys,ALL);
	
	shared dmi_keys := PROJECT(dmi_keys_comb(IdValue != ''),TRANSFORM(DNB.Layout_DNB_Base,SELF.duns_number := LEFT.IdValue,SELF := []));
	
  // fetch main records via Duns number key file.
	SHARED dmi_sourceview := JOIN(dmi_keys,DNB_DMI.Keys().Duns.qa,
													KEYED(LEFT.duns_number = RIGHT.duns) and mod_access.use_DNB(),
													TRANSFORM(Layout_DNB_Base_Linkids, SELF := RIGHT),
													LIMIT(ut.limits.default,SKIP));

	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(Layout_DNB_Base_Linkids L) := TRANSFORM
			self.src			:= 'DNB';
			self.src_desc := 'Dun & Bradstreet';
			self.hasName 	:= (L.business_name<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.st<>'' or L.zip<>'' or 
			                  L.mail_st<>'' or L.mail_zip<>'');
		  self.hasPhone := (L.telephone_number<>'');
			self.dt_first_seen := ut.NormDate((unsigned)L.date_first_seen);
			self.dt_last_seen := ut.NormDate((unsigned)L.date_last_seen);
			self := [];
	END;
	
	EXPORT SourceDetailInfo := project(dmi_sourceview,xform_Details(LEFT));
	EXPORT SourceView_Recs := '';
  EXPORT SourceView_RecCount := COUNT(dmi_sourceview);
	
END;
