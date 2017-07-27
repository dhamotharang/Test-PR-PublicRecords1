import Lib_KeyLib, Lib_ZipLib, Lib_StringLib;

string lSingleSpace(string pString1, string pString2, string pString3='')
 := trim(pString1) + ' '
  + if(trim(pString2) = '',
	   ' ',
	   trim(pString2) + ' '
	  )
  + trim(pString3)
 ;

lBaseKeyName 	:= 'key::moxie.corp_cont.';
lMoxieFileName	:= '~thor_data400::out::corp_cont_' + Corp.Corp_Build_Date;

rMoxieFileLayout
 :=
  record
	Corp.Layout_Corp_Cont_Out;
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
	string50								corpname		:= dMoxieFile.Corp_Legal_Name;									// Shortened and renamed
	string40        						lfmname 		:= lSingleSpace(dMoxieFile.cont_lname,
																			dMoxieFile.cont_fname,
																			dMoxieFile.cont_mname
																		   );
	string30								nameasis		:= Lib_KeyLib.KeyLib.CompNameNoSyn(dMoxieFile.Corp_Legal_Name); 	// Shortened and tweaked
	dMoxieFile.DID;
	dMoxieFile.BDID;
	typeof(dMoxieFile.corp_key)				corpkey			:= Lib_StringLib.StringLib.StringToUpperCase(dMoxieFile.corp_key);
	big_endian unsigned8 					filepos 		:= (big_endian unsigned8)dMoxieFile.__filepos;
  end
 ;
	
dNormalKeysTable	:= table(dMoxieFile,rNormalKeysLayout);

kBDID				:= buildindex(dNormalKeysTable(bdid<>''),{bdid,filepos},
									lBaseKeyName + 'bdid.key',moxie,overwrite);
kDID				:= buildindex(dNormalKeysTable(did<>''),{did,filepos},
									lBaseKeyName + 'did.key',moxie,overwrite);
kLFMName			:= buildindex(dNormalKeysTable(lfmname<>''),{lfmname,filepos},
									lBaseKeyName + 'lfmname.key',moxie,overwrite);
kCorpKey			:= buildindex(dNormalKeysTable(corpkey<>''),{corpkey,filepos},
									lBaseKeyName + 'corp_key.key',moxie,overwrite);
kCorpName			:= buildindex(dNormalKeysTable(corpname<>''),{corpname,filepos},
									lBaseKeyName + 'corpname.key',moxie,overwrite);
kNameAsIs			:= buildindex(dNormalKeysTable(nameasis<>''),{nameasis,filepos},
									lBaseKeyName + 'nameasis.key',moxie,overwrite);
kCharterNo			:= buildindex(dNormalKeysTable(sos_charter_nbr<>''),{sos_charter_nbr,filepos},
									lBaseKeyName + 'sos_charter_nbr.key',moxie,overwrite);
kStOrigCharterNo	:= buildindex(dNormalKeysTable(st_orig<>''),{st_orig,sos_charter_nbr,filepos},
									lBaseKeyName + 'st_orig.sos_charter_nbr.key',moxie,overwrite);
// End "Normal" keys ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// Begin "State Normalized" keys, based upon keys using state-only, unique because we include state_origin in addition to addresses
rStateKeysLayout
 :=
  record
	typeof(dMoxieFile.Corp_State_Origin) 	st				:= '';															// Will be normalized
	string50								corpname		:= dMoxieFile.Corp_Legal_Name;									// Shortened and renamed
	string40        						lfmname 		:= lSingleSpace(dMoxieFile.cont_lname,
																			dMoxieFile.cont_fname,
																			dMoxieFile.cont_mname
																		   );
	string30								nameasis		:= Lib_KeyLib.KeyLib.CompNameNoSyn(dMoxieFile.Corp_Legal_Name); 	// Shortened and tweaked
	string80								cn80			:= Lib_KeyLib.KeyLib.GongDACName(dMoxieFile.Corp_Legal_Name);		// Shortened and tweaked	
	string10								cn				:= '';
	dMoxieFile.Corp_State_Origin;								
	dMoxieFile.Corp_Addr1_State;								
	dMoxieFile.Cont_State;								
	big_endian unsigned8					filepos			:= (big_endian unsigned8)dMoxieFile.__filepos;
  end
 ;

rStateKeysLayout tNormalizeState(rStateKeysLayout pInput,unsigned1 pCounter)
 :=
  transform
	self.st	:= choose(pCounter,
					  pInput.Corp_State_Origin,
					  pInput.Corp_Addr1_State,
					  pInput.Cont_State
					 );
	self 	:= pInput;
end;

dStateKeysTable		:= table(dMoxieFile,rStateKeysLayout);
dStateKeysNorm		:= normalize(dStateKeysTable,3,tNormalizeState(left,counter));

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
dStateKeysDedup		:= dedup(dStateKeysSort,st,filepos,local);

kStCorpName			:= buildindex(dStateKeysDedup,{st,corpname,filepos},		// already looking for blank st field, no need to repeat here
									lBaseKeyName + 'st.corpname.key',moxie,overwrite);
									
kStLFMName			:= buildindex(dStateKeysDedup,{st,lfmname,filepos},
									lBaseKeyName + 'st.lfmname.key',moxie,overwrite);
									
kStCN				:= buildindex(dStateKeysSort,{st,cn,filepos},
									lBaseKeyName + 'st.cn.key',moxie,overwrite);
									
kStNameAsIs			:= buildindex(dStateKeysDedup,{st,nameasis,filepos},
									lBaseKeyName + 'st.nameasis.key',moxie,overwrite);
									
kCN					:= buildindex(dStateKeysSort(cn<>''),{cn,filepos},
									lBaseKeyName + 'cn.key',moxie,overwrite);

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
	dMoxieFile.Cont_PreDir;
	dMoxieFile.Cont_Prim_Name;
	dMoxieFile.Cont_Prim_Range;
	dMoxieFile.Cont_Addr_Suffix;
	dMoxieFile.Cont_PostDir;
	dMoxieFile.Cont_P_City_Name;
	dMoxieFile.Cont_State;
	dMoxieFile.Cont_Zip5;
	string50									corpname		:= dMoxieFile.Corp_Legal_Name;									// Shortened and renamed
	string30									nameasis		:= Lib_KeyLib.KeyLib.CompNameNoSyn(dMoxieFile.Corp_Legal_Name); // Shortened and tweaked
	string80									cn80			:= Lib_KeyLib.KeyLib.GongDACName(dMoxieFile.Corp_Legal_Name);	// Shortened and tweaked	
	string10									cn				:= '';
	string40        							lfmname 		:= lSingleSpace(dMoxieFile.cont_lname,
																			dMoxieFile.cont_fname,
																			dMoxieFile.cont_mname
																		   );
	varstring									ZipToCityList	:= '';
	big_endian unsigned8 						filepos 		:= (big_endian unsigned8)dMoxieFile.__filepos;
  end
 ;

rAddressKeysLayout tNormalizeAddress(rAddressKeysLayout pInput, unsigned pCounter)
 :=
  transform
    self.predir			:= choose(pCounter,
								  pInput.corp_addr1_predir,
								  pInput.cont_predir
								 );
	self.pre_dir		:= self.predir;
    self.prim_name		:= choose(pCounter,
								  pInput.corp_addr1_prim_name,
								  pInput.Cont_prim_name
								 );
    self.street_name	:= self.prim_name;
    self.prim_range		:= choose(pCounter,
								  pInput.corp_addr1_prim_range,
								  pInput.Cont_prim_range
								 );
    self.suffix			:= choose(pCounter,
								  pInput.corp_addr1_addr_suffix,
								  pInput.Cont_addr_suffix
								 );
    self.postdir		:= choose(pCounter,
								  pInput.corp_addr1_postdir,
								  pInput.Cont_postdir
								 );
	self.post_dir		:= self.postdir;
    self.city			:= choose(pCounter,
								  pInput.corp_addr1_p_city_name,
								  pInput.Cont_p_city_name
								 );
    self.st				:= choose(pCounter,
								  pInput.corp_addr1_state,
								  pInput.Cont_state
								 );
    self.zip			:= choose(pCounter,
								  pInput.corp_addr1_zip5,
								  pInput.Cont_zip5
								 );
    self.z5				:= self.zip;
	self.ZipToCityList	:= choose(pCounter,
								  Lib_ZipLib.ZipLib.ZipToCities(pInput.corp_addr1_zip5),
								  Lib_ZipLib.ZipLib.ZipToCities(pInput.Cont_zip5)
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

dZ5PrimNamePrimRange:= dedup(dAddressKeysSort,z5,prim_name,prim_range,filepos,local);
kZ5PrimNamePrimRange:= buildindex(dZ5PrimNamePrimRange(z5<>''),{z5,prim_name,prim_range,filepos},
									lBaseKeyName + 'z5.prim_name.prim_range.key',moxie,overwrite);
dZipStreetEverything:= dedup(dAddressKeysSort,zip,street_name,suffix,predir,postdir,prim_range,lfmname,filepos,local);
kZipStreetEverything:= buildindex(dZipStreetEverything(zip<>''),{zip,street_name,suffix,predir,postdir,prim_range,lfmname,filepos},
									lBaseKeyName + 'z5.street_name.suffix.predir.postdir.prim_range.lfmname.key',moxie,overwrite);

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
dStCityLFMName		:= dedup(dAddressCityKeysTableDist,st,city,lfmname,filepos,local);
kStCityLFMName		:= buildindex(dStCityLFMName(st<>''),{st,city,lfmname,filepos},
									lBaseKeyName + 'st.city.lfmname.key',moxie,overwrite);
// End "Address Normalized" keys ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(Corp.Layout_Corp_Cont_Out) * count(dMoxieFile) : global;
headersize := sizeof(Corp.Layout_Corp_Cont_Out) : global;

dfile := INDEX(dMoxieFile,{f:= moxietransform(__filepos, rawsize, headersize)},{dMoxieFile},lBaseKeyName + 'fpos.data.key');

kfpos := buildindex(dfile,moxie,overwrite);

// end fpos key


export Out_Corp_Cont_Moxie_Keys
 :=
  parallel(
			 kBDID
			,kDID
			,kLFMName
			,kCorpName
			,kCorpKey
			,kNameAsIs
			,kCN
			,kCharterNo
			,kStOrigCharterNo
			,kStCorpName
			,kStLFMName
			,kStCN
			,kStNameAsIs
			,kZ5PrimNamePrimRange
			,kZipStreetEverything
			,kStCityCorpName
			,kStCityEverything
			,kStCityCN
			,kStCityNameAsIs
			,kStCityLFMName
			,kfpos
		   );