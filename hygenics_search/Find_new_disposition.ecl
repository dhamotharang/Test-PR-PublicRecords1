dev :=dataset('~thor_200::base::fcra_criminal_offenses_'+hygenics_search.Version.Development,hygenics_search.Layout_Moxie_Offenses,thor)
				(fcra_conviction_flag ='U' and 
				vendor not in hygenics_search.sDOC_Vendors_Conviction_Unknown and 
				vendor not in hygenics_search.sCourt_Vendors_With_Conviction_Based_Upon_Sent_Date and 
				vendor not in hygenics_search.sCourt_Vendors_With_Only_Traffic and 
				vendor not in hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Off_Lev and 
				vendor not in hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Offender_Key and 
				vendor not in hygenics_search.sDOC_Vendors_Conviction_Unknown and 
				vendor not in hygenics_search.sDOC_Vendors_NoOffense_NoConviction //and 
				//court_disp_desc not in set_exclude
				);
				
lkup:= hygenics_search.File_Conviction_Lookup;

layout_dev:= record
dev.court_disp_desc;
dev.fcra_conviction_flag;
total:= count(group);
end;

tblUnqDisp := sort(table(dev,layout_dev,court_disp_desc,fcra_conviction_flag,few),court_disp_desc,fcra_conviction_flag);


tblUnqDisp trecs1(tblUnqDisp L, lkup R) := transform
self := L;
end;
			
getNonMatchingDisp := join(tblUnqDisp,lkup,
				stringlib.stringtouppercase(trim(left.court_disp_desc,left,right)) = stringlib.stringtouppercase(trim(right.court_disp_desc,left,right)),
				trecs1(left,right),left only, lookup);

updatelookup := if((integer)Crim_Common.Version_Development-(integer)Crim_Common.Version_Production = 30 
										,sequential(
												output(getNonMatchingDisp,,'~thor_200::in::'+Crim_Common.Version_Development+'::NewDispositions.csv',csv(terminator('\r\n'), separator('~')),overwrite),
												fileservices.Despray('~thor_200::in::'+Crim_Common.Version_Development+'::NewDispositions.csv', 'edata12-bld.br.seisint.com', '/stub_cleaning/court/dispositions/toLegal/NewDispositions_'+Crim_Common.Version_Development+'.csv'),
												fileservices.SendEmail('tgibson@seisint.com', 'FCRA Criminal Court','New Crim Court Dispositions Available')
)
,output('No_disposition_updates'));


sequential(
												output(getNonMatchingDisp,,'~thor_200::in::'+Crim_Common.Version_Development+'::NewDispositions.csv',csv(terminator('\r\n'), separator('~')),overwrite),
												fileservices.Despray('~thor_200::in::'+Crim_Common.Version_Development+'::NewDispositions.csv', 'edata12-bld.br.seisint.com', '/stub_cleaning/court/dispositions/toLegal/NewDispositions_'+Crim_Common.Version_Development+'.csv'),
												fileservices.SendEmail('tgibson@seisint.com', 'FCRA Criminal Court','New Crim Court Dispositions Available')
)
//updatelookup;


// layout_dev trecs2(tblUnqDisp L, lkup R) := transform
// self := L;// end;

// getMatchingDisp := join(tblUnqDisp,lkup,
				// left.court_disp_desc = right.court_disp_desc,
				// trecs2(left,right), lookup);

// layout_dev trecs3(getMatchingDisp L, lkup R) := transform
// self := L;
// end;				
// getMatchingDispDiffFlag := join(getMatchingDisp,lkup,
				// left.court_disp_desc = right.court_disp_desc and
				// left.fcra_conviction_flag = right.conviction_flag,
				// trecs3(left,right),left only, lookup) : persist('~thor_200::persist::tempdisp');
				
// output(getMatchingDispDiffFlag,named('DispositionsFlaggedByProcessOtherThanTable'));
				
				
// dev trecs4(dev L ,getMatchingDispDiffFlag R) := transform
// self := L;
// end;

// getMatchingDispDiffFlagSources := join(dev,getMatchingDispDiffFlag(fcra_conviction_flag<>'U'),
				// left.court_disp_desc = right.court_disp_desc and 
				// left.fcra_conviction_flag = right.fcra_conviction_flag,
				// trecs4(left,right), lookup) : persist('~thor_200::persist::tempdisp2');
				

// layout_getMatchingDispDiffFlagSources:= record
// getMatchingDispDiffFlagSources.source_file;
// total:= count(group);
// end;

// tblMatchingDispDiffFlagSources := sort(table(getMatchingDispDiffFlagSources,layout_getMatchingDispDiffFlagSources,source_file,few),source_file);

// output(tblMatchingDispDiffFlagSources,all,named('SourcesToConfirmProperFlagging'));
				

