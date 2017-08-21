/********************************************************************************************************** 
	Name: 			Build_Keys_All
	Created On: 07/20/2013
	By: 				ssivasubramanian
	Desc: 			This function is responsible for calling the each of the key definition function and manages the 
							building and versioning (and maintaining history) of each of the keys
***********************************************************************************************************/

EXPORT Build_Keys_All(string file_date) := FUNCTION
	
	//build the CID Key
	Key_cid_File 							:= _Files.Subkey.cid(file_date);
	CID_KEY										:= BUILD(key_watercraft_cid(Key_cid_File),UPDATE);
	
	//build the BDID Key
	Key_bdid_File 						:= _Files.Subkey.bdid(file_date);
	BDID_KEY									:= BUILD(key_watercraft_bdid(Key_bdid_File),UPDATE);
	
	//build the DID Key
	Key_did_File							:= _Files.Subkey.did(file_date);
	DID_KEY										:= BUILD(key_watercraft_did(Key_did_File),UPDATE);
	
	//build the SID Key
	Key_sid_File 							:= _Files.Subkey.sid(file_date);
	SID_KEY										:= BUILD(key_watercraft_sid(Key_sid_File),UPDATE);
	
	//build the WID Key
	Key_wid_File							:= _Files.Subkey.wid(file_date);
	WID_KEY										:=	BUILD(key_watercraft_wid(Key_wid_File),UPDATE);
	
	//build the HULLNUM Key
	Key_hullnum_File 					:= _Files.Subkey.hullnum(file_date);
	HULLNUM_KEY								:=	BUILD(key_watercraft_hullnum(Key_hullnum_File),UPDATE);
	
	//build the OFFNUM Key
	Key_offnum_File 					:= _Files.Subkey.Offnum(file_date);
	OFFNUM_KEY								:=	BUILD(key_watercraft_offnum(Key_offnum_File),UPDATE);
	
	//build the VSLNAM Key
	Key_vslnam_File 					:= _Files.Subkey.vslnam(file_date);
	VSLNAM_KEY								:= BUILD(key_watercraft_vslnam(Key_vslnam_File),UPDATE);
	
	//Generate the sequence in which the keys should be build and return the sequence
	BuildKeys := PARALLEL(CID_KEY,BDID_KEY,DID_KEY,SID_KEY,WID_KEY,HULLNUM_KEY,OFFNUM_KEY,VSLNAM_KEY);
										
	RETURN BuildKeys;

END;

