import CrimSrch, lib_stringlib;

Layout_Moxie_Offenses_temp tJoinForConvictionFlag(Layout_Moxie_Offenses_temp pOffense,Layout_Conviction_Lookup pLookup)
 :=
  transform
	self.fcra_conviction_flag	:= if(pOffense.FCRA_Conviction_Flag = 'Y',
									  pOffense.FCRA_Conviction_Flag,
									  if(pLookup.Conviction_Flag<>'',
										 pLookup.Conviction_Flag,
										 if(pOffense.FCRA_Conviction_Flag <> 'U',
											pOffense.FCRA_Conviction_Flag,
											'U'
										   )
										)
									 );
	self						:=	pOffense;
  end
 ;

dCourtOffensesConvictionByDisp	:= Court_Offenses_Step1_Traffic(Vendor not in sCourt_Vendors_With_Conviction_Based_Upon_Sent_Date);
dCourtOffensesConvictionByDisp1	:= join(dCourtOffensesConvictionByDisp,File_Conviction_Lookup(Court_Disp_Desc<>''),
										//left.Vendor = right.Vendor
									//and 
									trim(lib_stringlib.stringlib.stringtouppercase(left.Court_Disp_Desc)) = trim(lib_stringlib.stringlib.stringtouppercase(right.Court_Disp_Desc)),
										tJoinForConvictionFlag(left,right),
										left outer,
										lookup
									   );
dCourtOffensesConvictionByDisp2	:= join(dCourtOffensesConvictionByDisp1,File_Conviction_Lookup(Court_Disp_Desc<>''),
										//left.Vendor = right.Vendor
									//and 
									trim(lib_stringlib.stringlib.stringtouppercase(left.Court_Disp_Desc)) = trim(lib_stringlib.stringlib.stringtouppercase(right.Court_Disp_Desc)),
										tJoinForConvictionFlag(left,right),
										left outer,
										lookup
									   );
dCourtOffensesConvictionsMaybe	:= join(dCourtOffensesConvictionByDisp2,File_Conviction_Lookup(Court_Disp_Desc='' and Court_Disp_Desc=''),
										//left.Vendor = right.Vendor
									//and 
									trim(lib_stringlib.stringlib.stringtouppercase(left.Court_Disp_Desc)) = trim(lib_stringlib.stringlib.stringtouppercase(right.Court_Disp_Desc))
									and trim(lib_stringlib.stringlib.stringtouppercase(left.Court_Disp_Desc)) = trim(lib_stringlib.stringlib.stringtouppercase(right.Court_Disp_Desc)),
										tJoinForConvictionFlag(left,right),
										left outer,
										lookup
									   );

Layout_Moxie_Offenses_temp tSetConvictionFlagBySentDate(Layout_Moxie_Offenses_temp pOffense)
 :=
  transform
	self.fcra_conviction_flag 	:= if((integer4)pOffense.Sent_Date<>0,'Y','N');
	self						:= pOffense;
  end
 ;
dCourtOffensesConvictionBySentDate	:= Court_Offenses_Step1_Traffic(Vendor in sCourt_Vendors_With_Conviction_Based_Upon_Sent_Date);
dCourtOffensesConvictionBySentDate1	:= project(dCourtOffensesConvictionBySentDate,tSetConvictionFlagBySentDate(left));

#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
export Court_Offenses_Step2_Conviction
 := dCourtOffensesConvictionsMaybe
 +	dCourtOffensesConvictionBySentDate1
 : persist('Persist::CrimSrch_Court_Offenses_Fixed_Conviction')
 ;
#else
export Court_Offenses_Step2_Conviction
 := dCourtOffensesConvictionsMaybe
 +	dCourtOffensesConvictionBySentDate1
 ;
#end