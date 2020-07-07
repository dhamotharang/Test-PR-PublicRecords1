import doxie, gateway, targus, NID, Phones, STD;

export FN_PPL_Confirm_Connect(dataset(doxie.layout_pp_raw_common) in_data,
                              doxie.IDataAccess mod_access,
                              gateway.Layouts.Config gateway_cfg) := function

targus_gateway_url := gateway_cfg.url;

WirelessSearchRsltSet := [
  Phones.Constants.TargusType.WirelessConnectionSearch, 
  Phones.Constants.TargusType.PhoneDataExpress+Phones.Constants.TargusType.WirelessConnectionSearch
];	

cfm_data_rec := record
  string10 	phone; 
  string20 	fname;
  string20 	lname;
  string120	listed_name;
end;

cfm_from_in := project(choosen(in_data(confirmed_flag, phone<>''),1), cfm_data_rec);
cfm_sp_init := choosen(in_data,1)(
  phone<>'' and (lname<>'' or fname<>'' or listed_name<>'') and 
  ~(vendor_id='GH' and Activeflag='Y') and TargusType not in WirelessSearchRsltSet
);
cfm_overlap := join(cfm_from_in, cfm_sp_init, left.phone = right.phone);

targus.layout_targus_in prep_for_connect(cfm_sp_init le) := transform
  self.user.GLBPurpose := mod_access.glb;
  self.user.DLPurpose := mod_access.dppa;
  self.user.QueryID := '3';
  self.SearchBy.PhoneNumber := le.phone;
  self.options.IncludeWirelessConnectionSearch := true;
  self := [];
end;

cfm_sp_ready := project(cfm_sp_init, prep_for_connect(left));

vMakeGWCall := targus_gateway_url!='' and exists(cfm_sp_init) and ~exists(cfm_overlap);
cfm_sp_rslt := if(vMakeGWCall,
  Gateway.SoapCall_Targus(cfm_sp_ready, gateway_cfg, 3, , vMakeGWCall, mod_access, TRUE), 
  dataset([],targus.layout_targus_out));

cfm_data_rec get_cfm_sp(cfm_sp_rslt le, unsigned cnt) := transform
  self.phone := if(cnt=1, le.searchby.phonenumber, skip);
  self.listed_name := 
    if(le.response.wirelessconnectionsearchresult.companyname<>'',
      le.response.wirelessconnectionsearchresult.companyname,
      le.response.wirelessconnectionsearchresult.consumername.fll);
  self.fname := le.response.wirelessconnectionsearchresult.consumername.frst;
  self.lname := le.response.wirelessconnectionsearchresult.consumername.lst;    
end;

cfm_from_sp := project(cfm_sp_rslt, get_cfm_sp(left, counter));
cfm_data := cfm_from_in + cfm_from_sp;

in_data confirm_them(in_data l, cfm_data r) := transform
  // @CLEANUP: Lines 58-68 are begging for a clean-up. Impossible to read as it is.  
  is_confirmed := (r.listed_name<>'' and 
    STD.STR.ToUpperCase(r.listed_name)= STD.STR.ToUpperCase(l.listed_name[1..length(trim(r.listed_name))])) or // <-- can be replaced with STD.STR.StartsWith()
    (l.fname<>'' or l.lname<>'') and 
    (l.fname='' or NID.mod_PFirstTools.PFLeqPFR(STD.STR.ToUpperCase(r.fname),STD.STR.ToUpperCase(l.fname))
        or trim(STD.STR.ToUpperCase(r.fname)) = STD.STR.ToUpperCase(l.fname)[1] 
    or trim(STD.STR.toUpperCase(r.fname))[1] = STD.STR.ToUpperCase(l.fname)) and
    (l.lname='' or metaphonelib.DMetaPhone1(STD.STR.ToUpperCase(r.lname))=metaphonelib.DMetaPhone1(STD.STR.ToUpperCase(l.lname))) or 
    (l.fname<>'' or l.lname<>'') and 
    (l.fname='' or STD.STR.ToUpperCase(r.lname)=STD.STR.ToUpperCase(l.fname)) and
    (l.lname='' or STD.STR.ToUpperCase(r.fname)=STD.STR.ToUpperCase(l.lname));										
  self.listed_name_targus := if(is_confirmed,'',r.listed_name);				 
  self.confirmed_flag := if(r.listed_name<>'' or r.fname<>'' or r.lname<>'',true,l.confirmed_flag);
  self := l;
end;

cfm_final := join(in_data, cfm_data, 
  left.phone=right.phone, 
  confirm_them(left, right), left outer, keep(1));

cfm_final get_royal(cfm_final l, unsigned cnt) := transform
  self.TargusType := trim(l.TargusType) + 
    if(cnt=1 and exists(cfm_from_sp(listed_name<>'' or fname<>'' or lname<>'')) and 
      (l.TargusType not in WirelessSearchRsltSet), 
    Phones.Constants.TargusType.ConfirmConnect,
    '');
  self := l;
end;

cfm_final_royal := project(cfm_final, get_royal(left, counter));       
return cfm_final_royal;			  

end;