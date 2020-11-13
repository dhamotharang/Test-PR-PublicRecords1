IMPORT Scrubs_IDA;

sample_input_data_zip5_high:=DATASET('~thor_data400::in::ida::20201022::targus_high_ida_pin_confidence_unique_zip5_recs.csv',Scrubs_IDA.Zip5_High_Layout_IDA,CSV(HEADING(1),SEPARATOR('|')));

Export Zip5_High_In_IDA := project(sample_input_data_zip5_high,transform(recordof(sample_input_data_zip5_high),self.filecategory:='Zip5_High',self.phone2:=left.phone,self.phone3:=left.phone,self := left));
