import business_header,business_Header_SS,did_add,ut;

df := govdata.File_SEC_Broker_Dealer_In;

govdata.Layout_SEC_Broker_Dealer_BDID into_BDID(DF L) := transform
	self := L;
	self.bdid := 0;
end;

df2 := project(df,into_bdid(LEFT));

business_header.MAC_Source_Match(df2,outf1,
							false,bdid,
							false,'SB',
							false,foo,
							company_name,
							prim_range,prim_name,sec_range,zip,
							false,phone,
							false,fein)
							
o1 := outf1(bdid = 0);
o1_bdid := outf1(bdid != 0);
myset := ['A'];

business_header_SS.MAC_Match_Flex(o1,myset,
						company_name,
						prim_Range,prim_name,zip,
						sec_range,st,phone,fein,bdid,
						govdata.Layout_SEC_Broker_Dealer_BDID,
						false,bdscore,
						outf2)
						
outf := outf2 + o1_bdid;

//output(outf,,'~thor_data400::base::sec_broker_dealer_bdid_' + govdata.sec_bdid_date);

ut.MAC_SF_BuildProcess(outf,'~thor_data400::base::sec_broker_dealer',do1,2);

export Make_SEC_Broker_Dealer_BDID := do1;


						