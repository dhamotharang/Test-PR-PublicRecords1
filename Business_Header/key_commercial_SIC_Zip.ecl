Import Data_Services, doxie, ut, PRTE2_Business_Header;

f1 	:= 	dedup(sort(distribute(Business_Header.BH_BDID_SIC('built',pPersistname := persistnames().BHBDIDSIC + '::commercial_sickey')(ut.isNumeric(sic_code)),bdid),bdid,sic_code,local),bdid,sic_code,local);
f2	:=	dedup(sort(distribute(Business_Header.File_Business_Header,bdid),bdid,zip,zip4,local),bdid,zip,zip4,local);

layout_sic_index := record
	string8 sic_code;
	unsigned3 zip;
	unsigned2 zip4;	
	unsigned6 bdid;
end;

layout_sic_index JoinedToGetZips(f1 lInput, f2 rInput)	:=	transform
	self	:=	lInput;
	self	:=	rInput;
end;

JoinToGetZips	:=	join(	f1,
							f2,
							left.bdid=right.bdid,
							JoinedToGetZips(left,right),
							left outer,
							local
						 );

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
fdedup := dataset([],layout_sic_index);
#ELSE
fdedup := dedup(JoinToGetZips, all);
#END;

export key_commercial_SIC_Zip := index(fdedup,{sic_code, zip, zip4}, {bdid},'~thor_data400::key::business_header.CommercialBus.sic_zip_code_' + doxie.Version_SuperKey);