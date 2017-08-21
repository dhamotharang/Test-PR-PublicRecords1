import lib_fileservices,_control;

//#workunit('name','Despray DKC FLAccidents');

export DKC_FLAccidents_Keys(string pDestinationIP, string pDestinationVolume) :=

function

DKCKeys(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,pDestinationIP,pDestinationVolume + DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

key1 := DKCKeys('~thor_data400::key::moxie.flcrash0.accident_nbr.key','flcrash0.accident_nbr.key');
key2 := DKCKeys('~thor_data400::key::moxie.flcrash1.accident_nbr.key','flcrash1.accident_nbr.key');
key3 := DKCKeys('~thor_data400::key::moxie.flcrash2v.accident_nbr.section_nbr.key','flcrash2v.accident_nbr.section_nbr.key');
key4 := DKCKeys('~thor_data400::key::moxie.flcrash3v.accident_nbr.section_nbr.key','flcrash3v.accident_nbr.section_nbr.key');
key5 := DKCKeys('~thor_data400::key::moxie.flcrash4.accident_nbr.section_nbr.key','flcrash4.accident_nbr.section_nbr.key');
key6 := DKCKeys('~thor_data400::key::moxie.flcrash5.accident_nbr.section_nbr.passenger_nbr.key','flcrash5.accident_nbr.section_nbr.passenger_nbr.key');
key7 := DKCKeys('~thor_data400::key::moxie.flcrash6.accident_nbr.section_nbr.key','flcrash6.accident_nbr.section_nbr.key');
key8 := DKCKeys('~thor_data400::key::moxie.flcrash7.accident_nbr.key','flcrash7.accident_nbr.key');
key9 := DKCKeys('~thor_data400::key::moxie.flcrash8.accident_nbr.section_no.key','flcrash8.accident_nbr.section_no.key');
key10 := DKCKeys('~thor_data400::key::moxie.flcrashs.accident_nbr.rec_type_x.key','flcrashs.accident_nbr.rec_type_x.key');
key11 := DKCKeys('~thor_data400::key::moxie.flcrashs.cn.rec_type_x.key','flcrashs.cn.rec_type_x.key');
key12 := DKCKeys('~thor_data400::key::moxie.flcrashs.dph_lname.fname.mname.lname.rec_type_x.key','flcrashs.dph_lname.fname.mname.lname.rec_type_x.key');
key13 := DKCKeys('~thor_data400::key::moxie.flcrashs.drivers_license_info.dl_state.key','flcrashs.drivers_license_info.dl_state.key');
key14 := DKCKeys('~thor_data400::key::moxie.flcrashs.lfmname.rec_type_x.key','flcrashs.lfmname.rec_type_x.key');
key15 := DKCKeys('~thor_data400::key::moxie.flcrashs.nameasis.rec_type_x.key','flcrashs.nameasis.rec_type_x.key');
key16 := DKCKeys('~thor_data400::key::moxie.flcrashs.pcn.rec_type_x.key','flcrashs.pcn.rec_type_x.key');
key17 := DKCKeys('~thor_data400::key::moxie.flcrashs.st.city.cn.rec_type_x.key','flcrashs.st.city.cn.rec_type_x.key');
key18 := DKCKeys('~thor_data400::key::moxie.flcrashs.st.city.dph_lname.fname.mname.lname.rec_type_x.key','flcrashs.st.city.dph_lname.fname.mname.lname.rec_type_x.key');
key19 := DKCKeys('~thor_data400::key::moxie.flcrashs.st.city.lfmname.rec_type_x.key','flcrashs.st.city.lfmname.rec_type_x.key');
key20 := DKCKeys('~thor_data400::key::moxie.flcrashs.st.city.nameasis.rec_type_x.key','flcrashs.st.city.nameasis.rec_type_x.key');
key21 := DKCKeys('~thor_data400::key::moxie.flcrashs.st.city.pcn.rec_type_x.key','flcrashs.st.city.pcn.rec_type_x.key');
key22 := DKCKeys('~thor_data400::key::moxie.flcrashs.st.city.prim_name.prim_range.predir.postdir.suffix.key','flcrashs.st.city.prim_name.prim_range.predir.postdir.suffix.key');
key23 := DKCKeys('~thor_data400::key::moxie.flcrashs.st.cn.rec_type_x.key','flcrashs.st.cn.rec_type_x.key');
key24 := DKCKeys('~thor_data400::key::moxie.flcrashs.st.lfmname.rec_type_x.key','flcrashs.st.lfmname.rec_type_x.key');
key25 := DKCKeys('~thor_data400::key::moxie.flcrashs.st.nameasis.rec_type_x.key','flcrashs.st.nameasis.rec_type_x.key');
key26 := DKCKeys('~thor_data400::key::moxie.flcrashs.st.pcn.rec_type_x.key','flcrashs.st.pcn.rec_type_x.key');
key27 := DKCKeys('~thor_data400::key::moxie.flcrashs.tag_nbr.key','flcrashs.tag_nbr.key');
key28 := DKCKeys('~thor_data400::key::moxie.flcrashs.tag_state.tag_nbr.key','flcrashs.tag_state.tag_nbr.key');
key29 := DKCKeys('~thor_data400::key::moxie.flcrashs.vin.key','flcrashs.vin.key');
key30 := DKCKeys('~thor_data400::key::moxie.flcrashs.z5.prim_name.prim_range.key','flcrashs.z5.prim_name.prim_range.key');
key31 := DKCKeys('~thor_data400::key::moxie.flcrashs.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key','flcrashs.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key');
key32 := DKCKeys('~thor_data400::key::moxie.flcrashs.zip.cn.rec_type_x.key','flcrashs.zip.cn.rec_type_x.key');
key33 := DKCKeys('~thor_data400::key::moxie.flcrashs.zip.dph_lname.fname.mname.lname.key','flcrashs.zip.dph_lname.fname.mname.lname.key');
key34 := DKCKeys('~thor_data400::key::moxie.flcrashs.zip.lfmname.rec_type_x.key','flcrashs.zip.lfmname.rec_type_x.key');
key35 := DKCKeys('~thor_data400::key::moxie.flcrashs.zip.nameasis.rec_type_x.key','flcrashs.zip.nameasis.rec_type_x.key');
key36 := DKCKeys('~thor_data400::key::moxie.flcrashs.zip.pcn.rec_type_x.key','flcrashs.zip.pcn.rec_type_x.key');
key37 := DKCKeys('~thor_data400::key::moxie.flcrashs.zip.prim_name.suffix.predir.postdir.prim_range.sec_range.key','flcrashs.zip.prim_name.suffix.predir.postdir.prim_range.sec_range.key');


flcrash0_despray := lib_fileservices.fileservices.Despray('~thor_data400::in::flcrash0',_control.IPAddress.edata12,
 									pDestinationVolume+'flcrash0.d00',,,,TRUE);
flcrash1_despray := lib_fileservices.fileservices.Despray('~thor_data400::in::flcrash1',_control.IPAddress.edata12,
 									pDestinationVolume+'flcrash1.d00',,,,TRUE);
flcrash2v_despray := lib_fileservices.fileservices.Despray('~thor_data400::in::flcrash2v',_control.IPAddress.edata12,
 									pDestinationVolume+'flcrash2v.d00',,,,TRUE);
flcrash3v_despray := lib_fileservices.fileservices.Despray('~thor_data400::in::flcrash3v',_control.IPAddress.edata12,
 									pDestinationVolume+'flcrash3v.d00',,,,TRUE);
flcrash4_despray := lib_fileservices.fileservices.Despray('~thor_data400::in::flcrash4',_control.IPAddress.edata12,
 									pDestinationVolume+'flcrash4.d00',,,,TRUE);
flcrash5_despray := lib_fileservices.fileservices.Despray('~thor_data400::in::flcrash5',_control.IPAddress.edata12,
 									pDestinationVolume+'flcrash5.d00',,,,TRUE);
flcrash6_despray := lib_fileservices.fileservices.Despray('~thor_data400::in::flcrash6',_control.IPAddress.edata12,
 									pDestinationVolume+'flcrash6.d00',,,,TRUE);
flcrash7_despray := lib_fileservices.fileservices.Despray('~thor_data400::in::flcrash7',_control.IPAddress.edata12,
 									pDestinationVolume+'flcrash7.d00',,,,TRUE);
flcrash8_despray := lib_fileservices.fileservices.Despray('~thor_data400::in::flcrash8',_control.IPAddress.edata12,
 									pDestinationVolume+'flcrash8.d00',,,,TRUE);
flcrashs_despray := lib_fileservices.fileservices.Despray('~thor_data400::in::flcrashs',_control.IPAddress.edata12,
 									pDestinationVolume+'flcrashs.d00',,,,TRUE);



return sequential(
					key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,
					key11,key12,key13,key14,key15,key16,key17,key18,key19,
					key20,key21,key22,key23,key24,key25,key26,key27,key28,
					key29,key30,key31,key32,key33,key34,key35,key36,key37
					,flcrash0_despray
					,flcrash1_despray
					,flcrash2v_despray
					,flcrash3v_despray
					,flcrash4_despray
					,flcrash5_despray
					,flcrash6_despray
					,flcrash7_despray
					,flcrash8_despray
					,flcrashs_despray
					);

end;