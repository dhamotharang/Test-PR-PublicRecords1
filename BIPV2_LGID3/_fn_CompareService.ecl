import BIPV2_LGID3,tools;

EXPORT _fn_CompareService(

   unsigned6  pLgid31
  ,unsigned6  pLgid32
  ,string     pversion = 'qa'
  
) :=
function

//  version               := pversion;
  unsigned8 Lgid3one   := IF( pLgid31>pLgid32, pLgid31, pLgid32 );
  unsigned8 Lgid3two   := IF( pLgid31>pLgid32, pLgid32, pLgid31 );

  BFile := BIPV2_LGID3.In_LGID3;
  kFile := BIPV2_LGID3.Keys2(BFile,pversion);

  odl   := PROJECT(CHOOSEN(KFile.Candidates(Lgid3=Lgid3one),100000),BIPV2_LGID3.match_candidates(BFile).layout_candidates);
  odr   := PROJECT(CHOOSEN(KFile.Candidates(Lgid3=Lgid3Two),100000),BIPV2_LGID3.match_candidates(BFile).layout_candidates);
  k     := KFile.Specificities_Key;
  s     := GLOBAL(PROJECT(k,BIPV2_LGID3.Layout_Specificities.R)[1]);
  odlv  := BIPV2_LGID3.Debug(BFile,s).RolledEntities(odl);
  odrv  := BIPV2_LGID3.Debug(BFile,s).RolledEntities(odr);

  BIPV2_LGID3.match_candidates(BFile).layout_attribute_matches ainto(KFile.Attribute_Match le) := TRANSFORM
    SELF := le;
  END;

  am    := PROJECT(KFile.Attribute_Match(Lgid31=Lgid3one,Lgid32=Lgid3two)+KFile.Attribute_Match(Lgid31=Lgid3two,Lgid32=Lgid3one),ainto(LEFT));
  mtch  := BIPV2_LGID3.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,Lgid3one,Lgid3two,0,0}],BIPV2_LGID3.match_candidates(BFile).layout_matches),am);

  // get layout with the scores only for easier reading
  dnorm_specs_filt2 := BIPV2_LGID3._fn_normscores(mtch);
 
  layouttools := tools.macf_LayoutTools(recordof(mtch),false,'^(?!.*?(left|right|skipped).*).*$',true);
  mtch_score := project(mtch,layouttools.layout_record);
/*
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
  dnorm_specs_filt2 := dproj3(count(child(regexfind('^conf$',fieldname,nocase))) >0 or (unsigned)score != 0);
  */
// 24 24 right_hist_enterprise_number  
// 24 23 hist_enterprise_number_score 0 
// 23 22 left_hist_enterprise_number 

  return 
  parallel(
     // output( Lgid3one              ,named('Lgid3one'                    ))
    // ,output( Lgid3two              ,named('Lgid3two'                    ))
     OUTPUT( dnorm_specs_filt2      ,NAMED('RecordMatchesNonZeroScores'),all)
    ,OUTPUT( odlv + odrv            ,NAMED('Lgid3BothFieldValues'     ))
    // ,OUTPUT( odlv                   ,NAMED('Lgid3OneFieldValues'      ))
    // ,OUTPUT( odrv                   ,NAMED('Lgid3TwoFieldValues'      ))
//    ,OUTPUT( dproj3                 ,NAMED('RecordMatches'              ),all)
    ,OUTPUT( SORT(mtch       ,-Conf),NAMED('RecordMatches'             ))
    ,OUTPUT( SORT(mtch_score ,-Conf),NAMED('RecordMatchesScoreOnly'    ))
//    ,OUTPUT( odl + odr              ,NAMED('Lgid3BothRecords'         ))
    ,OUTPUT( odl                    ,NAMED('Lgid3OneRecords'          ))
    ,OUTPUT( odr                    ,NAMED('Lgid3TwoRecords'          ))

    // ,OUTPUT( dnorm_specs2           ,NAMED('RecordMatchesNormScores2'   ),all)
    // ,OUTPUT( diterate               ,NAMED('RecordMatchesIterate'       ),all)
    // ,OUTPUT( dproj                  ,NAMED('RecordMatchesIProj'         ),all)
    // ,OUTPUT( drollup                ,NAMED('RecordMatchesRollup'        ),all)
    // ,OUTPUT( dsortchild             ,NAMED('RecordMatchesSort'          ),all)
    // ,OUTPUT( dsupports              ,NAMED('RecordMatchesSupports'      ),all)
    // ,OUTPUT( dproj2                 ,NAMED('RecordMatchesProj2'         ),all)
    // ,OUTPUT( dproj3                 ,NAMED('RecordMatchesProj3'         ),all)
  );

end;