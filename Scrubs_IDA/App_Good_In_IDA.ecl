IMPORT Scrubs_IDA;

sample_input_data_app_good:=DATASET('~thor_data400::in::ida::20201022::non_fcra_recent_app_good.csv',Scrubs_IDA.App_Good_Layout_IDA,CSV(HEADING(1),SEPARATOR('|')));

Export App_Good_In_IDA := project(sample_input_data_app_good,transform(recordof(sample_input_data_app_good),self.filecategory:='APP_GOOD',self.phone2:=left.phone,self.phone3:=left.phone,self := left));
