export Check_4_New_Fields(

	dataset(Layout_YellowPages)	pInputFile	= Files().Input.Using

) :=
function

	TargusIn	:=	pInputFile(business_name <> '');

	badFields := TargusIn(trim(ExecName,left,right) <> '' or 
												trim(trim(FaxAC,left,right) + trim(FaxExchge,left,right) + trim(FaxPhone,left,right),left,right)<>'' or 
												trim(trim(AltAC,left,right) + trim(AltExchge,left,right) + trim(AltPhone,left,right),left,right)<>'' or
												trim(trim(MobileAC,left,right) + trim(MobileExchge,left,right) + trim(MobilePhone,left,right),left,right)<>'' or
												trim(trim(tollFreeAC,left,right) + trim(TollFreeExchge,left,right) + trim(TollFreePhone,left,right),left,right)<>''
												);					 
						 
	chkForNewFields := if(exists(badFields),
												fail('Targus is sending newly populated fields  - Development is needed!  The following fields need examined: executive contact name, FAX number, tollfree Number, Mobile number'),
												output('Continuing')
											 );

	return chkForNewFields;

end;