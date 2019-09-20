import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS, header_slimsort, watchdog, business_header,bipv2, INQL_v2;
 

export FN_Append_Bip(dataset(INQL_v2.Layouts.Common_ThorAdditions_non_fcra) pInFile) := function

bdid_match_set := ['A','P','F']; 
bip_layout:=record
  INQL_v2.Layouts.Common_ThorAdditions_non_fcra;
	bipv2.IDlayouts.l_xlink_ids   ;
	string cname;
	string				prim_range;
	string				prim_name;
	string			  zip5;
	string						sec_range;
	string						st;
	string					company_phone;
	string				ein;
	unsigned6			Appended_BDID;
end;


FiltForBDIDAppend :=  project(pInFile(Bus_Q.cname <> '' or Bus_Q.ein <> ''),
transform(bip_layout,
	               self.cname := left.bus_q.cname
								,self.prim_range := left.Bus_Q.prim_range
								,self.prim_name := left.Bus_Q.prim_name
								,self.zip5 := left.Bus_Q.zip5
								,self.sec_range := left.Bus_Q.sec_range
								,self.st := left.Bus_Q.st
								,self.company_phone := left.Bus_Q.company_phone
								,self.ein := left.Bus_Q.ein
								,self.Appended_BDID := left.Bus_Q.Appended_BDID, self := left));
								
Business_Header_SS.MAC_Add_BDID_FLEX(FiltForBDIDAppend
								,bdid_match_set
								,cname
								,prim_range
								,prim_name
								,zip5
								,sec_range
								,st
								,company_phone
								,ein
								,Appended_BDID
								,bip_layout
								,false
								,''
						    ,dPostBip
								, 
 						    , 																
			          , 															
			          ,BIPV2.xlink_version_set				 
			           );

return project(dPostBip,{INQL_v2.Layouts.Common_ThorAdditions_non_fcra,bipv2.IDlayouts.l_xlink_ids} );
end;