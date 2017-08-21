
import demo_data;
import ebr;

file_in:= dataset('~thor::base::demo_data_file_ebr_6500_prodcopy',ebr.Layout_6500_Government_Trade_Base,flat);
//
// this file had no data for my bdids, force to null just in case different bdids are used later
//
export scramble_ebr_6500  := dataset([], recordof(file_in));
