import AutoKeyB2;

export Proc_Build_Autokeys_Bid(

	string pversion

) := function


	AutoKeyB2.MAC_Build(File_Search_Base_Bid,
						fname,mname,lname,
						blank,
						blank,
						phone10,
						prim_name,prim_range,st,p_city_name,zip,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						zero,
						business_name,
						zero,
						phone10,
						prim_name,prim_range,st,p_city_name,zip,sec_range,
						bdid,
						Constants().oldautokeytemplatebid,
						Keynames(pversion).autokeyrootbid.new,
						outaction,false,
						YellowPages.Constants().ak_skipset,true,
						YellowPages.Constants().ak_typeStr
						,true,,,zero)
						
	
	return sequential(outaction,Promote(pversion).buildfiles.New2Built);

end;
