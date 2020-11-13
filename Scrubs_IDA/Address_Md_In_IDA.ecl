IMPORT Scrubs_IDA;

sample_input_data_address_medium:=DATASET('~thor_data400::in::ida::20201022::targus_medium_ida_pin_confidence_unique_address_recs.csv',Scrubs_IDA.Address_Md_Layout_IDA,CSV(HEADING(1),SEPARATOR('|')));

Export Address_Md_In_IDA := project(sample_input_data_address_medium,transform(recordof(sample_input_data_address_medium),self.phone2:=left.phone,self.phone3:=left.phone,self := left));

