IMPORT Data_Services,PRTE2_Header;
slim_rec_plus := record
	unsigned6 did;
	qstring9 ssn;
	QSTRING4 ssn4;
	unsigned2 cnt;
	unsigned2 freq;
	unsigned8 __fpos { virtual (fileposition)};
end;
#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
k3 := project(Header_SlimSort.did_ssn('did_ssn_nonUtil'),transform(slim_rec_plus,SELF.__fpos:=0,SELF:=LEFT));
#ELSE
k3 := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::base::did_ssn_nonUtil_BUILDING',slim_rec_plus,flat);
#END
export key_prep_did_ssn_nonUtil := index(k3,{did,ssn,ssn4,freq,__fpos},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_Data400::key::did_ssn_nonUtil' + thorlib.wuid());
