import AutoKeyB2,Std;

export Proc_Build_Autokey(string filedate = (string8)Std.Date.Today(), boolean isDelta = false) := function

ak_dataset := Constants.ak_dataset(isDelta);
ak_keyname := Constants.ak_keyname;
ak_logical := Constants.ak_logical(filedate);
ak_skipSet := Constants.ak_skipSet;
ak_typeStr := Constants.ak_typeStr;

PreviousKey:=index(official_records.Key_Official_Records_Payload,'~thor_200::key::official_records::autokey::payload_qa');
PrevMaxFakeID := if(isdelta,MAX(PreviousKey,fakeid),0);		

AutoKeyB2.MAC_Build (ak_dataset
					,fname,mname,lname
					,zero
					,zero
					,zero
					// AutokeyB2.MAC_Build doesn't like non-business address parts all set to the 
					// same "blank" attribute, so individual address blank attributes 
					// (except for state and city) were used.
					,blank_prim_name,blank_prim_range,per_state,city,blank_zip5,blank_sec_range
					,zero
					,zero,zero,zero
					,zero,zero,zero
					,zero,zero,zero
					,zero
					// AutokeyB2.MAC_Build doesn't like the same "zero" attribute used for both 
					// did & bdid, so individual attributes were used.
					,zeroDID
					,cname
					,zero
					,zero
					,blank,blank,bus_state,city,blank,blank
          ,zeroBDID
					,ak_keyname
					,ak_logical
					,outaction,false
					,ak_skipSet,true,ak_typeStr
					,true,,,zero,,,,,,,,,,isDelta,PrevMaxFakeID);

retval := outaction;

return retval;

end;