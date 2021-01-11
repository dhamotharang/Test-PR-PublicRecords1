IMPORT $, AutoKeyI, Address, BatchShare, BatchServices, dx_Email, email_data, iesp, STD;

EXPORT Transforms := MODULE

  EXPORT $.Layouts.batch_in_ext_rec cleanEmailAddress($.Layouts.batch_in_rec _input) := TRANSFORM
    ClndUsrName := email_data.Fn_Clean_Email_Username(_input.email);
    ClndUserDomain := email_data.Fn_Clean_Email_Domain(_input.email);
    BlankEmail := ClndUsrName = '' OR ClndUserDomain = '';
    SELF.is_rejected_rec := BlankEmail;
    SELF.record_err_msg := IF(BlankEmail,AutoKeyI.errorcodes._msgs(AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT),'');
    SELF.record_err_code := IF(BlankEmail,AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT,0);
    SELF.email_username := ClndUsrName;
    SELF.email_domain := ClndUserDomain;
    SELF := _input;
  END;

  hasCityStateorZip($.Layouts.batch_in_rec _input) := FUNCTION
    has_address := (_input.p_city_name != '' AND _input.st != '') OR _input.z5 != '';
    RETURN has_address;
  END;

  hasFullAddress($.Layouts.batch_in_rec _input) := FUNCTION
    str_addr := STD.Str.CleanSpaces(Address.Addr1FromComponents(_input.prim_range,_input.predir,_input.prim_name,
                                              _input.addr_suffix,_input.postdir,_input.unit_desig,_input.sec_range));
    has_full_address := str_addr != '' AND _input.prim_name!= '' AND
                        ((_input.p_city_name != '' AND _input.st != '') OR _input.z5 != '');
    RETURN has_full_address;
  END;

  hasFullName($.Layouts.batch_in_rec _input) := TRIM(_input.name_first,ALL) <> '' AND TRIM(_input.name_last,ALL) <> '';
  hasFullSSN($.Layouts.batch_in_rec _input) := LENGTH(STD.Str.Filter(_input.ssn,'0123456789')) = 9;

  hasSufficientIdentityInput($.Layouts.batch_in_rec _input, BOOLEAN require_full_address) := FUNCTION

    has_full_address := hasFullAddress(_input);
    has_address := hasCityStateorZip(_input);
    has_full_name := hasFullName(_input);

    has_ssn := hasFullSSN(_input);
    has_lexid := _input.DID>0;
    BOOLEAN has_sufficient_input := has_lexid OR (has_ssn AND has_full_name) OR (has_full_name AND has_full_address)
                                    OR (~require_full_address AND (has_full_name AND has_address));

    RETURN has_sufficient_input;
  END;

  EXPORT $.Layouts.batch_in_ext_rec checkIdentityInput($.Layouts.batch_in_rec le, BOOLEAN full_address_check = FALSE) := TRANSFORM

    insufficient_input := ~hasSufficientIdentityInput(le, full_address_check);
    SELF.is_rejected_rec := insufficient_input;
    SELF.record_err_msg := IF(insufficient_input,AutoKeyI.errorcodes._msgs(AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT),'');
    SELF.record_err_code := IF(insufficient_input,AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT,0);
    SELF.ssn := STD.Str.Filter(le.ssn,'0123456789');
    SELF.has_full_address := hasFullAddress(le);
    SELF.has_full_name    := hasFullName(le);
    SELF.has_full_ssn     := hasFullSSN(le);
    SELF := le;
  END;

  EXPORT $.Layouts.batch_in_didvile_rec toMACDidAppend($.Layouts.batch_in_rec l) := TRANSFORM
      SELF.seq     := (UNSIGNED) l.acctno;
      SELF.fname  := l.name_first;
      SELF.mname  := l.name_middle;
      SELF.lname  := l.name_last;
      SELF.suffix := l.name_suffix;
      SELF := l;
      SELF := [];
    END;

    EXPORT $.Layouts.email_raw_rec addRawPayload ($.Layouts.email_ids_rec LE,
                                                               dx_Email.Layouts.i_Payload RI)
    := TRANSFORM
      SELF.acctno         := LE.acctno,
      SELF.seq            := LE.seq,
      SELF.subject_lexid  := LE.subject_lexid,
      SELF.isdeepdive     := LE.isdeepdive,
      SELF.email_id       := RI.email_rec_key,
      SELF.is_current     := RI.current_rec,
      SELF.email_username := RI.append_email_username,
      SELF.email_domain   := RI.append_domain,
      SELF.original.first_name  := RI.orig_first_name;
      SELF.original.last_name   := RI.orig_last_name;
      SELF.original.middle_name := RI.orig_middle_name;
      SELF.original.name_suffix := RI.orig_name_suffix;
      SELF.original.address     := RI.orig_address;
      SELF.original.city        := RI.orig_city;
      SELF.original.state       := RI.orig_state;
      SELF.original.zip         := RI.orig_zip;
      SELF.original.zip4        := RI.orig_zip4;
      SELF.original.email       := RI.orig_email;
      SELF.original.ip          := RI.orig_ip;
      SELF.original.login_date  := RI.orig_login_date;
      SELF.original.site        := RI.orig_site;
      SELF.original.phone       := RI.orig_phone;
      SELF.original.ssn         := RI.orig_ssn;
      SELF.original.dob         := RI.orig_dob;
      SELF.cleaned.Name    := RI.Clean_Name,
      SELF.cleaned.Address := RI.clean_address,
      SELF.cleaned := RI;
      SELF.ln_date_last := (UNSIGNED) RI.date_last_seen;
      SELF.ln_date_first := (UNSIGNED) RI.date_first_seen;
      SELF := RI;
      SELF := [];
  END;

  SHARED BatchShare.Layouts.ShareAddress xfAddrPenalties($.Layouts.email_internal_rec le) := TRANSFORM
            SELF.predir         := le.cleaned.Address.predir;
            SELF.prim_name      := le.cleaned.Address.prim_name;
            SELF.prim_range     := le.cleaned.Address.prim_range;
            SELF.postdir        := le.cleaned.Address.postdir;
            SELF.addr_suffix    := le.cleaned.Address.addr_suffix;
            SELF.sec_range      := le.cleaned.Address.sec_range;
            SELF.p_city_name    := le.cleaned.Address.p_city_name;
            SELF.st             := le.cleaned.Address.st;
            SELF.z5             := le.cleaned.Address.zip;
            SELF.zip4           := le.cleaned.Address.zip4;
            SELF:=[];
  END;

  SHARED BatchShare.Layouts.ShareName xfNamePenalties($.Layouts.email_internal_rec le) := TRANSFORM
            SELF.name_last      := le.cleaned.Name.lname;
            SELF.name_middle    := le.cleaned.Name.mname;
            SELF.name_first     := le.cleaned.Name.fname;
            SELF.name_suffix    := le.cleaned.Name.name_suffix;
  END;

  SHARED BatchShare.Layouts.SharePII xfPiiPenalties($.Layouts.email_internal_rec le) := TRANSFORM
            SELF.ssn    := le.cleaned.clean_ssn;
            SELF.dob    := IF(le.cleaned.clean_dob>0,(STRING8)le.cleaned.clean_dob,'');
  END;

  SHARED BatchServices.Layouts.layout_batch_in_for_penalties xfPenaltiesLayout($.Layouts.batch_in_rec le) := TRANSFORM
            SELF._predir         := le.predir;
            SELF._prim_name      := le.prim_name;
            SELF._prim_range     := le.prim_range;
            SELF._postdir        := le.postdir;
            SELF._addr_suffix    := le.addr_suffix;
            SELF._sec_range      := le.sec_range;
            SELF._p_city_name    := le.p_city_name;
            SELF._st             := le.st;
            SELF._z5             := le.z5;

            SELF._name_last      := le.name_last;
            SELF._name_middle    := le.name_middle;
            SELF._name_first     := le.name_first;
            SELF._name_suffix     := le.name_suffix;
            SELF._ssn            := le.ssn;
            SELF._dob            := le.dob;
            SELF._acctno         := le.acctno;
            SELF:=[];
  END;

  EXPORT $.Layouts.email_internal_rec AddPenalties ($.Layouts.email_internal_rec _raw,
                                                                 $.Layouts.batch_in_rec _input)
  := TRANSFORM

    input_pii := PROJECT(_input, xfPenaltiesLayout(LEFT));

    address_to_match := PROJECT(_raw, xfAddrPenalties(LEFT));
    indv_name_to_match := PROJECT(_raw, xfNamePenalties(LEFT));
    ssn_dob_to_match := PROJECT(_raw, xfPiiPenalties(LEFT));
    penalty_addr := BatchShare.Functions.penalize_address(input_pii, address_to_match);
    penalty_name := BatchShare.Functions.penalize_fullname(input_pii, indv_name_to_match);
    penalty_pii := BatchShare.Functions.penalize_ssn_dob(input_pii, ssn_dob_to_match)
    // per requirements we should not allow loose matching such as name-only or address-only under any circumstances
    // to avoid loose matching based solely on name we should penalize results based on name+ssn - in case if email record doesn't have ssn populated
      + IF(_raw.cleaned.clean_ssn = '' AND ~_input.has_full_address AND _input.has_full_ssn, $.Constants.Defaults.SSN_SEARCH_PENALTY, 0);
    SELF.penalt_addr := penalty_addr;
    SELF.penalt_name := penalty_name;
    SELF.penalt_didssndob := penalty_pii;
    SELF.penalt := IF(_raw.DID>0 AND _raw.DID=_raw.subject_lexid, 0,
                      penalty_name + penalty_addr + penalty_pii);
    SELF:=_raw;
  END;

  EXPORT $.Layouts.email_final_rec AddFuzzyRelationship ($.Layouts.email_final_rec _indiv,
                                                        $.Layouts.batch_in_rec _input,
                                                        UNSIGNED pemalty_threshold)
  := TRANSFORM

    input_pii := PROJECT(_input, xfPenaltiesLayout(LEFT));

    address_to_match := PROJECT(_indiv, xfAddrPenalties(LEFT));
    indv_name_to_match := PROJECT(_indiv, xfNamePenalties(LEFT));
    ssn_dob_to_match := PROJECT(_indiv, xfPiiPenalties(LEFT));
    penalty_addr := BatchShare.Functions.penalize_address(input_pii, address_to_match);
    penalty_name := IF(_input.has_full_name, BatchShare.Functions.penalize_fullname(input_pii, indv_name_to_match), $.Constants.Defaults.RELATIONSHIP_PENALTY); // in case if input has only lexid, we need to penalize for relationship purpose
    penalty_pii := BatchShare.Functions.penalize_ssn_dob(input_pii, ssn_dob_to_match)
    // to avoid subject matching based solely on name we should penalize results based on name+ssn - in case if email record doesn't have ssn populated
      + IF(_indiv.cleaned.clean_ssn = '' AND ~_input.has_full_address AND _input.has_full_ssn, $.Constants.Defaults.RELATIONSHIP_PENALTY, 0);
    SELF.penalt_addr := penalty_addr;
    SELF.penalt_name := penalty_name;
    SELF.penalt_didssndob := penalty_pii;
    _penalty :=  penalty_name + penalty_addr + penalty_pii;
    SELF.penalt := _penalty;  // in case of search by email the penalty is not calculated, the only exception will be for fuzzy relations
    SELF.relationship := IF(_penalty <= pemalty_threshold, $.Constants.Relationship.PossibleSubject, _indiv.relationship);
    SELF:=_indiv;
  END;

  EXPORT $.Layouts.event_history_rec xfBVDeltabaseResp($.Layouts.Gateway_Data.bv_history_deltabase_rec le)
  := TRANSFORM
      SELF.email := STD.Str.ToUpperCase(TRIM(le.email_address, ALL));
      SELF.email_username := STD.Str.ToUpperCase(le.Account);
      SELF.email_domain := STD.Str.ToUpperCase(le.Domain);
      SELF.email_status := STD.Str.ToLowerCase(le.Status);
      error_desc := $.Constants.GatewayValues.get_error_desc(STD.Str.ToUpperCase(le.error_code));
      SELF.email_status_reason := MAP(error_desc<>''=> error_desc,
                                      le.Error ='(null)' => '', // ESP is returning (null) in case of blank, we need to clean up
                                      STD.Str.ToTitleCase(le.Error));
      SELF.is_disposable_address := STD.Str.ToLowerCase(le.disposable) = $.Constants.STR_TRUE;
      SELF.is_role_address := STD.Str.ToLowerCase(le.role_address) = $.Constants.STR_TRUE;
      SELF.date_added := STD.Str.FilterOut(le.date_added[1..10],'-');
      SELF.error_code := STD.Str.ToUpperCase(le.error_code);
  END;

  EXPORT $.Layouts.Gateway_Data.bv_history_rec xfBVSoapResp(iesp.briteverify_email.t_BriteVerifyEmailResponse le)
  := TRANSFORM
      SELF.email := STD.Str.ToUpperCase(TRIM(le.Result.Address, ALL));
      SELF.email_username := STD.Str.ToUpperCase(le.Result.Account);
      SELF.email_domain := STD.Str.ToUpperCase(le.Result.Domain);
      _email_status := STD.Str.ToLowerCase(le.Result.Status);
      SELF.email_status := _email_status;
      error_desc := $.Constants.GatewayValues.get_error_desc(STD.Str.ToUpperCase(le.Result.ErrorCode));
      SELF.email_status_reason := IF(error_desc<>'', error_desc, STD.Str.ToTitleCase(le.Result.Error));
      isDisposableAddress := STD.Str.ToLowerCase(le.Result.Disposable) = $.Constants.STR_TRUE;
      isRoleAddress := STD.Str.ToLowerCase(le.Result.RoleAddress) = $.Constants.STR_TRUE;
      additional_status := MAP(isDisposableAddress AND isRoleAddress => $.Constants.GatewayValues.RoleAddress+' / '+$.Constants.GatewayValues.DisposableAddress,
                               isRoleAddress => $.Constants.GatewayValues.RoleAddress,
                               isDisposableAddress => $.Constants.GatewayValues.DisposableAddress,'');
      SELF.additional_status_info := additional_status;
  END;

  EXPORT iesp.briteverify_email.t_BriteVerifyEmailRequest xfBVSoapRequest($.Layouts.Gateway_Data.batch_in_bv_rec L, STRING apikey)
  := TRANSFORM
    SELF.SearchBy.EmailAddress  := TRIM(L.email,ALL);
    SELF.Options.JSONServiceAPIKey := apikey;
    SELF:=[];
  END;

  EXPORT $.Layouts.batch_in_rec xfSearchIn(iesp.emailsearchv2.t_EmailSearchV2SearchBy rec_in)
  := TRANSFORM

    BOOLEAN is_cleanable := ((rec_in.Address.City !='') and (rec_in.Address.State != '')) or (rec_in.Address.Zip5 != '');

    addr_1			 	:= Address.Addr1FromComponents(rec_in.Address.StreetNumber,
                                                     rec_in.Address.StreetPreDirection,
                                                     rec_in.Address.StreetName,
                                                     rec_in.Address.StreetSuffix,
                                                     rec_in.Address.StreetPostDirection,
                                                     '', rec_in.Address.UnitNumber);
    addr_2 				:= Address.Addr2FromComponents(rec_in.Address.City, rec_in.Address.State, rec_in.Address.Zip5);
    addr_line_1 	:= IF (addr_1 = '', rec_in.Address.StreetAddress1, addr_1);
    clean_addr 		:= Address.GetCleanAddress(addr_line_1,addr_2,address.Components.country.US);
    ca						:= clean_addr.results;

    SELF.acctno  := $.Constants.Defaults.SingleSearchAccountNo;
    SELF.DID := rec_in.LexId;
    SELF.name_first := rec_in.Name.first;
    SELF.name_middle := rec_in.Name.Middle;
    SELF.name_last := rec_in.Name.Last;
    SELF.name_suffix := rec_in.Name.Suffix;
    SELF.ssn := rec_in.SSN;
    _dob := iesp.ECL2ESP.DateToString(rec_in.DOB);
    SELF.dob := IF((UNSIGNED)_dob > 0, _dob, '');
    SELF.prim_range := if (is_cleanable, ca.prim_range, rec_in.Address.StreetNumber);
    SELF.predir := if (is_cleanable, ca.predir, rec_in.Address.StreetPreDirection);
    SELF.prim_name := if (is_cleanable, ca.prim_name, rec_in.Address.StreetName);
    SELF.addr_suffix := if (is_cleanable, ca.suffix, rec_in.Address.StreetSuffix);
    SELF.postdir := if (is_cleanable, ca.postdir, rec_in.Address.StreetPostDirection);
    SELF.unit_desig := if (is_cleanable, ca.unit_desig, rec_in.Address.UnitDesignation);
    SELF.sec_range := if (is_cleanable, ca.sec_range, rec_in.Address.UnitNumber);
    SELF.p_city_name := if (is_cleanable, ca.p_city, rec_in.Address.City);
    SELF.st := if (is_cleanable, ca.state, rec_in.Address.State);
    SELF.z5 := if (is_cleanable, ca.zip, rec_in.Address.Zip5);
    SELF.zip4 := if (is_cleanable, ca.zip4, rec_in.Address.Zip4);

    SELF := rec_in;
    SELF := [];
  END;

  EXPORT iesp.emailsearchv2.t_EmailSearchV2Record  xfSearchOut($.Layouts.email_final_rec le)
  := TRANSFORM
    SELF.Original.EmailAddress := le.Original.email;
    SELF.Original.FirstName := le.Original.first_name;
    SELF.Original.LastName := le.Original.last_name;
    SELF.Original.StreetAddress := le.Original.address;
    SELF.Original.IPAddress := le.Original.ip;
    SELF.Original.LoginDate := le.Original.login_date;
    SELF.Original.Website := le.Original.site;
    SELF.Original.CompanyTitle := le.CompanyTitle;
    SELF.Original.CompanyName := le.orig_CompanyName;
    SELF.Original := le.Original;

    SELF.Cleaned.EmailAddress := le.Cleaned.clean_email;
    SELF.Cleaned.CompanyName := le.cln_CompanyName;
    SELF.Cleaned.Name.first := le.Cleaned.Name.fname;
    SELF.Cleaned.Name.Middle := le.Cleaned.Name.mname;
    SELF.Cleaned.Name.last := le.Cleaned.Name.lname;
    SELF.Cleaned.Name.Suffix := le.Cleaned.Name.name_suffix;
    SELF.Cleaned.Name.Prefix := le.Cleaned.Name.title;
    SELF.Cleaned.Address.StreetNumber := le.Cleaned.Address.prim_range;
    SELF.Cleaned.Address.StreetPreDirection := le.Cleaned.Address.predir;
    SELF.Cleaned.Address.StreetName := le.Cleaned.Address.prim_name;
    SELF.Cleaned.Address.StreetSuffix := le.Cleaned.Address.addr_suffix;
    SELF.Cleaned.Address.StreetPostDirection := le.Cleaned.Address.postdir;
    SELF.Cleaned.Address.UnitDesignation := le.Cleaned.Address.unit_desig;
    SELF.Cleaned.Address.UnitNumber := le.Cleaned.Address.sec_range;
    SELF.Cleaned.Address.City := le.Cleaned.Address.p_city_name;
    SELF.Cleaned.Address.State := le.Cleaned.Address.st;
    SELF.Cleaned.Address.Zip5 := le.Cleaned.Address.zip;
    SELF.Cleaned.Address.Zip4 := le.Cleaned.Address.zip4;
    SELF.Cleaned.Address.StreetAddress1 := Address.Addr1FromComponents(le.Cleaned.Address.prim_range, le.Cleaned.Address.Predir, le.Cleaned.Address.prim_name, le.Cleaned.Address.addr_suffix, le.Cleaned.Address.Postdir, le.Cleaned.Address.unit_desig, le.Cleaned.Address.sec_range);
    SELF.Cleaned.Address.StateCityZip := Address.Addr2FromComponents(le.Cleaned.Address.p_city_name, le.Cleaned.Address.st, le.Cleaned.Address.zip);

    SELF.BestInfo.SSN := le.BestInfo.SSN;
    SELF.BestInfo.DOB := iesp.ECL2ESP.toDate(le.BestInfo.dob);
    SELF.BestInfo.Name.first := le.BestInfo.fname;
    SELF.BestInfo.Name.Middle := le.BestInfo.mname;
    SELF.BestInfo.Name.last := le.BestInfo.lname;
    SELF.BestInfo.Name.Suffix := le.BestInfo.name_suffix;
    SELF.BestInfo.Name.Prefix := le.BestInfo.title;
    SELF.BestInfo.Address.StreetNumber := le.BestInfo.prim_range;
    SELF.BestInfo.Address.StreetPreDirection := le.BestInfo.predir;
    SELF.BestInfo.Address.StreetName := le.BestInfo.prim_name;
    SELF.BestInfo.Address.StreetSuffix := le.BestInfo.suffix;
    SELF.BestInfo.Address.StreetPostDirection := le.BestInfo.postdir;
    SELF.BestInfo.Address.UnitDesignation := le.BestInfo.unit_desig;
    SELF.BestInfo.Address.UnitNumber := le.BestInfo.sec_range;
    SELF.BestInfo.Address.City := le.BestInfo.city_name;
    SELF.BestInfo.Address.State := le.BestInfo.st;
    SELF.BestInfo.Address.Zip5 := le.BestInfo.zip;
    SELF.BestInfo.Address.Zip4 := le.BestInfo.zip4;
    SELF.BestInfo.Address.StreetAddress1 := Address.Addr1FromComponents(le.BestInfo.prim_range, le.BestInfo.Predir, le.BestInfo.prim_name, le.BestInfo.suffix, le.BestInfo.Postdir, le.BestInfo.unit_desig, le.BestInfo.sec_range);
    SELF.BestInfo.Address.StateCityZip := Address.Addr2FromComponents(le.BestInfo.city_name, le.BestInfo.st, le.BestInfo.zip);

    SELF.LexId := le.DID;
    SELF.ProcessDate := iesp.ECL2ESP.toDatestring8(le.process_date);
    SELF.DateFirstSeen := iesp.ECL2ESP.toDatestring8(le.date_first_seen);
    SELF.DateLastSeen := iesp.ECL2ESP.toDatestring8(le.date_last_seen);
    SELF.LNDateFirst := iesp.ECL2ESP.toDate(le.ln_date_first);
    SELF.LNDateLast := iesp.ECL2ESP.toDate(le.ln_date_last);
    SELF.DateVendorFirstReported := iesp.ECL2ESP.toDatestring8(le.date_vendor_first_reported);
    SELF.DateVendorLastReported := iesp.ECL2ESP.toDatestring8(le.date_vendor_last_reported);
    SELF.LatestOrigLoginDate := le.latest_orig_login_date;
    SELF.Source := le.email_src;
    SELF.NumEmailPerLexid := le.num_email_per_did;
    SELF.NumLexIdPerEmail := le.num_did_per_email;
    SELF.PenaltyAddress := le.penalt_addr;
    SELF.PenaltyName := le.penalt_name;
    SELF.PenaltyDidSsnDob := le.penalt_didssndob;
    SELF.EmailStatus := le.email_status;
    SELF.EmailStatusReason := le.email_status_reason;

    _last_verified := IF(le.email_status<>'' AND le.date_last_verified<>'' AND ~$.Constants.isUnknown(le.email_status),
                         $.Constants.LastVerified + ' ' + le.date_last_verified,'');
    SELF.AdditionalStatusInfo := MAP(le.additional_status_info<>'' AND _last_verified<>'' => TRIM(le.additional_status_info) + '; '+_last_verified,
                                     le.additional_status_info<>'' => le.additional_status_info,
                                     _last_verified<>'' => _last_verified,
                                     '');

    SELF.EmailId := le.email_id;
    SELF.Relationship := le.Relationship;
    SELF.isDeepDive := le.isDeepDive;
    SELF.Penalt := le.Penalt;

    SELF := le;
    SELF := [];
  END;

  EXPORT iesp.share.t_ResponseHeader  xfAddHeader(INTEGER status, DATASET($.Layouts.email_final_rec) re)
  := TRANSFORM

    service_header := iesp.ECL2ESP.GetHeaderRow();

    SELF.QueryId       := service_header.QueryId;
    SELF.TransactionId := service_header.TransactionId;
    SELF.Status        := status;
    SELF.Message       := AutoKeyI.errorcodes._msgs(status);
    SELF.Exceptions    := PROJECT(re, TRANSFORM(iesp.share.t_WsException,
                                                        SELF.Source :='Roxie',
                                                        SELF.Code := LEFT.record_err_code,
                                                        SELF.Message := LEFT.record_err_msg,
                                                        SELF.Location := ''));
    SELF.Disclaimers   := service_header.Disclaimers;
  END;

  EXPORT iesp.emailsearchv2.t_EmailSearchV2InputSubject  xfInputEcho(iesp.emailsearchv2.t_EmailSearchV2SearchBy _in, UNSIGNED lexid)
  := TRANSFORM

    SELF.InputEcho     := _in;
    SELF.SubjectLexid  := lexid;
  END;

  EXPORT $.Layouts.batch_final_rec xfBatchOut($.Layouts.email_final_rec le)
    := TRANSFORM
      SELF.acctno          := le.acctno,
      SELF.orig_first_name := le.original.first_name;
      SELF.orig_last_name  := le.original.last_name;
      SELF.orig_address    := le.original.address;
      SELF.orig_city       := le.original.city;
      SELF.orig_state      := le.original.state;
      SELF.orig_zip        := le.original.zip;
      SELF.orig_zip4       := le.original.zip4;
      SELF.orig_email      := le.original.email;
      SELF.orig_ip         := le.original.ip;
      SELF.orig_login_date := le.original.login_date;
      SELF.orig_site       := le.original.site;
      SELF.orig_company_name := le.orig_CompanyName;
      SELF.cln_company_name := le.cln_CompanyName;
      SELF.company_title := le.CompanyTitle;
      SELF.src := le.email_src;
      SELF.best_title := le.bestinfo.title;
      SELF.best_fname := le.bestinfo.fname;
      SELF.best_mname := le.bestinfo.mname;
      SELF.best_lname := le.bestinfo.lname;
      SELF.best_name_suffix := le.bestinfo.name_suffix;
      SELF.best_prim_range := le.bestinfo.prim_range;
      SELF.best_predir := le.bestinfo.predir;
      SELF.best_prim_name := le.bestinfo.prim_name;
      SELF.best_addr_suffix := le.bestinfo.suffix;
      SELF.best_postdir := le.bestinfo.postdir;
      SELF.best_unit_desig := le.bestinfo.unit_desig;
      SELF.best_sec_range := le.bestinfo.sec_range;
      SELF.best_city_name := le.bestinfo.city_name;
      SELF.best_st := le.bestinfo.st;
      SELF.best_zip := le.bestinfo.zip;
      SELF.best_zip4 := le.bestinfo.zip4;
      SELF.best_ssn := le.bestinfo.ssn;
      SELF.best_dob := le.BestInfo.dob;
      SELF.clean_email := le.cleaned.clean_email;
      SELF := le.cleaned.Name;
      SELF := le.cleaned.Address;
      _last_verified := IF(le.email_status<>'' AND le.date_last_verified<>'' AND ~$.Constants.isUnknown(le.email_status),
                         $.Constants.LastVerified + ' ' + le.date_last_verified,'');
      SELF.additional_status_info :=
                                  MAP(le.additional_status_info<>'' AND _last_verified<>'' => TRIM(le.additional_status_info) + '; '+_last_verified,
                                     le.additional_status_info<>'' => le.additional_status_info,
                                     _last_verified<>'' => _last_verified,
                                     '');
      SELF.ln_date_first := IF(le.ln_date_first>0, (STRING) le.ln_date_first,'');
      SELF.ln_date_last := IF(le.ln_date_last>0, (STRING) le.ln_date_last,'');
      SELF := le;
  END;

  EXPORT $.Layouts.crs_email_rec xform_crs_email($.Layouts.email_final_rec le)
   := TRANSFORM
      SELF.OriginalCompanyName := le.orig_CompanyName;
      SELF.CompanyTitle := le.CompanyTitle;
      SELF.OriginalEmail := le.Original.email;
      //cleaned:
      SELF.EmailAddress := le.Cleaned.clean_email;
      SELF.CompanyName := le.cln_CompanyName;
      SELF.Name.first := le.Cleaned.Name.fname;
      SELF.Name.Middle := le.Cleaned.Name.mname;
      SELF.Name.last := le.Cleaned.Name.lname;
      SELF.Name.Suffix := le.Cleaned.Name.name_suffix;
      SELF.Name.Prefix := le.Cleaned.Name.title;
      SELF.Address.StreetNumber := le.Cleaned.Address.prim_range;
      SELF.Address.StreetPreDirection := le.Cleaned.Address.predir;
      SELF.Address.StreetName := le.Cleaned.Address.prim_name;
      SELF.Address.StreetSuffix := le.Cleaned.Address.addr_suffix;
      SELF.Address.StreetPostDirection := le.Cleaned.Address.postdir;
      SELF.Address.UnitDesignation := le.Cleaned.Address.unit_desig;
      SELF.Address.UnitNumber := le.Cleaned.Address.sec_range;
      SELF.Address.City := le.Cleaned.Address.p_city_name;
      SELF.Address.State := le.Cleaned.Address.st;
      SELF.Address.Zip5 := le.Cleaned.Address.zip;
      SELF.Address.Zip4 := le.Cleaned.Address.zip4;
      SELF.Address.StreetAddress1 := Address.Addr1FromComponents(le.Cleaned.Address.prim_range, le.Cleaned.Address.Predir, le.Cleaned.Address.prim_name, le.Cleaned.Address.addr_suffix, le.Cleaned.Address.Postdir, le.Cleaned.Address.unit_desig, le.Cleaned.Address.sec_range);
      SELF.Address.StateCityZip := Address.Addr2FromComponents(le.Cleaned.Address.p_city_name, le.Cleaned.Address.st, le.Cleaned.Address.zip);
      SELF := [];
  END;

  EXPORT $.Layouts.crs_email_raw_rec xform_crs_raw($.Layouts.email_final_rec le)
  := TRANSFORM
    SELF.Original.EmailAddress := le.Original.email;
    SELF.Original.IPAddress := le.Original.ip;
    SELF.Original.LoginDate := le.Original.login_date;
    SELF.Original.Website := le.Original.site;
    SELF.Original.CompanyTitle := le.CompanyTitle;
    SELF.Original.CompanyName := le.orig_CompanyName;

    SELF.Cleaned.EmailAddress := le.Cleaned.clean_email;
    SELF.Cleaned.Phone := le.Cleaned.clean_phone;
    SELF.Cleaned.SSN := le.Cleaned.clean_ssn;
    SELF.Cleaned.DOB := le.Cleaned.clean_dob;
    SELF.Cleaned.CompanyName := le.cln_CompanyName;
    SELF.Cleaned.Name.first := le.Cleaned.Name.fname;
    SELF.Cleaned.Name.Middle := le.Cleaned.Name.mname;
    SELF.Cleaned.Name.last := le.Cleaned.Name.lname;
    SELF.Cleaned.Name.Suffix := le.Cleaned.Name.name_suffix;
    SELF.Cleaned.Name.Prefix := le.Cleaned.Name.title;
    SELF.Cleaned.Address.StreetNumber := le.Cleaned.Address.prim_range;
    SELF.Cleaned.Address.StreetPreDirection := le.Cleaned.Address.predir;
    SELF.Cleaned.Address.StreetName := le.Cleaned.Address.prim_name;
    SELF.Cleaned.Address.StreetSuffix := le.Cleaned.Address.addr_suffix;
    SELF.Cleaned.Address.StreetPostDirection := le.Cleaned.Address.postdir;
    SELF.Cleaned.Address.UnitDesignation := le.Cleaned.Address.unit_desig;
    SELF.Cleaned.Address.UnitNumber := le.Cleaned.Address.sec_range;
    SELF.Cleaned.Address.City := le.Cleaned.Address.p_city_name;
    SELF.Cleaned.Address.State := le.Cleaned.Address.st;
    SELF.Cleaned.Address.Zip5 := le.Cleaned.Address.zip;
    SELF.Cleaned.Address.Zip4 := le.Cleaned.Address.zip4;
    SELF.Cleaned.Address.StreetAddress1 := Address.Addr1FromComponents(le.Cleaned.Address.prim_range, le.Cleaned.Address.Predir, le.Cleaned.Address.prim_name, le.Cleaned.Address.addr_suffix, le.Cleaned.Address.Postdir, le.Cleaned.Address.unit_desig, le.Cleaned.Address.sec_range);
    SELF.Cleaned.Address.StateCityZip := Address.Addr2FromComponents(le.Cleaned.Address.p_city_name, le.Cleaned.Address.st, le.Cleaned.Address.zip);

    SELF.LexId := le.DID;
    SELF.ProcessDate := le.process_date;
    SELF.DateFirstSeen := le.date_first_seen;
    SELF.DateLastSeen := le.date_last_seen;
    SELF.DateVendorFirstReported := le.date_vendor_first_reported;
    SELF.DateVendorLastReported := le.date_vendor_last_reported;
    SELF.Source := le.email_src;
    SELF.EmailId := le.email_id;

    SELF := le;
    SELF := [];
  END;

  EXPORT $.Layouts.email_final_rec ApplyDobMask ($.Layouts.email_final_rec le, UNSIGNED1 _dob_mask)
   := TRANSFORM
    SELF.BestInfo.DOB := IF(le.BestInfo.dob>0, iesp.ECL2ESP.DateToInteger(iesp.ECL2ESP.ApplyDateMask(iesp.ECL2ESP.toDate(le.BestInfo.dob), _dob_mask)), 0);
    SELF.Cleaned.clean_dob := IF(le.Cleaned.clean_dob>0,iesp.ECL2ESP.DateToInteger(iesp.ECL2ESP.ApplyDateMask(iesp.ECL2ESP.toDate(le.Cleaned.clean_dob), _dob_mask)), 0);
    _masked_dob := iesp.ECL2ESP.ApplyDateStringMask(iesp.ECL2ESP.toMaskableDatestring8(le.Original.dob), _dob_mask);
    SELF.Original.dob := IF(le.Original.dob<>'', _masked_dob.Year + _masked_dob.month + _masked_dob.day,'');
    SELF := le;
  END;

END;
