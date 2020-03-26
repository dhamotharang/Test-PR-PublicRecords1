import tools;

EXPORT mac_Rollup_Match_Scores(
  
   pMtch
  ,pAddFieldsRegex        = '\'(cnp_name|company_name_type_derived)\''

) :=
functionmacro

  #UNIQUENAME(ADDFIELDSREGEX)
  #SET(ADDFIELDSREGEX ,pAddFieldsRegex)


  layspecs := {unsigned rid,string fieldname,string fieldvalue};
  layouttools2 := tools.macf_LayoutTools(recordof(pMtch),false,'^(?!rid).*$',true);

  // layspecs := {unsigned rid,string fieldname,string fieldvalue};
  dnorm_specs2 := normalize(pMtch,count(layouttools2.setAllFields),transform({unsigned rollupid,layspecs}
    ,self.fieldname 	:= layouttools2.fGetFieldName(counter);
    ,self.fieldvalue	:= (string)layouttools2.fGetFieldValue(counter,left)
    ,self.rid					:= left.rid
    ,self.rollupid    := counter;
  ));

// -- try this

  layouttools3 := tools.macf_LayoutTools(recordof(pMtch),false,'^(?!.*?(left|right|skipped|_score).*).*$',true);
  mtch_score3 := project(pMtch,layouttools3.layout_record);
//conf Proxid1 Proxid2 conf prop dateoverlap rcid1 rcid2 left company inc state 

  // diterate          := iterate(sort(group(dnorm_specs2),rid,rollupid),transform(recordof(left)
                         // ,self.rollupid := map(regexfind('^left_|^conf$',right.fieldname                  ,nocase) and not regexfind('^support_',left.fieldname,nocase) and not regexfind('dt_last_seen',left.fieldname,nocase) => right.rollupid  
                                              // ,regexfind('^support_'    ,left.fieldname + right.fieldname ,nocase)                                                                                                              => 1
                                              // ,                                                                                                                                                                                    left.rollupid 
                         // ) 
                         // ,self := right ));
                         
  diterate          := iterate(sort(distribute(group(dnorm_specs2),rid),rid,rollupid,local),transform(recordof(left)
                         ,self.rollupid := map(regexfind('^left_|^conf$',right.fieldname                  ,nocase) and not regexfind('^support_',left.fieldname,nocase) and not regexfind('dt_last_seen',left.fieldname,nocase) => right.rollupid  
                                              ,regexfind('^support_'    ,left.fieldname + right.fieldname ,nocase)                                                                                                              => 1
                                              ,                                                                                                                                                                                    left.rollupid 
                         ) 
                         ,self := right ),local);

  dproj             := project(diterate,transform(
                           {unsigned rid,unsigned rollupid,dataset(layspecs) child}
                          ,self := left
                          ,self.child := dataset([{left.rollupid,left.fieldname,left.fieldvalue}],layspecs)
                       ),local);
                       
  drollup           := rollup(dproj,left.rid = right.rid,transform(recordof(left),self.child := left.child + right.child,self := left),local);
  // drollup           := rollup(sort(dproj,rid,rollupid),left.rid = right.rid,transform(recordof(left),self.child := left.child + right.child,self := left));
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
  ),local);
  //
  drollup2 := project(dprojme,transform(recordof(left)
    ,self.child := rollup(left.child,left.rid = right.rid,transform(recordof(left),self.child := left.child + right.child,self := left))
    ,self := left
  ),local);
  
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
  ),local);

  dproj3            := project(sort(project(dsortchild,transform(
                        {unsigned rid,unsigned rollupid,dataset({unsigned rid,dataset(layspecs - rid) child,string score,string skipped}) child}
                        ,self.child   := project(left.child,transform({unsigned rid,dataset(layspecs - rid) child,string score,string skipped}
                                            ,self.child   := left.child(not regexfind('_score$|_skipped$',fieldname,nocase))
                                            ,self.score   := left.child(    regexfind('_score$'   ,fieldname,nocase) or regexfind('support_cnp_name'   ,fieldname,nocase))[1].fieldvalue
                                            ,self.skipped := left.child(    regexfind('_skipped$' ,fieldname,nocase))[1].fieldvalue
                                            ,self.rid     := left.rid
                                         ))

                        ,self := left
                                                         )),rid,rollupid,local),{recordof(left)/* - rid - rollupid*/});
 
  dnorm_specs_filt2 := project(dproj3,transform(
                        {unsigned rid,unsigned rollupid,dataset({dataset(layspecs - rid) child,string score,string skipped}) child}
  #IF(%'ADDFIELDSREGEX'% != '')
    ,self.child := project(left.child(exists(child(regexfind('^conf$',fieldname,nocase) or regexfind(%'ADDFIELDSREGEX'%,fieldname,nocase))) or (unsigned)score != 0),recordof(left) - rid)
  #ELSE
    ,self.child := project(left.child(exists(child(regexfind('^conf$',fieldname,nocase))) or (unsigned)score != 0),recordof(left) - rid)
  #END
    // ,self.child := project(left.child(  (unsigned)score != 0) ,recordof(left) - rid)
//    ,self.child := left.child(count(child(regexfind('^conf$',fieldname,nocase))) >0 or (unsigned)score != 0)
    ,self := left
  ));  
  
  djoinme := join(dnorm_specs_filt2,mtch_score3,left.rid = right.rid,transform({recordof(right) - rid,recordof(left) - rid - rollupid},self := right,self := left),hash);

  return djoinme;
  
endmacro;
