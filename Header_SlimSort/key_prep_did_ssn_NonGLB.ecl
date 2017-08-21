IMPORT Data_Services, PRTE2_Header;
slim_rec_plus := record
	unsigned6 did;
	qstring9 ssn;
	QSTRING4 ssn4;
	unsigned2 cnt;
	unsigned2 freq;
	unsigned8 __fpos { virtual (fileposition)};
end;

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
k2 := project(Header_SlimSort.did_ssn('did_ssn_nonglb'),transform(slim_rec_plus,SELF.__fpos:=0,SELF:=LEFT));
#ELSE
k2 := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::base::did_ssn_nonglb_BUILDING',slim_rec_plus,flat);
#END
export key_prep_did_ssn_NonGLB := index(k2,{did,ssn,ssn4,freq,__fpos},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_Data400::key::did_ssn_nonglb' + thorlib.wuid());