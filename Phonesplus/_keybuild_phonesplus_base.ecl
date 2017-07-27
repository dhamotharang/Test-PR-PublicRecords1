import doxie_files, doxie, Cellphone, ut, phonesplus_v2, aid, address;

f_phonesplus := Phonesplus.file_phonesplus_base;

//---blanking phones that meet WA cell suppression
ut.mac_suppress_by_phonetype(f_phonesplus,cellphone,state,_fphonesplus_cell,true,did);

//---flagging records with glb_dppa_flag = 'G' in pplus that got blaked by ut.mac_suppress_by_phonetype
flag_wa_sup_as_glb := join(distribute(f_phonesplus, hash(CellPhoneIDKey)),
                           distribute(_fphonesplus_cell (cellphone = ''), hash(CellPhoneIDKey)),
											left.CellPhoneIDKey = right.CellPhoneIDKey and
											left.did= right.did and
											left.lname= right.lname and
											left.mname= right.mname and
											left.fname= right.fname and
											left.prim_range= right.prim_range and
											left.prim_name= right.prim_name and
											left.sec_range= right.sec_range and
											left.zip5= right.zip5,
											transform(recordof(f_phonesplus),
											self.glb_dppa_flag := if(left.CellPhoneIDKey = right.CellPhoneIDKey, 'G', left.glb_dppa_flag),
											self := left),
											left outer,
											keep(1),
											local);
//----Apply AID						   
Phonesplus_v2.Mac_Get_AID_Addr(flag_wa_sup_as_glb,true, pplus_out);
 
export _keybuild_phonesplus_base := pplus_out;



