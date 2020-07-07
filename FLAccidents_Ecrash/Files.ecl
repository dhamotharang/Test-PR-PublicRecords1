/*2015-08-28T21:23:37Z (Srilatha Katukuri)
#181860 - changed the base file to documents

*/
/*2015-08-07T22:58:55Z (Srilatha Katukuri)
#181860 PRUS
*/
import Data_Services;

EXPORT Files := module

 export deletes := dataset(Data_Services.foreign_prod+'thor_data::in::ecrash_deletes',FLAccidents_Ecrash.Layouts.deletes,csv(terminator(['\n','\r\n']), separator(','),quote('"'))); 
 export Base := module
   export Supplemental := dataset(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::base::ecrash_supplemental',FLAccidents_Ecrash.Layouts.ReportVersion,thor);
   export PhotoBase := dataset(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::base::ecrash_documents',FLAccidents_Ecrash.Layouts.PhotoLayout,thor);
   export accidents_alpha := dataset(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::base::accidents_alpha',Layout_eCrash.Accidents_Alpha,thor);  
   export accidents_alpha_father := dataset(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::base::accidents_alpha_father',Layout_eCrash.Accidents_Alpha,thor);  
 end;
end ;
