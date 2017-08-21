export File_Generated_PKFile :=  module
 
  shared Persistent_key_file := Generate_Persistent_key_File ;
	
	export full_file           := Persistent_key_file;
 
  export noDID               := Persistent_key_file(did = 0) ;
	
  shared D_withDID           := DISTRIBUTE(Persistent_key_file(did <> 0), HASH(did)) : persist('persist::IMAP::File_Gen_Distributed_PkeyDID');
	
  export withDID             := D_withDID ;
	
	
 end; 