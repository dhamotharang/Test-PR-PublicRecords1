import BizLinkFull, BIPV2_Company_Names, ut, SALT28, BIPV2_Best, BIPV2_Suppression;
import std.Str AS Str;
import address;
EXPORT IDfunctions := 
MODULE
EXPORT rec_SearchInput := record
  STRING company_name;
  STRING prim_range;
  STRING prim_name;
  STRING zip5;
  STRING sec_range;
  STRING city;
  STRING state;
  STRING phone10;
  STRING fein;
  STRING URL;
  STRING Email;
  STRING Contact_fname;
  STRING Contact_mname;
  STRING Contact_lname;
  STRING30 acctno := '';
  UNSIGNED3 zip_radius_miles := 0;
  STRING sic_code := '';            //this is a straight post filter when nonblank - but this is unlikely to meet requirements
  UNSIGNED results_limit:=0;
  STRING inSeleid:='0';
  BOOLEAN allow7DigitMatch:=FALSE;
  STRING contact_ssn:='';
  UNSIGNED contact_did:=0;
  BOOLEAN HSort:=FALSE;
end;
EXPORT fn_IndexedSearchForXLinkIDs(
  dataset(rec_SearchInput) SearchInput
  //  ,score_threshold?       = '75'
  //   others?
):=MODULE
//add counter 
SHARED THISMODULE:=BizLinkFull;
SHARED SearchInputc:=PROJECT(SearchInput,TRANSFORM({SearchInput;UNSIGNED6 cntr;STRING company_phone_3;STRING company_phone_7;STRING company_name_prefix;STRING fname_preferred;DATASET(THISMODULE.Process_Biz_Layouts.layout_zip_cases) zip_cases;},
  ssAirportReplacement:=BIPV2.fn_translate_city(stringlib.StringToUpperCase(LEFT.city));
  sNewCity:=Str.ToUpperCase(IF(COUNT(ssAirportReplacement)=0,LEFT.city,ssAirportReplacement[1]));
  sNewState_:=Str.ToUpperCase(IF(COUNT(ssAirportReplacement)=0,LEFT.state,ssAirportReplacement[2]));
  sNewState:=IF(sNewState_<>'',sNewState_,IF(sNewCity='','',address.Key_CityStChance(city_name=sNewCity and percent_chance>=99)[1].st));
  dZips:=BIPV2.fn_get_zips_2(sNewCity,sNewState,LEFT.zip5,LEFT.zip_radius_miles);
  Input_zip_radius:=LEFT.zip_radius_miles;
  SELF.zip_cases:=IF(dZips[1].zip='',DATASET([],THISMODULE.Process_Biz_Layouts.layout_zip_cases),PROJECT(dZips,TRANSFORM(THISMODULE.Process_Biz_Layouts.layout_zip_cases,SELF.weight:=100-((LEFT.radius/Input_zip_radius)*80);SELF:=LEFT;)));
  SELF.city:=dZips[1].city;
  SELF.state:=dZips[1].state;
  SELF.company_phone_3:=IF(LENGTH(TRIM(LEFT.phone10))=10,LEFT.phone10[..3],'');
  SELF.company_phone_7:=IF(LENGTH(TRIM(LEFT.phone10))=10,LEFT.phone10[4..10],IF(LENGTH(TRIM(LEFT.phone10))=7,TRIM(LEFT.phone10),''));
  SELF.company_name_prefix:='';//LEFT.company_name[..5];
  SELF.fname_preferred:=THISMODULE.fn_PreferredName(LEFT.Contact_fname);
  SELF.cntr:=COUNTER;
  SELF:=LEFT;
));
BIPV2_Company_Names.functions.mac_go(SearchInputc,SearchInputcnp0,cntr,company_name,,FALSE);
SHARED SearchInputcnp:=PROJECT(SearchInputcnp0,TRANSFORM(RECORDOF(LEFT),SELF.company_name_prefix:=THISMODULE.fn_company_name_prefix(LEFT.cnp_name);SELF:=LEFT;));
//---------------------------------------------------------------------------
//  *****   BizLinkFull   ******
//---------------------------------------------------------------------------
SHARED Template:=DATASET([],THISMODULE.Process_Biz_Layouts.InputLayout);
SHARED SALTInput2_:=PROJECT(SearchInputcnp,TRANSFORM({THISMODULE.Process_Biz_Layouts.InputLayout;STRING30 acctno;},
  SELF.UniqueID       := (TYPEOF(Template.UniqueID))LEFT.cntr;
  SELF.company_name_prefix:=(TYPEOF(Template.company_name_prefix))THISMODULE.Fields.Make_company_name_prefix((SALT28.StrType)LEFT.company_name_prefix);
  SELF.cnp_number     := (TYPEOF(Template.cnp_number))LEFT.cnp_number;
  SELF.cnp_btype      := (TYPEOF(Template.cnp_btype))LEFT.cnp_btype;
  SELF.cnp_lowv       := (TYPEOF(Template.cnp_lowv))LEFT.cnp_lowv;
  SELF.cnp_name       := (TYPEOF(Template.cnp_name))THISMODULE.Fields.Make_cnp_name((SALT28.StrType)LEFT.cnp_name);
  SELF.prim_range     := (TYPEOF(Template.prim_range))LEFT.prim_range;
  SELF.prim_name      := (TYPEOF(Template.prim_name))THISMODULE.Fields.Make_prim_name((SALT28.StrType)LEFT.prim_name);
  SELF.sec_range      := (TYPEOF(Template.sec_range))THISMODULE.Fields.Make_sec_range((SALT28.StrType)LEFT.sec_range);   
  SELF.city           := (TYPEOF(Template.city))THISMODULE.Fields.Make_city((SALT28.StrType)LEFT.city);
  SELF.st             := (TYPEOF(Template.st))THISMODULE.Fields.Make_st((SALT28.StrType)LEFT.state);
  SELF.zip_cases      := LEFT.zip_cases;
  SELF.company_phone  := (TYPEOF(Template.company_phone))LEFT.phone10;
  SELF.company_phone_3:= IF(LEFT.allow7DigitMatch,'',(TYPEOF(Template.company_phone_3))LEFT.company_phone_3);
  SELF.company_phone_3_ex:= IF(LEFT.allow7DigitMatch,(TYPEOF(Template.company_phone_3))LEFT.company_phone_3,'');
  SELF.company_phone_7:= (TYPEOF(Template.company_phone_7))LEFT.company_phone_7;
  SELF.company_fein   := (TYPEOF(Template.company_fein))LEFT.fein;
  SELF.company_url    := (TYPEOF(Template.company_url))THISMODULE.Fields.Make_company_url((SALT28.StrType)LEFT.url);
  SELF.company_sic_code1:=(TYPEOF(Template.company_sic_code1))THISMODULE.Fields.Make_company_sic_code1((SALT28.StrType)LEFT.sic_code);
  SELF.fname          := (TYPEOF(Template.fname))THISMODULE.Fields.Make_fname((SALT28.StrType)LEFT.contact_fname);
  SELF.mname          := (TYPEOF(Template.mname))THISMODULE.Fields.Make_mname((SALT28.StrType)LEFT.contact_mname);
  SELF.lname          := (TYPEOF(Template.lname))THISMODULE.Fields.Make_lname((SALT28.StrType)LEFT.contact_lname);
  SELF.fname_preferred:= (TYPEOF(Template.fname_preferred))THISMODULE.Fields.Make_fname_preferred((SALT28.StrType)LEFT.fname_preferred);
  SELF.contact_email  := (TYPEOF(Template.contact_email))LEFT.Email;
  SELF.contact_ssn    := (TYPEOF(Template.contact_ssn))LEFT.contact_ssn;
  SELF.contact_did    := (TYPEOF(Template.contact_did))LEFT.contact_did;
  SELF.MaxIDs         := IF(LEFT.results_limit=0,50,LEFT.results_limit);
  SELF.Entered_seleid := (UNSIGNED)LEFT.inSeleID;
  SELF.sele_flag      := IF(LEFT.HSort,'T','_');
  SELF.org_flag       := IF(LEFT.HSort,'T','_');
  SELF.ult_flag       := IF(LEFT.HSort,'T','_');
  SELF.acctno         := LEFT.acctno;
  SELF.disableForce   :=TRUE;
  SELF := [];
));
EXPORT SALTInput2:=PROJECT(SALTInput2_,THISMODULE.Process_Biz_Layouts.InputLayout);
EXPORT uid_results := BIPV2_Suppression.macSuppress(THISMODULE.MEOW_Biz(SALTInput2).uid_results);  //Added this for BIPV2_xLink.fn_bdid_append (for BIPV2_xLink.MAC_BDID_Append for BIID and others)
EXPORT uid_results_w_acct:=JOIN(uid_results,SearchInputc,LEFT.uniqueid=RIGHT.cntr,TRANSFORM({RECORDOF(LEFT);TYPEOF(RIGHT.acctno) acctno;},SELF.acctno:=RIGHT.acctno;SELF:=LEFT;));
// EXPORT Raw_Results2 := THISMODULE.MEOW_Biz(SALTInput2).Raw_Results;  //Added this for BIPV2_xLink.fn_bdid_append (for BIPV2_xLink.MAC_BDID_Append for BIID and others)
//EXPORT Data_Tmp := THISMODULE.MEOW_Biz(SALTInput2).Data_Tmp;  //This is where the magic happens
EXPORT SALTOutput2 := BIPV2_Suppression.macSuppress(THISMODULE.MEOW_Biz(SALTInput2).Data_);  //This is where the magic happens
EXPORT raw_data := THISMODULE.MEOW_Biz(SALTInput2).raw_data;  //For now, this just supports SeleBest work below
SHARED outrec2:=RECORD
  rec_SearchInput.acctno;
  BIPV2.IDlayouts.l_xlink_ids;
  RECORDOF(SALTOutput2)-[DotID,EmpID,POWID,SeleID,ProxID,OrgID,UltID];
END;
SHARED output_unsuppressed:=JOIN(SALTOutput2,SearchInputc,
  LEFT.uniqueid = RIGHT.cntr AND (RIGHT.sic_code='' OR (ut.rmv_ld_zeros(LEFT.company_sic_code1)=ut.rmv_ld_zeros(RIGHT.sic_code))),
  TRANSFORM({outrec2;},
    SELF.proxweight:=LEFT.weight;
    SELF.source:=IF(LEFT.proxid=0,'__',LEFT.source);
    SELF := LEFT;
    SELF := RIGHT;
));
BIPV2_Suppression.mac_contacts(output_unsuppressed, output_clean, output_dirty,,,fname, lname);
SHARED Outfile2 := output_clean;
EXPORT RecordIn2 := rec_SearchInput;
EXPORT RecordOut2 := outrec2;
// output(SALTInput2,named('SALTInput2'));
// output(uid_results, named('uid_results'));
// output(Raw_Results2, named('Raw_Results2'));
// output(raw_data, named('raw_data'));
EXPORT Data2_ := Outfile2;

EXPORT UnsuppressedData2_ := output_unsuppressed;
// EXPORT Data2_:=Raw_Results2;
EXPORT SeleMatch:=JOIN(SearchInput,Outfile2(rcid>0),LEFT.acctno=RIGHT.acctno AND (UNSIGNED)LEFT.inSeleID=RIGHT.rcid,TRANSFORM({STRING30 acctno;BOOLEAN valid_sele;},SELF.valid_sele:=((UNSIGNED)LEFT.InSeleID=0 OR (UNSIGNED)LEFT.InSeleID=RIGHT.seleid);SELF:=LEFT;),LEFT OUTER);
//  ** Start work for SeleBest
// fetch the sele best
renewed_uid_results := dedup(project(raw_data, {raw_data.UniqueId, BIPV2.IDlayouts.l_xlink_ids}), all);
sb := BIPV2_Best.Key_LinkIds.kfetch(
  inputs := dedup(project(renewed_uid_results, BIPV2.IDlayouts.l_xlink_ids), all),
  Level := BIPV2.IDconstants.Fetch_Level_SELEID
)(proxid = 0);//when proxid > 0, that is the proxid best.  when 0, its sele.
// append back the UniqueId
wu := 
  join(
    dedup(renewed_uid_results, UniqueId, seleid, all),
    sb,   
    left.seleid = right.seleid,
    transform(
      {sb, unsigned8 UniqueId},
      self.UniqueId := left.UniqueId,
      self := right
    )
  ,  keep(1)
);
// now project/transform to the layout needed for scoring
lfs :=
project(
  wu,
  transform(
    {raw_data},
    
    cp := left.company_phone[1].company_phone;    //If restrictions already applied, then I think taking the first row is good.  if not, we can add a normalize here.
    self.company_phone := cp;
    self.company_phone_3 := cp[1..3];
    self.company_phone_7 := cp[4..10];
    self.company_name   :=  left.company_name[1].company_name;
    self.dt_first_seen  := left.company_name[1].dt_first_seen;
    self.dt_last_seen   := left.company_name[1].dt_last_seen;
    self.company_fein   :=  left.company_fein[1].company_fein;
    self.company_url    :=  left.company_url[1].company_url;
    
    ca := left.company_address[1];
    self.prim_range := ca.company_prim_range; 
    self.prim_name := ca.company_prim_name;
    self.sec_range := ca.company_sec_range; 
    self.city := ca.address_v_city_name;  
    self.st := ca.company_st;
    self.zip := ca.company_zip5;    
    self.zip4 := ca.company_zip4;
    self := left;
    self := []    //  fill in lots of fields we dont care to score, like rcid2
  )
);
//add cnp_name, etc
forcnp :=
project(
  lfs,
  transform(
    {lfs, unsigned6 rid_forcnp},
    self := left,
    self.rid_forcnp := counter
  )
);
BIPV2_Company_Names.functions.mac_go(forcnp, wcnp, rid_forcnp,company_name,,FALSE)
wcnp2 := project(wcnp, {raw_data});
import salt29;
best_out:=THISMODULE.MEOW_Biz(SALTInput2).ScoreData(wcnp2,SALTInput2);
// output(Wu, named('wu'));
wcounty :=
join(
  best_out,
  Wu,
  left.uniqueid = right.uniqueid and left.seleid = right.seleid,
  transform(
    {best_out, sb.company_address.county_name, dataset({sb.company_fein.sources}) company_fein_sources, dataset({sb.company_name.sources}) company_name_sources, sb.company_address.company_address_data_permits},
    self.county_name := right.company_address[1].county_name,
    self.addr_suffix := right.company_address[1].company_addr_suffix,
    self.predir := right.company_address[1].company_predir,
    self.postdir := right.company_address[1].company_postdir,
    self.unit_desig := right.company_address[1].company_unit_desig,
    self.p_city_name := right.company_address[1].company_p_city_name,
    self.v_city_name := right.company_address[1].address_v_city_name,
    self.company_fein_sources := right.company_fein.sources,
    self.company_name_sources := right.company_name.sources,
    self.company_address_data_permits := right.company_address[1].company_address_data_permits,
    self := left
  ),
  keep(1)
);
// output(sb, named('sb'));
// output(renewed_uid_results, all, named('renewed_uid_results'));
// output(wu, all, named('wu'));
wparentinfo := //ultimate_proxid and sele_proxid needed for mac_AddParentAbovSeleField
join(
  wcounty,
  Data2_,
  left.uniqueid = right.uniqueid and left.seleid = right.seleid,
  transform(
    {wcounty},
    self.ultimate_proxid := right.ultimate_proxid,
    self.sele_proxid := right.sele_proxid,
    self := left
  ),
  keep(1)
);
wpas := BIPV2.IDmacros.mac_AddParentAbovSeleField(wparentinfo);
wpas_status := join(wpas  ,sb ,left.seleid = right.seleid,transform({recordof(wpas), boolean isActive, boolean isDefunct},self.isactive := right.isactive,self.isdefunct := right.isdefunct,self.company_status_derived := '',self := left),left outer);
wsta := JOIN(wpas_status,SALTInput2_,LEFT.uniqueid=RIGHT.uniqueid,TRANSFORM({RECORDOF(LEFT) AND NOT uniqueid;STRING30 acctno;},SELF:=LEFT;SELF:=RIGHT;));
// wsta := JOIN(BIPV2.mac_AddStatus(wpas),SALTInput2_,LEFT.uniqueid=RIGHT.uniqueid,TRANSFORM({STRING30 acctno;RECORDOF(LEFT) AND NOT uniqueid;},SELF:=LEFT;SELF:=RIGHT;));
// output(sb, named('sb'));
EXPORT SeleBest := BIPV2_Suppression.macSuppress(wsta);
END;
END;
