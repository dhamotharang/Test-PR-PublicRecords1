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
k4 := project(Header_SlimSort.did_ssn('did_ssn_nonglb_nonUtil'),transform(slim_rec_plus,SELF.__fpos:=0,SELF:=LEFT));
#ELSE
k4 := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::base::did_ssn_nonglb_nonUtil_BUILDING',slim_rec_plus,flat);
#END
export key_prep_did_ssn_Nonglb_NonUtil := index(k4,{did,ssn,ssn4,freq,__fpos},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_Data400::key::did_ssn_nonglb_nonUtil' + thorlib.wuid());