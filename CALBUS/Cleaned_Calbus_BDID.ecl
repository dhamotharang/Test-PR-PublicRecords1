import did_add, Business_Header_SS, Business_Header, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville;

in_file := Calbus.Update_Calbus;

Pre_BDID_Rec := record
	unsigned6	bdid	:= 0;
	//unsigned1	bdid_score := 0;
	recordof(in_file);
end;

matchset := ['A','N'];

business_header_ss.MAC_Match_Flex(
	in_file, matchset,
	Owner_Name, 
    Business_prim_range, Business_prim_name, Business_zip5, 
	Business_sec_range,	Business_st,
	'','',
	bdid,	
	Pre_BDID_Rec,
	false, bdid_score, //set the flag to true for bdid_score
	postBDID)
	
/*
BDID_rec := record
   Calbus.Layouts_Calbus.Layout_Base;
end;


BDID_rec tBdid(PostBDID L) := transform
	self.bdid		    := if(L.bdid = 0, '', intformat(L.bdid,12,1));
	//self.BDID_SCORE	:= (string3)L.bdid_score;
	self            := L;
end;
	
ds_Calbus_BDID := project(PostBDID, tBdid(left)); 
*/
export Cleaned_Calbus_BDID := PostBDID : persist(Calbus.Constants.Cluster + 'persist::calbus::Cleaned_Calbus_bdid','400way');
