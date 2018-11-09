/*
  gets samples to review for people in the set
  should output the rolled up views for all samples first, then later output details if needed to look at 
  this should allow much faster review times

pInfile              := BIPV2_ProxID.In_DOT_Base    ;
pMatchThreshold      := 30                          ;
pSetReviewers        := ['CM','LB','TL','DW','SS']  ;
pSamplesPerReviewer  := 15                          ;
pKeyversions         := 'built'                     ;
outputecl            := false                       ;
pFractionAtThreshold := 1.0                         ;
pDebuggingOutputs    := true                        ;

kmtch                   := BIPV2_ProxID.Keys(pInfile,pKeyversions).MatchSample ;
kcand                   := BIPV2_ProxID.Keys(pInfile,pKeyversions).Candidates  ;
outputReviewSamples     := Tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_ProxID.In_DOT_Base,proxid,pMatchThreshold,pSamplesPerReviewer,pSetReviewers,outputecl,pFractionAtThreshold,pDebuggingOutputs);

outputReviewSamples;
*/
import tools,std;

EXPORT mac_GetSALTReviewSamples(

   pMatchSampleKey                    //Match sample debug index
  ,pMatchCandidatesKey                //Match Candidates key
  ,pInFile                            //Infile for matching(BIPV2_ProxID.In_DOT_Base)
  ,pID                                //Internal linking id(proxid, dotid, bdid, did, etc)
  ,pThreshold                         //threshold for your matching
  ,pNumSamplesPerReviewer             //how many samples for each reviewer
  ,psetReviewers          = '[]'      //names of reviewers
	,pOutputEcl			        = 'false'		//Should output the ecl as a string(for testing) or actually run the ecl
  ,pFractionAtThreshold   = '.667'    //by default, 2/3 at threshold, 1/3 above
  ,pDebuggingOutputs      = 'false'   //extra debugging outputs added
  ,pExtraMatchFilter      = '\'\''    //if you want to filter for only particular types of matches(i.e. 'company_inc_state_score <= 0' )
  ,pUniqueOutput          = '\'\''    //make the outputs unique(for when running multiple per wuid)

) :=
functionmacro
  
  import std,tools;
  #UNIQUENAME(ECL)
  #UNIQUENAME(CNTR)
  #UNIQUENAME(Samples)
  #UNIQUENAME(SlimSamples)
  #UNIQUENAME(NormSamples)
  #UNIQUENAME(RollSamples)
  #UNIQUENAME(NormTransform)
  #UNIQUENAME(RollTransform)
  #UNIQUENAME(RollLayout)
  #UNIQUENAME(outputNormSamples)
  #UNIQUENAME(outputRollSamples)
  #UNIQUENAME(SepOutput)
  #UNIQUENAME(BigOutputs)
  #UNIQUENAME(Outputs)
  #UNIQUENAME(EqIndex)
  #UNIQUENAME(GtIndex)
  #UNIQUENAME(cnteqSamples)
  #UNIQUENAME(cntgtSamples)
  #UNIQUENAME(layscore)
  #UNIQUENAME(layfields)
  #UNIQUENAME(lMatchSampleKey)
  #UNIQUENAME(multipier)
  #UNIQUENAME(lID)
  #UNIQUENAME(lModuleIndex)
  #UNIQUENAME(lModule)
  #UNIQUENAME(lInfile)
  #UNIQUENAME(AllRolled)
  #UNIQUENAME(AllCands  )
  #UNIQUENAME(AllScores)
  #UNIQUENAME(countReviewers)
  #UNIQUENAME(mapRemainders)
  #UNIQUENAME(startrec)
  #UNIQUENAME(laynorm)
  #UNIQUENAME(kcand)
  #UNIQUENAME(setfields)
  #UNIQUENAME(ExtraMatchFilter)
// 	LOADXML('<xml/>');
  #IF(pExtraMatchFilter = '')
    #SET(ExtraMatchFilter,pExtraMatchFilter)
  #ELSE
    #SET(ExtraMatchFilter,',' + pExtraMatchFilter)
  #END
  
  #SET(lID            ,#TEXT(pID    ))
  #SET(lInfile        ,trim(#TEXT(pInFile    ),all))
  #SET(kcand            ,#TEXT(pMatchCandidatesKey    ))
  #SET(lModuleIndex   ,std.str.find(%'lInfile'%,'.',1))
  #IF(%lModuleIndex% != 0)
    #SET(lModule        ,trim(std.str.cleanspaces(%'lInfile'%[1..(%lModuleIndex% - 1)] ),left,right))
  #ELSE
    #ERROR('Can\'t find module name in your infile: ' + %'lInfile'%)
  #END
  
  #SET(lMatchSampleKey ,trim(#TEXT(pMatchSampleKey),all))
  #SET   (ECL    ,'kmatchsample    := ' + %'lMatchSampleKey'% + ';\n')
  #APPEND(ECL    ,'kmatchsample_eq := kmatchsample(conf = ' + pThreshold + %'ExtraMatchFilter'% + ');\n')
  #APPEND(ECL    ,'kmatchsample_gt := kmatchsample(conf > ' + pThreshold + %'ExtraMatchFilter'% + ');\n')

  #APPEND(ECL    ,'//do 2/3 recs at threshold, 1/3 above threshold\n')
  #APPEND(ECL    ,'countReviewers := ' + count(psetReviewers) + ';\n')
  #APPEND(ECL    ,'totalSamples := ' + pNumSamplesPerReviewer + ' * countReviewers;\n')
  
  #APPEND(ECL    ,'countkmatchsample_eq  := count(kmatchsample_eq);\n')
  #APPEND(ECL    ,'countkmatchsample_gt  := count(kmatchsample_gt);\n')

  #APPEND(ECL    ,'samplesatthreshold          := if((unsigned)(totalsamples * ' + #TEXT(pFractionAtThreshold) + ')      >= countkmatchsample_eq  ,countkmatchsample_eq   ,(unsigned)(totalsamples * ' + #TEXT(pFractionAtThreshold) + ')      );\n')
  #APPEND(ECL    ,'samplesabovethreshold       := if((totalSamples - samplesatthreshold) >  countkmatchsample_gt  ,countkmatchsample_gt   ,(totalSamples - samplesatthreshold) );\n')

  #SET(cnteqSamples    ,(unsigned)(pNumSamplesPerReviewer * pFractionAtThreshold))
  #SET(cntgtSamples    ,(unsigned)(pNumSamplesPerReviewer * 1 - pFractionAtThreshold))

  #APPEND(ECL    ,'samplerecseq      := iff(samplesatthreshold    != 0 ,enth (kmatchsample_eq,samplesatthreshold     ) ,dataset([],recordof(kmatchsample_eq))) : independent;\n')  
  #APPEND(ECL    ,'samplerecsgt      := iff(samplesabovethreshold != 0 ,enth (kmatchsample_gt,samplesabovethreshold  ) ,dataset([],recordof(kmatchsample_gt))) : independent;\n\n')

////
  #APPEND(ECL    ,'allsamplerecs     := sort(samplerecseq + samplerecsgt,' + %'lID'% + '1 + ' + %'lID'% + '2);\n')
  #APPEND(ECL    ,'totalsamplesreal  := samplesatthreshold + samplesabovethreshold;         \n\n')
  #APPEND(ECL    ,'samplesperreviewer  := (unsigned)totalsamplesreal / countReviewers;\n')
  #APPEND(ECL    ,'samplesremainder    := totalsamplesreal % countReviewers;          \n\n')
////
  #APPEND(ECL    ,'allsampleproxids :=   table(table(samplerecseq + samplerecsgt  ,{unsigned6 ' + %'lID'% + ' := ' + %'lID'% + '1})\n')
  #APPEND(ECL    ,'                          + table(samplerecseq + samplerecsgt  ,{unsigned6 ' + %'lID'% + ' := ' + %'lID'% + '2})\n')
  #APPEND(ECL    ,'                      ,{' + %'lID'% + '},' + %'lID'% + ',few);\n')
  #APPEND(ECL    ,'setsampleproxids  := set(allsampleproxids  ,' + %'lID'% + ');\n')
  #APPEND(ECL    ,'allproxidcands    := project(' + %'kcand'% + '(' + %'lID'% + ' in setsampleproxids)  ,transform(' + %'lModule'% + '.match_candidates(' + %'lInfile'% + ').layout_candidates,self := left,self := []));\n')
  #APPEND(ECL    ,'s := dataset([],' + %'lModule'% + '.Layout_Specificities.R);\n')
  #APPEND(ECL    ,'allproxidsrolled := ' + %'lModule'% + '.Debug(' + %'lInfile'% + ',s).RolledEntities(allproxidcands);\n')
  #APPEND(ECL    ,'layrolled := recordof(allproxidsrolled);\n\n')

  #APPEND(ECL    ,'mapremainder(unsigned previewer) := \n')
  #APPEND(ECL    ,'map(\n')
  #APPEND(ECL    ,'   samplesremainder  = 0 => 0         \n')


  #SET(layscore  , tools.mac_FilterLayout(recordof(pMatchSampleKey),true,'^(?!.*?(left|right|skipped|match_code).*).*$'    ,true))
  #SET(layfields , tools.mac_FilterLayout(recordof(pMatchSampleKey),true,'^(?=.*?(left|right|skipped).*).*$'    ,true)) 
  #SET(laynorm   , tools.mac_FilterLayout(recordof(pMatchSampleKey),true,'^(conf|support|attribute_conf)'      ,true)) 
  #SET(laynorm   , %'laynorm'%[1..(length(%'laynorm'%) - 1)] + ',typeof(' + %'kcand'% + '.' + %'lID'% + ') ' + %'lID'% + '}'  )
  #SET(setfields   ,tools.mac_SetFields(recordof(pMatchSampleKey),'^(support_|attribute_).*$',true,true) )
  
  #SET(Samples      ,'')
  #SET(SlimSamples  ,'')
  #SET(NormSamples  ,'')
  #SET(RollSamples  ,'')
  #SET(SepOutput    ,'____')

  #SET(outputNormSamples  ,'\t,output(\'-----------------------------------\' ,named(\'' + pUniqueOutput + '__\' ))\n')
  #SET(outputRollSamples  ,'\t,output(\'-----------------------------------\' ,named(\'' + pUniqueOutput + '_\'))\n')
  #APPEND(outputRollSamples  ,'\t,output(\'2 recs per Matching Pair, + 1 blank rec for separation\' ,named(\'' + pUniqueOutput + 'RolledUpViewsOfSamplesFollows\'))\n')
  #APPEND(outputRollSamples  ,'\t,output(allrolled ,named(\'' + pUniqueOutput + 'AllSamplesCombined\'),all)\n')
  
  #SET(BigOutputs   ,'\t,output(\'-----------------------------------\' ,named(\'' + pUniqueOutput + '___\'))\n')
  #APPEND(BigOutputs   ,'\t,output(\'Full Match Candidates Record, then just the score\' ,named(\'' + pUniqueOutput + 'DetailedMatchingInfoFollows\'))\n')
  #APPEND(BigOutputs  ,'\t,output(AllCands  ,named(\'' + pUniqueOutput + 'AllSamplesCands\'),all)\n')
  #APPEND(BigOutputs  ,'\t,output(AllScores ,named(\'' + pUniqueOutput + 'AllSamplesScores\'),all)\n')
  
  #SET(Outputs      ,'')
  #SET(mapRemainders ,'')
  #SET(startrec     ,'startrec1   := 1    ;\n')
  #SET(EqIndex      ,1)
  #SET(GtIndex      ,1)
  #SET(AllRolled  ,'allrolled := sort(\n')
  #SET(AllCands   ,'AllCands  := \n')
  #SET(AllScores  ,'AllScores := \n')
  
  #APPEND(Outputs ,'\t output(count(kmatchsample   ) ,named(\'' + pUniqueOutput + 'TotalMatchSamples\'   ))\n')
  #APPEND(Outputs ,'\t,output(count(kmatchsample_eq) ,named(\'' + pUniqueOutput + 'TotalMatchSamplesEqualToThreshold\'))\n')
  #APPEND(Outputs ,'\t,output(count(kmatchsample_gt) ,named(\'' + pUniqueOutput + 'TotalMatchSamplesGreaterThanThreshold\'))\n')

  #IF(pDebuggingOutputs = true)
    #APPEND(Outputs ,'\t,output(' + pThreshold + '                     ,named(\'' + pUniqueOutput + 'conf\'                 ))\n')
    #APPEND(Outputs ,'\t,output(' + pFractionAtThreshold + '    ,named(\'' + pUniqueOutput + 'FractionAtThreshold\'  ))\n')
    #APPEND(Outputs ,'\t,output(countReviewers         ,named(\'' + pUniqueOutput + 'countReviewers\'       ))\n')
    #APPEND(Outputs ,'\t,output(totalSamples           ,named(\'' + pUniqueOutput + 'totalSamples\'         ))\n')
    #APPEND(Outputs ,'\t,output(countkmatchsample_eq   ,named(\'' + pUniqueOutput + 'countkmatchsample_eq\' ))\n')
    #APPEND(Outputs ,'\t,output(countkmatchsample_gt   ,named(\'' + pUniqueOutput + 'countkmatchsample_gt\' ))\n')
    #APPEND(Outputs ,'\t,output(samplesatthreshold     ,named(\'' + pUniqueOutput + 'samplesatthreshold\'   ))\n')
    #APPEND(Outputs ,'\t,output(samplesabovethreshold  ,named(\'' + pUniqueOutput + 'samplesabovethreshold\'))\n')
    #APPEND(Outputs ,'\t,output(samplerecseq           ,named(\'' + pUniqueOutput + 'samplerecseq\'         ))\n')
    #APPEND(Outputs ,'\t,output(samplerecsgt           ,named(\'' + pUniqueOutput + 'samplerecsgt\'         ))\n')
    #APPEND(Outputs ,'\t,output(allsamplerecs          ,named(\'' + pUniqueOutput + 'allsamplerecs\'        ))\n')
    #APPEND(Outputs ,'\t,output(totalsamplesreal       ,named(\'' + pUniqueOutput + 'totalsamplesreal\'     ))\n')
    #APPEND(Outputs ,'\t,output(samplesperreviewer     ,named(\'' + pUniqueOutput + 'samplesperreviewer\'   ))\n')
    #APPEND(Outputs ,'\t,output(samplesremainder       ,named(\'' + pUniqueOutput + 'samplesremainder\'     ))\n')
  #END
//get norm and roll transforms loop
  #SET(NormTransform ,'')
  #SET(RollTransform ,'')
  #SET(RollLayout    ,'')
  #SET(CNTR ,1)

  #LOOP
    #IF(%CNTR% > count(%setfields%))
      #BREAK
    #END

    #APPEND(NormTransform ,',self.' + %setfields%[%CNTR%] + ' := left.' + %setfields%[%CNTR%])
    #APPEND(RollTransform ,',self.' + %setfields%[%CNTR%] + ' := if(right.' + %'lID'% + ' != 0  ,left.' + %setfields%[%CNTR%] + ',0)')

    #APPEND(RollLayout    ,' ,typeof(kmatchsample.' + %setfields%[%CNTR%] + ') ' + %setfields%[%CNTR%])
    
    
    #SET(CNTR ,%CNTR% + 1)
  #END
  
  #SET(NormTransform ,'@reviewer@_norm := project(normalize(@reviewer@,3,transform(' + %'laynorm'% + ',self.' + %'lID'% + ' := choose(counter  ,left.' + %'lID'% + '1,left.' + %'lID'% + '2,0),self.conf := left.conf,self.conf_prop := left.conf_prop' + %'NormTransform'% + ')) ,transform({unsigned cnt,recordof(left)},self.cnt := counter + ((startrec@counter@ - 1) * 3),self := left));\n')
  #SET(RollTransform ,'@reviewer@_rolled := sort(join(@reviewer@_norm ,allproxidsrolled ,left.' + %'lID'% + ' = right.' + %'lID'% + ' ,transform({unsigned cnt,integer2 conf' + %'RollLayout'% + ',recordof(right)},self.cnt := left.cnt,self.conf := if(right.' + %'lID'% + ' != 0  ,left.conf,0)' + %'RollTransform'% + ',self := right),left outer,lookup),cnt);\n')

/////main loop
  #SET(CNTR ,1)

  #LOOP
    #IF(%CNTR% > count(psetReviewers))
      #BREAK
    #END
    #SET(multipier  ,%CNTR% - 1)

    #IF(%CNTR% > 1)
      #APPEND(startrec     ,'startrec' + %'CNTR'% + '   := startrec' + %'multipier'% + ' + samplesperreviewer + mapremainder(' + %'multipier'% + ');\n')
    #END
    #APPEND(mapRemainders     ,'  ,previewer         = ' + %'CNTR'% + ' and samplesremainder >= ' + %'CNTR'% + '  => 1\n')

    #APPEND(Samples     ,psetReviewers[%CNTR%] + ' := choosen(allsamplerecs,samplesperreviewer + mapremainder(' + %'CNTR'% + '),startrec' + %'CNTR'% + ' );\n')
    #APPEND(SlimSamples ,psetReviewers[%CNTR%] + '_Score  := project(' + psetReviewers[%CNTR%] + ',' + %'layscore'%  + ' );\n')
    #APPEND(SlimSamples ,psetReviewers[%CNTR%] + '_Fields := project(' + psetReviewers[%CNTR%] + ',' + %'layfields'% + ' );\n')

    #APPEND(NormSamples ,regexreplace('@counter@',regexreplace('@reviewer@',%'NormTransform'% ,psetReviewers[%CNTR%],nocase)  ,%'CNTR'%,nocase) )
    #APPEND(RollSamples ,regexreplace('@counter@',regexreplace('@reviewer@',%'RollTransform'% ,psetReviewers[%CNTR%],nocase)  ,%'CNTR'%,nocase) )
 
    #IF(%CNTR% = 1)
      #APPEND(AllRolled ,'\t  ' + psetReviewers[%CNTR%] + '_rolled')
      #APPEND(AllCands  ,'\t  ' + psetReviewers[%CNTR%])
      #APPEND(AllScores ,'\t  ' + psetReviewers[%CNTR%] + '_score')
    #ELSE
      #APPEND(AllRolled ,'\t+ ' + psetReviewers[%CNTR%] + '_rolled')
      #APPEND(AllCands  ,'\t+ ' + psetReviewers[%CNTR%])
      #APPEND(AllScores ,'\t+ ' + psetReviewers[%CNTR%] + '_score')
    #END
    #APPEND(outputNormSamples ,'\t,output(' + psetReviewers[%CNTR%] + '_norm         ,named(\'' + pUniqueOutput + psetReviewers[%CNTR%] + '_norm\'       ),all)\n')
    #APPEND(outputRollSamples ,'\t,output(' + psetReviewers[%CNTR%] + '_rolled       ,named(\'' + pUniqueOutput + psetReviewers[%CNTR%] + '\'     ),all)\n')

    #APPEND(BigOutputs ,'\t,output(\'-----------------------------------\' ,named(\'' + pUniqueOutput + %'SepOutput'% + '\'))\n')
    #APPEND(BigOutputs ,'\t,output(' + psetReviewers[%CNTR%] + '         ,named(\'' + pUniqueOutput + psetReviewers[%CNTR%] + '_cands\'       ),all)\n')
    #APPEND(BigOutputs ,'\t,output(' + psetReviewers[%CNTR%] + '_score   ,named(\'' + pUniqueOutput + psetReviewers[%CNTR%] + '_scores\'),all)\n')
//    #APPEND(BigOutputs ,'\t,output(' + psetReviewers[%CNTR%] + '_Fields  ,named(\'' + psetReviewers[%CNTR%] + '_Fields\'))\n')
    
    #APPEND(SepOutput ,'_')
    #SET(EqIndex      ,%EqIndex% + %cnteqSamples%)
    #SET(GtIndex      ,%GtIndex% + %cntgtSamples%)
    #SET(CNTR ,%CNTR% + 1)
  #END
  
  #APPEND(mapRemainders     ,'  ,0\n);\n')
  
  #APPEND(AllRolled ,'\t,cnt)	;')
  #APPEND(AllCands  ,'\t;')
  #APPEND(AllScores ,'\t;')
  #APPEND(ECL ,%'mapRemainders'% + '\n' )
  #APPEND(ECL ,%'startrec'% + '\n' )
  #APPEND(ECL ,%'Samples'%      + '\n' )
  #APPEND(ECL ,%'NormSamples'%  + '\n' )
  #APPEND(ECL ,%'RollSamples'%  + '\n' )
  #APPEND(ECL ,%'AllRolled'%    + '\n' )
  #APPEND(ECL ,%'SlimSamples'%  + '\n' )
  #APPEND(ECL ,%'AllCands'%    + '\n' )
  #APPEND(ECL ,%'AllScores'%    + '\n' )
  #APPEND(ECL ,'return PARALLEL(\n' + %'Outputs'% + %'outputRollSamples'% /*+ %'outputNormSamples'%*/ + %'BigOutputs'% + ');\n'   )
  
  #SET(ECL  ,'' + %'ECL'%)

	#if(pOutputEcl = true)
		return output(%'ECL'%);
	#ELSE
		%ECL%
	#END

endmacro;