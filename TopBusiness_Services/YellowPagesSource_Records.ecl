// ================================================================================
// ===== RETURNS Yellow Pages Source Doc records in an ESP-COMPLIANT WAY ====
// ================================================================================
IMPORT BIPV2, iesp, TopBusiness_Services;

EXPORT YellowPagesSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// Use the linkid payload to build source doc
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get yellow pages data
  SHARED yellow_recs := TopBusiness_Services.Key_Fetches(DEDUP(in_docs_linkonly,ALL),
													                               inoptions.fetch_level
																									      ).ds_yp_linkidskey_recs;
														 									 
	SHARED yellow_idValue := JOIN(yellow_recs,in_docids,
                             BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND                                                                               
                             (((string) left.source_rec_id = right.IdValue AND 
                             right.IdType = Constants.sourcerecid) OR
														 (right.IdValue = left.primary_key AND
														 right.IdType = Constants.busvlid) OR
														 right.IdValue = ''),
                             TRANSFORM(LEFT));															 
														 
	iesp.topbusinessOtherSources.t_OtherContact xform_contacts(recordof(yellow_idValue) L) := TRANSFORM
		self.Name.First  				:= L.exec_fname;
	  self.Name.Middle 				:= L.exec_mname;
		self.Name.Last 					:= L.exec_lname;  
		self.Name.Suffix 				:= L.exec_name_suffix;  	
		self.Name.Prefix 				:= L.exec_title;
		self.Title							:= L.executive_title;
		self := [];
  end;
	
	iesp.topbusinessOtherSources.t_otherSICCode xform_sic(recordof(yellow_idValue) L, INTEGER C) := TRANSFORM
		self.Code  := CHOOSE(C,L.sic_code,L.sic2,L.sic3,L.sic4)[1..4];
		self.Description := '';											 
	end;
	
	iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(yellow_idValue) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.IdValue 								:= L.primary_key;
		SELF.Source 								:= L.source;
		SELF.CompanyName        		:= L.business_name;
		SELF.Phone									:= L.phone10;
		SELF.PhoneType							:= L.phone_type;
		SELF.URL										:= L.web_address;
		SELF.Email									:= L.email_address;
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.prim_name,L.prim_range,L.predir,L.postdir,
															L.suffix,L.unit_desig,L.sec_range,L.v_city_name,
															L.st,L.zip,L.zip4,'');
		
		// Create a dataset from the 4 sic code fields
		SELF.SICCodes := NORMALIZE(DATASET(L),4,xform_sic(LEFT, COUNTER));
		SELF.NAICSCodes := DATASET([{L.naics_code,''}],iesp.topbusinessOtherSources.t_otherNAICSCodes);
		SELF.Contacts := PROJECT(L,xform_contacts(LEFT));
		SELF := [];
	END;
	
	EXPORT SourceView_Recs := PROJECT(yellow_idValue, toOut(left));
  EXPORT SourceView_RecCount := COUNT(yellow_idValue);

END;
