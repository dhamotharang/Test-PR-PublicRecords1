EXPORT mac_join_matches(

   pRollupMatches_old
  ,pRollupMatches_new
  ,pID

) :=
functionmacro

  #uniquename(lID )
  #uniquename(lID1)
  #uniquename(lID2)
  #SET(lID  ,trim(#TEXT(pID)))
  #SET(lID1 ,trim(#TEXT(pID)) + '1')
  #SET(lID2 ,trim(#TEXT(pID)) + '2')

  ds_diff_conf_matches_roll := join(pRollupMatches_old(%lID1% != 0)  ,pRollupMatches_new(%lID1% != 0)  ,left.%lID1% = right.%lID1% and left.%lID2% = right.%lID2% ,transform(
   {dataset({recordof(pRollupMatches_old.child)}) salt_old ,dataset({recordof(pRollupMatches_old.child)}) salt_new}
  ,self.salt_old := 
      left.child  ;
  ,self.salt_new := 
      right.child ;
  ),hash);

  ds_parse_fieldnames := project(ds_diff_conf_matches_roll  ,transform({dataset({recordof(pRollupMatches_old.child),string fieldname,unsigned rid,boolean filterout}) salt_old ,dataset({recordof(pRollupMatches_old.child),string fieldname,unsigned rid,boolean filterout}) salt_new}
    ,self.salt_old := project(left.salt_old ,transform({recordof(left),string fieldname,unsigned rid,boolean filterout}  ,self.fieldname := regexreplace('^left_(.*)$',left.child(regexfind('left_'  ,fieldname,nocase))[1].fieldname,'$1',nocase)  ,self.rid := counter,self := left,self := []  ));
     self.salt_new := project(left.salt_new ,transform({recordof(left),string fieldname,unsigned rid,boolean filterout}  ,self.fieldname := regexreplace('^left_(.*)$',left.child(regexfind('left_'  ,fieldname,nocase))[1].fieldname,'$1',nocase)  ,self.rid := counter,self := left,self := []  ));
  ));
  // output(enth(ds_parse_fieldnames/*(exists(salt_old((unsigned)child(fieldname = '%lID1%')[1].fieldvalue = 1123681246 or (unsigned)child(fieldname = '%lID2%')[1].fieldvalue = 1123681246)))*/        ,300) ,named('ds_parse_fieldnames'       ),all);

  ds_parse_fieldnames_filt := project(ds_parse_fieldnames ,transform(
    {  dataset({recordof(pRollupMatches_old.child) - skipped}) salt_old 
      ,dataset({dataset({recordof(pRollupMatches_old.child.child)}) child,string score}) salt_new
      // ,dataset({dataset({recordof(pRollupMatches_old.child.child) - fieldname}) child,string score}) salt_new
    } //recordof(ds_diff_conf_matches_roll)
    ,get_fieldnames := join(left.salt_old(fieldname != '',(integer)score != 0) ,left.salt_new(fieldname != '',(integer)score != 0)  ,STD.Str.ToUpperCase(trim(left.fieldname)) = STD.Str.ToUpperCase(trim(right.fieldname)) ,transform({string fieldname,integer diff_score,unsigned rid}
      ,self.fieldname   := if(left.fieldname != '',left.fieldname,right.fieldname)
      ,self.diff_score  := abs(((integer)left.score - (integer)right.score))
      ,self.rid         := left.rid + right.rid 
      )
      ,full outer);
     set_fieldnames := set(get_fieldnames,STD.Str.ToUpperCase(trim(fieldname)));
     
      salt_old := left.salt_old(fieldname = '' or STD.Str.ToUpperCase(trim(fieldname)) in set_fieldnames)  ; 
      salt_new := left.salt_new(fieldname = '' or STD.Str.ToUpperCase(trim(fieldname)) in set_fieldnames)  ;
      salt_old_ := join(salt_old ,table(get_fieldnames,{fieldname,integer diff_score := max(group,diff_score)},fieldname) ,STD.Str.ToUpperCase(trim(left.fieldname)) = STD.Str.ToUpperCase(trim(right.fieldname))  ,transform({recordof(left),integer diff_score},self.diff_score := right.diff_score,self := left));
      salt_new_ := join(salt_new ,table(get_fieldnames,{fieldname,integer diff_score := max(group,diff_score)},fieldname) ,STD.Str.ToUpperCase(trim(left.fieldname)) = STD.Str.ToUpperCase(trim(right.fieldname))  ,transform({recordof(left),integer diff_score},self.diff_score := right.diff_score,self := left));
     
     
     // self.salt_old := project(salt_old(rid in [1,2],(integer)score = 0)  ,recordof(left) - fieldname - filterout - skipped                               ) + project(sort(salt_old_  ,if(rid in [1,2]  , rid ,3)  ,if(rid > 2 ,-diff_score  ,0)   ,fieldname)  ,recordof(left) - fieldname - filterout - skipped);
     self.salt_old := project(salt_old(rid in [1,2],(integer)score = 0)  ,recordof(left) - rid - fieldname - filterout - skipped                               ) + project(sort(salt_old_  /*,if(rid in [1,2]  , rid ,3)  ,if(rid > 2 ,-diff_score  ,0)*/   ,fieldname)  ,recordof(left) - diff_score - rid - fieldname - filterout - skipped);
     // self.salt_new := project(salt_new(rid in [1,2],(integer)score = 0)  ,{dataset({recordof(pRollupMatches_old.child.child) - fieldname}) child,string score} ) + project(sort(salt_new_  ,if(rid in [1,2]  , rid ,3)  ,if(rid > 2 ,-diff_score  ,0)   ,fieldname)  ,{dataset({recordof(pRollupMatches_old.child.child) - fieldname}) child,string score});
     self.salt_new := project(salt_new(rid in [1,2],(integer)score = 0)  ,{dataset({recordof(pRollupMatches_old.child.child)}) child,string score} ) + project(sort(salt_new_  /*,if(rid in [1,2]  , rid ,3)  ,if(rid > 2 ,-diff_score  ,0)*/   ,fieldname)  ,{dataset({recordof(pRollupMatches_old.child.child)}) child,string score});
  ));

  // output(enth(ds_parse_fieldnames_filt/*(exists(salt_old((unsigned)child(fieldname = '%lID1%')[1].fieldvalue = 1123681246 or (unsigned)child(fieldname = '%lID2%')[1].fieldvalue = 1123681246))) */       ,300) ,named('ds_parse_fieldnames_filt'       ),all);

  return ds_parse_fieldnames_filt;


endmacro;