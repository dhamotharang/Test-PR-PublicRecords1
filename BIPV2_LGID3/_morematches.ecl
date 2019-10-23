import tools,BIPV2_Files,BIPV2_LGID3;

ih                      := BIPV2_LGID3.In_LGID3;
psetReviewers					  := ['TL','CM','LB','DW'];
pNumSamplesPerReviewer	:= 150;
ConfThreshold					  := '41';
kmtch									  := BIPV2_LGID3.Keys(ih).MatchSample;
kcand									  := BIPV2_LGID3.Keys(ih).Candidates;
outputecl               := true;
xtraMatchFilter         := 'company_inc_state_score <= 0';
lFractionAtThreshold    := 1.0                         ;

// out										  := tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_LGID3.In_LGID3,lgid3,ConfThreshold,pNumSamplesPerReviewer,psetReviewers,outputecl,lFractionAtThreshold);

// out;
kmatchsample    := kmtch;
kmatchsample_eq := kmatchsample(conf = 41);
kmatchsample_gt := kmatchsample(conf > 41);
//do 2/3 recs at threshold, 1/3 above threshold
countReviewers := 4;
totalSamples := 150 * countReviewers;
countkmatchsample_eq  := count(kmatchsample_eq);
countkmatchsample_gt  := count(kmatchsample_gt);
samplesatthreshold          := if((unsigned)(totalsamples * lFractionAtThreshold)      >= countkmatchsample_eq  ,countkmatchsample_eq   ,(unsigned)(totalsamples * lFractionAtThreshold)      );
samplesabovethreshold       := if((totalSamples - samplesatthreshold) >  countkmatchsample_gt  ,countkmatchsample_gt   ,(totalSamples - samplesatthreshold) );
samplerecseq      := iff(samplesatthreshold    != 0 ,enth (kmatchsample_eq,samplesatthreshold     ) ,dataset([],recordof(kmatchsample_eq))) : independent;
samplerecsgt      := iff(samplesabovethreshold != 0 ,enth (kmatchsample_gt,samplesabovethreshold  ) ,dataset([],recordof(kmatchsample_gt))) : independent;

allsamplerecs     := sort(samplerecseq + samplerecsgt,lgid31 + lgid32);
totalsamplesreal  := samplesatthreshold + samplesabovethreshold;         

samplesperreviewer  := (unsigned)totalsamplesreal / countReviewers;
samplesremainder    := totalsamplesreal % countReviewers;          

allsampleproxids :=   table(table(samplerecseq + samplerecsgt  ,{unsigned6 lgid3 := lgid31})
                          + table(samplerecseq + samplerecsgt  ,{unsigned6 lgid3 := lgid32})
                      ,{lgid3},lgid3,few);
setsampleproxids  := set(allsampleproxids  ,lgid3);
allproxidcands    := project(kcand(lgid3 in setsampleproxids)  ,BIPV2_LGID3.match_candidates(BIPV2_LGID3.In_LGID3).layout_candidates);
kspec						  := BIPV2_LGID3.Keys(ih).Specificities_Key;
s := project(kspec,BIPV2_LGID3.Layout_Specificities.R)[1];
// s := dataset([],BIPV2_LGID3.Layout_Specificities.R);  //hack
//s := project(dataset([{''}],{string stuff}),transform(BIPV2_LGID3.Layout_Specificities.R,self := []));  //hack
allproxidsrolled := BIPV2_LGID3.Debug(BIPV2_LGID3.In_LGID3,s).RolledEntities(allproxidcands);
layrolled := recordof(allproxidsrolled);


//////// -- hack
dmtches := project(allsamplerecs,transform(BIPV2_LGID3.match_candidates(BIPV2_LGID3.In_LGID3).layout_matches,self.LGID31 := left.lgid31,self.LGID32 := left.lgid32,self := []));
// DATASET([{0,0,0,0,LGID3one,LGID3two,0,0}],BIPV2_LGID3.match_candidates(BIPV2_LGID3.In_LGID3).layout_matches);


emptySet := dataset([],BIPV2_Files.files_lgid3.Layout_LGID3);
BIPV2_LGID3.match_candidates(emptySet).layout_attribute_matches ainto(BIPV2_LGID3.Keys(emptySet).Attribute_Matches le) := TRANSFORM
	SELF := le;
END;


setLgid3s := set(allproxidcands, LGID3);
am := PROJECT(BIPV2_LGID3.Keys(emptySet).Attribute_Matches(LGID31 in setLgid3s and LGID32 in setLgid3s),ainto(LEFT));
mtch := BIPV2_LGID3.Debug(BIPV2_LGID3.In_LGID3,s).AnnotateMatchesFromData(allproxidcands,dmtches,am );
mtch_score2  := project(mtch,transform({unsigned rid,recordof(left)},self.rid := counter,self := left));

  layspecs := {unsigned rid,string fieldname,string fieldvalue};
  layouttools2 := tools.macf_LayoutTools(recordof(mtch_score2),false,'^(?!rid).*$',true);

  // layspecs := {unsigned rid,string fieldname,string fieldvalue};
  dnorm_specs2 := normalize(mtch_score2,count(layouttools2.setAllFields),transform({unsigned rollupid,layspecs}
    ,self.fieldname 	:= layouttools2.fGetFieldName(counter);
    ,self.fieldvalue	:= (string)layouttools2.fGetFieldValue(counter,left)
    ,self.rid					:= left.rid
    ,self.rollupid    := counter;
  ));

// -- try this

  layouttools3 := tools.macf_LayoutTools(recordof(mtch_score2),false,'^(?!.*?(left|right|skipped|_score).*).*$',true);
  mtch_score3 := project(mtch_score2,layouttools3.layout_record);
//conf lgid31 lgid32 conf prop dateoverlap rcid1 rcid2 left company inc state 

// -- try this


  // diterate          := iterate(sort(group(dnorm_specs2),rid,rollupid),transform(recordof(left),self.rollupid := if(regexfind('^left_|^support_|^conf$',right.fieldname,nocase) and not regexfind('^support_',left.fieldname,nocase),right.rollupid  ,left.rollupid ) ,self := right ));
  diterate          := iterate(sort(group(dnorm_specs2),rid,rollupid),transform(recordof(left)
                         ,self.rollupid := map(regexfind('^left_|^conf$',right.fieldname,nocase) and not regexfind('^support_',left.fieldname,nocase) => right.rollupid  
                                          ,regexfind('^support_',left.fieldname + right.fieldname,nocase) => 1
                                          ,left.rollupid 
                         ) 
                         ,self := right ));
  dproj             := project(diterate,transform(
                           {unsigned rid,unsigned rollupid,dataset(layspecs) child}
                          ,self := left
                          ,self.child := dataset([{left.rollupid,left.fieldname,left.fieldvalue}],layspecs)
                       ));
                       
  drollup           := rollup(sort(dproj,rid,rollupid),left.rid = right.rid,transform(recordof(left),self.child := left.child + right.child,self := left));
  // rollup child dataset now
  dprojme := project(drollup,transform(
      {unsigned rid,unsigned rollupid,dataset({unsigned rid,dataset(layspecs - rid) child}) child}
      ,self.rid       := left.rid
      ,self.rollupid  := left.rollupid
      ,self.child     := project(left.child
                            ,transform(
                              {unsigned rid,dataset(layspecs - rid) child}
                              ,self.rid   := left.rid
                              ,self.child := dataset([{left.fieldname,left.fieldvalue}],{layspecs - rid}))) 
  ));
  //
  drollup2 := project(dprojme,transform(recordof(left)
    ,self.child := rollup(left.child,left.rid = right.rid,transform(recordof(left),self.child := left.child + right.child,self := left))
    ,self := left
  ));
  
  dsortchild        := project(drollup2,transform(recordof(left)
    ,self.child := project(left.child,transform(recordof(left),self.child := 
                   sort(left.child  ,map(regexfind('^left_'   ,fieldname,nocase) => 1
                                        ,regexfind('^right_'  ,fieldname,nocase) => 2
                                        ,regexfind('_score$'  ,fieldname,nocase) => 3
                                        ,regexfind('_skipped$',fieldname,nocase) => 4
                                        ,                                           0
                                    ))
                                    ,self := left
                  ))
   ,self := left
  ));

  dproj3            := project(sort(project(dsortchild,transform(
                        {unsigned rid,unsigned rollupid,dataset({unsigned rid,dataset(layspecs - rid) child,string score,string skipped}) child}
                        ,self.child   := project(left.child,transform({unsigned rid,dataset(layspecs - rid) child,string score,string skipped}
                                            ,self.child   := left.child(not regexfind('_score$|_skipped$',fieldname,nocase))
                                            ,self.score   := left.child(    regexfind('_score$'   ,fieldname,nocase))[1].fieldvalue
                                            ,self.skipped := left.child(    regexfind('_skipped$' ,fieldname,nocase))[1].fieldvalue
                                            ,self.rid     := left.rid
                                         ))

                        ,self := left
                                                         )),rid,rollupid),{recordof(left)/* - rid - rollupid*/});
 
  dnorm_specs_filt2 := project(dproj3,transform(
                        {unsigned rid,unsigned rollupid,dataset({dataset(layspecs - rid) child,string score,string skipped}) child}
    ,self.child := project(left.child((unsigned)score != 0),recordof(left) - rid)
//    ,self.child := left.child(count(child(regexfind('^conf$',fieldname,nocase))) >0 or (unsigned)score != 0)
    ,self := left
  ));
  
  djoinme := join(dnorm_specs_filt2,mtch_score3,left.rid = right.rid,transform({recordof(right) - rid,recordof(left) - rid - rollupid},self := right,self := left));
  
  dnorm2 := normalize(djoinme,2,transform(recordof(left),self := if(counter = 1,left,dataset([],recordof(left))[1])));
  // dnorm_specs_filt2 := dproj3(count(child(regexfind('^conf$',fieldname,nocase))) >0 or (unsigned)score != 0);

  //more than 1 record here, so need more than 1 supports
  // dsupports         := dsortchild(  exists(child(regexfind('^support_',fieldname,nocase))) )[1].child;
   // dproj2            := project(dsortchild  
                          // ,transform(recordof(left)
                            // ,self.child := if(left.rollupid = 1,left.child + dsupports,left.child)
                            // ,self.child := project(left.child,transform(recordof(left),self.child := if(left.rid = 1,left.child + ))
                            // ,self := left
                        // ));

   // dproj2            := project(dsortchild(not exists(
                                                  // child(
                                                    // regexfind('^support_',fieldname,nocase) 
                                                  // )
                                               // )
                                           // )     
                          // ,transform(recordof(left)
                            // ,self.child := if(left.rollupid = 1,left.child + dsupports,left.child)
                            // ,self := left
                        // ));
  // dproj3            := project(sort(project(dproj2,transform({recordof(left),string score,string skipped},self.child   := left.child(not regexfind('_score$|_skipped$',fieldname,nocase))
                                                                                              // ,self.score   := left.child(    regexfind('_score$'   ,fieldname,nocase))[1].fieldvalue
                                                                                              // ,self.skipped := left.child(    regexfind('_skipped$' ,fieldname,nocase))[1].fieldvalue
                                                                                              // ,self := left
                                                         // )),rid,rollupid),{recordof(left) - rid - rollupid});
  // dnorm_specs_filt2 := dproj3(count(child(regexfind('^conf$',fieldname,nocase))) >0 or (unsigned)score != 0);

//////// -- end hack


mapremainder(unsigned previewer) := 
map(
   samplesremainder  = 0 => 0         
  ,previewer         = 1 and samplesremainder >= 1  => 1
  ,previewer         = 2 and samplesremainder >= 2  => 1
  ,previewer         = 3 and samplesremainder >= 3  => 1
  ,previewer         = 4 and samplesremainder >= 4  => 1
  ,0
);

startrec1   := 1    ;
startrec2   := startrec1 + samplesperreviewer + mapremainder(1);
startrec3   := startrec2 + samplesperreviewer + mapremainder(2);
startrec4   := startrec3 + samplesperreviewer + mapremainder(3);

TL := choosen(allsamplerecs,samplesperreviewer + mapremainder(1),startrec1 );
CM := choosen(allsamplerecs,samplesperreviewer + mapremainder(2),startrec2 );
LB := choosen(allsamplerecs,samplesperreviewer + mapremainder(3),startrec3 );
DW := choosen(allsamplerecs,samplesperreviewer + mapremainder(4),startrec4 );

TL_norm := project(normalize(TL,3,transform( {		 integer2 conf 	,integer2 conf_prop ,typeof(kcand.lgid3) lgid3},self.lgid3 := choose(counter  ,left.lgid31,left.lgid32,0),self.conf := left.conf,self.conf_prop := left.conf_prop)) ,transform({unsigned cnt,recordof(left)},self.cnt := counter + ((startrec1 - 1) * 3),self := left));
CM_norm := project(normalize(CM,3,transform( {		 integer2 conf 	,integer2 conf_prop ,typeof(kcand.lgid3) lgid3},self.lgid3 := choose(counter  ,left.lgid31,left.lgid32,0),self.conf := left.conf,self.conf_prop := left.conf_prop)) ,transform({unsigned cnt,recordof(left)},self.cnt := counter + ((startrec2 - 1) * 3),self := left));
LB_norm := project(normalize(LB,3,transform( {		 integer2 conf 	,integer2 conf_prop ,typeof(kcand.lgid3) lgid3},self.lgid3 := choose(counter  ,left.lgid31,left.lgid32,0),self.conf := left.conf,self.conf_prop := left.conf_prop)) ,transform({unsigned cnt,recordof(left)},self.cnt := counter + ((startrec3 - 1) * 3),self := left));
DW_norm := project(normalize(DW,3,transform( {		 integer2 conf 	,integer2 conf_prop ,typeof(kcand.lgid3) lgid3},self.lgid3 := choose(counter  ,left.lgid31,left.lgid32,0),self.conf := left.conf,self.conf_prop := left.conf_prop)) ,transform({unsigned cnt,recordof(left)},self.cnt := counter + ((startrec4 - 1) * 3),self := left));

TL_rolled := sort(join(TL_norm ,allproxidsrolled ,left.lgid3 = right.lgid3 ,transform({unsigned cnt,integer2 conf,recordof(right)},self.cnt := left.cnt,self.conf := if(right.lgid3 != 0  ,left.conf,0),self := right),left outer,lookup),cnt);
CM_rolled := sort(join(CM_norm ,allproxidsrolled ,left.lgid3 = right.lgid3 ,transform({unsigned cnt,integer2 conf,recordof(right)},self.cnt := left.cnt,self.conf := if(right.lgid3 != 0  ,left.conf,0),self := right),left outer,lookup),cnt);
LB_rolled := sort(join(LB_norm ,allproxidsrolled ,left.lgid3 = right.lgid3 ,transform({unsigned cnt,integer2 conf,recordof(right)},self.cnt := left.cnt,self.conf := if(right.lgid3 != 0  ,left.conf,0),self := right),left outer,lookup),cnt);
DW_rolled := sort(join(DW_norm ,allproxidsrolled ,left.lgid3 = right.lgid3 ,transform({unsigned cnt,integer2 conf,recordof(right)},self.cnt := left.cnt,self.conf := if(right.lgid3 != 0  ,left.conf,0),self := right),left outer,lookup),cnt);

allrolled := sort(
	  TL_rolled	+ CM_rolled	+ LB_rolled	+ DW_rolled	,cnt)	;
TL_Score  := project(TL, {		 integer2 conf 	,unsigned6 lgid31 	,unsigned6 lgid32 	,integer2 conf_prop 	,integer2 dateoverlap 	,unsigned6 rcid1 	,unsigned6 rcid2 	,integer2 company_inc_state_score 	,integer2 company_name_score 	,integer2 duns_number_score 	,integer2 company_fein_score 	,integer2 company_charter_number_score 	,integer2 cnp_number_score 	,integer2 cnp_btype_score } );
TL_Fields := project(TL, {		 string2 left_company_inc_state 	,boolean company_inc_state_skipped 	,string2 right_company_inc_state 	,string500 left_company_name  	,string500 right_company_name 	,string9 left_duns_number 	,string9 right_duns_number 	,string9 left_company_fein 	,string9 right_company_fein 	,string32 left_company_charter_number 	,string32 right_company_charter_number 	,string30 left_cnp_number 	,boolean cnp_number_skipped 	,string30 right_cnp_number 	,string10 left_cnp_btype 	,string10 right_cnp_btype 	,unsigned3 left_nodes_total 	,unsigned3 right_nodes_total 	,string9 left_active_duns_number 	,string9 right_active_duns_number 	,string9 left_hist_duns_number 	,string9 right_hist_duns_number 	,string30 left_active_domestic_corp_key 	,string30 right_active_domestic_corp_key 	,string30 left_hist_domestic_corp_key 	,string30 right_hist_domestic_corp_key 	,string30 left_foreign_corp_key 	,string30 right_foreign_corp_key 	,string30 left_unk_corp_key 	,string30 right_unk_corp_key 	,string250 left_cnp_name 	,string250 right_cnp_name 	,string1 left_cnp_hasnumber 	,string1 right_cnp_hasnumber 	,string20 left_cnp_lowv 	,string20 right_cnp_lowv 	,boolean left_cnp_translated 	,boolean right_cnp_translated 	,integer4 left_cnp_classid 	,integer4 right_cnp_classid 	,string10 left_prim_range 	,string10 right_prim_range 	,string28 left_prim_name 	,string28 right_prim_name 	,string8 left_sec_range 	,string8 right_sec_range 	,string25 left_v_city_name 	,string25 right_v_city_name 	,string2 left_st 	,string2 right_st 	,string5 left_zip 	,string5 right_zip 	,unsigned4 left_dt_first_seen 	,unsigned4 right_dt_first_seen 	,unsigned4 left_dt_last_seen 	,unsigned4 right_dt_last_seen } );
CM_Score  := project(CM, {		 integer2 conf 	,unsigned6 lgid31 	,unsigned6 lgid32 	,integer2 conf_prop 	,integer2 dateoverlap 	,unsigned6 rcid1 	,unsigned6 rcid2 	,integer2 company_inc_state_score 	,integer2 company_name_score 	,integer2 duns_number_score 	,integer2 company_fein_score 	,integer2 company_charter_number_score 	,integer2 cnp_number_score 	,integer2 cnp_btype_score } );
CM_Fields := project(CM, {		 string2 left_company_inc_state 	,boolean company_inc_state_skipped 	,string2 right_company_inc_state 	,string500 left_company_name 	 	,string500 right_company_name 	,string9 left_duns_number 	,string9 right_duns_number 	,string9 left_company_fein 	,string9 right_company_fein 	,string32 left_company_charter_number 	,string32 right_company_charter_number 	,string30 left_cnp_number 	,boolean cnp_number_skipped 	,string30 right_cnp_number 	,string10 left_cnp_btype 	,string10 right_cnp_btype 	,unsigned3 left_nodes_total 	,unsigned3 right_nodes_total 	,string9 left_active_duns_number 	,string9 right_active_duns_number 	,string9 left_hist_duns_number 	,string9 right_hist_duns_number 	,string30 left_active_domestic_corp_key 	,string30 right_active_domestic_corp_key 	,string30 left_hist_domestic_corp_key 	,string30 right_hist_domestic_corp_key 	,string30 left_foreign_corp_key 	,string30 right_foreign_corp_key 	,string30 left_unk_corp_key 	,string30 right_unk_corp_key 	,string250 left_cnp_name 	,string250 right_cnp_name 	,string1 left_cnp_hasnumber 	,string1 right_cnp_hasnumber 	,string20 left_cnp_lowv 	,string20 right_cnp_lowv 	,boolean left_cnp_translated 	,boolean right_cnp_translated 	,integer4 left_cnp_classid 	,integer4 right_cnp_classid 	,string10 left_prim_range 	,string10 right_prim_range 	,string28 left_prim_name 	,string28 right_prim_name 	,string8 left_sec_range 	,string8 right_sec_range 	,string25 left_v_city_name 	,string25 right_v_city_name 	,string2 left_st 	,string2 right_st 	,string5 left_zip 	,string5 right_zip 	,unsigned4 left_dt_first_seen 	,unsigned4 right_dt_first_seen 	,unsigned4 left_dt_last_seen 	,unsigned4 right_dt_last_seen } );
LB_Score  := project(LB, {		 integer2 conf 	,unsigned6 lgid31 	,unsigned6 lgid32 	,integer2 conf_prop 	,integer2 dateoverlap 	,unsigned6 rcid1 	,unsigned6 rcid2 	,integer2 company_inc_state_score 	,integer2 company_name_score 	,integer2 duns_number_score 	,integer2 company_fein_score 	,integer2 company_charter_number_score 	,integer2 cnp_number_score 	,integer2 cnp_btype_score } );
LB_Fields := project(LB, {		 string2 left_company_inc_state 	,boolean company_inc_state_skipped 	,string2 right_company_inc_state 	,string500 left_company_name 	 	,string500 right_company_name 	,string9 left_duns_number 	,string9 right_duns_number 	,string9 left_company_fein 	,string9 right_company_fein 	,string32 left_company_charter_number 	,string32 right_company_charter_number 	,string30 left_cnp_number 	,boolean cnp_number_skipped 	,string30 right_cnp_number 	,string10 left_cnp_btype 	,string10 right_cnp_btype 	,unsigned3 left_nodes_total 	,unsigned3 right_nodes_total 	,string9 left_active_duns_number 	,string9 right_active_duns_number 	,string9 left_hist_duns_number 	,string9 right_hist_duns_number 	,string30 left_active_domestic_corp_key 	,string30 right_active_domestic_corp_key 	,string30 left_hist_domestic_corp_key 	,string30 right_hist_domestic_corp_key 	,string30 left_foreign_corp_key 	,string30 right_foreign_corp_key 	,string30 left_unk_corp_key 	,string30 right_unk_corp_key 	,string250 left_cnp_name 	,string250 right_cnp_name 	,string1 left_cnp_hasnumber 	,string1 right_cnp_hasnumber 	,string20 left_cnp_lowv 	,string20 right_cnp_lowv 	,boolean left_cnp_translated 	,boolean right_cnp_translated 	,integer4 left_cnp_classid 	,integer4 right_cnp_classid 	,string10 left_prim_range 	,string10 right_prim_range 	,string28 left_prim_name 	,string28 right_prim_name 	,string8 left_sec_range 	,string8 right_sec_range 	,string25 left_v_city_name 	,string25 right_v_city_name 	,string2 left_st 	,string2 right_st 	,string5 left_zip 	,string5 right_zip 	,unsigned4 left_dt_first_seen 	,unsigned4 right_dt_first_seen 	,unsigned4 left_dt_last_seen 	,unsigned4 right_dt_last_seen } );
DW_Score  := project(DW, {		 integer2 conf 	,unsigned6 lgid31 	,unsigned6 lgid32 	,integer2 conf_prop 	,integer2 dateoverlap 	,unsigned6 rcid1 	,unsigned6 rcid2 	,integer2 company_inc_state_score 	,integer2 company_name_score 	,integer2 duns_number_score 	,integer2 company_fein_score 	,integer2 company_charter_number_score 	,integer2 cnp_number_score 	,integer2 cnp_btype_score } );
DW_Fields := project(DW, {		 string2 left_company_inc_state 	,boolean company_inc_state_skipped 	,string2 right_company_inc_state 	,string500 left_company_name 	 	,string500 right_company_name 	,string9 left_duns_number 	,string9 right_duns_number 	,string9 left_company_fein 	,string9 right_company_fein 	,string32 left_company_charter_number 	,string32 right_company_charter_number 	,string30 left_cnp_number 	,boolean cnp_number_skipped 	,string30 right_cnp_number 	,string10 left_cnp_btype 	,string10 right_cnp_btype 	,unsigned3 left_nodes_total 	,unsigned3 right_nodes_total 	,string9 left_active_duns_number 	,string9 right_active_duns_number 	,string9 left_hist_duns_number 	,string9 right_hist_duns_number 	,string30 left_active_domestic_corp_key 	,string30 right_active_domestic_corp_key 	,string30 left_hist_domestic_corp_key 	,string30 right_hist_domestic_corp_key 	,string30 left_foreign_corp_key 	,string30 right_foreign_corp_key 	,string30 left_unk_corp_key 	,string30 right_unk_corp_key 	,string250 left_cnp_name 	,string250 right_cnp_name 	,string1 left_cnp_hasnumber 	,string1 right_cnp_hasnumber 	,string20 left_cnp_lowv 	,string20 right_cnp_lowv 	,boolean left_cnp_translated 	,boolean right_cnp_translated 	,integer4 left_cnp_classid 	,integer4 right_cnp_classid 	,string10 left_prim_range 	,string10 right_prim_range 	,string28 left_prim_name 	,string28 right_prim_name 	,string8 left_sec_range 	,string8 right_sec_range 	,string25 left_v_city_name 	,string25 right_v_city_name 	,string2 left_st 	,string2 right_st 	,string5 left_zip 	,string5 right_zip 	,unsigned4 left_dt_first_seen 	,unsigned4 right_dt_first_seen 	,unsigned4 left_dt_last_seen 	,unsigned4 right_dt_last_seen } );

AllCands  := 
	  TL	+ CM	+ LB	+ DW	;
AllScores := 
	  TL_score	+ CM_score	+ LB_score	+ DW_score	;
return PARALLEL(
	 output(count(kmatchsample   ) ,named('TotalMatchSamples'   ))
	,output(count(kmatchsample_eq) ,named('TotalMatchSamplesEqualToThreshold'))
	,output(count(kmatchsample_gt) ,named('TotalMatchSamplesGreaterThanThreshold'))
  ,output(mtch              ,named('mtch'             ),all)
  ,output(mtch_score2       ,named('mtch_score2'      ),all)
  ,output(dnorm_specs2      ,named('dnorm_specs2'     ),all)
  ,output(diterate          ,named('diterate'         ),all)
  ,output(dproj             ,named('dproj'            ),all)
  ,output(drollup           ,named('drollup'          ),all)
  ,output(dprojme           ,named('dprojme'          ),all)
  ,output(drollup2           ,named('drollup2'          ),all)
  ,output(dsortchild        ,named('dsortchild'       ),all)
  // ,output(dsupports         ,named('dsupports'        ),all)
  // ,output(dproj2            ,named('dproj2'           ),all)
  ,output(dproj3            ,named('dproj3'           ),all)
  ,output(dnorm_specs_filt2 ,named('dnorm_specs_filt2'),all)
  ,output(dnorm2 ,named('dnorm2'),all)
  ,output(mtch_score3 ,named('mtch_score3'))
  ,output(djoinme ,named('djoinme'))

	,output('-----------------------------------' ,named('_'))
	,output('2 recs per Matching Pair, + 1 blank rec for separation' ,named('RolledUpViewsOfSamplesFollows'))
	,output(allrolled ,named('AllSamplesCombined'),all)
	,output(TL_rolled       ,named('TL'     ),all)
	,output(CM_rolled       ,named('CM'     ),all)
	,output(LB_rolled       ,named('LB'     ),all)
	,output(DW_rolled       ,named('DW'     ),all)
	,output('-----------------------------------' ,named('___'))
	,output('Full Match Candidates Record, then just the score' ,named('DetailedMatchingInfoFollows'))
	,output(AllCands  ,named('AllSamplesCands'),all)
	,output(AllScores ,named('AllSamplesScores'),all)
	,output('-----------------------------------' ,named('____'))
	,output(TL         ,named('TL_cands'       ),all)
	,output(TL_score   ,named('TL_scores'),all)
	,output('-----------------------------------' ,named('_____'))
	,output(CM         ,named('CM_cands'       ),all)
	,output(CM_score   ,named('CM_scores'),all)
	,output('-----------------------------------' ,named('______'))
	,output(LB         ,named('LB_cands'       ),all)
	,output(LB_score   ,named('LB_scores'),all)
	,output('-----------------------------------' ,named('_______'))
	,output(DW         ,named('DW_cands'       ),all)
	,output(DW_score   ,named('DW_scores'),all)
);

