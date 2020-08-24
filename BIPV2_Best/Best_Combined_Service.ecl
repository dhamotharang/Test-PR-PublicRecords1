/*--SOAP--
<message name="BIP_Best_Combined_Service">
  <part name="Ultid" type="xsd:unsignedInt"/>
  <part name="Orgid" type="xsd:unsignedInt"/>
  <part name="Seleid" type="xsd:unsignedInt"/>
  <part name="Proxid" type="xsd:unsignedInt"/>
  <part name="Sele_Level_Only" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns BIP Best values for Best, SBFE & Marketing Best
<p>Please enter the BIP ID for the level of hierarchy to return (Ult/Org/Sele/Prox).</p>
<p>Best is determined for both Sele and Prox level entities.  If the sele_level_only option is set (defaults to false), prox level results will be removed and only sele level Best will be shown.</p>
*/
IMPORT BIPV2, BIPV2_Best, BIPV2_Best_SBFE;

#WEBSERVICE(
	DESCRIPTION(
	     '<h3>This service returns BIP Best values for Best, SBFE & Marketing Best</h3>\n'
			 + '<p>Please enter the BIP ID for the level of hierarchy to return (Ult/Org/Sele/Prox).</p>'
			 + '<p>Best is determined for both Sele and Prox level entities.  If the sele_level_only option is set (defaults to false), prox level results will be removed and only sele level Best will be shown.</p>'
			 )
	);
				
EXPORT Best_Combined_Service() := FUNCTION
  input_ultid   := 0 : STORED('Ultid',  FORMAT(SEQUENCE(1)));
  input_orgid   := 0 : STORED('Orgid',  FORMAT(SEQUENCE(2)));
  input_seleid  := 0 : STORED('Seleid', FORMAT(SEQUENCE(3)));
  input_proxid  := 0 : STORED('Proxid', FORMAT(SEQUENCE(4)));
  boolean sele_level_only := false : STORED('sele_level_only', FORMAT(SEQUENCE(5)));


  input := dataset([{input_ultid, input_orgid, input_seleid, input_proxid, sele_level_only}], 
                    {unsigned ultid, unsigned orgid,unsigned seleid,unsigned proxid, boolean sele_level_only});
  BestKey :=   BIPV2_Best.Key_Linkids.key;
	 SBFEKey :=   BIPV2_Best_SBFE.Key_Linkids().key;
	
	
  string1 Level := map(input_ultid<>0 => BIPV2.IDconstants.Fetch_Level_UltID, 
                       input_orgid<>0 => BIPV2.IDconstants.Fetch_Level_OrgID,
                       input_seleid<>0 => BIPV2.IDconstants.Fetch_Level_SeleID,
                       BIPV2.IDconstants.Fetch_Level_ProxID);
                      
  inputs := DATASET([{0,0,0,0,0,0,0,0,0,input_proxid,0,0,input_seleid,0,0,input_orgid,0,0,input_ultid}],BIPV2.IDlayouts.l_xlink_ids2);

	 // I had to put BIPV2.IDmacros.mac_IndexFetch2 in it's own macro because it can't be called twice in same scope
  fetchData(inp_ds, key, lvl) := functionmacro
     BIPV2.IDmacros.mac_IndexFetch2(inp_ds, key, ds_fetched, lvl);
     return ds_fetched;
  endmacro;
 
  ds_best_fetched := fetchData(inputs, BestKey, Level);
  ds_sbfe_fetched := fetchData(inputs, SBFEKey, Level);
	

  filterSrcCode(ds, permits, ds_src='', codeBmap) := functionmacro
    ds_filt := ds(permits & codeBmap <> 0);
    #IF(#TEXT(ds_src)='')
        return ds_filt;
    #ELSE
    // function instead of transform: need to check complicated SKIP condition.
    ds_filt xform (ds_filt L) := function
        ds_src_filt := L.ds_src (BIPV2.mod_sources.src2bmap(source) & codeBmap <> 0);
        ds_filt xTransform := transform, skip (~exists(ds_src_filt))
                                  self.ds_src := ds_src_filt;
                                  self := L;
                              end;
        return xTransform;
      end;
			 return project(ds_filt, xform(left)); //Using a SKIP in the transform was giving a syntax error and hence, had to use to this EXISTS filter condition
    #END
  endmacro;
	
  allowCodeBmap := BIPV2.mod_Sources.code2bmap(BIPV2.mod_Sources.code.MARKETING_UNRESTRICTED);

  recordof(ds_best_fetched) apply_src_filter(recordof(ds_best_fetched) L) := transform
    // NOTE: These filter the "sources" child dataset when applicable, but not all sections have that
    self.company_name			:= filterSrcCode(L.company_name,    company_name_data_permits,    sources, allowCodeBmap);
    self.company_address:= filterSrcCode(L.company_address, company_address_data_permits,        , allowCodeBmap);
    self.company_phone		:= filterSrcCode(L.company_phone,   company_phone_data_permits,          , allowCodeBmap);
    self.company_fein			:= filterSrcCode(L.company_fein,    company_fein_data_permits,    sources, allowCodeBmap);
    self.company_url			 := filterSrcCode(L.company_url,     company_url_data_permits,            , allowCodeBmap);
    self.company_incorporation_date := filterSrcCode(L.company_incorporation_date, company_incorporation_date_permits, sources, allowCodeBmap);
    self.dba_name       := filterSrcCode(L.dba_name,        dba_name_data_permits,               , allowCodeBmap);
    self := L;
  end;
	
  marketing_ds_best_fetched := project(ds_best_fetched, apply_src_filter(left));

  out_format := {recordof(ds_best_fetched) -fetch_error_code -uniqueid -powid -empid -dotid 
                -ultscore -orgscore -selescore -proxscore -powscore -empscore -dotscore
                -ultweight -orgweight -seleweight -proxweight -powweight -empweight -dotweight 
                -isactive -isdefunct};
  best_out      := project(ds_best_fetched, transform(out_format, self:=left));
  sbfe_out      := project(ds_sbfe_fetched, transform(out_format, self:=left));
  marketing_out := project(marketing_ds_best_fetched, transform(out_format, self:=left));

 
  rank1_slim_layout := {
     ds_best_fetched.ultid;
     ds_best_fetched.orgid;
     ds_best_fetched.seleid;
     ds_best_fetched.proxid;
     ds_best_fetched.company_name.company_name;
     {{ds_best_fetched.company_address} -address_v_city_name -county_name -company_address_data_permits -company_address_method};
     ds_best_fetched.company_phone.company_phone;
     ds_best_fetched.company_fein.company_fein;
     ds_best_fetched.company_url.company_url;
     ds_best_fetched.company_incorporation_date.company_incorporation_date;
     ds_best_fetched.duns_number.duns_number;
     ds_best_fetched.sic_code.company_sic_code1;
     ds_best_fetched.naics_code.company_naics_code1;
     ds_best_fetched.dba_name.dba_name;
     };

  rank1_slim_layout rank1SlimTrans(recordof(ds_best_fetched) l) := transform
    self.company_name := l.company_name[1].company_name;
    self.company_prim_range := l.company_address[1].company_prim_range;
    self.company_predir := l.company_address[1].company_predir;
    self.company_prim_name := l.company_address[1].company_prim_name;
    self.company_addr_suffix := l.company_address[1].company_addr_suffix;
    self.company_postdir := l.company_address[1].company_postdir;
    self.company_unit_desig := l.company_address[1].company_unit_desig;
    self.company_sec_range := l.company_address[1].company_sec_range;
    self.company_p_city_name := l.company_address[1].company_p_city_name;
    self.company_st := l.company_address[1].company_st;
    self.company_zip5 := l.company_address[1].company_zip5;
    self.company_zip4 := l.company_address[1].company_zip4;
    self.company_phone := l.company_phone[1].company_phone;
    self.company_fein := l.company_fein[1].company_fein;
    self.company_url := l.company_url[1].company_url;
    self.company_incorporation_date := l.company_incorporation_date[1].company_incorporation_date;
    self.duns_number := l.duns_number[1].duns_number;
    self.company_sic_code1 := l.sic_code[1].company_sic_code1;
    self.company_naics_code1 := l.naics_code[1].company_naics_code1;
    self.dba_name := l.dba_name[1].dba_name;
    self.company_locid := l.company_address[1].company_locid;
		self.address_dt_first_seen := l.company_address[1].address_dt_first_seen;
	  self.address_dt_last_seen := l.company_address[1].address_dt_last_seen;
    self := l;  
  end;

  best_slim_rec := project(ds_best_fetched, rank1SlimTrans(left)); 
  sbfe_slim_rec := project(ds_sbfe_fetched, rank1SlimTrans(left));  
  marketing_slim_rec := project(marketing_ds_best_fetched, rank1SlimTrans(left)); 
 
  result := parallel (
    // Echo what the user's inputs were
    output(input, named('input')),
  
    // Slim rank 1 output
    output(best_slim_rec(not(proxid<>0 and sele_level_only)), named('Best_Rank_1')),
    output(sbfe_slim_rec(not(proxid<>0 and sele_level_only)), named('SBFE_Rank_1')),
    output(marketing_slim_rec(not(proxid<>0 and sele_level_only)), named('Marketing_Rank_1')),
  
    // Full Best key output
    output(best_out(not(proxid<>0 and sele_level_only)), named('Best_Full')),
    output(sbfe_out(not(proxid<>0 and sele_level_only)), named('SBFE_Full')),
    output(marketing_out(not(proxid<>0 and sele_level_only)), named('Marketing_Full')),
    );

  RETURN result;
END;