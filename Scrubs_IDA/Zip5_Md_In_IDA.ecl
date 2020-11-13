IMPORT Scrubs_IDA;

sample_input_data_zip5_medium:=DATASET('~thor_data400::in::ida::20201022::targus_medium_ida_pin_confidence_unique_zip5_recs.csv',Scrubs_IDA.Zip5_Md_Layout_IDA,CSV(HEADING(1),SEPARATOR('|')));

Export Zip5_Md_In_IDA := project(sample_input_data_zip5_medium,transform(recordof(sample_input_data_zip5_medium),self.filecategory:='Zip5_Medium',self.phone2:=left.phone,self.phone3:=left.phone,self := left));
