export	Mac_Append_RawAID(pFileIn,pFileOut)	:=
macro

	import	AID;
	
	#uniquename(dFileInAddrPopulated)
	#uniquename(dFileInAddrNotPopulated)
	#uniquename(dFileAppendRawAID)
	#uniquename(tRefomat2Orig)
	#uniquename(dFileRawAID)

	%dFileInAddrPopulated%		:=	pFileIn(Append_PrepAddr1	!=	''	and	Append_PrepAddr2	!=	'');
	%dFileInAddrNotPopulated%	:=	pFileIn(~(Append_PrepAddr1	!=	''	and	Append_PrepAddr2	!=	''));

	// Pass the records to the AddressID macro to fetch the RawAID
	AID.MacAppendFromRaw_2Line(	%dFileInAddrPopulated%,
															Append_PrepAddr1,
															Append_PrepAddr2,
															Append_RawAID,
															%dFileAppendRawAID%,
															AID.Common.eReturnValues.RawAID
														);

	recordof(pFileIn)	%tRefomat2Orig%(%dFileAppendRawAID%	pInput)	:=
	transform
		self.Append_RawAID	:=	pInput.AIDWork_RawAID;
		self								:=	pInput;
	end;

	%dFileRawAID%	:=	project(%dFileAppendRawAID%,%tRefomat2Orig%(left));
	
	pFileOut	:=	%dFileRawAID%	+	%dFileInAddrNotPopulated%;

endmacro;