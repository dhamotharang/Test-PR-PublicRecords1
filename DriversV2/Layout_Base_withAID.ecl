import AID;

export Layout_Base_withAID	:= record
	DriversV2.Layout_DL_Extended;	
	STRING100	Append_MailAddress1;
	STRING50	Append_MailAddressLast;
	AID.Common.xAID	Append_MailRawAID;
	AID.Common.xAID Append_MailACEAID; 
end;
