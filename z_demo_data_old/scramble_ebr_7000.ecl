
import demo_data;
import ebr;

file_in:= dataset('~thor::base::demo_data_file_ebr_7000_prodcopy',ebr.Layout_7000_SNP_Parent_Name_Address_Base,flat);
//
// this file had no data for my bdids, force to null just in case different bdids are used later
//
export scramble_ebr_7000  := dataset([], recordof(file_in));
