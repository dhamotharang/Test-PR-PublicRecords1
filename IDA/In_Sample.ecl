// Sample business data
EXPORT In_Sample := MODULE

shared sample_input_data_firstname_low:=DATASET('~thor_data400::in::ida::20201022::targus_low_ida_pin_confidence_unique_firstname_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));
shared sample_input_data_firstname_medium:=DATASET('~thor_data400::in::ida::20201022::targus_medium_ida_pin_confidence_unique_firstname_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));
shared sample_input_data_firstname_high:=DATASET('~thor_data400::in::ida::20201022::targus_high_ida_pin_confidence_unique_firstname_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));

shared sample_input_data_lastname_low:=DATASET('~thor_data400::in::ida::20201022::targus_low_ida_pin_confidence_unique_lastname_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));
shared sample_input_data_lastname_medium:=DATASET('~thor_data400::in::ida::20201022::targus_medium_ida_pin_confidence_unique_lastname_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));
shared sample_input_data_lastname_high:=DATASET('~thor_data400::in::ida::20201022::targus_high_ida_pin_confidence_unique_lastname_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));

shared sample_input_data_address_low:=DATASET('~thor_data400::in::ida::20201022::targus_low_ida_pin_confidence_unique_address_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));
shared sample_input_data_address_medium:=DATASET('~thor_data400::in::ida::20201022::targus_medium_ida_pin_confidence_unique_address_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));
shared sample_input_data_address_high:=DATASET('~thor_data400::in::ida::20201022::targus_high_ida_pin_confidence_unique_address_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));

shared sample_input_data_zip5_low:=DATASET('~thor_data400::in::ida::20201022::targus_low_ida_pin_confidence_unique_zip5_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));
shared sample_input_data_zip5_medium:=DATASET('~thor_data400::in::ida::20201022::targus_medium_ida_pin_confidence_unique_zip5_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));
shared sample_input_data_zip5_high:=DATASET('~thor_data400::in::ida::20201022::targus_high_ida_pin_confidence_unique_zip5_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));

shared sample_input_data_homephone_low:=DATASET('~thor_data400::in::ida::20201022::targus_low_ida_pin_confidence_unique_homephone_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));
shared sample_input_data_homephone_medium:=DATASET('~thor_data400::in::ida::20201022::targus_medium_ida_pin_confidence_unique_homephone_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));
shared sample_input_data_homephone_high:=DATASET('~thor_data400::in::ida::20201022::targus_high_ida_pin_confidence_unique_homephone_recs.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));

shared sample_input_data_app_poor:=DATASET('~thor_data400::in::ida::20201022::non_fcra_recent_app_poor.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));
shared sample_input_data_app_rand:=DATASET('~thor_data400::in::ida::20201022::non_fcra_recent_app_rand.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));
shared sample_input_data_app_good:=DATASET('~thor_data400::in::ida::20201022::non_fcra_recent_app_good.csv',IDA.Layouts.Input,CSV(HEADING(1),SEPARATOR('|')));

shared Sample_Combined_Cleaned := DATASET('~thor_data400::base::ida::20201102',IDA.layouts.base,thor);




Export In_Sample_FirstName_Low := project(sample_input_data_firstname_low,transform(recordof(sample_input_data_firstname_low),self.filecategory:='FirstName_Low',self := left));
Export In_Sample_FirstName_Medium := project(sample_input_data_firstname_medium,transform(recordof(sample_input_data_firstname_medium),self.filecategory:='FirstName_Medium',self := left));
Export In_Sample_FirstName_High := project(sample_input_data_firstname_high,transform(recordof(sample_input_data_firstname_high),self.filecategory:='FirstName_High',self := left));

Export In_Sample_LastName_Low := project(sample_input_data_lastname_low,transform(recordof(sample_input_data_lastname_low),self.filecategory:='LastName_Low',self := left));
Export In_Sample_LastName_Medium := project(sample_input_data_lastname_medium,transform(recordof(sample_input_data_lastname_medium),self.filecategory:='LastName_Medium',self := left));
Export In_Sample_LastName_High := project(sample_input_data_lastname_high,transform(recordof(sample_input_data_lastname_high),self.filecategory:='LastName_High',self := left));

Export In_sample_address_low := project(sample_input_data_address_low,transform(recordof(sample_input_data_address_low),self.filecategory:='Address_Low',self := left));
Export In_sample_address_medium := project(sample_input_data_address_medium,transform(recordof(sample_input_data_address_medium),self.filecategory:='Address_Medium',self := left));
Export In_sample_address_high := project(sample_input_data_address_high,transform(recordof(sample_input_data_address_high),self.filecategory:='Address_High',self := left));

Export In_sample_zip5_low := project(sample_input_data_zip5_low,transform(recordof(sample_input_data_zip5_low),self.filecategory:='Zip5_Low',self := left));
Export In_sample_zip5_medium := project(sample_input_data_zip5_medium,transform(recordof(sample_input_data_zip5_medium),self.filecategory:='Zip5_Medium',self := left));
Export In_sample_zip5_high := project(sample_input_data_zip5_high,transform(recordof(sample_input_data_zip5_high),self.filecategory:='Zip5_High',self := left));

Export In_sample_homephone_low := project(sample_input_data_homephone_low,transform(recordof(sample_input_data_homephone_low),self.filecategory:='Homephone_Low',self := left));
Export In_sample_homephone_medium := project(sample_input_data_homephone_medium,transform(recordof(sample_input_data_homephone_medium),self.filecategory:='Homephone_Medium',self := left));
Export In_sample_homephone_high := project(sample_input_data_homephone_high,transform(recordof(sample_input_data_homephone_high),self.filecategory:='Homephone_High',self := left));

Export In_sample_app_poor := project(sample_input_data_app_poor,transform(recordof(sample_input_data_app_poor),self.filecategory:='App_Poor',self := left));
Export In_sample_app_rand := project(sample_input_data_app_rand,transform(recordof(sample_input_data_app_rand),self.filecategory:='App_Rand',self := left));
Export In_sample_app_good := project(sample_input_data_app_good,transform(recordof(sample_input_data_app_good),self.filecategory:='App_Good',self := left));

Export In_Sample_All_Combined:= In_Sample_FirstName_Low + In_Sample_FirstName_Medium + In_Sample_FirstName_High 
                              + In_Sample_LastName_Low  + In_Sample_LastName_Medium  + In_Sample_LastName_High
															+ In_sample_address_low   + In_sample_address_Medium   + In_sample_address_High
															+ In_sample_zip5_low      + In_sample_zip5_Medium      + In_sample_zip5_High
															+ In_sample_homephone_low + In_sample_homephone_Medium + In_sample_homephone_High
															+ In_sample_app_poor      + In_sample_app_rand         + In_sample_app_good;
															
Export In_Sample_Combined_Cleaned := project(Sample_Combined_Cleaned,transform(recordof(Sample_Combined_Cleaned),self := left));


end;