import MasterConsumer_DW_Layouts;

file_lay := MasterConsumer_DW_Layouts.Layout_MarketView;

Marfile := DATASET('~thor::mcw::marketview::201303::data',file_lay,thor );      

// output(File_Out);
// sghatti is typing a message.

janfile := DATASET('~thor::in::mvd::201301::full::comp::uniqpid',MasterConsumer_DW_Layouts.Layout_MarketView_04092013,THOR);


output(janfile);

																																 
primary_list := ['pid'];					

no_of_keys := 1;

fn_1() := function

siva_compare.MAC_compare_file_layouts_1(Marfile, Janfile, outfile1);
siva_compare.MAC_compare_file_layouts_2(Marfile, Janfile, outfile2 );
firstfile := distribute(outfile1, hash64(pid));
Secondfile := distribute(outfile2, hash64(pid));

siva_compare.MAC_Comapre_files_macro(firstfile, Secondfile, no_of_keys ,primary_list, pid,'' ,'');

return 0;

end;

fn_2 := function

Siva_compare.MAC_restrat_1(no_of_keys,primary_list, pid,'' ,'');

return 0;

end;

if (not fileservices.fileexists('thor400_72::pview::compare::mcr'),fn_1(),fn_2);
    	
