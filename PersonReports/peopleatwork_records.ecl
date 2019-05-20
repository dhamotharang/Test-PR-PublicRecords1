// ==================================================================================
// ====== RETURNS PEOPLE@WORK RECORDS FOR A GIVEN PERSON IN ESP-COMPLIANT WAY =======
// ==================================================================================

IMPORT iesp, doxie, paw_services, paw, ut;

out_rec := iesp.peopleatwork.t_PeopleAtWorkRecord;

EXPORT out_rec peopleatwork_records (
  dataset (doxie.layout_references) dids,
  $.IParam.peopleatwork in_params = module ($.IParam.peopleatwork) end,
  boolean IsFCRA = false) := FUNCTION

  // this is copy/paste from paw_services/PAWSearchService_Records; shouldn't be this way:
  // paw_services must expose raw data in some way (without "also found", penalties, etc.)
  ids := paw_services.PAW_Raw.getContactIDs.byDIDs (dids);
  recs := join (ids, paw.Key_contactID,keyed(left.contact_id=right.contact_id), atmost(ut.limits.PAW_PER_CONTACTID)); //<25 recs per contactid
  recs_plus := project (recs, transform(paw_services.Layouts.Raw, self.timezone:=[], self:=left));
//l.active_phone_flag='Y' and l.company_phone <> '';
  // verify (this can be quite ineficcient, but I want to make the same call as in P@W single source):

  // assign sequence to the original results (to join back after verifying)
  sequenced_rec := record (paw_services.Layouts.Raw)
    unsigned __seq;
  end;
  sequenced_rec AddSequence (paw_services.Layouts.Raw L, integer C) := transform
    Self.__seq := C;
    Self := L;
  end;
  res_seq := project (recs_plus, AddSequence (Left, Counter));

  // verify:
  doxie.Layout_Append_Gong_Biz.Layout_In toAppendGong (sequenced_rec L) := transform
    Self.__seq := L.__seq;
    Self.phone := L.company_phone;
		Self.company_names := dataset([L.company_name], {string120 company_name});
  end;
  res_app_gong := project (res_seq, toAppendGong (Left));
  res_gong := doxie.Append_Gong_Biz (res_app_gong);

  // join back
  verified_rec := record (paw_services.Layouts.Raw)
    boolean verified;
  end;
	//additional verified logic to mimic comp report only if gong didn't verfy
	verified_rec  isVerified(res_seq l, res_gong r) := transform
	   self.verified := r.verified or (l.active_phone_flag='Y' and l.company_phone <> '');
		 self := l;
	end;
  res_verified := JOIN (res_seq, res_gong, Left.__seq = Right.__seq,isVerified(left,right),left outer, keep (1));

  // add timezone
  ut.getTimeZone (res_verified, company_phone,timezone,recs_plus_best_w_tzone);

  integer SetConfidence (string3 score) := function
    // Moxie and Roxie use different "score" fields to calculate confidence.
    // I prefer to use Roxie way here to keep it in sync with Comp Report
    int_score := (integer) score;
    // return map (int_score <= 10 => 3,
                // int_score <= 100 => 2,
                // 1);
    return map (int_score > 6 => 1,
                int_score > 4 => 2,
                3);
  end;

  out_rec FormatReport (verified_rec L) := transform
    Self.ConfidenceLevel := (string) SetConfidence (L.score);
    Self.Verified := L.verified;
    Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title);
    Self.UniqueId := intformat (L.did, 12, 1);
    Self.Title := L.company_title;
    Self.SSN := L.ssn;
    Self.EMail := L.email_address;
    Self.Phone10 := L.company_phone;
    Self.Gender := iesp.ECL2ESP.GetGender (L.title);//{xpath('Gender')};
    Self.TimeZone := L.timezone;
    Self.CompanyTimeZone := L.timezone;
    Self.CompanyName := L.company_name;
    Self.Department := l.company_department;
    Self.FEIN := L.company_fein;
    Self.BusinessId := intformat (L.bdid, 12, 1);
		self.BusinessIDs.proxid := l.proxid;
		self.businessIDs.ultid := l.ultid;
		self.businessIDs.orgid := l.orgid;
		self.businessIDs.seleid := l.seleid;
		self.businessIDs.dotid := l.dotid;
		self.BusinessIDs.empid := l.empid;
		self.BusinessIDs.powid := l.powid;
		self.IdValue := '';
    Self.Address := iesp.ECL2ESP.SetAddressWithType (
      l.company_prim_name, l.company_prim_range, L.company_predir, L.company_postdir, L.company_addr_suffix, L.company_unit_desig, L.company_sec_range, 
      l.company_city, l.company_state,  l.company_zip, l.company_zip4, '');
    Self.DateFirstSeen := iesp.ECL2ESP.toDatestring8 (L.dt_first_seen);
    Self.DateLastSeen  := iesp.ECL2ESP.toDatestring8 (L.dt_last_seen);
  end;
  res := if (~IsFCRA, project (recs_plus_best_w_tzone, FormatReport (Left)));


  // IMPORTANT: keeping the same sort as in CRS is tedious (last/first + whole record), since this sorting order
  // is defined by ECL record definition (the order of fields in the attribute), and fields in "iesp" layouts are
  // generally defined in different order. So, I'll jsut choose some making-sense-fields
  RETURN sort (res, -DateLastSeen, -DateFirstSeen, CompanyName, Phone10, Title, Name, record);
END;
