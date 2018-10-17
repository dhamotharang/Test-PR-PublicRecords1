//Executable code
import tools;
EXPORT _Proc_Iterate_Experimental(string modname = 'BIPV2_ProxID',boolean pIsTesting = false) := MODULE
// shared fprefix := '~temp::PROXid::Business_DOT_SALT_micro5::';
shared fprefix := '~temp::PROXid::'+modname+'::';
export lMT := 21;
shared dataset(layout_DOT_Base) ALoop(dataset(layout_DOT_Base) ih,unsigned MatchThreshold, string pversion,unsigned iter, boolean finalLoop, set of unsigned6 idots) := 
FUNCTION
	string siter    := (string)iter;
  string lversion := pversion;
  string combo    := lversion + '_' + siter;
  string prevcombo    := lversion + '_' + (string)((unsigned)siter - 1);
  names       :=    BIPV2_ProxID.filenames(combo).dall_filenames
                  + BIPV2_ProxID.keynames (combo).dall_filenames
                  + BIPV2_ProxID.filenames(lversion).dall_filenames
                  + BIPV2_ProxID.keynames (lversion).dall_filenames
                  + BIPV2_ProxID.filenames(siter).dall_filenames
                  + BIPV2_ProxID.keynames (siter).dall_filenames
                  ;
	m := matches(ih,MatchThreshold);
	s := specificities(ih);
	mc := match_candidates(ih);
		//these for indexes
  lFinalloop := if(pIsTesting = false  ,finalLoop  ,false);
  kiter := if(lFinalLoop  ,'' ,siter);
	
	BuildIndexes(string BIsiter) := 
	FUNCTION
    liter := if(BIsiter = '' ,pversion ,BIsiter);
		mtch := debug(ih,s.specificities[1]).AnnotateMatches(m.PossibleMatches);
		prop_file := mc.candidates; // Use propagated file
		Candidates := INDEX(prop_file,{PROXid},{prop_file},keynames(liter).match_candidates_debug.logical );
		ms_temp := sort(mtch,Conf,PROXid1,PROXid2,SKEW(1.0)); // Some headers have very skewed IDs
		MatchSample := INDEX(ms_temp,{Conf,PROXid1,PROXid2},{mtch},fprefix+'match_sample_debug'+liter,SORT KEYED);
		Specificities_Key := INDEX(s.specificities,{1},{s.specificities},keynames(liter).specificities_debug.logical);
		prop_file2 := m.Patched_Candidates; // Available for External ADL2
		PatchedCandidates := INDEX(prop_file2,{PROXid},{prop_file2},fprefix+'patched_candidates'+liter);
		
//		am := m.All_Attribute_Matches;
//		Attribute_Matches := INDEX(am,{Proxid1,Proxid2},{am},keynames(liter).attribute_matches.logical);
		return sequential(PARALLEL(BUILDINDEX(Candidates,OVERWRITE),BUILDINDEX(MatchSample,OVERWRITE),BUILDINDEX(Specificities_Key,FEW,OVERWRITE),BUILDINDEX(PatchedCandidates,OVERWRITE)/*,BUILDINDEX(Attribute_Matches,OVERWRITE)*/),promote(liter,'key').new2built);	
	END;
	sequential(
		 if(siter = '1' ,sequential(output(choosen(In_DOT_Base,100)),promote('0').new2built),Promote(prevcombo).new2built)  //setup first iteration
    ,nothor(Tools.fun_ClearfilesFromSupers(project(names, transform(Tools.Layout_Names,self.name := left.logicalname)), false)) //clear supers if needed
		,parallel(
		 OUTPUT(CHOOSEN(m.MatchSample,1000),NAMED('MatchSample'+siter))
		,OUTPUT(CHOOSEN(m.BorderlineMatchSample,1000),NAMED('BorderlineMatchSample'+siter))
		,OUTPUT(CHOOSEN(m.AlmostMatchSample,1000),NAMED('AlmostMatchSample'+siter))
		,OUTPUT(CHOOSEN(m.MatchSampleRecords,1000),NAMED('MatchSampleRecords'+siter))
		,OUTPUT(CHOOSEN(m.ToSlice,1000),NAMED('SliceOutCandidates'+siter))
		,OUTPUT(s.specificities,NAMED('Specificities'+siter))
		,OUTPUT(m.PreClusters,NAMED('PreClusters'+siter),all)
		,OUTPUT(m.PostClusters,NAMED('PostClusters'+siter),all)
		,OUTPUT(m.MatchesPerformed,NAMED('MatchesPerformed'+siter))
		,OUTPUT(m.SlicesPerformed,NAMED('SlicesPerformed'+siter))
		,OUTPUT(m.MatchesPropAssisted * 100 / m.MatchesPerformed,NAMED('PropagationAssisted_Pcnt'+siter))
		,OUTPUT(m.MatchesPropRequired * 100 / m.MatchesPerformed,NAMED('PropagationRequired_Pcnt'+siter))
		,OUTPUT(TOPN(m.RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'+siter))
		,OUTPUT(TOPN(m.ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'+siter))
		,OUTPUT(s.SpcShift,NAMED('SPCShift'+siter))
		,OUTPUT(m.PrePatchIdCount,NAMED('PrePatchIdCount'+siter))
		,OUTPUT(m.PostPatchIdCount,NAMED('PostPatchIdCount'+siter))
		,OUTPUT(m.All_matches,,fprefix+'AllMatches'+siter,OVERWRITE,COMPRESSED)
		,OUTPUT(DATASET([{m.PatchingError0,m.DidsNoRid0,m.DidsAboveRid0,m.DuplicateRids0,COUNT(mc.Unlinkables)}],{INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0}),NAMED('ValidityStatistics'+siter))
		,OUTPUT(m.patched_infile ,,filenames(combo).base.logical           ,Overwrite,__COMPRESSED__)
		,OUTPUT(m.PossibleMatches,,filenames(combo).possiblematches.logical,Overwrite,__COMPRESSED__)
    )
		,BuildIndexes(kiter)
    ,promote(combo,'base').new2built
	);
	
	return m.patched_infile;
END;
//note on finalLoop:  The idea is that whichever loop you call externally should default to true.  then, the subordinate loops it calls, it will set to false.
//  this allows us (among other things, if needed), to build a final set of indexes for just the final iteration
EXPORT Loop1(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(ih                                   , mt, pversion,1+offset, finalLoop, idots) : independent;
EXPORT Loop2(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop1(mt, ih, pversion,offset, false), mt, pversion,2+offset, finalLoop, idots) : independent;
EXPORT Loop3(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop2(mt, ih, pversion,offset, false), mt, pversion,3+offset, finalLoop, idots) : independent;
EXPORT Loop4(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop3(mt, ih, pversion,offset, false), mt, pversion,4+offset, finalLoop, idots) : independent;
EXPORT Loop5(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop4(mt, ih, pversion,offset, false), mt, pversion,5+offset, finalLoop, idots) : independent;
EXPORT Loop6(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop5(mt, ih, pversion,offset, false), mt, pversion,6+offset, finalLoop, idots) : independent;
EXPORT Loop7(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop6(mt, ih, pversion,offset, false), mt, pversion,7+offset, finalLoop, idots) : independent;
EXPORT Loop8(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop7(mt, ih, pversion,offset, false), mt, pversion,8+offset, finalLoop, idots) : independent;
EXPORT Loop9(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop8(mt, ih, pversion,offset, false), mt, pversion,9+offset, finalLoop, idots) : independent;
EXPORT Loop10(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop9 (mt, ih, pversion,offset, false), mt, pversion,10+offset, finalLoop, idots) : independent;
EXPORT Loop11(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop10(mt, ih, pversion,offset, false), mt, pversion,11+offset, finalLoop, idots) : independent;
EXPORT Loop12(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop11(mt, ih, pversion,offset, false), mt, pversion,12+offset, finalLoop, idots) : independent;
EXPORT Loop13(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop12(mt, ih, pversion,offset, false), mt, pversion,13+offset, finalLoop, idots) : independent;
EXPORT Loop14(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop13(mt, ih, pversion,offset, false), mt, pversion,14+offset, finalLoop, idots) : independent;
EXPORT Loop15(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop14(mt, ih, pversion,offset, false), mt, pversion,15+offset, finalLoop, idots) : independent;
EXPORT Loop16(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop15(mt, ih, pversion,offset, false), mt, pversion,16+offset, finalLoop, idots) : independent;
EXPORT Loop17(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop16(mt, ih, pversion,offset, false), mt, pversion,17+offset, finalLoop, idots) : independent;
EXPORT Loop18(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop17(mt, ih, pversion,offset, false), mt, pversion,18+offset, finalLoop, idots) : independent;
EXPORT Loop19(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop18(mt, ih, pversion,offset, false), mt, pversion,19+offset, finalLoop, idots) : independent;
EXPORT Loop20(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop19(mt, ih, pversion,offset, false), mt, pversion,20+offset, finalLoop, idots) : independent;
EXPORT Loop21(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop20(mt, ih, pversion,offset, false), mt, pversion,21+offset, finalLoop, idots) : independent;
EXPORT Loop22(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop21(mt, ih, pversion,offset, false), mt, pversion,22+offset, finalLoop, idots) : independent;
EXPORT Loop23(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop22(mt, ih, pversion,offset, false), mt, pversion,23+offset, finalLoop, idots) : independent;
EXPORT Loop24(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop23(mt, ih, pversion,offset, false), mt, pversion,24+offset, finalLoop, idots) : independent;
EXPORT Loop25(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop24(mt, ih, pversion,offset, false), mt, pversion,25+offset, finalLoop, idots) : independent;
EXPORT Loop26(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop25(mt, ih, pversion,offset, false), mt, pversion,26+offset, finalLoop, idots) : independent;
EXPORT Loop27(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop26(mt, ih, pversion,offset, false), mt, pversion,27+offset, finalLoop, idots) : independent;
EXPORT Loop28(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop27(mt, ih, pversion,offset, false), mt, pversion,28+offset, finalLoop, idots) : independent;
EXPORT Loop29(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop28(mt, ih, pversion,offset, false), mt, pversion,29+offset, finalLoop, idots) : independent;
EXPORT Loop30(UNSIGNED mt=lMT, dataset(layout_DOT_Base) ih = In_DOT_Base, string pversion,unsigned offset=0, boolean finalLoop = true, set of unsigned6 idots=[]) := ALoop(loop29(mt, ih, pversion,offset, false), mt, pversion,30+offset, finalLoop, idots) : independent;
  
  
END;
