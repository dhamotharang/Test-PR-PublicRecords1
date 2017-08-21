import demo_data;
import uccv2;

file_in:= dataset('~thor::base::demo_data_file_uccv2_party_name_prodcopy',uccv2.Layout_UCC_Common.layout_party,flat);

null_ds := dataset([],uccv2.Layout_UCC_Common.layout_party);

export scramble_uccv2_party_name := null_ds;

// make this null for now, unclear... nothing came with base file full on prod  report/search appears ok.

