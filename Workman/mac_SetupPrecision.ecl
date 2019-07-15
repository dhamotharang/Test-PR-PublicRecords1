import std,_control,tools;
/*
  takes in dataset of workunit summary from SALT, from WorkMan.mac_CreateSummaryReport
  and pass in your numbers for bad linkes, and questionable ones
  and set of versions, iteration combos
  it can generate this set if pGenerateSet is set to true, then you can copy and paste that result and pass it into this macro
  and it will generate the results

*/
EXPORT mac_SetupPrecision(
   pDataset
  ,pNumChecked                 // 
  ,pNumBad                     // 
  ,pNumQuestionable            // 
	,pOutputEcl				      = 'false'  // Should output the ecl as a string(for testing) or actually run the ecl
) :=
functionmacro

  #UNIQUENAME(ECL)
  #UNIQUENAME(ECLSTRING)
  #UNIQUENAME(CNTR)

  layerrorcounts := {unsigned Checked_matches,unsigned bad_Matches, unsigned questionable_matches};

  layconflevels := recordof(pDataset.confidencelevels);
  
  dnormconflevels := normalize(pDataset,left.confidencelevels,transform({string version,string iteration,layconflevels,layerrorcounts Review_Info}
    ,self := right
    ,self := left
    ,self := []
  ));

  dproj := project(dnormconflevels,transform(recordof(left)
    ,self.Review_Info.Checked_matches       := if(counter = 1 ,pNumChecked      ,0);
    ,self.Review_Info.bad_Matches           := if(counter = 1 ,pNumBad          ,0);
    ,self.Review_Info.questionable_matches  := if(counter = 1 ,pNumQuestionable ,0);
    ,self                                   := left;
  ));
  
  return dproj;

endmacro;

/*
dWks20130212 := sort(dedup(sort(BIPV2_ProxID.Files().wkhistory.qa(iteration != '',version = '20130212',(unsigned)matchesperformed != 0                  ),iteration,-wuid),iteration),(unsigned)iteration);
dWks20130330 := sort(dedup(sort(BIPV2_ProxID.Files().wkhistory.qa(iteration != '',version = '20130330',(unsigned)matchesperformed != 0,iteration != '28'),iteration,-wuid),iteration),(unsigned)iteration);
dWks20130521 := sort(dedup(sort(BIPV2_ProxID.Files().wkhistory.qa(iteration != '',version = '20130521',(unsigned)matchesperformed != 0                  ),iteration,-wuid),iteration),(unsigned)iteration);

dall := 
    dWks20130212
  + dWks20130330
  + dWks20130521
  ;

matchesperformed := sum(dall,(unsigned)matchesperformed);
layconflevels := recordof(dall.confidencelevels);
layconfmets   := {layconflevels };
dnormconflevels := normalize(dall,left.confidencelevels,transform({string wuid,string iteration,string version,layconflevels},self := right,self := left));

sumconfmatches := sort(table(dnormconflevels ,{conf,unsigned matchesfound := sum(group,matchesfound)},conf,few),conf);
summatchesperformed := sum(sumconfmatches,matchesfound);
daddfield      := project(sumconfmatches,transform({unsigned numerrors, real8 errorrate,unsigned checked,real8 BadsPlusRDiv2,recordof(sumconfmatches),unsigned RunningtotalMatches,real8 pctTotalMatches}
  ,self := left
  ,self.RunningtotalMatches := left.matchesfound
*/
//  ,self.checked       := if(counter = 1 ,178/*1-24*/ + 525/*25-29*/         + 630       ,0) 
//  ,self.BadsPlusRDiv2 := if(counter = 1 ,4  /*1-24*/ + (5 + 1/2)/*25-29*/   + (5 + 7/2) ,0.0);
/*  ,self := []));
  
daddpercent    := iterate(daddfield,transform(recordof(daddfield)
  ,self.RunningtotalMatches := left.RunningtotalMatches + right.RunningtotalMatches  
  ,self.pctTotalMatches     := self.RunningtotalMatches / summatchesperformed * 100.0
  ,self.errorrate           := if(right.checked != 0  ,right.BadsPlusRDiv2 / right.checked  ,left.errorrate / 2)
  ,self.numerrors           := self.errorrate * right.matchesfound
  ,self                     := right
));
precision := (1 - (sum(daddpercent,numerrors) / summatchesperformed)) * 100.0;

dadditerations := project(daddpercent ,transform({recordof(daddpercent),string version,string iteration,{layconflevels Iteration_1} Version_20130212,{layconflevels Iteration_25} Version_20130330,{layconflevels Iteration_30} Version_20130521}
  ,self := left
  ,self := []
));

djoin := join(
   dadditerations
  ,dnormconflevels
  ,left.conf = right.conf
  ,transform(
     recordof(left)
    ,self.Version_20130212.Iteration_1   := if(right.version = '20130212' and right.iteration = '1'   ,row({right.conf,right.matchesfound},layconflevels)  ,left.Version_20130212.Iteration_1 )
    ,self.Version_20130330.Iteration_25  := if(right.version = '20130330' and right.iteration = '25'  ,row({right.conf,right.matchesfound},layconflevels)  ,left.Version_20130330.Iteration_25)
    ,self.Version_20130521.Iteration_30  := if(right.version = '20130521' and right.iteration = '30'  ,row({right.conf,right.matchesfound},layconflevels)  ,left.Version_20130521.Iteration_30)
    ,self.version               := right.version
    ,self.iteration             := right.iteration
    ,self                       := left;
  )
);

drollup := rollup(sort(djoin,conf,version,(unsigned)iteration) ,left.conf = right.conf ,transform(
   recordof(left)
  ,self.Version_20130212.Iteration_1   := if(left.Version_20130212.Iteration_1.conf  != 0  ,left.Version_20130212.Iteration_1   ,right.Version_20130212.Iteration_1    );
  ,self.Version_20130330.Iteration_25  := if(left.Version_20130330.Iteration_25.conf != 0  ,left.Version_20130330.Iteration_25  ,right.Version_20130330.Iteration_25   );
  ,self.Version_20130521.Iteration_30  := if(left.Version_20130521.Iteration_30.conf != 0  ,left.Version_20130521.Iteration_30  ,right.Version_20130521.Iteration_30   );
  ,self                                := left
));

drollupsort := sort(drollup,conf,version,iteration);
layconfslim := {unsigned matchesfound};
layerrors := {unsigned Number, real8 Rate,unsigned Checked,real8 Bads_Plus_R_Div2};
laytotals := {unsigned MatchesFound,real8 PercentMatchesFound};

dslim := project(drollupsort,transform({unsigned conf, unsigned matchesfound,layerrors Errors,laytotals Cumulative_Totals
                            ,{layconfslim Iteration_1} Version_20130212,{layconfslim Iteration_25} Version_20130330,{layconfslim Iteration_30} Version_20130521}
  ,self.Version_20130212.Iteration_1   := left.Version_20130212.Iteration_1  ;
  ,self.Version_20130330.Iteration_25  := left.Version_20130330.Iteration_25 ;
  ,self.Version_20130521.Iteration_30  := left.Version_20130521.Iteration_30 ;
  ,self.Errors.Number                  := left.numerrors;
  ,self.Errors.Rate                    := left.errorrate;
  ,self.Errors.Checked                 := left.checked;
  ,self.Errors.Bads_Plus_R_Div2        := left.BadsPlusRDiv2
  ,self.Cumulative_Totals.MatchesFound        := left.RunningtotalMatches
  ,self.Cumulative_Totals.PercentMatchesFound := left.pctTotalMatches
  ,self                                := left
));


output(dnormconflevels  ,named('dnormconflevels' ) ,all);
output(sumconfmatches   ,named('sumconfmatches'  ) ,all);
output(daddpercent      ,named('daddpercent'     ) ,all);
output(matchesperformed ,named('matchesperformed') ,all);
output(precision        ,named('precision'       ) ,all);
output(dadditerations   ,named('dadditerations'  ) ,all);
output(djoin            ,named('djoin'           ) ,all);
output(drollup          ,named('drollup'         ) ,all);
output(drollupsort      ,named('drollupsort'     ) ,all);
output(dslim            ,named('dslim'           ) ,all);
*/
