import ut, Business_Header_SS, Business_Header, bipv2;


export FN_Append_Bip(dataset(SAM.layout_bip_linkid) pInFile) := function

bdid_match_set := ['A', 'N'];

filterappendlinkid := pInFile(cname <> '');
filterappend_nolinkid := pInFile(cname = '');


Business_Header_SS.MAC_Add_BDID_FLEX(filterappendlinkid
								,bdid_match_set
								,cname
								,prim_range
								,prim_name
								,zip
								,sec_range
								,st
								,''
								,''
								,BDID
								,SAM.layout_bip_linkid
								,false
								,''
						    ,dPostBip
								,
 						    ,
			          ,
			          ,BIPV2.xlink_version_set
							  ,													// url
	            	,															// email
		            ,p_city_name													// city
		            ,fname																// fname
	              ,mname																// mname
	            	,lname																// lname
	              );

outfile := dPostBip;
return outfile;
end;
