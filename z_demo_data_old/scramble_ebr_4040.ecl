
import demo_data;
import ebr;

file_in:= dataset('~thor::base::demo_data_file_ebr_4040_prodcopy',ebr.Layout_4040_Bulk_Transfers_Base,flat);
//
// this file had no data for my bdids, force to null just in case different bdids are used later
//
export scramble_ebr_4040  := dataset([], recordof(file_in));
