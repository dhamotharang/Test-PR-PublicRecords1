import business_header,business_header_ss,ut,did_add,mdr;

df := busdata.File_Credit_Unions;

rec := busdata.Layout_Credit_Unions_Base;

rec into_base(df L) := transform
	self.bdid := 0;
	self := L;
end;

df2 := project(df,into_base(LEFT));

business_header.MAC_Source_Match(df2,outf1,
							false,bdid,
							false,MDR.sourceTools.src_Credit_Unions,
							false,foo,
							cu_name,
							prim_range,prim_name,sec_range,zip,
							true,phone,
							false,foo);

df3 := outf1(bdid = 0);
myset := ['A','P'];

business_header_ss.MAC_Match_Flex(df3,myset,
						cu_name,
						prim_range,prim_name,zip,sec_range,st,
						phone,foo,
						bdid,
						rec,
						false, foo,
						outf2)

outfinal := outf2 + outf1(bdid != 0);

ut.mac_suppress_by_phonetype(outfinal,phone,state,outfinal_Clean_Phones);

ut.MAC_SF_BuildProcess(outfinal_Clean_Phones,'~thor_data400::base::credit_unions',do1,2);
export build_base := do1;

Out_Population_Stats.Business_Headers.Credit_Unions(qa, BH_Stats);
Out_Population_Stats.Business_Contact.Credit_Unions(qa, BC_Stats);

export Proc_Build_CreditUnions_BASE := 
sequential(
	 build_base
	,BH_Stats
	,BC_Stats
);