
import demo_data;
import ebr;

file_in:= dataset('~thor::base::demo_data_file_ebr_6510_prodcopy',ebr.Layout_6510_Government_Debarred_Contractor_Base,flat);
//
// this file had no data for my bdids, force to null just in case different bdids are used later
//
export scramble_ebr_6510  := dataset([], recordof(file_in));
