export MAC_RoyaltyQSENT(inf, royal_out, count_qt, count_pvs, src='vendor_id', type_flag='TypeFlag') := macro

	import MDR, Phones;
	
	#uniquename(qsent_royal)	
	%qsent_royal% := 
		dataset([{
							Royalty.Constants.RoyaltyCode.QSENT,
							Royalty.Constants.RoyaltyType.QSENT, 
							count(inf(src=MDR.sourceTools.src_Inhouse_QSent)), 
							0, 
							''
							}], Royalty.Layouts.Royalty)(royalty_count>0);

	#uniquename(qsent_IQ411_royal)	
	%qsent_IQ411_royal% := 
		dataset([{
							Royalty.Constants.RoyaltyCode.QSENT_IQ411,
							Royalty.Constants.RoyaltyType.QSENT_IQ411, 
							count(inf(type_flag=Phones.Constants.TypeFlag.DataSource_iQ411)), 
							0, 
							''
							}], Royalty.Layouts.Royalty);

	#uniquename(qsent_PVS_royal)	
	%qsent_PVS_royal% := 
		dataset([{
							Royalty.Constants.RoyaltyCode.QSENT_PVS,
							Royalty.Constants.RoyaltyType.QSENT_PVS, 
							count(inf(type_flag=Phones.Constants.TypeFlag.DataSource_PV)), 
							0, 
							''
							}], Royalty.Layouts.Royalty);

	royal_out := dataset([], Royalty.Layouts.Royalty) +
								if(count_qt, %qsent_royal%)+
								if(count_pvs, %qsent_IQ411_royal% + %qsent_PVS_royal%);
endmacro;
