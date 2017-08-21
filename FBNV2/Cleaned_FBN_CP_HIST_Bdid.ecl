
import  Business_Header_SS,Business_Header, ut,did_add;

BDID_Rec := record,maxlength(10000000)
	unsigned6	bdid	:= 0;
	Layout_FBN_CP_HIST.Layout_Slim_Clean_Bus;
end;


BDID_Rec bdids(Layout_FBN_CP_HIST.Layout_Slim_Clean_Bus l) := transform
	self.bdid := 0;
	self := l;
end;

common_in := project(cleaned_FBN_CP_HIST_Business, bdids(left));

matchset := ['A','P','N'];
//macro for businesses 
Business_Header_SS.MAC_Add_BDID_FLEX(
  common_in, matchset,
	cname, 
    Bus_prim_range, Bus_prim_name, Bus_zip5, 
	Bus_sec_range,	Bus_st,
	bus_phone,'',
	bdid,	
	BDID_Rec,
	false, bdid_score, //set the flag to true for bdid_score
	postBDID)


export Cleaned_FBN_CP_HIST_Bdid := postBDID :persist(cluster.cluster_out+'persist::FBNV2::CP_HIST_Bdid');
