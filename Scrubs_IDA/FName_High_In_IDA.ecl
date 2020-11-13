IMPORT Scrubs_IDA;

sample_input_data_firstname_high:=DATASET('~thor_data400::in::ida::20201022::targus_high_ida_pin_confidence_unique_firstname_recs.csv',Scrubs_IDA.FName_High_Layout_IDA,CSV(HEADING(1),SEPARATOR('|')));

Export FName_High_In_IDA := project(sample_input_data_firstname_high,transform(recordof(sample_input_data_firstname_high),self.filecategory:='FirstName_High',self.phone2:=left.phone,self.phone3:=left.phone,self := left));