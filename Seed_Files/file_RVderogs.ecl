import fcra;

export file_RVderogs := dataset('~thor_data400::base::testseed_riskview_derogs', fcra.RiskView_Derogs_Module.seed_layout, csv(heading(single), quote('"')));
