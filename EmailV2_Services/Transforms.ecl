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
  
  hasFullAddress($.Layouts.batch_in_rec _input) := FUNCTION
    str_addr := STD.Str.CleanSpaces(Address.Addr1FromComponents(_input.prim_range,_input.predir,_input.prim_name,
                                              _input.addr_suffix,_input.postdir,_input.unit_desig,_input.sec_range));
    has_full_address := str_addr != '' AND _input.prim_name!= '' AND
                        ((_input.p_city_name != '' AND _input.st != '') OR _input.z5 != '');
    RETURN has_full_address;
  END;
  
  hasFullName($.Layouts.batch_in_rec _input) := TRIM(_input.name_first,ALL) <> '' AND TRIM(_input.name_last,ALL) <> '';
  hasFullSSN($.Layouts.batch_in_rec _input) := LENGTH(STD.Str.Filter(_input.ssn,'0123456789')) = 9;
  
  hasSufficientIdentityInput($.Layouts.batch_in_rec _input) := FUNCTION
  
    has_full_address := hasFullAddress(_input);
    has_full_name := hasFullName(_input);

    has_ssn := hasFullSSN(_input);
    has_lexid := _input.DID>0;
    BOOLEAN has_sufficient_input := has_lexid OR (has_ssn AND has_full_name) OR (has_full_name AND has_full_address);
    
    RETURN has_sufficient_input;
  END;
  
  EXPORT $.Layouts.batch_in_ext_rec checkIdentityInput($.Layouts.batch_in_rec le) := TRANSFORM
  
    insufficient_input := ~hasSufficientIdentityInput(le);
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

  EXPORT $.Layouts.GatewayData.bv_history_rec xfBVDeltabaseResp($.Layouts.GatewayData.bv_history_deltabase_rec le)
  := TRANSFORM
      SELF.email := STD.Str.ToUpperCase(TRIM(le.email_address, ALL));
      SELF.email_username := STD.Str.ToUpperCase(le.Account);
      SELF.email_domain := STD.Str.ToUpperCase(le.Domain);
      SELF.email_status := le.Status;
      SELF.email_status_reason := IF(le.Error='(null)', '', le.Error);  // ESP is returning (null) in case of blank, we need to clean up
      isDisposableAddress := STD.Str.ToLowerCase(le.disposable) = $.Constants.STR_TRUE;
      isRoleAddress := STD.Str.ToLowerCase(le.role_address) = $.Constants.STR_TRUE;
      additional_status := MAP(isDisposableAddress AND isRoleAddress => $.Constants.GatewayValues.RoleAddress+' / '+$.Constants.GatewayValues.DisposableAddress,
                               isRoleAddress => $.Constants.GatewayValues.RoleAddress,
                               isDisposableAddress => $.Constants.GatewayValues.DisposableAddress,'');
      SELF.additional_status_info := additional_status;
  END;

  EXPORT $.Layouts.GatewayData.bv_history_rec xfBVSoapResp(iesp.briteverify_email.t_BriteVerifyEmailResponse le)
  := TRANSFORM
      SELF.email := STD.Str.ToUpperCase(TRIM(le.Result.Address, ALL));
      SELF.email_username := STD.Str.ToUpperCase(le.Result.Account);
      SELF.email_domain := STD.Str.ToUpperCase(le.Result.Domain);
      SELF.email_status := le.Result.Status;
      SELF.email_status_reason := le.Result.Error;
      isDisposableAddress := STD.Str.ToLowerCase(le.Result.Disposable) = $.Constants.STR_TRUE;
      isRoleAddress := STD.Str.ToLowerCase(le.Result.RoleAddress) = $.Constants.STR_TRUE;
      additional_status := MAP(isDisposableAddress AND isRoleAddress => $.Constants.GatewayValues.RoleAddress+' / '+$.Constants.GatewayValues.DisposableAddress,
                               isRoleAddress => $.Constants.GatewayValues.RoleAddress,
                               isDisposableAddress => $.Constants.GatewayValues.DisposableAddress,'');
      SELF.additional_status_info := additional_status;
  END;
   
  EXPORT iesp.briteverify_email.t_BriteVerifyEmailRequest xfBVSoapRequest($.Layouts.GatewayData.batch_in_bv_rec L, STRING apikey)
  := TRANSFORM
    SELF.SearchBy.EmailAddress  := L.email;
    SELF.Options.JSONServiceAPIKey := apikey;
    SELF:=[];
  END;
  
  
END;