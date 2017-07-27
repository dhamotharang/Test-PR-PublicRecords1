import Lib_KeyLib, Lib_ZipLib, Lib_StringLib;

lBaseKeyName 	:= 'key::moxie.corp.';
lMoxieFileName	:= '~thor_data400::out::corp_' + Corp.Corp_Build_Date;

rMoxieFileLayout
 :=
  record
	Corp.Layout_Corp_Out;
    unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

dMoxieFile := dataset(lMoxieFileName,rMoxieFileLayout,flat);

// Begin "Normal" keys, built upon existing fields without normalization vvvvvvvvvvvvvvvvvvvvv
rNormalKeysLayout
 :=
  record
	typeof(dMoxieFile.Corp_SOS_Charter_Nbr) sos_charter_nbr := trim(dMoxieFile.Corp_SOS_Charter_Nbr,left);
	typeof(dMoxieFile.Corp_State_Origin) 	st_orig			:= dMoxieFile.Corp_State_Origin;								// Just to rename to match keyname
	typeof(dMoxieFile.Corp_Fed_Tax_ID) 		fein 			:= dMoxieFile.Corp_Fed_Tax_ID;									// Just to rename to match keyname
	string50								corpname		:= dMoxieFile.Corp_Legal_Name;									// Shortened and renamed
	string30								nameasis		:= Lib_KeyLib.KeyLib.CompNameNoSyn(dMoxieFile.Corp_Legal_Name); // Shortened and tweaked
    dMoxieFile.BDID;
	typeof(dMoxieFile.corp_key)				corpkey		:= Lib_StringLib.StringLib.StringToUpperCase(dMoxieFile.corp_key);
	big_endian unsigned8 					filepos 		:= (big_endian unsigned8)dMoxieFile.__filepos;
  end
 ;
	
dNormalKeysTable	:= table(dMoxieFile,rNormalKeysLayout);

kBDID				:= buildindex(dNormalKeysTable(bdid<>''),{bdid,filepos},
									lBaseKeyName + 'bdid.key',moxie,overwrite);
									
kFEIN				:= buildindex(dNormalKeysTable(fein<>''),{fein,filepos},
									lBaseKeyName + 'fein.key',moxie,overwrite);
									
kCharterNo			:= buildindex(dNormalKeysTable(sos_charter_nbr<>''),{sos_charter_nbr,filepos},
									lBaseKeyName + 'sos_charter_nbr.key',moxie,overwrite);
									
kStOrigCharterNo	:= buildindex(dNormalKeysTable(st_orig<>''),{st_orig,sos_charter_nbr,filepos},
									lBaseKeyName + 'st_orig.sos_charter_nbr.key',moxie,overwrite);
									
kCorpName			:= buildindex(dNormalKeysTable(corpname<>''),{corpname,filepos},
									lBaseKeyName + 'corpname.key',moxie,overwrite);
									
kNameAsIs			:= buildindex(dNormalKeysTable(nameasis<>''),{nameasis,filepos},
									lBaseKeyName + 'nameasis.key',moxie,overwrite);
									
kCorpKey			:= buildindex(dNormalKeysTable(corpkey<>''),{corpkey,filepos},
									lBaseKeyName + 'corp_key.key',moxie,overwrite);
									
// End "Normal" keys ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// Begin "State Normalized" keys, based upon keys using state-only, unique because we include state_origin in addition to addresses
rStateKeysLayout
 :=
  record
	typeof(dMoxieFile.Corp_State_Origin) 	st				:= '';															// Will be normalized
	dMoxieFile.Corp_State_Origin;								
	dMoxieFile.Corp_Addr1_State;								
	dMoxieFile.Corp_Addr2_State;								
	dMoxieFile.Corp_RA_State;								
	dMoxieFile.Corp_Inc_State;								
	string50								corpname		:= dMoxieFile.Corp_Legal_Name;									// Shortened and renamed
	string30								nameasis		:= Lib_KeyLib.KeyLib.CompNameNoSyn(dMoxieFile.Corp_Legal_Name); // Shortened and tweaked
	string80								cn80			:= Lib_KeyLib.KeyLib.GongDACName(dMoxieFile.Corp_Legal_Name);	// Shortened and tweaked
	string10								cn				:= '';	// Shortened and tweaked
	big_endian unsigned8					filepos			:= (big_endian unsigned8)dMoxieFile.__filepos;
  end
 ;

rStateKeysLayout tNormalizeState(rStateKeysLayout pInput,unsigned1 pCounter)
 :=
  transform
	self.st	:= choose(pCounter,
					  pInput.Corp_State_Origin,
					  pInput.Corp_Addr1_State,
					  pInput.Corp_Addr2_State,
					  pInput.Corp_RA_State,
					  pInput.Corp_Inc_State
					 );
	self 	:= pInput;
end;

dStateKeysTable		:= table(dMoxieFile,rStateKeysLayout);
dStateKeysNorm		:= normalize(dStateKeysTable,5,tNormalizeState(left,counter));

rStateKeysLayout tNormalizeStateCN(rStateKeysLayout pInput,unsigned1 pCounter)
 :=
  transform
	self.cn	:= choose(pCounter,
					  pInput.cn80[1..10],
					  pInput.cn80[11..20],
					  pInput.cn80[21..30],
					  pInput.cn80[31..40],
					  pInput.cn80[41..50],
					  pInput.cn80[51..60],
					  pInput.cn80[61..70],
					  pInput.cn80[71..80]
					  );
	self 	:= pInput;
end;

dStateCNKeysNorm	:= normalize(dStateKeysNorm,8,tNormalizeStateCN(left,counter));

dStateKeysDist		:= distribute(dStateCNKeysNorm,hash(st,filepos));
dStateKeysSort		:= sort(dStateKeysDist(st<>''),st,filepos,local);			// omitting blank states here, the sooner the better


dStateCNKeysDedup	:= dedup(dStateKeysSort(cn<>''),st,cn,filepos,local);																		
kStCN				:= buildindex(dStateCNKeysDedup,{st,cn,filepos},
									lBaseKeyName + 'st.cn.key',moxie,overwrite);
									
dCNKeysDedup		:= dedup(dStateCNKeysDedup,cn,filepos,local);																		
kCN					:= buildindex(dCNKeysDedup,{cn,filepos},
									lBaseKeyName + 'cn.key',moxie,overwrite);

dStateKeysDedup		:= dedup(dStateKeysSort,st,filepos,local);																		

kStCorpName			:= buildindex(dStateKeysDedup,{st,corpname,filepos},		// already looking for blank st field, no need to repeat here
									lBaseKeyName + 'st.corpname.key',moxie,overwrite);

kStNameAsIs			:= buildindex(dStateKeysDedup,{st,nameasis,filepos},
									lBaseKeyName + 'st.nameasis.key',moxie,overwrite);


// End "State Normalized" keys ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// Begin "Address Normalized" keys, based upon multiple addresses vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
rAddressKeysLayout
 :=
  record
    typeof(dMoxieFile.corp_addr1_predir)		predir			:= '';
    typeof(dMoxieFile.corp_addr1_predir)		pre_dir			:= '';
	typeof(dMoxieFile.corp_addr1_prim_name)		prim_name		:= '';
	typeof(dMoxieFile.corp_addr1_prim_range)	prim_range		:= '';
	typeof(dMoxieFile.corp_addr1_addr_suffix)	suffix			:= '';
	typeof(dMoxieFile.corp_addr1_postdir)		postdir			:= '';
	typeof(dMoxieFile.corp_addr1_postdir)		post_dir		:= '';
	typeof(dMoxieFile.corp_addr1_p_city_name)	city			:= '';
	typeof(dMoxieFile.corp_addr1_state)			st				:= '';
	typeof(dMoxieFile.corp_addr1_zip5)			zip				:= '';
	typeof(dMoxieFile.corp_addr1_zip5)			z5				:= '';
	string28									street_name		:= '';
	dMoxieFile.Corp_Addr1_PreDir;
	dMoxieFile.Corp_Addr1_Prim_Name;
	dMoxieFile.Corp_Addr1_Prim_Range;
	dMoxieFile.Corp_Addr1_Addr_Suffix;
	dMoxieFile.Corp_Addr1_PostDir;
	dMoxieFile.Corp_Addr1_P_City_Name;
	dMoxieFile.Corp_Addr1_State;
	dMoxieFile.Corp_Addr1_Zip5;
	dMoxieFile.Corp_Addr2_PreDir;
	dMoxieFile.Corp_Addr2_Prim_Name;
	dMoxieFile.Corp_Addr2_Prim_Range;
	dMoxieFile.Corp_Addr2_Addr_Suffix;
	dMoxieFile.Corp_Addr2_PostDir;
	dMoxieFile.Corp_Addr2_P_City_Name;
	dMoxieFile.Corp_Addr2_State;
	dMoxieFile.Corp_Addr2_Zip5;
	string50									corpname		:= dMoxieFile.Corp_Legal_Name;									// Shortened and renamed
	string30									nameasis		:= Lib_KeyLib.KeyLib.CompNameNoSyn(dMoxieFile.Corp_Legal_Name); // Shortened and tweaked
	string80									cn80			:= Lib_KeyLib.KeyLib.GongDACName(dMoxieFile.Corp_Legal_Name);	// Shortened and tweaked
	string10									cn				:= '';
	string60									compname		:= Lib_KeyLib.KeyLib.CompName(dMoxieFile.Corp_Legal_Name);		// Tweaked
	varstring									ZipToCityList	:= '';
	big_endian unsigned8 						filepos 		:= (big_endian unsigned8)dMoxieFile.__filepos;
  end
 ;

rAddressKeysLayout tNormalizeAddress(rAddressKeysLayout pInput, unsigned pCounter)
 :=
  transform
    self.predir			:= choose(pCounter,
								  pInput.corp_addr1_predir,
								  pInput.corp_addr2_predir
								 );
	self.pre_dir		:= self.predir;
    self.prim_name		:= choose(pCounter,
								  pInput.corp_addr1_prim_name,
								  pInput.corp_addr2_prim_name
								 );
    self.street_name	:= self.prim_name;
    self.prim_range		:= choose(pCounter,
								  pInput.corp_addr1_prim_range,
								  pInput.corp_addr2_prim_range
								 );
    self.suffix			:= choose(pCounter,
								  pInput.corp_addr1_addr_suffix,
								  pInput.corp_addr2_addr_suffix
								 );
    self.postdir		:= choose(pCounter,
								  pInput.corp_addr1_postdir,
								  pInput.corp_addr2_postdir
								 );
	self.post_dir		:= self.postdir;
    self.city			:= choose(pCounter,
								  pInput.corp_addr1_p_city_name,
								  pInput.corp_addr2_p_city_name
								 );
    self.st				:= choose(pCounter,
								  pInput.corp_addr1_state,
								  pInput.corp_addr2_state
								 );
    self.zip			:= choose(pCounter,
								  pInput.corp_addr1_zip5,
								  pInput.corp_addr2_zip5
								 );
    self.z5				:= self.zip;
	self.ZipToCityList	:= choose(pCounter,
								  Lib_ZipLib.ZipLib.ZipToCities(pInput.corp_addr1_zip5),
								  Lib_ZipLib.ZipLib.ZipToCities(pInput.corp_addr2_zip5)
								 );
	self				:= pInput;
  end
 ;

dAddressKeysTable	:= table(dMoxieFile,rAddressKeysLayout);
dAddressKeysNorm	:= normalize(dAddressKeysTable,2,tNormalizeAddress(left,counter));

rAddressKeysLayout tNormalizeAddressCN(rAddressKeysLayout pInput,unsigned1 pCounter)
 :=
  transform
	self.cn	:= choose(pCounter,
					  pInput.cn80[1..10],
					  pInput.cn80[11..20],
					  pInput.cn80[21..30],
					  pInput.cn80[31..40],
					  pInput.cn80[41..50],
					  pInput.cn80[51..60],
					  pInput.cn80[61..70],
					  pInput.cn80[71..80]
					  );
	self 	:= pInput;
end;

dAddressCNKeysNorm	:= normalize(dAddressKeysNorm,8,tNormalizeAddressCN(left,counter));

dAddressKeysDist	:= distribute(dAddressCNKeysNorm,hash(zip,filepos));
dAddressKeysSort	:= sort(dAddressKeysDist,zip,st,city,postdir,suffix,prim_name,predir,filepos,local);

dZipStreetPrimRange := dedup(dAddressKeysSort,zip,street_name,prim_range,filepos,local);
kZipStreetPrimRange := buildindex(dZipStreetPrimRange(zip<>''),{zip,street_name,prim_range,filepos},
									lBaseKeyName + 'zip.street_name.prim_range.key',moxie,overwrite);
dZ5PrimNamePrimRange:= dedup(dAddressKeysSort,z5,prim_name,prim_range,filepos,local);
kZ5PrimNamePrimRange:= buildindex(dZ5PrimNamePrimRange(z5<>''),{z5,prim_name,prim_range,filepos},
									lBaseKeyName + 'z5.prim_name.prim_range.key',moxie,overwrite);
dZipStreetEverything:= dedup(dAddressKeysSort,zip,street_name,suffix,predir,postdir,prim_range,compname,filepos,local);
kZipStreetEverything:= buildindex(dZipStreetEverything(zip<>''),{zip,street_name,suffix,predir,postdir,prim_range,compname,filepos},
									lBaseKeyName + 'zip.street_name.suffix.predir.postdir.prim_range.company.key',moxie,overwrite);

rAddressKeysLayout tNormalizeAddressKeysCities(rAddressKeysLayout pInput,integer pCounter)
 :=
  transform
	self.city	:= if(pCounter=1,pInput.city,stringlib.stringextract(pInput.ZipToCityList,pCounter));
	self		:= pInput;
  end
 ;
 
dAddressCityKeysTableNorm	:= normalize(dAddressKeysSort,
										 (integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
										 tNormalizeAddressKeysCities(left,counter)
										);
dAddressCityKeysTableDist	:= distribute(dAddressCityKeysTableNorm,hash(st,city,filepos));

dStCityCorpName		:= dedup(dAddressCityKeysTableDist,st,city,corpname,filepos,local);
kStCityCorpName		:= buildindex(dStCityCorpName(st<>''),{st,city,corpname,filepos},
									lBaseKeyName + 'st.city.corpname.key',moxie,overwrite);
dStCityEverything	:= dedup(dAddressCityKeysTableDist,st,city,prim_name,prim_range,predir,postdir,suffix,filepos,local);
kStCityEverything	:= buildindex(dStCityEverything(st<>''),{st,city,prim_name,prim_range,predir,postdir,suffix,filepos},
									lBaseKeyName + 'st.city.prim_name.prim_range.pre_dir.post_dir.suffix.key',moxie,overwrite);
dStCityCN			:= dedup(dAddressCityKeysTableDist,st,city,cn,filepos,local);
kStCityCN			:= buildindex(dStCityCN(st<>''),{st,city,cn,filepos},
									lBaseKeyName + 'st.city.cn.key',moxie,overwrite);
dStCityNameAsIs		:= dedup(dAddressCityKeysTableDist,st,city,nameasis,filepos,local);
kStCityNameAsIs		:= buildindex(dStCityNameAsIs(st<>''),{st,city,nameasis,filepos},
									lBaseKeyName + 'st.city.nameasis.key',moxie,overwrite);
// End "Address Normalized" keys ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(Corp.Layout_Corp_Out) * count(dMoxieFile) : global;
headersize := sizeof(Corp.Layout_Corp_Out) : global;

dfile := INDEX(dMoxieFile,{f:= moxietransform(__filepos, rawsize, headersize)},{dMoxieFile},lBaseKeyName + 'fpos.data.key');

kfpos := buildindex(dfile,moxie,overwrite);

// --end fpos key





export Out_Corp_Moxie_Keys
 :=
  parallel(
			 kBDID
			,kFEIN
			,kCharterNo
			,kStOrigCharterNo
			,kCorpName
			,kNameAsIs
			,kCN
			,kCorpKey
			,kStCorpName
			,kStCN
			,kStNameAsIs
			,kZipStreetPrimRange
			,kZ5PrimNamePrimRange
			,kZipStreetEverything
			,kStCityCorpName
			,kStCityEverything
			,kStCityCN
			,kStCityNameAsIs
			,kfpos
		   )
 ;