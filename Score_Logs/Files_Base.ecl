EXPORT Files_Base := MODULE

/* Intermediate Logs */
EXPORT Intermediate := dataset('~thor_data400::base::acclogs_scoring::intermediate', Score_Logs.Layouts.Base_Intermediate_Layout, thor, __compressed__, opt);

/* Online Transaction Logs */
EXPORT File := dataset('~thor_data400::base::acclogs_scoring', Score_Logs.Layouts.Base_Transaction_Layout, thor, __compressed__, opt);

/* Accounting logs from logs and fcra logs thor */
EXPORT Transaction_IDs := dataset('~thor_data400::out::acclogs_scoring::transaction_ids', Score_Logs.Layouts.Base_AccTransaction_Layout, thor, __compressed__, opt);

/* Accounting logs files processed list from logs and fcra logs thor */
EXPORT Processed_Files := dataset('~thor_data400::out::acclogs_scoring::processed_files', {string name{maxlength(256)}}, thor, __compressed__, opt);

END;