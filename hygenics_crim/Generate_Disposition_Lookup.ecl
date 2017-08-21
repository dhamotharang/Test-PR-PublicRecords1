import corrections, hygenics_search, Crim_Common;

file_courtoffenses := dataset('~thor_Data400::base::corrections_court_offenses_PUBLIC',
                              corrections.layout_courtoffenses,flat)(length(offender_key)>2 and
															Vendor not in hygenics_search.sCourt_Vendors_To_Omit
															);

file_offenses1 := dataset('~thor_data400::base::corrections_offenses_PUBLIC' ,
                              hygenics_crim.layout_offense, flat)(length(trim(offender_key, left, right))>2 and 
															Vendor not in hygenics_search.sCourt_Vendors_To_Omit);


dev1 := file_courtoffenses
				(//fcra_conviction_flag IN ['U',''] and 
				vendor not in hygenics_search.sDOC_Vendors_Conviction_Unknown and 
				vendor not in hygenics_search.sCourt_Vendors_With_Conviction_Based_Upon_Sent_Date and 
				vendor not in hygenics_search.sCourt_Vendors_With_Only_Traffic and 
				//vendor not in hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Off_Lev and 
				vendor not in hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Offender_Key and 
				vendor not in hygenics_search.sDOC_Vendors_Conviction_Unknown and 
				vendor not in hygenics_search.sDOC_Vendors_NoOffense_NoConviction and 
				regexfind('^CV[0-9]+$',trim(court_disp_desc_1)) =false                                 

				//court_disp_desc not in set_exclude
				);
dev2 := file_offenses1
				(//fcra_conviction_flag IN ['U',''] and 
				vendor not in hygenics_search.sDOC_Vendors_Conviction_Unknown and 
				vendor not in hygenics_search.sCourt_Vendors_With_Conviction_Based_Upon_Sent_Date and 
				vendor not in hygenics_search.sCourt_Vendors_With_Only_Traffic and 
				//vendor not in hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Off_Lev and 
				vendor not in hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Offender_Key and 
				vendor not in hygenics_search.sDOC_Vendors_Conviction_Unknown and 
				vendor not in hygenics_search.sDOC_Vendors_NoOffense_NoConviction and 
				regexfind('^CV[0-9]+$',trim(ct_disp_desc_1)) =false                                 

				//court_disp_desc not in set_exclude
				);			

				
lkup:= hygenics_search.File_Conviction_Lookup;//CrimSrch.File_Conviction_Lookup;

layout_dev:= record
string2 vendor := dev1.vendor;
//dev.source_file;
string40 court_disp_desc := dev1.court_disp_desc_1;
dev1.fcra_conviction_flag;
total:= count(group);
end;

layout_dev2:= record
string2 vendor := dev2.vendor;
//dev.source_file;
string40 court_disp_desc := dev2.ct_disp_desc_1;
dev2.fcra_conviction_flag;
total:= count(group);
end;



tblUnqDisp1 := table(dev1,layout_dev,court_disp_desc_1,fcra_conviction_flag,few);
tblUnqDisp2 := table(dev2,layout_dev2,ct_disp_desc_1,fcra_conviction_flag,few);
tblUnqDisp :=  sort(table(tblUnqDisp1+tblUnqDisp2,{vendor,court_disp_desc,fcra_conviction_flag,count(group)},vendor,court_disp_desc,fcra_conviction_flag,few),court_disp_desc,fcra_conviction_flag);
//output(tblUnqDisp(vendor ='QS'));
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


// these are being looked at by hygenics
output(choosen(getNonMatchingDisp(vendor in ['CP']),all));
output(choosen(getNonMatchingDisp(vendor in ['TM']),all));
output(choosen(getNonMatchingDisp(vendor in ['OZ']),all));
output(choosen(getNonMatchingDisp(vendor in ['FJ']),all));
output(choosen(getNonMatchingDisp(vendor in ['FE']),all));
output(choosen(getNonMatchingDisp(vendor in ['MV']),all));
output(choosen(getNonMatchingDisp(vendor in ['IC']),all));
output(choosen(getNonMatchingDisp(vendor in ['KL']),all));
//output(choosen(getNonMatchingDisp(),all));

output(choosen(getNonMatchingDisp(vendor not in ['CP','OZ','FJ','4D','MV','IC','KL','TK']),all));

//getNonMatchingDisp();
