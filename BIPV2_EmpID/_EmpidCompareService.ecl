import BIPV2_Empid,tools;

EXPORT _EmpidCompareService(

   unsigned6  pEmpid1
  ,unsigned6  pEmpid2
  // ,string     pversion  = 'qa'
  
) :=
function

  // version               := pversion;
  unsigned8 Empidone   := IF( pEmpid1>pEmpid2, pEmpid1, pEmpid2 );
  unsigned8 Empidtwo   := IF( pEmpid1>pEmpid2, pEmpid2, pEmpid1 );

  BFile := BIPV2_EmpID.In_EmpID;
  kFile := BIPV2_Empid.Keys(BFile/*,version*/);

  odl   := PROJECT(CHOOSEN(KFile.Candidates(Empid=Empidone),100000),BIPV2_Empid.match_candidates(BFile).layout_candidates);
  odr   := PROJECT(CHOOSEN(KFile.Candidates(Empid=EmpidTwo),100000),BIPV2_Empid.match_candidates(BFile).layout_candidates);
  k     := KFile.Specificities_Key;
  s     := GLOBAL(PROJECT(k,BIPV2_Empid.Layout_Specificities.R)[1]);
  odlv  := BIPV2_Empid.Debug(BFile,s).RolledEntities(odl);
  odrv  := BIPV2_Empid.Debug(BFile,s).RolledEntities(odr);

  // BIPV2_Empid.match_candidates(BFile).layout_attribute_matches ainto(KFile.Attribute_Matches le) := TRANSFORM
    // SELF := le;
  // END;

  // am    := PROJECT(KFile.Attribute_Matches(Empid1=Empidone,Empid2=Empidtwo)+KFile.Attribute_Matches(Empid1=Empidtwo,Empid2=Empidone),ainto(LEFT));
  mtch  := BIPV2_Empid.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,Empidone,Empidtwo,0,0}],BIPV2_Empid.match_candidates(BFile).layout_matches)/*,am*/);

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
  dnorm_specs_filt2 := dproj3(count(child(regexfind('^conf$',fieldname,nocase))) >0 or (unsigned)score != 0);
  
  return 
  parallel(
     OUTPUT( dnorm_specs_filt2      ,NAMED('RecordMatchesNonZeroScores'),all)
    ,OUTPUT( odlv + odrv            ,NAMED('EmpidBothFieldValues'     ))
    ,OUTPUT( SORT(mtch       ,-Conf),NAMED('RecordMatches'             ))
    ,OUTPUT( SORT(mtch_score ,-Conf),NAMED('RecordMatchesScoreOnly'    ))
    ,OUTPUT( odl                    ,NAMED('EmpidOneRecords'          ))
    ,OUTPUT( odr                    ,NAMED('EmpidTwoRecords'          ))

  );

end;