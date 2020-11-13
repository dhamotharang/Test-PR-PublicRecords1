IMPORT Scrubs_IDA;

sample_input_data_homephone_medium:=DATASET('~thor_data400::in::ida::20201022::targus_medium_ida_pin_confidence_unique_homephone_recs.csv',Scrubs_IDA.Homephone_Md_Layout_IDA,CSV(HEADING(1),SEPARATOR('|')));

Export Homephone_Md_In_IDA := project(sample_input_data_homephone_medium,transform(recordof(sample_input_data_homephone_medium),self.filecategory:='Homephone_Medium',self.phone2:=left.phone,self.phone3:=left.phone,self := left));

