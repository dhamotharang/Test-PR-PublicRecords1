IMPORT watchdog,fcra_list,PromoteSupers, ut;

EXPORT Proc_optout_weekly(string pversion, boolean is_optout_weekly = false) := function

boolean isthreemonths(string build_date, string pversion)	:= ut.DaysApart(build_date, pversion) <= FCRA_list.Constants.threemonths; 

fcra_best_monthly         := fcra_list.file_best;
fcra_best_weekly          := fcra_list.file_base_optout;
fcra_best_weekly_sort          := sort(fcra_list.file_base_optout, -run_date);

boolean isNewFCRABest := fcra_best_monthly[1].run_date <> fcra_best_weekly_sort[1].run_date;

//rollup new FCRA best with historical FCRA best

pre_optout := if(isNewFCRABest, fcra_list.fn_rollup_monthly(fcra_best_weekly), fcra_best_weekly);

optout_flagged     := pre_optout(opt_out_hit);
optout_no_flagged := project(pre_optout(~opt_out_hit), watchdog.Layout_Best);

//flag optout
new_optout_flagged := fcra_list.fn_fcra_best_patch(optout_no_flagged, is_optout_weekly).weekly_optout;

//opt out Lexid within 3 months and despray
Lexid_optout := project(new_optout_flagged(opt_out_hit and isthreemonths((string8)run_date, pversion)),fcra_list.layout_optout.lexid);

PromoteSupers.MAC_SF_BuildProcess(Lexid_optout ,'~thor_data400::base::watchdog_best_fcra_lexid_optout',BLexid_Optout,2,true);

desprayFile := FCRA_list.fn_despray(pversion).dweekly;

//build opt out base including all historical opt out records

combine_optout := optout_flagged + new_optout_flagged;

PromoteSupers.MAC_SF_BuildProcess(combine_optout,'~thor_data400::base::watchdog_best_fcra_list_optout',BAll_Optout,2,,true);

build_all := sequential(BLexid_Optout, desprayFile, BAll_Optout);

return build_all;

end;

