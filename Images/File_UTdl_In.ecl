export File_UTdl_In := 
DISTRIBUTE(
DATASET('~images::in::ut20031201', Layout_UTdl_In, flat) + 
DATASET('~images::in::ut20031211', Layout_UTdl_In, flat) + 
DATASET('~images::in::ut20040105_1', Layout_UTdl_In, flat) + 
DATASET('~images::in::ut20040105_2', Layout_UTdl_In, flat) + 
DATASET('~images::in::ut20040105_3', Layout_UTdl_In, flat), HASH(RANDOM())) : persist('persist::utdl_distributed');