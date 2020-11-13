IMPORT Scrubs_IDA;

out_FName_Low:=DATASET('~thor_data400::base::ida::targus_low_firstname::built',Scrubs_IDA.Outfile_Layout_IDA,thor);
out_FName_Md:=DATASET('~thor_data400::base::ida::targus_medium_firstname::built',Scrubs_IDA.Outfile_Layout_IDA,thor);
out_FName_High:=DATASET('~thor_data400::base::ida::targus_high_firstname::built',Scrubs_IDA.Outfile_Layout_IDA,thor);

out_LName_Low:=DATASET('~thor_data400::base::ida::targus_low_lastname::built',Scrubs_IDA.Outfile_Layout_IDA,thor);
out_LName_Md:=DATASET('~thor_data400::base::ida::targus_medium_lastname::built',Scrubs_IDA.Outfile_Layout_IDA,thor);
out_LName_High:=DATASET('~thor_data400::base::ida::targus_high_lastname::built',Scrubs_IDA.Outfile_Layout_IDA,thor);

out_Address_Low:=DATASET('~thor_data400::base::ida::targus_low_address::built',Scrubs_IDA.Outfile_Layout_IDA,thor);
out_Address_Md:=DATASET('~thor_data400::base::ida::targus_medium_address::built',Scrubs_IDA.Outfile_Layout_IDA,thor);
out_Address_High:=DATASET('~thor_data400::base::ida::targus_high_address::built',Scrubs_IDA.Outfile_Layout_IDA,thor);

out_Zip5_Low:=DATASET('~thor_data400::base::ida::targus_low_zip5::built',Scrubs_IDA.Outfile_Layout_IDA,thor);
out_Zip5_Md:=DATASET('~thor_data400::base::ida::targus_medium_zip5::built',Scrubs_IDA.Outfile_Layout_IDA,thor);
out_Zip5_High:=DATASET('~thor_data400::base::ida::targus_high_zip5::built',Scrubs_IDA.Outfile_Layout_IDA,thor);

out_Homephone_Low:=DATASET('~thor_data400::base::ida::targus_low_homephone::built',Scrubs_IDA.Outfile_Layout_IDA,thor);
out_Homephone_Md:=DATASET('~thor_data400::base::ida::targus_medium_homephone::built',Scrubs_IDA.Outfile_Layout_IDA,thor);
out_Homephone_High:=DATASET('~thor_data400::base::ida::targus_high_homephone::built',Scrubs_IDA.Outfile_Layout_IDA,thor);

out_App_Poor:=DATASET('~thor_data400::base::ida::nonfcra_recent_app_poor::built',Scrubs_IDA.Outfile_Layout_IDA,thor);
out_App_Rand:=DATASET('~thor_data400::base::ida::nonfcra_recent_app_rand::built',Scrubs_IDA.Outfile_Layout_IDA,thor);
out_App_Good:=DATASET('~thor_data400::base::ida::nonfcra_recent_app_good::built',Scrubs_IDA.Outfile_Layout_IDA,thor);

combine_all := 
    out_FName_Low       + 
    out_FName_Md        + 
    out_FName_High      +
    out_LName_Low       +
    out_LName_Md        +
    out_LName_High      +
    out_Address_Low     +
    out_Address_Md      +
    out_Address_High    +
    out_Zip5_Low        +
    out_Zip5_Md         +
    out_Zip5_High       +
    out_Homephone_Low   +
    out_Homephone_Md    +
    out_Homephone_High  +
    out_App_Poor        +
    out_App_Rand        +
    out_App_Good;

Export Outfile_In_IDA := combine_all;
 /*
 Run_test := combine_all(orig_email <> '');
 
 TABLE(Run_test,{orig_filecategory,COUNT(GROUP)},orig_filecategory, few,all);
 */