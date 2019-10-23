EXPORT mac_Rollup_Match_Scores(

   pMatchSampleKey                    //Match sample debug index.  should be just samples of this, not the whole key
  ,pMatchCandidatesKey                //Match Candidates key
  ,pSpeckey                           //specificities key
  ,pAttmatcheskey         = ''        //att matches key
  ,pInFile                            //Infile for matching(BIPV2_ProxID.In_DOT_Base)
  ,pID                                //Internal linking id(proxid, dotid, bdid, did, etc)
  ,pRid                               //Rid
  ,pAddFieldsRegex        = '\'\''
	,pOutputEcl			        = 'false'		//Should output the ecl as a string(for testing) or actually run the ecl
  ,pDebuggingOutputs      = 'false'   //extra debugging outputs added
  ,pUniqueOutput          = '\'\''    //make the outputs unique(for when running multiple per wuid)

) :=
functionmacro

  import std,tools;
  #UNIQUENAME(ECL)
  #UNIQUENAME(lID)
  #UNIQUENAME(lID1)
  #UNIQUENAME(lID2)
  #UNIQUENAME(lRID)
  #UNIQUENAME(lRID1)
  #UNIQUENAME(lRID2)
  #UNIQUENAME(lInfile)
  #UNIQUENAME(kcand)
  #UNIQUENAME(kmtch)
  #UNIQUENAME(katt )
  #UNIQUENAME(katt_raw )
  #UNIQUENAME(kspec )
  #UNIQUENAME(lModuleIndex)
  #UNIQUENAME(lModule)
  #UNIQUENAME(lDebuggingOutputs)
  #UNIQUENAME(lAddFieldsRegex)
  

  // -- set parameters to local value types for easier processing
  #SET(kmtch          ,#TEXT(pMatchSampleKey        ))
  #SET(kcand          ,#TEXT(pMatchCandidatesKey    ))
  #SET(katt           ,#TEXT(pAttmatcheskey         ))
  // #IF(regexfind('[[:alnum:]]',#TEXT(pAttmatcheskey),nocase))
  #IF(trim(#getdatatype(pAttmatcheskey)) = '')  //blank is most likely dataset or key
    #SET(katt_raw       ,#TEXT(pAttmatcheskey)         )
  #END
  #SET(kspec          ,#TEXT(pSpeckey         ))
  #SET(lAddFieldsRegex,pAddFieldsRegex        )
  #SET(lID            ,#TEXT(pID                    ))
  #SET(lID1           ,#TEXT(pID                    ) + '1')
  #SET(lID2           ,#TEXT(pID                    ) + '2')
  #SET(lRID           ,#TEXT(pRid                   ))
  #SET(lRID1          ,#TEXT(pRid                   ) + '1')
  #SET(lRID2          ,#TEXT(pRid                   ) + '2')
  #SET(lInfile        ,trim(#TEXT(pInFile    ),all))
  #SET(lModuleIndex   ,std.str.find(%'lInfile'%,'.',1))
  #IF(%lModuleIndex% != 0)
    #SET(lModule        ,trim(std.str.cleanspaces(%'lInfile'%[1..(%lModuleIndex% - 1)] ),left,right))
  #ELSE
    #ERROR('Can\'t find module name in your infile: ' + %'lInfile'%)
  #END
  #SET(ECL  ,'')
  #SET(lDebuggingOutputs ,'')
  
  // #APPEND(ECL  ,'s := dataset([],' + %'lModule'% + '.Layout_Specificities.R)[1];\n')
  #APPEND(ECL  ,'s := project(' + %'kspec'% + ',transform(' + %'lModule'% + '.Layout_Specificities.R,self := left,self := []))[1];\n')
  // #APPEND(ECL  ,'s := project(' + %'kspec'% + ',transform(' + %'lModule'% + '.Layout_Specificities.R,self.cnp_name_MAXIMUM := left.cnp_name_max,self := left,self := []))[1];\n')

  #APPEND(ECL  ,'dmtches := project(' + %'kmtch'% + ',transform(' + %'lModule'% + '.match_candidates(' + %'lInfile'% + ').layout_matches,self.' + %'lID1'% + ' := left.' + %'lID1'% + ',self.' + %'lID2'% + ' := left.' + %'lID2'% + ',self := []));\n')

  // #IF(regexfind('[[:alnum:]]',trim(%'katt_raw'%),nocase) and not regexfind('(katt_old_same_matches_sample|katt_new_same_matches_sample)',trim(%'katt_raw'%),nocase) )
  #IF(trim(#getdatatype(pAttmatcheskey)) = '')  //blank is most likely dataset or key
    #APPEND(ECL  ,'mtch := ' + %'lModule'% + '.Debug(' + %'lInfile'% + ',s).AnnotateMatchesFromData(' + %'kcand'% + ',dmtches ,' + %'katt'% + '); //att matches\n')
  #ELSE
    #APPEND(ECL  ,'mtch := ' + %'lModule'% + '.Debug(' + %'lInfile'% + ',s).AnnotateMatchesFromData(' + %'kcand'% + ',dmtches ); \n')
  #END
  #APPEND(ECL  ,'mtch_score2  := project( dedup(sort(distribute(mtch,hash(' + %'lID1'% + ',' + %'lID2'% + '))  ,' + %'lID1'% + ',' + %'lID2'% + ',-conf,local)    ,' + %'lID1'% + ',' + %'lID2'% + ',local)   ,transform({unsigned rid,recordof(left)},self.rid := counter,self := left));\n')

  #APPEND(ECL  ,'layspecs := {unsigned rid,string fieldname,string fieldvalue};\n')
  #APPEND(ECL  ,'layouttools2 := tools.macf_LayoutTools(recordof(mtch_score2),false,\'^(?!rid).*$\',true);\n')

  #APPEND(ECL  ,'dnorm_specs2 := normalize(mtch_score2,count(layouttools2.setAllFields),transform({unsigned rollupid,layspecs}\n')
  #APPEND(ECL  ,'  ,self.fieldname 	:= layouttools2.fGetFieldName(counter);\n')
  #APPEND(ECL  ,'  ,self.fieldvalue	:= (string)layouttools2.fGetFieldValue(counter,left)\n')
  #APPEND(ECL  ,'  ,self.rid					:= left.rid\n')
  #APPEND(ECL  ,'  ,self.rollupid    := counter;\n')
  #APPEND(ECL  ,'));\n')

  #APPEND(ECL  ,'layouttools3 := tools.macf_LayoutTools(recordof(mtch_score2),false,\'^(?!.*?(left|right|skipped|_score|_code).*).*$\',true);\n')
  #APPEND(ECL  ,'mtch_score3 := project(mtch_score2,layouttools3.layout_record);\n')

  #APPEND(ECL  ,'diterate          := iterate(sort(group(dnorm_specs2),rid,rollupid),transform(recordof(left)\n')
  #APPEND(ECL  ,'                       ,self.rollupid := map(regexfind(\'^left_|^conf$\',right.fieldname,nocase) and not regexfind(\'^support_\',left.fieldname,nocase) => right.rollupid  \n')
  #APPEND(ECL  ,'                                        ,regexfind(\'^support_\',left.fieldname + right.fieldname,nocase) => 1\n')
  #APPEND(ECL  ,'                                        ,left.rollupid \n')
  #APPEND(ECL  ,'                       ) \n')
  #APPEND(ECL  ,'                       ,self := right ));\n')
  #APPEND(ECL  ,'dproj             := project(diterate,transform(\n')
  #APPEND(ECL  ,'                         {unsigned rid,unsigned rollupid,dataset(layspecs) child}\n')
  #APPEND(ECL  ,'                        ,self := left\n')
  #APPEND(ECL  ,'                        ,self.child := dataset([{left.rollupid,left.fieldname,left.fieldvalue}],layspecs)\n')
  #APPEND(ECL  ,'                     ));\n')
                       
  #APPEND(ECL  ,'drollup           := rollup(sort(dproj,rid,rollupid),left.rid = right.rid,transform(recordof(left),self.child := left.child + right.child,self := left));\n')
  // rollup child dataset now
  #APPEND(ECL  ,'dprojme := project(drollup,transform(\n')
  #APPEND(ECL  ,'    {unsigned rid,unsigned rollupid,dataset({unsigned rid,dataset(layspecs - rid) child}) child}\n')
  #APPEND(ECL  ,'    ,self.rid       := left.rid\n')
  #APPEND(ECL  ,'    ,self.rollupid  := left.rollupid\n')
  #APPEND(ECL  ,'    ,self.child     := project(left.child\n')
  #APPEND(ECL  ,'                          ,transform(\n')
  #APPEND(ECL  ,'                            {unsigned rid,dataset(layspecs - rid) child}\n')
  #APPEND(ECL  ,'                            ,self.rid   := left.rid\n')
  #APPEND(ECL  ,'                            ,self.child := dataset([{left.fieldname,left.fieldvalue}],{layspecs - rid}))) \n')
  #APPEND(ECL  ,'));\n')
  #APPEND(ECL  ,'drollup2 := project(dprojme,transform(recordof(left)\n')
  #APPEND(ECL  ,'  ,self.child := rollup(left.child,left.rid = right.rid,transform(recordof(left),self.child := left.child + right.child,self := left))\n')
  #APPEND(ECL  ,'  ,self := left\n')
  #APPEND(ECL  ,'));\n')
  
  #APPEND(ECL  ,'dsortchild        := project(drollup2,transform(recordof(left)\n')
  #APPEND(ECL  ,'  ,self.child := project(left.child,transform(recordof(left),self.child := \n')
  #APPEND(ECL  ,'                 sort(left.child  ,map(regexfind(\'^left_\'   ,fieldname,nocase) => 1\n')
  #APPEND(ECL  ,'                                      ,regexfind(\'^right_\'  ,fieldname,nocase) => 2\n')
  #APPEND(ECL  ,'                                      ,regexfind(\'_score$\'  ,fieldname,nocase) => 3\n')
  #APPEND(ECL  ,'                                      ,regexfind(\'_skipped$\',fieldname,nocase) => 4\n')
  #APPEND(ECL  ,'                                      ,                                             0\n')
  #APPEND(ECL  ,'                                  ))\n')
  #APPEND(ECL  ,'                                  ,self := left\n')
  #APPEND(ECL  ,'                ))\n')
  #APPEND(ECL  ,' ,self := left\n')
  #APPEND(ECL  ,'));\n')

  #APPEND(ECL  ,'dproj3            := project(sort(project(dsortchild,transform(\n')
  #APPEND(ECL  ,'                      {unsigned rid,unsigned rollupid,dataset({unsigned rid,dataset(layspecs - rid) child,string score,string skipped}) child}\n')
  #APPEND(ECL  ,'                      ,self.child   := project(left.child,transform({unsigned rid,dataset(layspecs - rid) child,string score,string skipped}\n')
  #APPEND(ECL  ,'                                          ,self.child   := left.child(not regexfind(\'_score$|_skipped$|_score_prop$\',fieldname,nocase))\n')
  #APPEND(ECL  ,'                                          ,self.score   := left.child(    regexfind(\'_score$\'   ,fieldname,nocase))[1].fieldvalue\n')
  #APPEND(ECL  ,'                                          ,self.skipped := left.child(    regexfind(\'_skipped$\' ,fieldname,nocase))[1].fieldvalue\n')
  #APPEND(ECL  ,'                                          ,self.rid     := left.rid\n')
  #APPEND(ECL  ,'                                       ))\n')

  #APPEND(ECL  ,'                      ,self := left\n')
  #APPEND(ECL  ,'                                                       )),rid,rollupid),{recordof(left)/* - rid - rollupid*/});\n')
 
  #APPEND(ECL  ,'dnorm_specs_filt2 := project(dproj3,transform(\n')
  #APPEND(ECL  ,'                      {unsigned rid,unsigned rollupid,dataset({dataset(layspecs - rid) child,string score,string skipped}) child}\n')
  #IF(%'lAddFieldsRegex'% = '')
    #APPEND(ECL  ,'  ,self.child := project(left.child( (trim(score) = \'\' and exists(child(regexfind(\'(conf|_match)\',fieldname,nocase)))) or (integer)score != 0),recordof(left) - rid)\n')
  #ELSE
    #APPEND(ECL  ,'  ,self.child := project(left.child( (trim(score) = \'\' and exists(child(regexfind(\'(conf|_match)\',fieldname,nocase)))) or (integer)score != 0 or (exists(child(regexfind(\'' + %'lAddFieldsRegex'% + '\',fieldname,nocase))))  ),recordof(left) - rid)\n')
  #END
  #APPEND(ECL  ,'  ,self := left\n')
  #APPEND(ECL  ,'));\n')
  
  #APPEND(ECL  ,'djoinme := join(dnorm_specs_filt2,mtch_score3,left.rid = right.rid,transform({recordof(right) - rid,recordof(left) - rid - rollupid},self := right,self := left));\n')
  #APPEND(ECL  ,'ds_prep_norm := project(djoinme ,transform(recordof(left)\n')
  #APPEND(ECL  ,'  ,ds_child2 := dataset([\n')
  #APPEND(ECL  ,'     {\'conf\'  ,(string)left.conf  }\n')
  #APPEND(ECL  ,'    ,{\'' + %'lID1'%  + '\' ,(string)left.' + %'lID1'%  + '}\n')
  #APPEND(ECL  ,'    ,{\'' + %'lID2'%  + '\' ,(string)left.' + %'lID2'%  + '}\n')
  #APPEND(ECL  ,'    ,{\'' + %'lRID1'% + '\' ,(string)left.' + %'lRID1'% + '}\n')
  #APPEND(ECL  ,'    ,{\'' + %'lRID2'% + '\' ,(string)left.' + %'lRID2'% + '}\n')
  #APPEND(ECL  ,'  ]  ,{string fieldname,string fieldvalue});\n')
    
  #APPEND(ECL  ,'  self.child := \n') 
  // #APPEND(ECL  ,'      dataset([{ds_child2,\'\',\'\'}],recordof(left.child))\n')
  // #APPEND(ECL  ,'  + left.child;\n')
  #APPEND(ECL  ,'   left.child;\n')
    
  #APPEND(ECL  ,'  ,self       := left\n')
  
  #APPEND(ECL  ,'));\n')
  
  #APPEND(ECL  ,'dnorm2 := normalize(ds_prep_norm,2,transform(recordof(left),self := if(counter = 1,left,dataset([],recordof(left))[1])));\n')


  #APPEND(lDebuggingOutputs ,'output_debugs := parallel(\n')
  #APPEND(lDebuggingOutputs ,'   output(\'--------------------------------------------\' ,named(\'SALT_REGRESSION_TESTING_mac_Rollup_Match_Scores_Begin_______________________________' + pUniqueOutput + '\'          ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(dmtches          ,100) ,named(\'dmtches' + pUniqueOutput + '\'          ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(mtch             ,100) ,named(\'mtch' + pUniqueOutput + '\'             ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(mtch_score2      ,100) ,named(\'mtch_score2' + pUniqueOutput + '\'      ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(dnorm_specs2     ,100) ,named(\'dnorm_specs2' + pUniqueOutput + '\'     ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(mtch_score3      ,100) ,named(\'mtch_score3' + pUniqueOutput + '\'      ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(diterate         ,100) ,named(\'diterate' + pUniqueOutput + '\'         ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(dproj            ,100) ,named(\'dproj' + pUniqueOutput + '\'            ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(drollup          ,100) ,named(\'drollup' + pUniqueOutput + '\'          ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(dprojme          ,100) ,named(\'dprojme' + pUniqueOutput + '\'          ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(drollup2         ,100) ,named(\'drollup2' + pUniqueOutput + '\'         ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(dsortchild       ,100) ,named(\'dsortchild' + pUniqueOutput + '\'       ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(dproj3           ,100) ,named(\'dproj3' + pUniqueOutput + '\'           ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(dnorm_specs_filt2,100) ,named(\'dnorm_specs_filt2' + pUniqueOutput + '\'))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(djoinme          ,100) ,named(\'djoinme' + pUniqueOutput + '\'          ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(ds_prep_norm     ,100) ,named(\'ds_prep_norm' + pUniqueOutput + '\'     ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(choosen(dnorm2           ,100) ,named(\'dnorm2' + pUniqueOutput + '\'           ))\n')
  #APPEND(lDebuggingOutputs ,'  ,output(\'--------------------------------------------\' ,named(\'SALT_REGRESSION_TESTING_mac_Rollup_Match_Scores_End_______________________________' + pUniqueOutput + '\'          ))\n')
  #APPEND(lDebuggingOutputs ,');\n')
  
  #IF(pDebuggingOutputs = false)
    #SET(ECL  ,%'ECL'% + 'return dnorm2;')
  #ELSE
    #SET(ECL  ,%'ECL'% + %'lDebuggingOutputs'% + 'return when(dnorm2,output_debugs);')
  #END

	#if(pOutputEcl = true)
		return output(%'ECL'%);
	#ELSE
		%ECL%
	#END

  
endmacro;