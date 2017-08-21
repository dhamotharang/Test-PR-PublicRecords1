import versioncontrol;

export Moxie_Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared numgens			:= 1;
	shared lversiondate := pversion;
	export lRoot				:= _Dataset(pUseOtherEnvironment).thor_cluster_Files + 'key::moxie.'	;


	export Business_Headers :=
	module
	
		Shared llRootOld	:= lroot 			+ 'bus_hdr.'					;
		shared llRoot			:= llRootOld	+ '@version@.'	;
		shared fMyRoot(boolean pUseOld)	:= if(pUseOld, llRootOld, llRoot);
		
		shared lkey1root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'phoneno.key'																																															;
		shared lkey2root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'fein.key'																																																;
		shared lkey3root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'bdid.key'																																																;
		shared lkey4root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'z5.prim_name.prim_range.key'																																							;
		shared lkey5root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'zip.street_name.suffix.predir.postdir.prim_range.company.sec_range.key'																	;
		shared lkey6root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'cn.key'																																																	;
		shared lkey7root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'st.cn.key'																																																;
		shared lkey8root	(boolean pUseOld) := fMyRoot(pUseOld) + 'st.city.cn.key'																																													;
		shared lkey9root	(boolean pUseOld) := fMyRoot(pUseOld) + 'z5.cn.key'																																																;
		shared lkey10root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'nameasis.key'																																														;
		shared lkey11root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'st.nameasis.key'																																													;
		shared lkey12root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'st.city.nameasis.key'																																										;
		shared lkey13root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'z5.nameasis.key'																																													;
		shared lkey14root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'pcn.nameasis.key'																																												;
		shared lkey15root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'st.pcn.nameasis.key'																																											;
		shared lkey16root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'st.city.pcn.nameasis.key'																																								;
		shared lkey17root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'z5.pcn.nameasis.key'																																											;
		shared lkey18root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'dph_cname.prim_range.dph_street.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key'	;
		shared lkey19root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'dph_cname.z5.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key'										;
		shared lkey20root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'dph_cname.z3.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key'										;
		shared lkey21root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'st.dph_cname.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key'										;
		shared lkey22root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'exchange.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key'												;
		shared lkey23root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'prim_range.st.dph_city.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key'					;
		shared lkey24root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'prim_range.z5.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key'										;
		shared lkey25root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'lat25.long25.cn.key'																																											;
		shared lkey26root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'fpos.data.key'																																														;
	            	                                           
		export key1		:= versioncontrol.mBuildFilenameVersions(lkey1root	(true),lversiondate	,lkey1root	(false),numgens);
		export key2		:= versioncontrol.mBuildFilenameVersions(lkey2root	(true),lversiondate	,lkey2root	(false),numgens);
		export key3		:= versioncontrol.mBuildFilenameVersions(lkey3root	(true),lversiondate	,lkey3root	(false),numgens);
		export key4		:= versioncontrol.mBuildFilenameVersions(lkey4root	(true),lversiondate	,lkey4root	(false),numgens);
		export key5		:= versioncontrol.mBuildFilenameVersions(lkey5root	(true),lversiondate	,lkey5root	(false),numgens);
		export key6		:= versioncontrol.mBuildFilenameVersions(lkey6root	(true),lversiondate	,lkey6root	(false),numgens);
		export key7		:= versioncontrol.mBuildFilenameVersions(lkey7root	(true),lversiondate	,lkey7root	(false),numgens);
		export key8		:= versioncontrol.mBuildFilenameVersions(lkey8root	(true),lversiondate	,lkey8root	(false),numgens);
		export key9		:= versioncontrol.mBuildFilenameVersions(lkey9root	(true),lversiondate	,lkey9root	(false),numgens);
		export key10	:= versioncontrol.mBuildFilenameVersions(lkey10root	(true),lversiondate	,lkey10root	(false),numgens);
		export key11	:= versioncontrol.mBuildFilenameVersions(lkey11root	(true),lversiondate	,lkey11root	(false),numgens);
		export key12	:= versioncontrol.mBuildFilenameVersions(lkey12root	(true),lversiondate	,lkey12root	(false),numgens);
		export key13	:= versioncontrol.mBuildFilenameVersions(lkey13root	(true),lversiondate	,lkey13root	(false),numgens);
		export key14	:= versioncontrol.mBuildFilenameVersions(lkey14root	(true),lversiondate	,lkey14root	(false),numgens);
		export key15	:= versioncontrol.mBuildFilenameVersions(lkey15root	(true),lversiondate	,lkey15root	(false),numgens);
		export key16	:= versioncontrol.mBuildFilenameVersions(lkey16root	(true),lversiondate	,lkey16root	(false),numgens);
		export key17	:= versioncontrol.mBuildFilenameVersions(lkey17root	(true),lversiondate	,lkey17root	(false),numgens);
		export key18	:= versioncontrol.mBuildFilenameVersions(lkey18root	(true),lversiondate	,lkey18root	(false),numgens);
		export key19	:= versioncontrol.mBuildFilenameVersions(lkey19root	(true),lversiondate	,lkey19root	(false),numgens);
		export key20	:= versioncontrol.mBuildFilenameVersions(lkey20root	(true),lversiondate	,lkey20root	(false),numgens);
		export key21	:= versioncontrol.mBuildFilenameVersions(lkey21root	(true),lversiondate	,lkey21root	(false),numgens);
		export key22	:= versioncontrol.mBuildFilenameVersions(lkey22root	(true),lversiondate	,lkey22root	(false),numgens);
		export key23	:= versioncontrol.mBuildFilenameVersions(lkey23root	(true),lversiondate	,lkey23root	(false),numgens);
		export key24	:= versioncontrol.mBuildFilenameVersions(lkey24root	(true),lversiondate	,lkey24root	(false),numgens);
		export key25	:= versioncontrol.mBuildFilenameVersions(lkey25root	(true),lversiondate	,lkey25root	(false),numgens);
		export key26	:= versioncontrol.mBuildFilenameVersions(lkey26root	(true),lversiondate	,lkey26root	(false),numgens);
	            	                                                                                                   
		export dAll_filenames :=                                                                                      
				key1.dAll_filenames                                                                           
			+ key2.dAll_filenames
			+ key3.dAll_filenames
			+ key4.dAll_filenames
			+ key5.dAll_filenames
			+ key6.dAll_filenames
			+ key7.dAll_filenames
			+ key8.dAll_filenames
			+ key9.dAll_filenames
			+ key10.dAll_filenames
			+ key11.dAll_filenames
			+ key12.dAll_filenames
			+ key13.dAll_filenames
			+ key14.dAll_filenames
			+ key15.dAll_filenames
			+ key16.dAll_filenames
			+ key17.dAll_filenames
			+ key18.dAll_filenames
			+ key19.dAll_filenames
			+ key20.dAll_filenames
			+ key21.dAll_filenames
			+ key22.dAll_filenames
			+ key23.dAll_filenames
			+ key24.dAll_filenames
			+ key25.dAll_filenames
			+ key26.dAll_filenames
			; 
	            	
	end;        	
              	
	export Business_Contacts :=
	module
	
		Shared llRootOld								:= lroot + 'bus_cont.'					;
		shared llRoot										:= llRootOld + '@version@.'				;
		shared fMyRoot(boolean pUseOld)	:= if(pUseOld, llRootOld, llRoot)	;
		
		shared lkey1root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'lfmname.key'																									;
		shared lkey2root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'z5.prim_name.prim_range.key'																	;
		shared lkey3root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'did.key'																											;
		shared lkey4root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'bdid.key'																										;
		shared lkey5root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'ssn.key'																											;
		shared lkey6root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key'	;
		shared lkey7root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'st.lfmname.key'																							;
		shared lkey8root	(boolean pUseOld) := fMyRoot(pUseOld) + 'st.city.lfmname.key'																					;
		shared lkey9root	(boolean pUseOld) := fMyRoot(pUseOld) + 'fpos.data.key'																								;
		shared lkey10root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'lat25.long25.lfmname.key'																		;
	            	                                           
		export key1		:= versioncontrol.mBuildFilenameVersions(lkey1root	(true),lversiondate	,lkey1root	(false),numgens);
		export key2		:= versioncontrol.mBuildFilenameVersions(lkey2root	(true),lversiondate	,lkey2root	(false),numgens);
		export key3		:= versioncontrol.mBuildFilenameVersions(lkey3root	(true),lversiondate	,lkey3root	(false),numgens);
		export key4		:= versioncontrol.mBuildFilenameVersions(lkey4root	(true),lversiondate	,lkey4root	(false),numgens);
		export key5		:= versioncontrol.mBuildFilenameVersions(lkey5root	(true),lversiondate	,lkey5root	(false),numgens);
		export key6		:= versioncontrol.mBuildFilenameVersions(lkey6root	(true),lversiondate	,lkey6root	(false),numgens);
		export key7		:= versioncontrol.mBuildFilenameVersions(lkey7root	(true),lversiondate	,lkey7root	(false),numgens);
		export key8		:= versioncontrol.mBuildFilenameVersions(lkey8root	(true),lversiondate	,lkey8root	(false),numgens);
		export key9		:= versioncontrol.mBuildFilenameVersions(lkey9root	(true),lversiondate	,lkey9root	(false),numgens);
		export key10	:= versioncontrol.mBuildFilenameVersions(lkey10root	(true),lversiondate	,lkey10root	(false),numgens);
	            	                                                                                                   
		export dAll_filenames :=                                                                                      
				key1.dAll_filenames                                                                           
			+ key2.dAll_filenames
			+ key3.dAll_filenames
			+ key4.dAll_filenames
			+ key5.dAll_filenames
			+ key6.dAll_filenames
			+ key7.dAll_filenames
			+ key8.dAll_filenames
			+ key9.dAll_filenames
			+ key10.dAll_filenames
			; 
	            	
	end;        	

	export Business_Relatives :=
	module
	
		Shared llRootOld								:= lroot + 'bus_relatives.'					;
		shared llRoot										:= llRootOld + '@version@.'				;
		shared fMyRoot(boolean pUseOld)	:= if(pUseOld, llRootOld, llRoot)	;
		
		shared lkey1root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'bdid1.name_address.corp_charter_number.fbn_filing.fein.phone.bankruptcy_filing.key'	;
		shared lkey2root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'fpos.data.key'																																				;
	            	             
		export key1		:= versioncontrol.mBuildFilenameVersions(lkey1root	(true),lversiondate	,lkey1root	(false),numgens);
		export key2		:= versioncontrol.mBuildFilenameVersions(lkey2root	(true),lversiondate	,lkey2root	(false),numgens);
	            	                                                                                                   
		export dAll_filenames :=                                                                                      
				key1.dAll_filenames                                                                           
			+ key2.dAll_filenames
			; 
	            	
	end;        	

	export Business_Relatives_Group :=
	module
	
		Shared llRootOld								:= lroot + 'bus_relatives_group.'	;
		shared llRoot										:= llRootOld + '@version@.'				;
		shared fMyRoot(boolean pUseOld)	:= if(pUseOld, llRootOld, llRoot)	;
		
		shared lkey1root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'bdid.key'			;
		shared lkey2root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'group_id.key'	;
		shared lkey3root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'fpos.data.key'	;
	            	             
		export key1		:= versioncontrol.mBuildFilenameVersions(lkey1root	(true),lversiondate	,lkey1root	(false),numgens);
		export key2		:= versioncontrol.mBuildFilenameVersions(lkey2root	(true),lversiondate	,lkey2root	(false),numgens);
		export key3		:= versioncontrol.mBuildFilenameVersions(lkey3root	(true),lversiondate	,lkey3root	(false),numgens);
	            	                                                                                                   
		export dAll_filenames :=                                                                                      
				key1.dAll_filenames                                                                           
			+ key2.dAll_filenames
			+ key3.dAll_filenames
			; 
	            	
	end;        	

	export Business_Best :=
	module
	
		Shared llRootOld								:= lroot + 'bus_hdr_best.'				;
		shared llRoot										:= llRootOld + '@version@.'				;
		shared fMyRoot(boolean pUseOld)	:= if(pUseOld, llRootOld, llRoot)	;
		
		shared lkey1root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'bdid.key'			;
		shared lkey2root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'fpos.data.key'	;
	            	                                            
		export key1		:= versioncontrol.mBuildFilenameVersions(lkey1root	(true),lversiondate	,lkey1root	(false),numgens);
		export key2		:= versioncontrol.mBuildFilenameVersions(lkey2root	(true),lversiondate	,lkey2root	(false),numgens);
	            	                                                                                                   
		export dAll_filenames :=                                                                                      
				key1.dAll_filenames                                                                           
			+ key2.dAll_filenames
			; 
	            	
	end;        	

	export Business_Stat :=
	module
	
		Shared llRootOld								:= lroot + 'bus_hdr_stat.'				;
		shared llRoot										:= llRootOld + '@version@.'				;
		shared fMyRoot(boolean pUseOld)	:= if(pUseOld, llRootOld, llRoot)	;
		
		shared lkey1root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'bdid.key'			;
		shared lkey2root	(boolean pUseOld)	:= fMyRoot(pUseOld) + 'fpos.data.key'	;
	            	                                            
		export key1		:= versioncontrol.mBuildFilenameVersions(lkey1root	(true),lversiondate	,lkey1root	(false),numgens);
		export key2		:= versioncontrol.mBuildFilenameVersions(lkey2root	(true),lversiondate	,lkey2root	(false),numgens);
	            	                                                                                                   
		export dAll_filenames :=                                                                                      
				key1.dAll_filenames                                                                           
			+ key2.dAll_filenames
			; 
	            	
	end;        	

	export dAll_filenames :=
			Business_Headers.dAll_filenames
		+ Business_Contacts.dAll_filenames
//		+ Paw.dAll_filenames
		+ Business_Relatives.dAll_filenames
		+ Business_Relatives_Group.dAll_filenames
		+ Business_Best.dAll_filenames
		+ Business_Stat.dAll_filenames
		;
              	
             
end;