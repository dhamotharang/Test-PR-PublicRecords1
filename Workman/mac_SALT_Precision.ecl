/*
  WorkMan.mac_SALT_Precision -- Calculates SALT Precision.  Outputs two results, one with the precision number and a few other relevant totals
                              2nd result is the worksheet with matchesfound,bads, error rate, etc per confidence level.

  output from WorkMan.mac_SetupPrecision input here

/*
dWks20130521 := sort(dedup(sort(BIPV2_ProxID.Files().wkhistory.qa(iteration != '',version = '20130521',(unsigned)matchesperformed != 0                  ),iteration,-wuid),iteration),(unsigned)iteration);

d20130521_precision := WorkMan.mac_SetupPrecision(dWks20130521,630,5,7);

setiters := ['20130521','35','20130521','34','20130521','33','20130521','32','20130521','31','20130521','30','20130330','29','20130330','27','20130330','26','20130330','25','20130212','24','20130212','23','20130212','22','20130212','21','20130212','20','20130212','19','20130212','18','20130212','17','20130212','16','20130212','15','20130212','14','20130212','13','20130212','12','20130212','11','20130212','10','20130212','9','20130212','8','20130212','7','20130212','6','20130212','5','20130212','4','20130212','3','20130212','2','20130212','1'];

dprecision := WorkMan.mac_SALT_Precision(dall,[],false);

dprecision;

setiters := ['20130521','35','20130521','34','20130521','33','20130521','32','20130521','31','20130521','30','20130330','29','20130330','27','20130330','26','20130330','25','20130212','24','20130212','23','20130212','22','20130212','21','20130212','20','20130212','19','20130212','18','20130212','17','20130212','16','20130212','15','20130212','14','20130212','13','20130212','12','20130212','11','20130212','10','20130212','9','20130212','8','20130212','7','20130212','6','20130212','5','20130212','4','20130212','3','20130212','2','20130212','1'];
WorkMan.mac_SALT_Precision(dall,setiters,false);

*/
EXPORT mac_SALT_Precision(
   pDataset                           // a dataset resulting from a call to WorkMan.mac_SetupPrecision.  This is the raw materials for the precision calculation
  ,pSet                   = '[]'
	,pOutputEcl				      = 'false'   // Should output the ecl as a string(for testing) or actually run the ecl
) :=
functionmacro

  #UNIQUENAME(ECL)
  #UNIQUENAME(ECLSTRING)
  #UNIQUENAME(CNTR)
  #UNIQUENAME(PREVVERSION)
  #UNIQUENAME(LAYITER)
  #UNIQUENAME(LAYITERSLIM)
  #UNIQUENAME(LAYVERSION)
  #UNIQUENAME(LAYVERSIONSLIM)
  #UNIQUENAME(LAYALLITERATIONS)
  #UNIQUENAME(LAYALLITERATIONSSLIM)
  #UNIQUENAME(PREVVERSION)
  #UNIQUENAME(ITERATION)
  #UNIQUENAME(VERSION   )
  #UNIQUENAME(VER_ITER   )
  #UNIQUENAME(JOINTRANSFORM   )
  #UNIQUENAME(ROLLUPTRANSFORM  )
  #UNIQUENAME(SLIMTRANSFORM   )
  #UNIQUENAME(TOTALTRANSFORM   )
  #UNIQUENAME(COMMATRANSFORM   )
  #UNIQUENAME(MYSET   )
  #UNIQUENAME(LAYOUTTOOLS)
  
  #SET    (ECL,'layconfslim := {unsigned matchesfound};\n')
  
  #APPEND (ECL,'laycalculatederrors := {string Number, string Rate};\n')
  #APPEND (ECL,'layreviewresults    := {string Samples,string Bads_Plus_R_Div2,string bads,string questionables};\n')
  #APPEND (ECL,'layerrors           := {laycalculatederrors Calculated_Errors,layreviewresults Reviewed_Results};     \n')
  #APPEND (ECL,'laytotals           := {string MatchesFound,string PercentMatchesFound};\n')
  #APPEND (ECL,'layerrorcounts      := {unsigned bad_links, unsigned questionable_links};\n')

  #APPEND (ECL,'layconflevels := {unsigned conf, unsigned matchesfound};\n')
  #APPEND (ECL,'laymatchesfound := {string matchesfound};\n')
  #APPEND (ECL,'layconfmets   := {layconflevels };\n')
  #APPEND (ECL,'dnormconflevels := ' + #TEXT(pDataset) + ';\n')

  #APPEND (ECL,'sumconfmatches := sort(table(dnormconflevels ,{conf,unsigned matchesfound := sum(group,matchesfound),unsigned checked_matches := sum(group,Review_Info.Checked_matches),unsigned bad_Matches := sum(group,Review_Info.bad_Matches),unsigned questionable_matches := sum(group,Review_Info.questionable_matches)},conf,few),conf);\n')
  #APPEND (ECL,'summatchesperformed := sum(sumconfmatches,matchesfound);\n')
  #APPEND (ECL,'daddfield      := project(sumconfmatches,transform({unsigned numerrors, real8 errorrate,unsigned checked,real8 BadsPlusRDiv2,recordof(sumconfmatches),unsigned RunningtotalMatches,real8 pctTotalMatches}\n')
  #APPEND (ECL,'  ,self := left\n')
  #APPEND (ECL,'  ,self.RunningtotalMatches := left.matchesfound\n')
  #APPEND (ECL,'  ,self.checked       := left.checked_matches \n')
  #APPEND (ECL,'  ,self.BadsPlusRDiv2 := left.bad_matches + (left.questionable_matches / 2);\n')
  #APPEND (ECL,'  ,self := []));\n')
  #APPEND (ECL,'daddpercent    := iterate(daddfield,transform(recordof(daddfield)\n')
  #APPEND (ECL,'  ,self.RunningtotalMatches := left.RunningtotalMatches + right.RunningtotalMatches  \n')
  #APPEND (ECL,'  ,self.pctTotalMatches     := self.RunningtotalMatches / summatchesperformed * 100.0\n')
  #APPEND (ECL,'  ,self.errorrate           := if(right.checked != 0  ,right.BadsPlusRDiv2 / right.checked  ,left.errorrate / 2)\n')
  #APPEND (ECL,'  ,self.numerrors           := self.errorrate * right.matchesfound\n')
  #APPEND (ECL,'  ,self                     := right\n')
  #APPEND (ECL,'));\n')
  #APPEND (ECL,'precision := (1 - (sum(daddpercent,numerrors) / summatchesperformed)) * 100.0;\n\n')

  #SET(CNTR        ,1)
  #SET(LAYITER     ,'')
  #SET(ITERATION   ,'')
  #SET(VERSION     ,'')
  #SET(VER_ITER     ,'')
  #SET(LAYVERSION   ,'')
  #SET(LAYITERSLIM     ,'')
  #SET(LAYVERSIONSLIM   ,'')
  #SET(LAYALLITERATIONS ,'')
  #SET(LAYALLITERATIONSSLIM ,'')

  #SET   (JOINTRANSFORM   ,'djoin := join(\n')
  #APPEND(JOINTRANSFORM   ,'   dadditerations\n')
  #APPEND(JOINTRANSFORM   ,'  ,dnormconflevels\n')
  #APPEND(JOINTRANSFORM   ,'  ,left.conf = right.conf\n')
  #APPEND(JOINTRANSFORM   ,'  ,transform(\n')
  #APPEND(JOINTRANSFORM   ,'     recordof(left)\n')
  
  #SET    (ROLLUPTRANSFORM ,'drollup := rollup(sort(djoin,conf,version,(unsigned)iteration) ,left.conf = right.conf ,transform(\n')
  #APPEND (ROLLUPTRANSFORM ,'   recordof(left)                                                                                 \n')

  #SET    (SLIMTRANSFORM ,'dslim := project(drollupsort,transform({string conf, string matchesfound,string pcttotalmatches,layerrors,laytotals Cumulative_Totals,layiteration_slim Iterations}\n')

  #SET   (TOTALTRANSFORM   ,'dtotalrecord := rollup(dslim,true,transform(recordof(left)\n')
  #APPEND(TOTALTRANSFORM   ,'  ,self.conf                                                  := \'Totals\'\n')
  #APPEND(TOTALTRANSFORM   ,'  ,self.MatchesFound                                          := (string)((unsigned)left.MatchesFound              + (unsigned)right.MatchesFound)\n')
  #APPEND(TOTALTRANSFORM   ,'  ,self.pcttotalmatches                                       := \'100.0\'\n')

  #SET   (COMMATRANSFORM ,'dcommas := project(dprecisionworksheet,transform(recordof(left)\n')

  #LOOP
    #IF(%CNTR% > count(pSet))
      #BREAK
    #END
    
    #SET(VERSION    ,pSet[%CNTR%    ])
    #SET(ITERATION  ,pSet[%CNTR% + 1])
    #SET(VER_ITER   ,%'VERSION'% + '_' + %'ITERATION'%)
    
    //add this field to layout
    #APPEND(LAYITER     ,'layit' + %'VER_ITER'% + ' := {layconflevels Iteration_' + %'ITERATION'% + '};\n')
    #APPEND(LAYITERSLIM ,'layit' + %'VER_ITER'% + '_slim := {{string matchesfound,string pctmatches} Iteration_' + %'ITERATION'% + '};\n')
    #APPEND(JOINTRANSFORM   ,'    ,self.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '   := if(right.version = \'' + %'VERSION'% + '\' and right.iteration = \'' + %'ITERATION'% + '\'   ,row({right.conf,right.matchesfound},layconflevels)  ,left.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + ')\n')
    #APPEND(ROLLUPTRANSFORM ,'  ,self.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '   := if(left.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '.conf  != 0  ,left.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '   ,right.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '    );\n')

    #APPEND(SLIMTRANSFORM   ,'  ,self.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '.matchesfound   := (string)left.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '.matchesfound  ;\n')
    #APPEND(SLIMTRANSFORM   ,'  ,self.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '.pctmatches     := realformat(left.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '.matchesfound  / sum(' + #TEXT(pDataset) + '(version = \'' + %'VERSION'% + '\',iteration = \'' + %'ITERATION'% + '\'),matchesfound) * 100.0,8,4);\n')

    #APPEND(TOTALTRANSFORM   ,'  ,self.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '.matchesfound   := (string)((unsigned)left.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '.matchesfound + ' + ' (unsigned)right.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '.matchesfound) ;\n')
    #APPEND(TOTALTRANSFORM   ,'  ,self.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '.pctmatches     := \'100.0\'\n')

    #APPEND(COMMATRANSFORM   ,'  ,self.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '.matchesfound   := ut.fIntWithCommas((unsigned)left.Iterations.Build_' + %'VERSION'% + '.Iteration_' + %'ITERATION'% + '.matchesfound)  ;\n')

    #IF(%CNTR% = 1)
      #APPEND(LAYVERSION      ,'layversion' + %'VERSION'% + ' := {layit' + %'VER_ITER'%)
      #APPEND(LAYVERSIONSLIM  ,'layversion' + %'VERSION'% + '_slim := {layit' + %'VER_ITER'% + '_slim')
      #APPEND(LAYALLITERATIONS  ,'layiteration_details  := {layversion' + %'VERSION'% + ' Build_' + %'VERSION'%)
      #APPEND(LAYALLITERATIONSSLIM  ,'layiteration_slim  := {layversion' + %'VERSION'% + '_slim Build_' + %'VERSION'%)
    #ELSIF(%'PREVVERSION'% != %'VERSION'%)
      #APPEND(LAYVERSION          ,'};\n')
      #APPEND(LAYVERSION          ,'layversion' + %'VERSION'% + ' := {layit' + %'VER_ITER'%)
      #APPEND(LAYALLITERATIONS    ,',layversion' + %'VERSION'% + ' Build_' + %'VERSION'%)
      #APPEND(LAYALLITERATIONSSLIM    ,',layversion' + %'VERSION'% + '_slim Build_' + %'VERSION'%)
      #APPEND(LAYVERSIONSLIM      ,'};\n')
      #APPEND(LAYVERSIONSLIM      ,'layversion' + %'VERSION'% + '_slim := {layit' + %'VER_ITER'% + '_slim')
    #ELSE
      #APPEND(LAYVERSION      ,',layit' + %'VER_ITER'%)
      #APPEND(LAYVERSIONSLIM  ,',layit' + %'VER_ITER'% + '_slim')
    #END
    
    #SET(PREVVERSION    ,%'VERSION'%)
    #SET(CNTR           ,%CNTR% + 2)    
  #END
  
  #APPEND(LAYVERSION    ,'};\n')
  #APPEND(LAYVERSIONSLIM ,'};\n')
  #APPEND(LAYALLITERATIONS ,'};\n')
  #APPEND(LAYALLITERATIONSSLIM ,'};\n')
  
  #APPEND(ECL ,%'LAYITER'% + %'LAYVERSION'% + %'LAYITERSLIM'% + %'LAYVERSIONSLIM'% + %'LAYALLITERATIONS'% + %'LAYALLITERATIONSSLIM'%)
  
  #APPEND(ECL ,'dadditerations := project(daddpercent ,transform({recordof(daddpercent),string version,string iteration,layiteration_details Iterations}\n')  
  #APPEND(ECL ,'  ,self := left\n')  
  #APPEND(ECL ,'  ,self := []\n')  
  #APPEND(ECL ,'));\n')  

  #APPEND(JOINTRANSFORM   ,'    ,self.version               := right.version\n')
  #APPEND(JOINTRANSFORM   ,'    ,self.iteration             := right.iteration\n')
  #APPEND(JOINTRANSFORM   ,'    ,self                       := left;\n')
  #APPEND(JOINTRANSFORM   ,'  )\n')
  #APPEND(JOINTRANSFORM   ,');\n')

  #APPEND(ECL ,%'JOINTRANSFORM'%)  

  #APPEND(ROLLUPTRANSFORM   ,'  ,self                                := left\n')
  #APPEND(ROLLUPTRANSFORM   ,'));\n')
  #APPEND(ROLLUPTRANSFORM   ,'drollupsort := sort(drollup,conf,version,iteration);\n')

  #APPEND(ECL ,%'ROLLUPTRANSFORM'%)  

  #APPEND(SLIMTRANSFORM   ,'  ,self.Calculated_Errors.Number                := (string)left.numerrors;\n')
  #APPEND(SLIMTRANSFORM   ,'  ,self.Calculated_Errors.Rate                  := realformat(left.errorrate * 100.0,8,4);\n')

  #APPEND(SLIMTRANSFORM   ,'  ,self.Reviewed_Results.Samples                := (string)left.checked\n')
  #APPEND(SLIMTRANSFORM   ,'  ,self.Reviewed_Results.Bads_Plus_R_Div2       := (string)left.BadsPlusRDiv2\n')
  #APPEND(SLIMTRANSFORM   ,'  ,self.Reviewed_Results.bads                   := (string)left.bad_matches\n')
  #APPEND(SLIMTRANSFORM   ,'  ,self.Reviewed_Results.questionables          := (string)left.questionable_matches\n')

  #APPEND(SLIMTRANSFORM   ,'  ,self.Cumulative_Totals.MatchesFound          := (string)left.RunningtotalMatches\n')
  #APPEND(SLIMTRANSFORM   ,'  ,self.Cumulative_Totals.PercentMatchesFound   := realformat(left.pctTotalMatches,8,4)\n')
  #APPEND(SLIMTRANSFORM   ,'  ,self.pcttotalmatches                         := realformat(left.matchesfound / summatchesperformed * 100.0,8,4)\n')
  #APPEND(SLIMTRANSFORM   ,'  ,self.conf                                    := (string)left.conf\n')
  #APPEND(SLIMTRANSFORM   ,'  ,self.matchesfound                            := (string)left.matchesfound\n')
//  #APPEND(SLIMTRANSFORM   ,'  ,self                                         := left\n')
  #APPEND(SLIMTRANSFORM   ,'));                                                                      \n')

  #APPEND(ECL ,%'SLIMTRANSFORM'%)  

  #APPEND(TOTALTRANSFORM   ,'  ,self.Calculated_Errors.Number                              := (string)((unsigned)left.Calculated_Errors.Number           + (unsigned)right.Calculated_Errors.Number )             \n')
  #APPEND(TOTALTRANSFORM   ,'  ,self.Reviewed_Results.Samples                              := (string)((unsigned)left.Reviewed_Results.Samples           + (unsigned)right.Reviewed_Results.Samples )             \n')
  #APPEND(TOTALTRANSFORM   ,'  ,self.Reviewed_Results.Bads_Plus_R_Div2                     := (string)((real8)left.Reviewed_Results.Bads_Plus_R_Div2     + (real8)right.Reviewed_Results.Bads_Plus_R_Div2  )   \n')
  #APPEND(TOTALTRANSFORM   ,'  ,self.Calculated_Errors.Rate                                := realformat((real8)self.Reviewed_Results.Bads_Plus_R_Div2 / (unsigned)self.Reviewed_Results.Samples,8,4) \n')
  #APPEND(TOTALTRANSFORM   ,'  ,self.Reviewed_Results.bads                                 := (string)((unsigned)left.Reviewed_Results.bads              + (unsigned)right.Reviewed_Results.bads           )      \n')
  #APPEND(TOTALTRANSFORM   ,'  ,self.Reviewed_Results.questionables                        := (string)((unsigned)left.Reviewed_Results.questionables     + (unsigned)right.Reviewed_Results.questionables  )      \n')
  #APPEND(TOTALTRANSFORM   ,'  ,self.Cumulative_Totals.MatchesFound                        := if((unsigned)left.Cumulative_Totals.MatchesFound > (unsigned)right.Cumulative_Totals.MatchesFound ,left.Cumulative_Totals.MatchesFound,right.Cumulative_Totals.MatchesFound)\n')
  #APPEND(TOTALTRANSFORM   ,'  ,self.Cumulative_Totals.PercentMatchesFound                 := \'100.0\' \n')
  #APPEND(TOTALTRANSFORM   ,'));\n')

  #APPEND(ECL ,%'TOTALTRANSFORM'%)  

  #APPEND(ECL ,'dprecisionworksheet := dtotalrecord + dslim;\n')  

  #APPEND(COMMATRANSFORM   ,'  ,self.Calculated_Errors.Number                := ut.fIntWithCommas((unsigned)left.Calculated_Errors.Number);\n')
  #APPEND(COMMATRANSFORM   ,'  ,self.Calculated_Errors.Rate                  := left.Calculated_Errors.Rate;\n')

  #APPEND(COMMATRANSFORM   ,'  ,self.Reviewed_Results.Samples                := ut.fIntWithCommas((unsigned)left.Reviewed_Results.Samples)\n')
  #APPEND(COMMATRANSFORM   ,'  ,self.Reviewed_Results.Bads_Plus_R_Div2       := (string)left.Reviewed_Results.Bads_Plus_R_Div2\n')
  #APPEND(COMMATRANSFORM   ,'  ,self.Reviewed_Results.bads                   := ut.fIntWithCommas((unsigned)left.Reviewed_Results.bads)\n')
  #APPEND(COMMATRANSFORM   ,'  ,self.Reviewed_Results.questionables          := ut.fIntWithCommas((unsigned)(string)left.Reviewed_Results.questionables)\n')

  #APPEND(COMMATRANSFORM   ,'  ,self.Cumulative_Totals.MatchesFound          := ut.fIntWithCommas((unsigned)left.Cumulative_Totals.MatchesFound)\n')
  #APPEND(COMMATRANSFORM   ,'  ,self.Cumulative_Totals.PercentMatchesFound   := left.Cumulative_Totals.PercentMatchesFound\n')
  #APPEND(COMMATRANSFORM   ,'  ,self.pcttotalmatches                         := left.pcttotalmatches\n')
  #APPEND(COMMATRANSFORM   ,'  ,self.conf                                    := left.conf\n')
  #APPEND(COMMATRANSFORM   ,'  ,self.matchesfound                            := ut.fIntWithCommas((unsigned)left.matchesfound)\n')
  #APPEND(COMMATRANSFORM   ,'  ,self                                         := left\n')
  #APPEND(COMMATRANSFORM   ,'));\n')

  #APPEND(ECL ,%'COMMATRANSFORM'%)  

/*
laycalculatederrors := {unsigned Number, string Rate}; ////
layreviewresults    := {unsigned Samples,real8 Bads_Plus_R_Div2,unsigned bads,unsigned questionables}; ////
layerrors           := {laycalculatederrors Calculated_Errors,layreviewresults Reviewed_Results};////

laytotals   := {unsigned MatchesFound,string PercentMatchesFound};
{string conf, unsigned matchesfound,string pcttotalmatches,layerrors,laytotals Cumulative_Totals
                            ,layiteration_slim Iterations}
*/                            
  #SET   (MYSET ,'dtableitersversions := sort(table(' + #TEXT(pDataset) + ' ,{version,iteration}  ,version,iteration),-(unsigned)version,-(unsigned)iteration);\n')  
  #APPEND(MYSET ,'dprojiters := project(dtableitersversions ,transform({string setitems},self.setitems := \',\\\'\' + left.version + \'\\\',\\\'\' + left.iteration + \'\\\'\'));\n')  
  #APPEND(MYSET ,'drollupiterations := rollup(dprojiters,true,transform(recordof(left)\n')  
  #APPEND(MYSET ,'  ,self.setitems := left.setitems + right.setitems\n')  
  #APPEND(MYSET ,'));\n')  
  #APPEND(MYSET ,'myset := \'setiters := [\' + drollupiterations[1].setitems[2..] + \'];\\nWorkMan.mac_SALT_Precision(' + #TEXT(pDataset) + ',setiters,false);\';')  

  #APPEND(ECL ,'summatchesfound   := sum(dslim,(unsigned)matchesfound);\n')  
  #APPEND(ECL ,'sumchecked        := sum(project(dslim,transform({unsigned checked  },self.checked   := (unsigned)left.Reviewed_Results.Samples)),checked  );\n')  
  #APPEND(ECL ,'sumcalcerrors     := sum(project(dslim,transform({unsigned numerrors},self.numerrors := (unsigned)left.Calculated_Errors.Number)),numerrors);\n')  
  #APPEND(ECL ,'sumreviewedbads   := sum(sumconfmatches,(unsigned)bad_matches);\n')  
  #APPEND(ECL ,'sumreviewedquest  := sum(sumconfmatches,(unsigned)questionable_matches);\n\n')  
  #APPEND(ECL ,'dprecision := dataset([{(string)precision,ut.fIntWithCommas(summatchesfound),ut.fIntWithCommas(sumcalcerrors),ut.fIntWithCommas(sumchecked),ut.fIntWithCommas(sumreviewedbads),ut.fIntWithCommas(sumreviewedquest)}],{string Precision,string Total_Matches,string Total_Calculated_Errors,string Total_Matches_Reviewed, string Total_Bads_Found, string Total_Questionable_Found});\n\n')  

  #APPEND(ECL ,'outputprecision := sequential(\n')  
  #APPEND(ECL ,'   output(dprecision          ,named(\'Precision\'         ))\n')  
  #APPEND(ECL ,'  ,output(dcommas             ,named(\'PrecisionWorksheet\'),all)\n')  
  #APPEND(ECL ,');\n')  

  #SET(ECLSTRING  ,%'ECL'%)
	#if(count(pSet) = 0)
    #SET(ECLSTRING  ,%'MYSET'%)
    #SET(ECL        ,%'MYSET'% + '\nreturn output(myset);\n')
  #ELSE
    #SET(ECLSTRING  ,%'ECL'%)
    #SET(ECL        ,%'ECL'% + '\nreturn outputprecision;\n')
  #END
  
	#if(pOutputEcl = true)
		return %'ECLSTRING'%;
	#ELSE
		%ECL%
	#END

endmacro;