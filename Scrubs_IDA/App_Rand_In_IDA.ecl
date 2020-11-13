IMPORT Scrubs_IDA;

sample_input_data_app_rand:=DATASET('~thor_data400::in::ida::20201022::non_fcra_recent_app_rand.csv',Scrubs_IDA.App_Rand_Layout_IDA,CSV(HEADING(1),SEPARATOR('|')));

Export App_Rand_In_IDA := project(sample_input_data_app_rand,transform(recordof(sample_input_data_app_rand),self.filecategory:='APP_RAND',self.phone2:=left.phone,self.phone3:=left.phone,self := left));
