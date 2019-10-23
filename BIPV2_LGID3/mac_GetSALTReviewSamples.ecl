/*
	Shamelessly pilfered from Vern's tools.mac_GetSALTReviewSamples (due to some hardcoded proxid references)
  gets samples to review for people in the set
  should output the rolled up views for all samples first, then later output details if needed to look at 
  this should allow much faster review times
iter := '25';
#workunit('name','BIPV2_LGID3 Iter ' + iter + ' review samples');
psetReviewers           := ['CM','LB','TL','JL','FN','DW'];
pNumSamplesPerReviewer  := 15;
kmtch      := index(BIPV2_LGID3.Keys(BIPV2_LGID3.In_LGID3).MatchSample ,BIPV2_LGID3.keynames('20130330' + iter).match_sample_debug.logical);
tools.mac_GetReviewSamples(kmtch,lgid3,'21',pNumSamplesPerReviewer,psetReviewers,true);
*/
import tools;
EXPORT mac_GetSALTReviewSamples(
   pMatchSampleKey                    //Match sample debug index
  ,pMatchCandidatesKey                //Match Candidates key
  ,pInFile                            //Infile for matching(BIPV2_LGID3.In_LGID3)
  ,pID                                //Internal linking id(lgid3, dotid, bdid, did, etc)
  ,pThreshold                         //threshold for your matching
  ,pNumSamplesPerReviewer             //how many samples for each reviewer
  ,psetReviewers          = '[]'      //names of reviewers
	,pOutputEcl			        = 'false'		//Should output the ecl as a string(for testing) or actually run the ecl
) :=
functionmacro
	import std, tools;
		
  #UNIQUENAME(ECL)
  #UNIQUENAME(CNTR)
  #UNIQUENAME(Samples)
  #UNIQUENAME(SlimSamples)
  #UNIQUENAME(NormSamples)
  #UNIQUENAME(RollSamples)
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
// 	LOADXML('<xml/>');
  
  #SET(lID            ,#TEXT(pID    ))
  #SET(lInfile        ,trim(#TEXT(pInFile    ),all))
  #SET(lModuleIndex   ,std.str.find(%'lInfile'%,'.',1))
  #IF(%lModuleIndex% != 0)
    #SET(lModule        ,trim(std.str.cleanspaces(%'lInfile'%[1..(%lModuleIndex% - 1)] ),left,right))
  #ELSE
    #ERROR('Can\'t find module name in your infile: ' + %'lInfile'%)
  #END
  
  #SET(lMatchSampleKey ,trim(#TEXT(pMatchSampleKey),all))
  #SET   (ECL    ,'kmatchsample    := ' + %'lMatchSampleKey'% + ';\n')
  #APPEND(ECL    ,'kmatchsample_eq := pull(kmatchsample)(conf = ' + pThreshold + ');\n')
  #APPEND(ECL    ,'kmatchsample_gt := pull(kmatchsample)(conf > ' + pThreshold + ');\n')
  #APPEND(ECL    ,'//do 2/3 recs at threshold, 1/3 above threshold\n')
  #APPEND(ECL    ,'countReviewers := ' + count(psetReviewers) + ';\n')
  #APPEND(ECL    ,'totalSamples := ' + pNumSamplesPerReviewer + ' * countReviewers;\n')
  
  #APPEND(ECL    ,'countkmatchsample_eq  := count(kmatchsample_eq);\n')
  #APPEND(ECL    ,'countkmatchsample_gt  := count(kmatchsample_gt);\n')
  #APPEND(ECL    ,'samplesatthreshold          := if((unsigned)(totalsamples * 2/3)      >= countkmatchsample_eq  ,countkmatchsample_eq   ,(unsigned)(totalsamples * 2/3)      );\n')
  #APPEND(ECL    ,'samplesabovethreshold       := if((totalSamples - samplesatthreshold) >  countkmatchsample_gt  ,countkmatchsample_gt   ,(totalSamples - samplesatthreshold) );\n')
  #SET(cnteqSamples    ,(unsigned)(pNumSamplesPerReviewer * 2/3))
  #SET(cntgtSamples    ,(unsigned)(pNumSamplesPerReviewer * 1/3))
  #APPEND(ECL    ,'samplerecseq      := enth (kmatchsample_eq,samplesatthreshold     ) : independent;\n')
  #APPEND(ECL    ,'samplerecsgt      := enth (kmatchsample_gt,samplesabovethreshold  ) : independent;\n\n')
////
  #APPEND(ECL    ,'allsamplerecs     := sort(samplerecseq + samplerecsgt,lgid31 + lgid32);\n')
  #APPEND(ECL    ,'totalsamplesreal  := samplesatthreshold + samplesabovethreshold;         \n\n')
  #APPEND(ECL    ,'samplesperreviewer  := (unsigned)totalsamplesreal / countReviewers;\n')
  #APPEND(ECL    ,'samplesremainder    := totalsamplesreal % countReviewers;          \n\n')
////
  #APPEND(ECL    ,'allsamplelgid3s :=   table(table(samplerecseq + samplerecsgt  ,{unsigned6 ' + %'lID'% + ' := ' + %'lID'% + '1})\n')
  #APPEND(ECL    ,'                          + table(samplerecseq + samplerecsgt  ,{unsigned6 ' + %'lID'% + ' := ' + %'lID'% + '2})\n')
  #APPEND(ECL    ,'                      ,{' + %'lID'% + '},' + %'lID'% + ',few);\n')
  #APPEND(ECL    ,'setsamplelgid3s  := set(allsamplelgid3s  ,' + %'lID'% + ');\n')
  #APPEND(ECL    ,'alllgid3cands    := project(kcand(' + %'lID'% + ' in setsamplelgid3s)  ,' + %'lModule'% + '.match_candidates(' + %'lInfile'% + ').layout_candidates);\n')
  #APPEND(ECL    ,'s := dataset([],' + %'lModule'% + '.Layout_Specificities.R);\n')
  #APPEND(ECL    ,'alllgid3srolled := ' + %'lModule'% + '.Debug(' + %'lInfile'% + ',s).RolledEntities(alllgid3cands);\n')
  #APPEND(ECL    ,'layrolled := recordof(alllgid3srolled);\n\n')
  #APPEND(ECL    ,'mapremainder(unsigned previewer) := \n')
  #APPEND(ECL    ,'map(\n')
  #APPEND(ECL    ,'   samplesremainder  = 0 => 0         \n')
  #SET(layscore  , tools.mac_FilterLayout(recordof(pMatchSampleKey),true,'^(?!.*?(left|right|skipped).*).*$'    ,true))
  #SET(layfields , tools.mac_FilterLayout(recordof(pMatchSampleKey),true,'^(?=.*?(left|right|skipped).*).*$'    ,true)) 
  
  #SET(Samples      ,'')
  #SET(SlimSamples  ,'')
  #SET(NormSamples  ,'')
  #SET(RollSamples  ,'')
  #SET(SepOutput    ,'____')
  #SET(outputNormSamples  ,'\t,output(\'-----------------------------------\' ,named(\'__\' ))\n')
  #SET(outputRollSamples  ,'\t,output(\'-----------------------------------\' ,named(\'_\'))\n')
  #APPEND(outputRollSamples  ,'\t,output(\'2 recs per Matching Pair, + 1 blank rec for separation\' ,named(\'RolledUpViewsOfSamplesFollows\'))\n')
  #APPEND(outputRollSamples  ,'\t,output(allrolled ,named(\'AllSamplesCombined\'),all)\n')
  
  #SET(BigOutputs   ,'\t,output(\'-----------------------------------\' ,named(\'___\'))\n')
  #APPEND(BigOutputs   ,'\t,output(\'Full Match Candidates Record, then just the score\' ,named(\'DetailedMatchingInfoFollows\'))\n')
  #APPEND(BigOutputs  ,'\t,output(AllCands  ,named(\'AllSamplesCands\'),all)\n')
  #APPEND(BigOutputs  ,'\t,output(AllScores ,named(\'AllSamplesScores\'),all)\n')
  
  #SET(Outputs      ,'')
  #SET(mapRemainders ,'')
  #SET(startrec     ,'startrec1   := 1    ;\n')
  #SET(EqIndex      ,1)
  #SET(GtIndex      ,1)
  #SET(AllRolled  ,'allrolled := sort(\n')
  #SET(AllCands   ,'AllCands  := \n')
  #SET(AllScores  ,'AllScores := \n')
  
  #APPEND(Outputs ,'\t output(count(kmatchsample   ) ,named(\'TotalMatchSamples\'   ))\n')
  #APPEND(Outputs ,'\t,output(count(kmatchsample_eq) ,named(\'TotalMatchSamplesEqualToThreshold\'))\n')
  #APPEND(Outputs ,'\t,output(count(kmatchsample_gt) ,named(\'TotalMatchSamplesGreaterThanThreshold\'))\n')
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
    #APPEND(NormSamples ,psetReviewers[%CNTR%] + '_norm := project(normalize(' + psetReviewers[%CNTR%] + ',3,transform({integer2 conf,unsigned6 lgid3},self.lgid3 := choose(counter  ,left.lgid31,left.lgid32,0),self.conf := left.conf)) ,transform({unsigned cnt,recordof(left)},self.cnt := counter + ((startrec' + %'CNTR'% + ' - 1) * 3),self := left));\n')
    #APPEND(RollSamples ,psetReviewers[%CNTR%] + '_rolled := sort(join(' + psetReviewers[%CNTR%] + '_norm ,alllgid3srolled ,left.lgid3 = right.lgid3 ,transform({unsigned cnt,integer2 conf,recordof(right)},self.cnt := left.cnt,self.conf := if(right.lgid3 != 0  ,left.conf,0),self := right),left outer,lookup),cnt);\n')
 
    #IF(%CNTR% = 1)
      #APPEND(AllRolled ,'\t  ' + psetReviewers[%CNTR%] + '_rolled')
      #APPEND(AllCands  ,'\t  ' + psetReviewers[%CNTR%])
      #APPEND(AllScores ,'\t  ' + psetReviewers[%CNTR%] + '_score')
    #ELSE
      #APPEND(AllRolled ,'\t+ ' + psetReviewers[%CNTR%] + '_rolled')
      #APPEND(AllCands  ,'\t+ ' + psetReviewers[%CNTR%])
      #APPEND(AllScores ,'\t+ ' + psetReviewers[%CNTR%] + '_score')
    #END
    #APPEND(outputNormSamples ,'\t,output(' + psetReviewers[%CNTR%] + '_norm         ,named(\'' + psetReviewers[%CNTR%] + '_norm\'       ),all)\n')
    #APPEND(outputRollSamples ,'\t,output(' + psetReviewers[%CNTR%] + '_rolled       ,named(\'' + psetReviewers[%CNTR%] + '\'     ),all)\n')
    #APPEND(BigOutputs ,'\t,output(\'-----------------------------------\' ,named(\'' + %'SepOutput'% + '\'))\n')
    #APPEND(BigOutputs ,'\t,output(' + psetReviewers[%CNTR%] + '         ,named(\'' + psetReviewers[%CNTR%] + '_cands\'       ),all)\n')
    #APPEND(BigOutputs ,'\t,output(' + psetReviewers[%CNTR%] + '_score   ,named(\'' + psetReviewers[%CNTR%] + '_scores\'),all)\n')
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
