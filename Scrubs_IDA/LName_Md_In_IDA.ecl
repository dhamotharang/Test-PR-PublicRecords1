IMPORT Scrubs_IDA;

sample_input_data_lastname_medium:=DATASET('~thor_data400::in::ida::20201022::targus_medium_ida_pin_confidence_unique_lastname_recs.csv',Scrubs_IDA.LName_Md_Layout_IDA,CSV(HEADING(1),SEPARATOR('|')));

Export LName_Md_In_IDA := project(sample_input_data_lastname_medium,transform(recordof(sample_input_data_lastname_medium),self.filecategory:='LastName_Medium',self.phone2:=left.phone,self.phone3:=left.phone,self := left));
