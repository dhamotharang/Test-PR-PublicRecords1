	D_Phoneplus_file       := DISTRIBUTE(Files_Used.phones_plus_file(did<>0),HASH(did));
	
temp_layout_phone := record
Layout_Phonesplus_Slim;
Files_used.Layout_phones_plus.HomePhone ;

end; 


  temp_layout_phone Join_DID_PhonesplusFile (Layout_UNQ_PK_DID_Plus_Relatives L , Files_Used.Layout_phones_plus R) := TRANSFORM
  //Layout_Vehicle_Party_slim Change_Layout (Files_Used.Layout_vehicle_party L) := TRANSFORM
  
    SELF	:=	R;
    SELF	:=	L;

  end;	
		
 J_Phones_plus_slim      := JOIN(File_Generated_UNQ_PK_DID_Plus_Relatives,D_Phoneplus_file, 
                                 LEFT.did = RIGHT.DID ,
							     Join_DID_PhonesplusFile(LEFT,RIGHT),LOCAL);
								 
Layout_Phonesplus_Slim Normalize_phonenos (temp_layout_phone L, INTEGER C) := TRANSFORM
   
   SELF.cellphone := CHOOSE(C, L.homephone, L.cellphone);
	 SELF := L;
END;

Norm_Phone_nos := NORMALIZE(J_Phones_plus_slim,2,Normalize_phonenos(LEFT,COUNTER),LOCAL);

Notnull_phone_nos := Norm_Phone_nos(cellphone<> '');
//D_Notnull_phone_nos := DISTRIBUTE(Notnull_phone_nos,HASH(did,prim_range,predir,prim_name ,addr_suffix,postdir,zip5));
S_Notnull_phone_nos := SORT(Notnull_phone_nos,did,persistent_key, relative_flag,prim_range,predir,prim_name ,addr_suffix,postdir,zip5,cellphone,datelastseen,LOCAL);
S_NotNull_Phone_nos_dedup := dedup(S_Notnull_phone_nos,did,persistent_key, relative_flag,prim_range,predir,prim_name ,addr_suffix,postdir,zip5,cellphone,RIGHT,LOCAL);

export File_Generated_Phonesplus_slim_subset := S_NotNull_Phone_nos_dedup : persist ('persist::Imap::PhonesPlus_slim');