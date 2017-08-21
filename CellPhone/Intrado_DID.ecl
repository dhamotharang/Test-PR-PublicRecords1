import bankrupt,did_add,fair_isaac,didville,ut,header_slimsort,watchdog, Business_Header, Business_Header_SS, idl_header;


df := CellPhone.Intrado_Clean;

temprec := record
	df;
	string		blk := '';
	unsigned6	did_temp := 0;
	unsigned1 	did_score_temp := 0;
	string9		ssn_appended_temp := '';
	qstring34  	vendor_id := df.phone10;
end;

df2 := table(df,temprec);

//---------Apply name flipping macro--------------------
ut.mac_flipnames(df2,fname,mname,lname,names_flipped);

//------------------------------------------------------
myset := ['A','D','P','Q','Z'];

did_add.MAC_Match_Flex(names_flipped,myset,d1,blk,fname,mname,lname,
	name_suffix,prim_range, prim_name, sec_range, zip5, state, phone10,
	did_temp,temprec,true,did_score_temp,70,outf)
	


did_add.MAC_Add_SSN_By_DID(outf,did_temp,ssn_appended_temp,out2,true)	

				
typeof(df) into(out2 L) := transform
	self.did := L.did_temp; //if (L.did_temp = 0,'',intformat(L.did_temp,12,1));
	self.did_score := intformat(L.did_score_temp,3,1);
	self := L;
end;

out4 := project(out2,into(LEFT)) : PERSIST('~thor_dell400::persist::intrado_did');


export Intrado_DID := out4;




