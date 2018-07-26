IMPORT watchdog,fcra_list,PromoteSupers, ut;

EXPORT Proc_optout_weekly(string pversion, boolean is_optout_weekly = false) := function

fcra_best_monthly         := project(fcra_list.file_best,transform(fcra_list.layout_optout.base, self := left, self := []));
fcra_best_weekly          := fcra_list.file_base_optout;

//check if new FCRA best and then replace the old FCRA best
boolean isNewFCRABest := fcra_best_monthly[1].run_date <> fcra_best_weekly[1].run_date;

pre_optout := if(isNewFCRABest, fcra_best_monthly, fcra_best_weekly);

//split optout hit and no optout hit
optout_flagged     := pre_optout(opt_out_hit);
optout_no_flagged := project(pre_optout(~opt_out_hit), watchdog.Layout_Best);
//flag new optout
new_optout_flagged := fcra_list.fn_fcra_best_patch(optout_no_flagged, is_optout_weekly).weekly_optout;

//build opt out base including all historical opt out records

combine_optout := optout_flagged + new_optout_flagged;

//opt out Lexid and despray

Lexid_optout := project(combine_optout(opt_out_hit),fcra_list.layout_optout.lexid);

PromoteSupers.MAC_SF_BuildProcess(Lexid_optout ,'~thor_data400::base::watchdog_best_fcra_lexid_optout',BLexid_Optout,2,true);

desprayFile := FCRA_list.fn_despray(pversion).dweekly;

PromoteSupers.MAC_SF_BuildProcess(combine_optout,'~thor_data400::base::watchdog_best_fcra_list_optout',BAll_Optout,2,,true);

build_all := sequential(BLexid_Optout, desprayFile, BAll_Optout);

return build_all;

end;

