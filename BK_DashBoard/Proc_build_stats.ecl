#option ('multiplePersistInstances',FALSE);

import 		BankruptcyV3,header,overrides,personcontext,std,PromoteSupers;						

export Proc_build_stats(string pHostname, string pTarget, string pContact ='\' \'') := function

filedate := (STRING8)Std.Date.Today();

linking_base      := dataset(Bk_dashboard.filenames.linking,Bk_dashboard.Layouts.linking,CSV(heading(1),SEPARATOR(','),TERMINATOR('\n')));
overall_base      := dataset(Bk_dashboard.filenames.overall,Bk_dashboard.Layouts.overall,CSV(heading(1),SEPARATOR(','),TERMINATOR('\n')));
segmentation_base := dataset(Bk_dashboard.filenames.segmentation,Bk_dashboard.Layouts.segmentation,CSV(heading(1),SEPARATOR(','),TERMINATOR('\n')));
linking_in_days_base      := dataset(Bk_dashboard.filenames.linking_in_days,Bk_dashboard.Layouts.linking_in_days,CSV(heading(1),SEPARATOR(','),TERMINATOR('\n')));
overall_in_days_base      := dataset(Bk_dashboard.filenames.overall_in_days,Bk_dashboard.Layouts.overall_in_days,CSV(heading(1),SEPARATOR(','),TERMINATOR('\n')));

linking_all := Bk_dashboard.fn_CalculateStats(true).linking_stats + Bk_dashboard.fn_CalculateStats(false).linking_stats + linking_base(nametype <> '');
overall_all := Bk_dashboard.fn_CalculateStats(true).overall_stats + Bk_dashboard.fn_CalculateStats(false).overall_stats + overall_base;
segmentation_all := Bk_dashboard.fn_CalculateStats(true).segmentation_stats + Bk_dashboard.fn_CalculateStats(false).segmentation_stats + segmentation_base;

linking_in_days := Bk_dashboard.fn_CalculateStats(true).linking_stats_in_days + Bk_dashboard.fn_CalculateStats(false).linking_stats_in_days;
overall_in_days := Bk_dashboard.fn_CalculateStats(true).overall_stats_in_days + Bk_dashboard.fn_CalculateStats(false).overall_stats_in_days;

PromoteSupers.MAC_SF_BuildProcess(linking_all,
                       Bk_dashboard.filenames.linking,bld_bk_stats_linking, 2,true,true,filedate);
											 
PromoteSupers.MAC_SF_BuildProcess(overall_all,
                      Bk_dashboard.filenames.overall,bld_bk_stats_overall, 2,true,true,filedate);

PromoteSupers.MAC_SF_BuildProcess(segmentation_all,
                      Bk_dashboard.filenames.segmentation,bld_bk_stats_segmentation, 2,true,true,filedate);	

PromoteSupers.MAC_SF_BuildProcess(linking_in_days,
                       Bk_dashboard.filenames.linking_in_days,bld_bk_stats_linking_in_days, 2,true,true,filedate);
											 
PromoteSupers.MAC_SF_BuildProcess(overall_in_days,
                      Bk_dashboard.filenames.overall_in_days,bld_bk_stats_overall_in_days, 2,true,true,filedate);

build_stats := sequential(bld_bk_stats_linking,bld_bk_stats_overall,bld_bk_stats_segmentation,bld_bk_stats_linking_in_days,bld_bk_stats_overall_in_days);	

linking_samples := output(sort(linking_base, -buildversion, datatype));
overall_samples := output(sort(overall_base, -buildversion, datatype));
segmentation_samples := output(sort(segmentation_base, -buildversion, datatype));
linking_in_days_samples := output(sort(linking_in_days_base, -processdate, datatype));
overall_in_days_samples := output(sort(overall_in_days_base, -processdate, datatype));

output_samples := sequential(linking_samples,overall_samples,segmentation_samples,linking_in_days_samples,overall_in_days_samples);

despray_files := parallel(
	         Bk_dashboard.fn_despray(Bk_dashboard.filenames.linking, pHostname, pTarget),  
					 Bk_dashboard.fn_despray(Bk_dashboard.filenames.overall, pHostname, pTarget), 
					 Bk_dashboard.fn_despray(Bk_dashboard.filenames.segmentation, pHostname, pTarget),
					 Bk_dashboard.fn_despray(Bk_dashboard.filenames.linking_in_days, pHostname, pTarget),  
					 Bk_dashboard.fn_despray(Bk_dashboard.filenames.overall_in_days, pHostname, pTarget), 
	        );
									
email_alert := if(filedate = BK_DashBoard.buildversion,
FileServices.SendEmail(pContact,'BK DashBoard Stats '+ filedate ,'BK DashBoard Stats ' +filedate+ ' despray on' +  pHostname + failmessage),
FileServices.SendEmail(pContact, 'Bankruptcy Keys not up to date ' + filedate, 
'Bankrupty Keys not up to date and No BK DashBoard Stats ' +filedate + failmessage));

build_all := if(filedate = BK_DashBoard.buildversion, sequential(build_stats, output_samples,despray_files,email_alert), email_alert);

return build_all;

end;
 