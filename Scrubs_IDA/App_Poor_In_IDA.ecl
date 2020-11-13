IMPORT Scrubs_IDA;

sample_input_data_app_poor:=DATASET('~thor_data400::in::ida::20201022::non_fcra_recent_app_poor.csv',Scrubs_IDA.App_Poor_Layout_IDA,CSV(HEADING(1),SEPARATOR('|')));

Export App_Poor_In_IDA := project(sample_input_data_app_poor,transform(recordof(sample_input_data_app_poor),self.filecategory:='APP_POOR',self.phone2:=left.phone,self.phone3:=left.phone,self := left));
