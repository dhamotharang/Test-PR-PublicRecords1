//=================================================================================
// ======   RETURNS PROF LIC DATA FOR A PROLIC_SEQ_ID IN ESP-COMPLIANT WAY   ======
// ================================================================================
//
// This attribute was created by copying PersonReports.proflic_records and
// modified for use by TopBusiness_Services.SourceService_Records.
IMPORT Doxie, AutoStandardI, iesp, Prof_LicenseV2, prof_LicenseV2_Services, BIPV2, ut;

EXPORT ProfLicenseSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions,
  Doxie.IDataAccess mod_access,
	boolean IsFCRA = false)
 := MODULE

	SHARED prolic_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		prof_LicenseV2_Services.Assorted_Layouts.Layout_report;
	END;

	// For in_docids records that don't have SourceDocIds (corp_keys) retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));

	// *** Key fetch to get prolic data
  ds_prolickeys := PROJECT(Prof_LicenseV2.Key_Proflic_LinkIDs.KeyFetch(in_docs_linkonly, mod_access, Constants.sourceLinkIdLevel),
																TRANSFORM(Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := (STRING) LEFT.prolic_seq_id,
																					SELF := LEFT,
																					SELF := []));

	prolic_keys_comb := in_docids+ds_prolickeys;

	prolic_keys := PROJECT(prolic_keys_comb(IdValue != ''),TRANSFORM(prof_licenseV2_Services.Layout_Search_Ids_Prolic,SELF.prolic_seq_id := (INTEGER) LEFT.IdValue));

	prolic_keys_dedup := DEDUP(prolic_keys,ALL);

	// get report via prolic_seq_id keys
  prolic_sourceview := prof_LicenseV2_Services.Prof_Lic_Raw.source_view.by_ids (prolic_keys_dedup);

	SHARED prolic_sourceview_wLinkIds := JOIN(prolic_sourceview,prolic_keys_comb,
																					LEFT.prolic_seq_id = (INTEGER) RIGHT.IdValue,
																					TRANSFORM(prolic_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids

  iesp.proflicense.t_PL2Action SetAction (
    string _type, string violation_description, string8 violation_date, string8 effective_date,
    string description, string status, string8 posting_date, string50 case_number) := FUNCTION

    iesp.proflicense.t_PL2Action xform () := transform
      Self._Type         := _type;
      Self.ViolationDescription := violation_description;
      Self.ViolationDate := iesp.ECL2ESP.toDatestring8 (violation_date);
      Self.EffectiveDate := iesp.ECL2ESP.toDatestring8 (effective_date);
      Self.Description   := description;
      Self.Status        := status;
      Self.PostingDate   := iesp.ECL2ESP.toDatestring8 (posting_date);
			Self.CaseNumber		 := case_number;
    end;
    return Row (xform ());
  END;

  iesp.proflicense.t_PL2Education SetEducation (string school, string degree, string curriculum, string dates) := FUNCTION
    iesp.proflicense.t_PL2Education xform () := transform
      Self.School        := school;
      Self.Degree        := degree;
      Self.Curriculum    := curriculum;
      Self.DatesAttended := dates;
    end;
    return Row (xform ());
  END;

  SHARED iesp.proflicense.t_ProfessionalLicenseRecord toOut(prolic_layout_wLinkIds L) := transform
		IDmacros.mac_IespTransferLinkids()
		self.prolicSeqId         	 := (STRING) L.prolic_seq_id;
		self.LicenseType           := L.license_type;
    self.LicenseNumber         := L.license_number;
    self.ProviderNumber        := L.ProviderId;
    self.SanctionNumber        := L.sanc_id;
    self.SSN                   := L.best_ssn;
		self.Taxid                 := L.taxid;
    self.DateLastSeen          := iesp.ECL2ESP.toDate ((integer4) L.date_last_seen);
    self.ProfessionOrBoard     := L.profession_or_board;
    self.Status                := L.Status;
    self.StatusEffectiveDate   := iesp.ECL2ESP.toDate ((integer4) L.status_effective_dt);
    self.Name                  := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title);
    self.OriginalName          := iesp.ECL2ESP.SetName ('', '', '','','',L.Orig_name);
    self.AdditionalOrigName    := iesp.ECL2ESP.SetName ('', '', '','','',L.Additional_orig_name);
    self.CompanyName           := L.company_name;
    self.Address               := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir,
																		L.postdir, L.suffix, L.unit_desig, L.sec_range,
																		L.v_city_name, L.st, l.zip, l.zip4, l.county_name);
    self.OriginalAddress       := iesp.ECL2ESP.SetAddress ('','','','','','','',L.Orig_City,
																	L.Orig_St,L.Orig_Zip,'','','',L.Orig_Addr_1,L.Orig_Addr_2);
    self.AdditionalOrigAddress := iesp.ECL2ESP.SetAddress ('','','','','','','',L.additional_Orig_City,
																	L.additional_Orig_St,L.additional_Orig_Zip,'','','',
																	L.additional_Orig_additional_1,L.additional_Orig_additional_2);
    self.Phone                 := L.phone;
    self.TimeZone              := '';
    self.AdditionalPhone       := L.additional_phone;
    self.Gender                := L.sex;
    self.DOB                   := iesp.ECL2ESP.toDate ((integer4) L.dob);
    self.IssuedDate            := iesp.ECL2ESP.toDate ((integer4) L.issue_date);
    self.ExpirationDate        := iesp.ECL2ESP.toDate ((integer4) L.expiration_date);
    self.LastRenewalDate       := iesp.ECL2ESP.toDate ((integer4) L.last_renewal_date);
    self.LicenseObtainedBy     := L.license_obtained_by;
    self.BoardActionIndicator  := L.board_action_indicator;
    self.SourceState           := L.source_st_decoded;
    self.Occupation            := L.misc_occupation;
    self.PracticeHours         := (integer) L.misc_practice_hours;
    self.PracticeType          := L.misc_practice_type;
    self.Email                 := L.misc_email;
    self.Fax                   := L.misc_fax;
    self.Action                := SetAction (
      L.action_record_type, L.Action_complaint_violation_desc, L.Action_complaint_violation_dt,
      L.Action_effective_dt, L.Action_desc, L.action_status, L.Action_Posting_Status_dt, L.Action_case_number);
    self.ContinueEducation     := L.education_continuing_education;
    self.Education1            := SetEducation (L.education_1_school_attended, L.education_1_degree, L.education_1_curriculum, L.education_1_dates_attended);
    self.Education2            := SetEducation (L.education_2_school_attended, L.education_2_degree, L.education_2_curriculum, L.education_2_dates_attended);
    self.Education3            := SetEducation (L.education_3_school_attended, L.education_3_degree, L.education_3_curriculum, L.education_3_dates_attended);
    self.AdditionalLicensingSpecs := L.additional_licensing_specifics;
    self.PlaceOfBirth          := L.personal_pob_desc;
    self.Race                  := L.personal_race_desc;
		self := [];
  end;

	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(prolic_layout_wLinkIds L) := TRANSFORM
			self.src			:= 'PROFLIC';
			self.src_desc := 'Professional Licenses';
			self.hasName 	:= (L.orig_name<>'');
			self.hasSSN  	:= (L.best_ssn<>'');
			self.hasDOB  	:= (L.dob<>'');
		  self.hasFEIN 	:= false;
			self.hasAddr 	:= (L.orig_st<>'' or L.orig_zip<>'');
		  self.hasPhone := (L.phone<>'');
			self.dt_first_seen := ut.NormDate((unsigned)L.date_first_seen);
			self.dt_last_seen := ut.NormDate((unsigned)L.date_last_seen);
			self := [];
	END;

	EXPORT SourceDetailInfo := project(prolic_sourceview_wLinkIds,xform_Details(LEFT));
	EXPORT SourceView_Recs := project(prolic_sourceview_wLinkIds, toOut(left));
  EXPORT SourceView_RecCount := COUNT(prolic_sourceview_wLinkIds);

END;