Import Ancestry_Data;

Export Process_Data( String pVersion ) := Function 

best_file_ds := Ancestry_Data.Best_File(pversion);
names_file := Ancestry_Data.Aka_File(pversion).outputDS; 
address_file := Ancestry_Data.Hist_Addresses_File(pversion).outputDS;
allStats := Ancestry_Data.Calculate_Stats(pversion).Calculate_AllStats;


halfoftotal := count(address_file) div 2;

addressHalf1 := choosen(address_file, halfoftotal );// first half records
addressHalf2 := choosen(address_file, halfoftotal+1, halfoftotal+1 ); // second half 


despray := Ancestry_Data.Despray_File;

write_best := output(best_file_ds,, '~thor_data400::out::ancestry_data::'+ pVersion +'::best_file',__compressed__,csv(heading(single),separator(','),quote('"')), overwrite);

write_aka_file := output(names_file,, '~thor_data400::out::ancestry_data::'+ pVersion +'::aka_file', __compressed__,csv(heading(single),separator(','),quote('"')), overwrite);

write_hist_address1 := output(addressHalf1,, '~thor_data400::out::ancestry_data::'+ pVersion +'::hist_address_file1', __compressed__,csv(heading(single),separator(','),quote('"')), overwrite);

write_hist_address2 := output(addressHalf2,, '~thor_data400::out::ancestry_data::'+ pVersion +'::hist_address_file2', __compressed__,csv(heading(single),separator(','),quote('"')), overwrite);


process_files := parallel(
                        output(best_file_ds,named('best_file')),
                        output(names_file, named('aka_file')),
                        output(address_file, named('hist_address_file')),
                        allStats,
                        //despray,
                        // write_best,
                        // write_aka_file,
                        // write_hist_address1,
                        // write_hist_address2,
                          );   
Return process_files;

End;