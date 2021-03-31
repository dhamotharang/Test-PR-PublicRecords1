import dma, dx_dma, std;

num_files := nothor(STD.File.SuperFileContents(dx_dma.names.key_DNC));
export check_full := if(count(num_files) > 12, true, false);
