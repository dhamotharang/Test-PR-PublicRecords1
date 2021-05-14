/*--SOAP--
<message name="ProxidCompareService">
<part name="ProxidOne" type="xsd:string"/>
<part name="ProxidTwo" type="xsd:string"/>
<part name="Superfile" type="xsd:string"/>
</message>
*/

/*--INFO-- Modified version of ProxidCompareService to show extra information.*/

EXPORT svc_proxid_compare_ext := MACRO

  IMPORT SALT311, BIPV2_ProxID, ut, tools, BIPV2_Build;

  STRING50  Proxid1Str := '1'     : STORED('ProxidOne');
  STRING20  Proxid2Str := '2'     : STORED('ProxidTwo');
  STRING10  version    := 'built' : STORED('Superfile'); // 'qa'

  UNSIGNED8 Proxidone   := IF( (UNSIGNED8)Proxid1Str>(UNSIGNED8)Proxid2Str, (UNSIGNED8)Proxid1Str, (UNSIGNED8)Proxid2Str );
  UNSIGNED8 Proxidtwo   := IF( (UNSIGNED8)Proxid1Str>(UNSIGNED8)Proxid2Str, (UNSIGNED8)Proxid2Str, (UNSIGNED8)Proxid1Str );

  BFile := BIPV2_ProxID.In_DOT_Base;
  kFile := BIPV2_ProxID.Keys(BFile,version,FALSE);

  odl   := PROJECT(CHOOSEN(KFile.Candidates(Proxid=Proxidone),100000),transform(BIPV2_ProxID.match_candidates(BFile).layout_candidates,self := left,self := []));
  odr   := PROJECT(CHOOSEN(KFile.Candidates(Proxid=ProxidTwo),100000),transform(BIPV2_ProxID.match_candidates(BFile).layout_candidates,self := left,self := []));
  k     := KFile.Specificities_Key;
  s     := GLOBAL(PROJECT(k,transform(BIPV2_ProxID.Layout_Specificities.R,self := left,self := []))[1]);
  odlv  := BIPV2_ProxID.Debug(BFile,s).RolledEntities(odl);
  odrv  := BIPV2_ProxID.Debug(BFile,s).RolledEntities(odr);

  BIPV2_ProxID.match_candidates(BFile).layout_attribute_matches ainto(KFile.Attribute_Matches le) := TRANSFORM
    SELF := le;
  END;

  am    := PROJECT(choosen(KFile.Attribute_Matches(Proxid1=Proxidone,Proxid2=Proxidtwo),10000)+choosen(KFile.Attribute_Matches(Proxid1=Proxidtwo,Proxid2=Proxidone),10000),ainto(LEFT));
  mtch  := BIPV2_ProxID.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,Proxidone,Proxidtwo,0,0}],BIPV2_ProxID.match_candidates(BFile).layout_matches),am);

  // get layout with the scores only for easier reading
  layouttools := tools.macf_LayoutTools(recordof(mtch),false,'^(?!.*?(left|right|skipped).*).*$',true);
  mtch_score := project(mtch,layouttools.layout_record);

  layspecs := {unsigned rid,string fieldname,string fieldvalue};
  dnorm_specs := normalize(mtch,count(layouttools.setAllFields),transform(layspecs
    ,self.fieldname 	:= layouttools.fGetFieldName(counter);
    ,self.fieldvalue	:= (string)layouttools.fGetFieldValue(counter,left)
    ,self.rid					:= counter
  ));
  dnorm_specs_filt := sort(dnorm_specs((unsigned)fieldvalue != 0),rid);

  ///////////
  //--norm all fields, trying to group them better into child datasets per field so easier to see
  ///////////
  layouttools2 := tools.macf_LayoutTools(recordof(mtch),false,'',true);
  mtch_score2  := project(mtch,layouttools2.layout_record);

  // layspecs := {unsigned rid,string fieldname,string fieldvalue};
  dnorm_specs2 := normalize(mtch,count(layouttools2.setAllFields),transform({unsigned rollupid,layspecs}
    ,self.fieldname 	:= layouttools2.fGetFieldName(counter);
    ,self.fieldvalue	:= (string)layouttools2.fGetFieldValue(counter,left)
    ,self.rid					:= counter
    ,self.rollupid    := 0;
  ));

  diterate          := iterate(sort(group(dnorm_specs2),rid),transform(recordof(left),self.rollupid := if(regexfind('^left_|^support_',right.fieldname,nocase) and not regexfind('^support_',left.fieldname,nocase),right.rid  ,left.rollupid ) ,self := right ));
  dproj             := project(diterate,transform({unsigned rid,unsigned rollupid,dataset(layspecs - rid) child},self := left,self.child := dataset([{left.fieldname,left.fieldvalue}],layspecs - rid)));
  drollup           := rollup(sort(dproj,rid),left.rollupid = right.rollupid,transform(recordof(left),self.child := left.child + right.child,self := left));
  dsortchild        := project(drollup,transform(recordof(left),self.child := sort(left.child,map(regexfind('^left_',fieldname,nocase) => 1, regexfind('^right_',fieldname,nocase) => 2,
  regexfind('_score$',fieldname,nocase) => 3,regexfind('_skipped$',fieldname,nocase) => 4,0)),self := left
  ));
  dsupports         := dsortchild(  exists(child(regexfind('^support_',fieldname,nocase))) )[1].child;
  dproj2            := project(dsortchild(not exists(child(regexfind('^support_',fieldname,nocase)))),transform(recordof(left),self.child := if(left.rid = 1,left.child + dsupports,left.child),self := left));
  dproj3            := project(sort(project(dproj2,transform({recordof(left),string score,string skipped},self.child   := left.child(not regexfind('_score$|_skipped$',fieldname,nocase))
                                                                                              ,self.score   := left.child(    regexfind('_score$'   ,fieldname,nocase))[1].fieldvalue
                                                                                              ,self.skipped := left.child(    regexfind('_skipped$' ,fieldname,nocase))[1].fieldvalue
                                                                                              ,self := left
                                                         )),rid),{recordof(left) - rid - rollupid});
  dnorm_specs_filt2 := dproj3(count(child(regexfind('^conf$',fieldname,nocase) or regexfind('cnp_name',fieldname,nocase))) >0 or (unsigned)score != 0);
  
// 24 24 right_hist_enterprise_number  
// 24 23 hist_enterprise_number_score 0 
// 23 22 left_hist_enterprise_number 

//PML Begin
//key_xwalk   := IF(version='qa', BIPV2_Build.BIPV2FullKeys_Package().Xlinksup_proxid.qa, BIPV2_Build.BIPV2FullKeys_Package().Xlinksup_proxid.built);
//key_linkids := IF(version='qa', BIPV2_Build.BIPV2FullKeys_Package().linkids.qa,         BIPV2_Build.BIPV2FullKeys_Package().linkids.built);
//key_hidden  := IF(version='qa', BIPV2_Build.BIPV2FullKeys_Package().linkids_hidden.qa,  BIPV2_Build.BIPV2FullKeys_Package().linkids_hidden.built);

key_lo      := { BIPV2_Build.BIPV2FullKeys_Package().linkids.built };
ext_lo      := { key_lo.proxid, key_lo.lgid3, key_lo.seleid, key_lo.ultid, key_lo.rcid, key_lo.source, //key_lo.ingest_status,
                 key_lo.cnp_name, key_lo.company_name, key_lo.corp_legal_name, key_lo.dba_name,
                 key_lo.fname, key_lo.mname, key_lo.lname,
                 key_lo.prim_range, key_lo.prim_name, key_lo.p_city_name, key_lo.v_city_name, key_lo.st, key_lo.zip,
                 key_lo.company_fein, key_lo.contact_ssn, key_lo.company_phone, key_lo.contact_phone, key_lo.company_url, key_lo.contact_email_domain,
                 key_lo.contact_dob, key_lo.contact_did, key_lo.vanity_owner_did,
                 key_lo.company_sic_code1, key_lo.company_sic_code2, key_lo.company_sic_code3, key_lo.company_sic_code4, key_lo.company_sic_code5,
                 key_lo.company_naics_code1, key_lo.company_naics_code2, key_lo.company_naics_code3, key_lo.company_naics_code4, key_lo.company_naics_code5,
                 key_lo.company_ticker, key_lo.vl_id, key_lo.dt_first_seen, key_lo.dt_last_seen };
val_lo      := { STRING val, UNSIGNED cnt };
roll_lo     := { key_lo.proxid, DATASET(val_lo) lgid3_vals, DATASET(val_lo) seleid_vals, DATASET(val_lo) ultid_vals,
                 DATASET(val_lo) cnp_name_vals, DATASET(val_lo) company_name_vals, DATASET(val_lo) legal_name_vals, DATASET(val_lo) dba_name_vals, 
                 DATASET(val_lo) per_name_vals, DATASET(val_lo) co_address_vals,
                 DATASET(val_lo) fein_vals, DATASET(val_lo) ssn_vals, DATASET(val_lo) co_phone_vals, DATASET(val_lo) per_phone_vals, DATASET(val_lo) co_url_vals, DATASET(val_lo) per_dom_vals,
                 DATASET(val_lo) per_dob_vals, DATASET(val_lo) per_did_vals, DATASET(val_lo) own_did_vals, DATASET(val_lo) co_sic_vals, DATASET(val_lo) co_naics_vals,
                 DATASET(val_lo) ticker_vals, DATASET(val_lo) vl_id_vals, UNSIGNED4 earliest_first_seen, UNSIGNED4 latest_last_seen };

get_ext(UNSIGNED8 proxid_in) := FUNCTION
  //ult_id      := key_xwalk  (proxid=proxid_in)[1].ultid;
  //key_data    := key_linkids(ultid=ult_id, proxid=proxid_in) + key_hidden(ultid=ult_id, proxid=proxid_in);
  ult_id      := IF(version='qa', BIPV2_Build.BIPV2FullKeys_Package().Xlinksup_proxid.qa   (proxid=proxid_in)[1].ultid,
                                  BIPV2_Build.BIPV2FullKeys_Package().Xlinksup_proxid.built(proxid=proxid_in)[1].ultid);
  key_data    := IF(version='qa', BIPV2_Build.BIPV2FullKeys_Package().linkids.qa   (ultid=ult_id, proxid=proxid_in) + BIPV2_Build.BIPV2FullKeys_Package().linkids_hidden.qa   (ultid=ult_id, proxid=proxid_in),
                                  BIPV2_Build.BIPV2FullKeys_Package().linkids.built(ultid=ult_id, proxid=proxid_in) + BIPV2_Build.BIPV2FullKeys_Package().linkids_hidden.built(ultid=ult_id, proxid=proxid_in));
 
  ext_raw     := PROJECT(key_data, ext_lo);
  ext_dedup   := DEDUP(SORT(ext_raw,EXCEPT rcid,source),EXCEPT rcid,source);

  ext_sic     := PROJECT(ext_raw(TRIM(company_sic_code1)  >''), TRANSFORM(val_lo, SELF.val:=LEFT.company_sic_code1,   SELF.cnt:=1)) +
                 PROJECT(ext_raw(TRIM(company_sic_code2)  >''), TRANSFORM(val_lo, SELF.val:=LEFT.company_sic_code2,   SELF.cnt:=1)) +
                 PROJECT(ext_raw(TRIM(company_sic_code3)  >''), TRANSFORM(val_lo, SELF.val:=LEFT.company_sic_code3,   SELF.cnt:=1)) +
                 PROJECT(ext_raw(TRIM(company_sic_code4)  >''), TRANSFORM(val_lo, SELF.val:=LEFT.company_sic_code4,   SELF.cnt:=1)) +
                 PROJECT(ext_raw(TRIM(company_sic_code5)  >''), TRANSFORM(val_lo, SELF.val:=LEFT.company_sic_code5,   SELF.cnt:=1));
  ext_naics   := PROJECT(ext_raw(TRIM(company_naics_code1)>''), TRANSFORM(val_lo, SELF.val:=LEFT.company_naics_code1, SELF.cnt:=1)) +
                 PROJECT(ext_raw(TRIM(company_naics_code2)>''), TRANSFORM(val_lo, SELF.val:=LEFT.company_naics_code2, SELF.cnt:=1)) +
                 PROJECT(ext_raw(TRIM(company_naics_code3)>''), TRANSFORM(val_lo, SELF.val:=LEFT.company_naics_code3, SELF.cnt:=1)) +
                 PROJECT(ext_raw(TRIM(company_naics_code4)>''), TRANSFORM(val_lo, SELF.val:=LEFT.company_naics_code4, SELF.cnt:=1)) +
                 PROJECT(ext_raw(TRIM(company_naics_code5)>''), TRANSFORM(val_lo, SELF.val:=LEFT.company_naics_code5, SELF.cnt:=1));
 
  tb_lgid3    := SORT(PROJECT(TABLE(ext_raw(     lgid3                   > 0), { STRING val:=lgid3,                UNSIGNED cnt:=COUNT(GROUP) }, lgid3,                FEW),val_lo),-cnt,val);
  tb_seleid   := SORT(PROJECT(TABLE(ext_raw(     seleid                  > 0), { STRING val:=seleid,               UNSIGNED cnt:=COUNT(GROUP) }, seleid,               FEW),val_lo),-cnt,val);
  tb_ultid    := SORT(PROJECT(TABLE(ext_raw(     ultid                   > 0), { STRING val:=ultid,                UNSIGNED cnt:=COUNT(GROUP) }, ultid,                FEW),val_lo),-cnt,val);
  tb_cnp      := SORT(PROJECT(TABLE(ext_raw(TRIM(cnp_name)               >''), { STRING val:=cnp_name,             UNSIGNED cnt:=COUNT(GROUP) }, cnp_name,             FEW),val_lo),-cnt,val);
  tb_co_name  := SORT(PROJECT(TABLE(ext_raw(TRIM(company_name)           >''), { STRING val:=company_name,         UNSIGNED cnt:=COUNT(GROUP) }, company_name,         FEW),val_lo),-cnt,val);
  tb_leg_name := SORT(PROJECT(TABLE(ext_raw(TRIM(corp_legal_name)        >''), { STRING val:=corp_legal_name,      UNSIGNED cnt:=COUNT(GROUP) }, corp_legal_name,      FEW),val_lo),-cnt,val);
  tb_dba_name := SORT(PROJECT(TABLE(ext_raw(TRIM(dba_name)               >''), { STRING val:=dba_name,             UNSIGNED cnt:=COUNT(GROUP) }, dba_name,             FEW),val_lo),-cnt,val);
  tb_name     := SORT(PROJECT(TABLE(ext_raw(TRIM(fname)>'' OR TRIM(lname)>''), { STRING val:=TRIM(fname)+' | '+TRIM(mname)+' | '+TRIM(lname), UNSIGNED cnt:=COUNT(GROUP) },
                                                                                             TRIM(fname)+' | '+TRIM(mname)+' | '+TRIM(lname), FEW),val_lo),-cnt,val);
  tb_address  := SORT(PROJECT(TABLE(ext_raw(TRIM(prim_name)              >''), { STRING val:=TRIM(prim_range)+' '+TRIM(prim_name)+', '+TRIM(p_city_name)+'/'+TRIM(v_city_name)+', '+TRIM(st)+' '+TRIM(zip), UNSIGNED cnt:=COUNT(GROUP) },
                                                                                             TRIM(prim_range)+' '+TRIM(prim_name)+', '+TRIM(p_city_name)+'/'+TRIM(v_city_name)+', '+TRIM(st)+' '+TRIM(zip), FEW),val_lo),-cnt,val);
  tb_fein     := SORT(PROJECT(TABLE(ext_raw(TRIM(company_fein)           >''), { STRING val:=company_fein,         UNSIGNED cnt:=COUNT(GROUP) }, company_fein,         FEW),val_lo),-cnt,val);
  tb_ssn      := SORT(PROJECT(TABLE(ext_raw(TRIM(contact_ssn)            >''), { STRING val:=contact_ssn,          UNSIGNED cnt:=COUNT(GROUP) }, contact_ssn,          FEW),val_lo),-cnt,val);
  tb_co_phone := SORT(PROJECT(TABLE(ext_raw(TRIM(company_phone)          >''), { STRING val:=company_phone,        UNSIGNED cnt:=COUNT(GROUP) }, company_phone,        FEW),val_lo),-cnt,val);
  tb_phone    := SORT(PROJECT(TABLE(ext_raw(TRIM(contact_phone)          >''), { STRING val:=contact_phone,        UNSIGNED cnt:=COUNT(GROUP) }, contact_phone,        FEW),val_lo),-cnt,val);
  tb_url      := SORT(PROJECT(TABLE(ext_raw(TRIM(company_url)            >''), { STRING val:=company_url,          UNSIGNED cnt:=COUNT(GROUP) }, company_url,          FEW),val_lo),-cnt,val);
  tb_dom      := SORT(PROJECT(TABLE(ext_raw(TRIM(contact_email_domain)   >''), { STRING val:=contact_email_domain, UNSIGNED cnt:=COUNT(GROUP) }, contact_email_domain, FEW),val_lo),-cnt,val);
  tb_dob      := SORT(PROJECT(TABLE(ext_raw(     contact_dob             > 0), { STRING val:=contact_dob,          UNSIGNED cnt:=COUNT(GROUP) }, contact_dob,          FEW),val_lo),-cnt,val);
  tb_did      := SORT(PROJECT(TABLE(ext_raw(     contact_did             > 0), { STRING val:=contact_did,          UNSIGNED cnt:=COUNT(GROUP) }, contact_did,          FEW),val_lo),-cnt,val);
  tb_odid     := SORT(PROJECT(TABLE(ext_raw(     vanity_owner_did        > 0), { STRING val:=vanity_owner_did,     UNSIGNED cnt:=COUNT(GROUP) }, vanity_owner_did,     FEW),val_lo),-cnt,val);
  tb_sic      := SORT(PROJECT(TABLE(ext_sic                                  , {        val,                       UNSIGNED cnt:=COUNT(GROUP) }, val,                  FEW),val_lo),-cnt,val);
  tb_naics    := SORT(PROJECT(TABLE(ext_naics                                , {        val,                       UNSIGNED cnt:=COUNT(GROUP) }, val,                  FEW),val_lo),-cnt,val);
  tb_ticker   := SORT(PROJECT(TABLE(ext_raw(TRIM(company_ticker)         >''), { STRING val:=company_ticker,       UNSIGNED cnt:=COUNT(GROUP) }, company_ticker,       FEW),val_lo),-cnt,val);
  tb_vl_id    := SORT(PROJECT(TABLE(ext_raw(TRIM(vl_id)                  >''), { STRING val:=TRIM(source)+':'+TRIM(vl_id), UNSIGNED cnt:=COUNT(GROUP) }, TRIM(source)+':'+TRIM(vl_id), FEW),val_lo),-cnt,val);

  ext_roll    := DATASET([{proxid_in, tb_lgid3, tb_seleid, tb_ultid, tb_cnp, tb_co_name, tb_leg_name, tb_dba_name, tb_name, tb_address,
                           tb_fein, tb_ssn, tb_co_phone, tb_phone, tb_url, tb_dom, tb_dob, tb_did, tb_odid, tb_sic, tb_naics, tb_ticker, tb_vl_id,
                           MIN(ext_raw(dt_first_seen>0),dt_first_seen), MAX(ext_raw,dt_last_seen)}],roll_lo);

  RETURN MODULE
    EXPORT raw       := ext_raw;
    EXPORT deduped   := ext_dedup;
    EXPORT rolled    := ext_roll;
  END;
END;

ext1 := get_ext(Proxidone);
ext2 := get_ext(Proxidtwo);
//PML End


  parallel(
     OUTPUT( dnorm_specs_filt2      ,NAMED('RecordMatchesNonZeroScores'),all)
    ,OUTPUT( odlv + odrv            ,NAMED('ProxidBothFieldValues'     ))
    ,OUTPUT( ext1.rolled + ext2.rolled,NAMED('ProxidBothExtraFieldValues'))
    // ,OUTPUT( odlv                   ,NAMED('ProxidOneFieldValues'      ))
    // ,OUTPUT( odrv                   ,NAMED('ProxidTwoFieldValues'      ))
//    ,OUTPUT( dproj3                 ,NAMED('RecordMatches'              ),all)
    ,OUTPUT( SORT(mtch       ,-Conf),NAMED('RecordMatches'             ))
    ,OUTPUT( SORT(mtch_score ,-Conf),NAMED('RecordMatchesScoreOnly'    ))
//    ,OUTPUT( odl + odr              ,NAMED('ProxidBothRecords'         ))
    ,OUTPUT( odl                    ,NAMED('ProxidOneRecords'          ))
    ,OUTPUT( odr                    ,NAMED('ProxidTwoRecords'          ))

    // ,OUTPUT( dnorm_specs2           ,NAMED('RecordMatchesNormScores2'   ),all)
    // ,OUTPUT( diterate               ,NAMED('RecordMatchesIterate'       ),all)
    // ,OUTPUT( dproj                  ,NAMED('RecordMatchesIProj'         ),all)
    // ,OUTPUT( drollup                ,NAMED('RecordMatchesRollup'        ),all)
    // ,OUTPUT( dsortchild             ,NAMED('RecordMatchesSort'          ),all)
    // ,OUTPUT( dsupports              ,NAMED('RecordMatchesSupports'      ),all)
    // ,OUTPUT( dproj2                 ,NAMED('RecordMatchesProj2'         ),all)
    // ,OUTPUT( dproj3                 ,NAMED('RecordMatchesProj3'         ),all)
  );

ENDMACRO;

