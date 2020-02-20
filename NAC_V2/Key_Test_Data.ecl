/***
Key definition for Nac_V2 test system.
See DF-22004
***/
import doxie,data_services, iesp;

rNACCannedResponseBase	:=
record
	unsigned4		RequestHash;
	string20		TestDataTableName;
	// iesp.nac2_search.t_NAC2SearchResponse;
	iesp.share.t_ResponseHeader - Disclaimers _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(iesp.nac2_search.t_NAC2SearchResultRecord) Records {xpath('Records/Record'), MAXCOUNT(60)};
end;

dNACCannedResponseBase := DATASET('~nac::test::canned_response_base', rNACCannedResponseBase, thor);

EXPORT Key_Test_Data := index(dNACCannedResponseBase, {RequestHash, TestDataTableName}, {dNACCannedResponseBase},
						data_services.Data_Location.Prefix('DEFAULT')+'thor::NAC2::key::test_data_' + doxie.version_superkey);