import ut;

export File_FCRA_Batch_Logs_Common := dataset(ut.foreign_fcra_logs + '~thor10_231::base::batch_acclogs_common', inquiry_acclogs.Layout.Common, thor, opt);