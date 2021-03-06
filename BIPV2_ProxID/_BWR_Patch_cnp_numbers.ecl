/*
wuid: W20130816-135301
dbaseqa     := BIPV2_ProxID.files().base.qa;
dbasebuilt  := BIPV2_ProxID.files().base.built;
output(count(dbaseqa    ) ,named('CountBaseQA'));
output(count(dbasebuilt ) ,named('CountBaseBuilt'));
output(count(dbaseqa    (cnp_number != '')) ,named('CountBaseQAWithCnpNumber'));
output(count(dbasebuilt (cnp_number != '')) ,named('CountBaseBuiltWithCnpNumber'));
*/
#workunit('name','BIPV2 Sprint 2 Patch CNP Numbers');
// allscoreslay :=  {integer2 conf 	,unsigned6 proxid1 	,unsigned6 proxid2 	,integer2 conf_prop 	,integer2 dateoverlap 	,unsigned6 rcid1 	,unsigned6 rcid2 	,integer2 attribute_conf 	,string matching_attributes 	,integer2 cnp_number_score 	,integer2 prim_range_score 	,integer2 prim_name_score 	,integer2 st_score 	,integer2 ebr_file_number_score 	,integer2 hist_enterprise_number_score 	,integer2 hist_domestic_corp_key_score 	,integer2 unk_corp_key_score 	,integer2 active_enterprise_number_score 	,integer2 active_domestic_corp_key_score 	,integer2 hist_duns_number_score 	,integer2 active_duns_number_score 	,integer2 company_fein_score 	,integer2 company_phone_score 	,integer2 foreign_corp_key_score 	,integer2 cnp_name_score 	,integer2 zip_score 	,integer2 company_csz_score 	,integer2 sec_range_score 	,integer2 v_city_name_score 	,integer2 cnp_btype_score 	,integer2 iscorp_score 	,integer2 company_addr1_score 	,integer2 company_address_score 	,unsigned2 support_cnp_name };
// diter41samples := wk_ut.get_DS_Result('W20130813-205557','AllSamplesScores',allscoreslay);
// diter41samples_norm := table(normalize(diter41samples,2,transform({unsigned6 proxid},self.proxid := choose(counter,left.proxid1,left.proxid2))),{proxid},proxid,few);
setsampleproxidsfromiter41 := [11035628449 ,1685435116 ,29441413 ,2188179335 ,11028170449 ,51825310 ,130090368 ,182937303 ,481837021 ,173749931 ,6770148373 ,3478826696 ,11098514849 ,306286179 ,735151919 ,360383829 ,11085652849 ,1198052621 ,11104526449 ,10903194661 ,10857502160 ,11102967649 ,265547184 ,10791150503 ,5839627928 ,481561089 ,846672185 ,4126977163 ,152295504 ,2665479085 ,1063474219 ,105346585 ,11083073249 ,103854597 ,11026642049 ,2967422309 ,11061649649 ,114444550 ,323401233 ,330592526 ,53181298 ,787674704 ,598401503 ,86132727 ,11026629249 ,11067446849 ,27917726 ,143018576 ,146961655 ,10882147843 ,11152432849 ,11613053650 ,2472275376 ,1686435344 ,295937063 ,712029767 ,104412416 ,133035261 ,11100464049 ,11036212449 ,138644006 ,11051035649 ,1445367246 ,3412667084 ,11045469649 ,54678258 ,908970263 ,278203035 ,10816835703 ,11087395249 ,74090213 ,347149424 ,165157564 ,77747451 ,176752306 ,10953233492 ,11101754449 ,151090091 ,926042903 ,1684374738 ,11994044450 ,11028123249 ,27934804 ,1686875240 ,12182038473 ,590634261 ,1318049985 ,659389267 ,439071165 ,11056914049 ,11045380049 ,11020310562 ,73335827 ,11091338849 ,479392922 ,658920347 ,11093075249 ,11087351649 ,791550719 ,152270871 ,10773537705 ,547703495 ,1684634366 ,11568334050 ,1434910677 ,1378878321 ,1232867196 ,105627754 ,5165263068 ,11024347873 ,4387845934 ,11003279888 ,10801630146 ,155764539 ,11093276849 ,106068842 ,887314748 ,77745139 ,11549398 ,127067652 ,10957110360 ,11040726449 ,11595658450 ,11035759649 ,7107335054 ,10876450903 ,11056911249 ,10902126851 ,226997764 ,11104527649 ,2332468675 ,227742582 ,7772716 ,22435383 ,10774757361 ,11067446449 ,10839228050 ,129349220 ,273417527 ,2466743469 ,4942513894 ,990969723 ,11073774049 ,11083074849 ,4307618695 ,247569193 ,13236899 ,1308743393 ,152624789 ,11089460049 ,11040728449 ,329590477 ,11080882449 ,11089462449 ,129297381 ,227320627 ,11102968049 ,3895660721 ,142088239 ,11077905249 ,11022454677 ,11061650049 ,109055379 ,59228902 ,3106654657 ,369992190 ,1446811291 ,3106653057 ,12465821 ,44519688 ,11106863249 ,11095702849 ,75829527 ,146492159 ,11031987249 ,3895661521 ,4250542711 ,11080882049 ,1002491842 ,4655124331 ,2915231069 ,2507173486 ,11087393649 ,11073772449 ,104842773 ,11051034849 ,45958249 ,1679928469 ,1556893459 ,159609472 ,733810033 ,11094576849 ,210133655 ,11594128101 ,10848189458 ,11031987649 ,190998099 ,4126979963 ,7158248200 ,1689657543 ,843462403 ,161354775 ,10845140965 ,3638815159 ,330043835 ,10882325824 ,11093076049 ,1131467878 ,11081125249 ,598587745];
//dbasebuilt  := BIPV2_ProxID.files('20130808_43').base.logical(proxid in setsampleproxidsfromiter41) : persist('~thor::persist::lbentley::BIPSprint2.dbasebuilt');
dbasebuilt  := BIPV2_ProxID.files('20130808_43').base.logical;
BIPV2_Company_Names.functions.mac_go(dbasebuilt, dpatched, rcid, company_name, false,false);
dpatched_persist  := dpatched : persist('~thor::persist::lbentley::BIPSprint2.patchcnp_number');
daggDotid         := tools.mac_AggregateFieldsPerID(dpatched_persist,dotid ,['cnp_number','cnp_name','company_name'],false);
dagg_badDotid     := daggDotid(count(cnp_numbers) > 1);
//break up dots
dbreakdots1 := dedup(join(dpatched_persist,project(dagg_badDotid,{unsigned6 dotid}),left.dotid = right.dotid,transform({unsigned6 rcid,unsigned6 dotid,string cnp_number,string cnp_name,string company_name},self := left)),record,all);
dbreakdots2 := group(sort(distribute(dbreakdots1,dotid),dotid,cnp_number,rcid,local),dotid,local);
dbreakdots3 := iterate(dbreakdots2,transform(recordof(left)
  ,self.rcid  := right.rcid
  ,self.dotid := map( left.dotid       = 0                 => right.dotid
                     ,left.cnp_number  = right.cnp_number  => left.dotid
                     ,left.cnp_number != right.cnp_number  => right.rcid  //reset dotid here
                     ,                                        right.dotid
  )
  ,self := right
  )
);
dbreakdots4 := group(sort(distribute(group(dbreakdots3),dotid),dotid,-cnp_number,rcid,local),dotid,local);
dbreakdots5 := iterate(dbreakdots4,transform(recordof(left)
  ,self.rcid  := right.rcid
  ,self.dotid := map( left.dotid       = 0                 => right.dotid
                     ,left.cnp_number  = right.cnp_number  => left.dotid
                     ,left.cnp_number != right.cnp_number  => right.rcid  //reset dotid here
                     ,                                        right.dotid
  )
  ,self := right
  )
);
salt26.MAC_Reassign_UID(dpatched_persist,dbreakdots5,dotid,rcid ,dsDotidPatched);
djoin_fixedbaddotids := join(distribute(dsDotidPatched,rcid),distribute(dbreakdots1,rcid),left.rcid = right.rcid,transform({recordof(left)},self := left),local);
daggfixeddotid        := project(tools.mac_AggregateFieldsPerID(djoin_fixedbaddotids,dotid,['cnp_number','cnp_name','company_name','rcid'],false),transform(recordof(left),self.rcids := sort(left.rcids,rcid),self := left));
//proxid stuff
daggProxid        := tools.mac_AggregateFieldsPerID(dsDotidPatched,proxid,['cnp_number','cnp_name','company_name'],false);
dagg_badProxid    := daggProxid(count(cnp_numbers) > 1);
//break up Proxs
dbreakproxs1 := dedup(join(dsDotidPatched,project(dagg_badProxid,{unsigned6 proxid}),left.proxid = right.proxid,transform({unsigned6 dotid,unsigned6 proxid,string cnp_number,string cnp_name,string company_name},self := left)),record,all);
dbreakproxs2 := group(sort(distribute(dbreakproxs1,proxid),proxid,cnp_number,dotid,local),proxid,local);
dbreakproxs3 := iterate(dbreakproxs2,transform(recordof(left)
  ,self.dotid  := right.dotid
  ,self.proxid := map(left.proxid      = 0                 => right.proxid
                     ,left.cnp_number  = right.cnp_number  => left.proxid
                     ,left.cnp_number != right.cnp_number  => right.dotid //reset proxid here
                     ,                                        right.proxid
  )
  ,self        := right
  )
);
dbreakproxs4 := group(sort(distribute(group(dbreakproxs3),proxid),proxid,-cnp_number,dotid,local),proxid,local);
dbreakproxs5 := iterate(dbreakproxs4,transform(recordof(left)
  ,self.dotid  := right.dotid
  ,self.proxid := map(left.proxid      = 0                 => right.proxid
                     ,left.cnp_number  = right.cnp_number  => left.proxid
                     ,left.cnp_number != right.cnp_number  => right.dotid //reset proxid here
                     ,                                        right.proxid
  )
  ,self        := right
  )
);
salt26.MAC_Reassign_UID(dsDotidPatched,dbreakproxs5,proxid,dotid ,dsproxidPatched);
dsproxidproj := project(dsproxidPatched,BIPV2_Files.layout_dotid);
newversion := bipv2.KeySuffix + 'a';
writefile   := tools.macf_writefile(BIPV2_ProxID.filenames(newversion).base.logical,dsproxidproj,poverwrite := true,pDescription := 'fix cnp_numbers, patch overlinked dotids and proxids');
promotefile := BIPV2_ProxID.promote(newversion).new2built;
dbasebeforepatch  := dbasebuilt;
dbaseafterpatch   := BIPV2_ProxID.files(newversion).base.logical;
duniquesbeforepatch := project(strata.macf_Uniques(dbasebeforepatch ,,,false,['dotid','proxid']),transform({string file,recordof(left)},self.file := 'BeforePatch';self := left));
duniquesafterpatch  := project(strata.macf_Uniques(dbaseafterpatch  ,,,false,['dotid','proxid']),transform({string file,recordof(left)},self.file := 'AfterPatch' ;self := left));
outputuniques := output(duniquesbeforepatch + duniquesafterpatch,all);
dotintegrity  := BIPV2_Tools.idIntegrity().custom(dbaseafterpatch,rcid,dotid ,'dot'  ,,true,proxid);
proxintegrity := BIPV2_Tools.idIntegrity().custom(dbaseafterpatch,rcid,proxid,'prox' ,true);
sequential(
   writefile
  ,parallel(
     promotefile
    ,outputuniques
    ,dotintegrity 
    ,proxintegrity
  )
);
djoin_fixedbadproxids := join(distribute(dsproxidPatched,dotid),distribute(table(dbreakproxs1,{dotid},dotid),dotid),left.dotid = right.dotid,transform({recordof(left)},self := left),local);
daggfixedProxid        := project(tools.mac_AggregateFieldsPerID(djoin_fixedbadproxids,proxid,['cnp_number','cnp_name','company_name','dotid'],false),transform(recordof(left),self.dotids := sort(left.dotids,dotid),self := left));
dproxidsbefore := count(table(dbasebuilt  ,{proxid},proxid));
ddotidsbefore  := count(table(dbasebuilt  ,{dotid},dotid));
dproxidsafter  := count(table(dsproxidPatched  ,{proxid},proxid));
ddotidsafter   := count(table(dsproxidPatched  ,{dotid},dotid));
countdpatched_persist := count(dpatched_persist );
countdaggDotid        := count(daggDotid        );
countdagg_badDotid    := count(dagg_badDotid    );
countdbreakdots1      := count(dbreakdots1      );
countdbreakdots2      := count(dbreakdots2      );
countdbreakdots3      := count(dbreakdots3      );
countdsDotidPatched   := count(dsDotidPatched   );
countdaggProxid       := count(daggProxid       );
countdagg_badProxid   := count(dagg_badProxid   );
countdbreakproxs1     := count(dbreakproxs1     );
countdbreakproxs2     := count(dbreakproxs2     );
countdbreakproxs3     := count(dbreakproxs3     );
countdsproxidPatched  := count(dsproxidPatched  );
countdproxidsbefore   := count(dproxidsbefore   );
countddotidsbefore    := count(ddotidsbefore    );
countdproxidsafter    := count(dproxidsafter    );
countddotidsafter     := count(ddotidsafter     );
output(countdpatched_persist ,named('countdpatched_persist'));
output(countdaggDotid        ,named('countdaggDotid'       ));
output(countdagg_badDotid    ,named('countdagg_badDotid'   ));
output(countdbreakdots1      ,named('countdbreakdots1'     ));
output(countdbreakdots2      ,named('countdbreakdots2'     ));
output(countdbreakdots3      ,named('countdbreakdots3'     ));
output(countdsDotidPatched   ,named('countdsDotidPatched'  ));
output(countdaggProxid       ,named('countdaggProxid'      ));
output(countdagg_badProxid   ,named('countdagg_badProxid'  ));
output(countdbreakproxs1     ,named('countdbreakproxs1'    ));
output(countdbreakproxs2     ,named('countdbreakproxs2'    ));
output(countdbreakproxs3     ,named('countdbreakproxs3'    ));
output(countdsproxidPatched  ,named('countdsproxidPatched' ));
output(countdproxidsbefore   ,named('countdproxidsbefore'  ));
output(countddotidsbefore    ,named('countddotidsbefore'   ));
output(countdproxidsafter    ,named('countdproxidsafter'   ));
output(countddotidsafter     ,named('countddotidsafter'    ));
output(dpatched_persist ,named('dpatched_persist'));
output(daggDotid        ,named('daggDotid'       ));
output(dagg_badDotid    ,named('dagg_badDotid'   ));
output(daggfixeddotid    ,named('daggfixeddotid'   ));
output(dbreakdots1      ,named('dbreakdots1'     ));
output(dbreakdots2      ,named('dbreakdots2'     ));
output(dbreakdots3      ,named('dbreakdots3'     ));
output(dsDotidPatched   ,named('dsDotidPatched'  ));
output(daggProxid       ,named('daggProxid'      ));
output(dagg_badProxid   ,named('dagg_badProxid'  ));
output(daggfixedProxid   ,named('daggfixedProxid'  ));
output(dbreakproxs1     ,named('dbreakproxs1'    ));
output(dbreakproxs2     ,named('dbreakproxs2'    ));
output(dbreakproxs3     ,named('dbreakproxs3'    ));
output(dsproxidPatched  ,named('dsproxidPatched' ));
output(dproxidsbefore   ,named('dproxidsbefore'  ));
output(ddotidsbefore    ,named('ddotidsbefore'   ));
output(dproxidsafter    ,named('dproxidsafter'   ));
output(ddotidsafter     ,named('ddotidsafter'    ));
