/*2015-11-16T20:52:07Z (Srilatha Katukuri)
#193680 - CR 323
*/
import Data_Services,ut,doxie, STD; 
	
MaxDate := MAX(pull(FLAccidents_Ecrash.key_EcrashV2_accnbrv1)(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3'] and 
																															(trim(report_type_id,all) in ['A','DE'] or STD.str.ToUpperCase(trim(vendor_code,left,right)) = 'CMPD')),
							(integer)date_vendor_last_reported);

STRING8 Delta_Date := IF ((INTEGER)MaxDate > 0,INTFORMAT((INTEGER)MaxDate,8,1),ut.GetDate);

DateFile := DATASET([{'DELTADATE',Delta_Date}],FLAccidents_Ecrash.Layouts.Delta_Date);

export Key_eCrashV2_DeltaDate := INDEX(DateFile, {delta_text}, {Date_Added},   Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_deltadate_'+ doxie.Version_SuperKey);
																	
