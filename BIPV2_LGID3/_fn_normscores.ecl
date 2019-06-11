import tools;
EXPORT _fn_normscores(
  
  pMtch
) :=
functionmacro
  layouttools := tools.macf_LayoutTools(recordof(pMtch),false,'^(?!.*?(left|right|skipped).*).*$',true);
  mtch_score := project(pMtch,layouttools.layout_record);
  layspecs := {unsigned rid,string fieldname,string fieldvalue};
  dnorm_specs := normalize(pMtch,count(layouttools.setAllFields),transform(layspecs
    ,self.fieldname 	:= layouttools.fGetFieldName(counter);
    ,self.fieldvalue	:= (string)layouttools.fGetFieldValue(counter,left)
    ,self.rid					:= counter
  ));
  dnorm_specs_filt := sort(dnorm_specs((unsigned)fieldvalue != 0),rid);
  ///////////
  //--norm all fields, trying to group them better into child datasets per field so easier to see
  ///////////
  layouttools2 := tools.macf_LayoutTools(recordof(pMtch),false,'',true);
  mtch_score2  := project(pMtch,layouttools2.layout_record);
  // layspecs := {unsigned rid,string fieldname,string fieldvalue};
  dnorm_specs2 := normalize(pMtch,count(layouttools2.setAllFields),transform({unsigned rollupid,layspecs}
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
  return dnorm_specs_filt2;
  
endmacro;
