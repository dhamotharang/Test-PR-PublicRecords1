
import demo_data;
import ebr;

file_in:= dataset('~thor::base::demo_data_file_ebr_4035_prodcopy',ebr.Layout_4035_Attachment_Lien_Base,flat);
//
// this file had no data for my bdids, force to null just in case different bdids are used later
//
export scramble_ebr_4035  := dataset([], recordof(file_in));
