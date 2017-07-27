import iesp;

layout_ResponseHeader := record, maxlength(10000)
	iesp.share.t_ResponseHeader;
	string100	ErrMsg {xpath('ErrMsg')};
	unsigned2	ErrCode {xpath('ErrCode')};
end;

layout_Response := record
	layout_ResponseHeader header {xpath('Header/')};
	iesp.gateway.t_NetAcuityInfo - _Header;
end;

EXPORT layout_NA_Out_v4 := record
	layout_Response response {xpath('Response/')};
end;