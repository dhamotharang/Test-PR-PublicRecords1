D_offendermain := File_SOR_Main_with_PKey;

Layout_SOR_offender_out Extract_Main_info(D_offendermain L ) := TRANSFORM
   SELF := L;
end;

SOR_Main := PROJECT(D_offendermain,Extract_Main_info(LEFT),LOCAL);

export Mapping_Extract_SOR_Main := SOR_Main ;//: persist('persist::Imap::SOR_Main');