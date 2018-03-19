import Data_Services,doxie,std; 
	
MaxDate := MAX(pull(FLAccidents_Ecrash.key_EcrashV2_accnbrv1)(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3']),(integer)date_vendor_last_reported);

STRING8 Delta_Date := IF ((INTEGER)MaxDate > 0,INTFORMAT((INTEGER)MaxDate,8,1),(STRING8)Std.Date.Today());

DateFile := DATASET([{'DELTADATE',Delta_Date}],FLAccidents_Ecrash.Layouts.Delta_Date);

export Key_eCrashV2_DeltaDate := INDEX(DateFile, {delta_text}, {Date_Added},   Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_deltadate_'+ doxie.Version_SuperKey);
