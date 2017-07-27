import AutoKeyB2,FLAccidents;

export Proc_build_ecrashV2_autokey(string filedate) := function

Cluster		:= '~thor_data400';
ak_skipSet := FLAccidents.Constants.ak_skipSet;
ak_typeStr := FLAccidents.Constants.ak_typeStr;
e_keyname  := Cluster + '::key::ecrashV2::autokey::';
e_logical	:= Cluster+'::key::ecrashV2::'+filedate+'::autokey::';
e_dataset	:= FLAccidents_Ecrash.File_Ecrash_AutoKeyV2;
e_srcType	:= 'ecrash';

AutoKeyB2.MAC_Build (e_dataset
					,fname,mname,lname
					,zero
					,zero
					,zero
					,prim_name,prim_range,st,v_city_name,zip5,sec_range
					,zero
					,zero,zero,zero
					,zero,zero,zero
					,zero,zero,zero
					,zero
					,DID
					,b_name
					,zero
					,zero
					,b_prim_name,b_prim_range,b_st,b_v_city_name,b_zip5,b_sec_range
          ,b_did
					,e_keyname
					,e_logical
					,outaction,false
					,ak_skipSet,true,ak_typeStr
					,true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(e_keyname, mymove,, ak_skipset);

retval := sequential(outaction,mymove);

return retval;

end;
