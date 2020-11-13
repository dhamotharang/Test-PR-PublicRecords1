IMPORT Scrubs_IDA;

sample_input_data_homephone_low:=DATASET('~thor_data400::in::ida::20201022::targus_low_ida_pin_confidence_unique_homephone_recs.csv',Scrubs_IDA.Homephone_Low_Layout_IDA,CSV(HEADING(1),SEPARATOR('|')));

Export Homephone_Low_In_IDA := project(sample_input_data_homephone_low,transform(recordof(sample_input_data_homephone_low),self.filecategory:='Homephone_Low',self.phone2:=left.phone,self.phone3:=left.phone,self := left));
