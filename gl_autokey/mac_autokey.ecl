export mac_autokey(
	outname,
	indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						inDID,
					//personal above.  business below
						inbname,
						infein,
						bphone,
						inbprim_name,inbprim_range,inbst,inbcity_name,inbzip,inbsec_range,
							//when one address, use same field names here as above
						inbdid,
						inkeyname,inlogical,diffing='false',
						build_skip_set='[]',
							//P in this set to skip personal phones
							//Q in this set to skip business phones
							//S in this set to skip SSN
							//F in this set to skip FEIN
							//C in this set to skip ALL personal (Contact) data
							//B in this set to skip ALL Business data

						useFakeIDs = false,
						typeStr = '\'AK\'', //use default
						useOnlyRecordIDs = false,
						FakeIDFieldType = 'unsigned6',
						tmsid = 'tmsid',
						rmsid = 'rmsid',
						FakeIDField = 'unsigned6 FakeID'
	) :=
		macro
			export outname :=
				module
					import autokeyb2;
					export build(string filedate) :=
						function
							autokeyb2.MAC_Build(indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						inDID,
						inbname,
						infein,
						bphone,
						inbprim_name,inbprim_range,inbst,inbcity_name,inbzip,inbsec_range,
						inbdid,
						inkeyname,inlogical,outaction,diffing,
						build_skip_set,
						useFakeIDs,
						typeStr,
						useOnlyRecordIDs,
						FakeIDFieldType);
							return outaction;
						end;
					export retrieve(gl_autokey.autokey_interfaces.retrieve_ids in_parms) := module
						shared ids := gl_autokey.get_IDs(inkeyname,typestr,build_skip_set,true,in_parms);
						AutokeyB2.mac_get_payload_ids(
							ids,
							inkeyname,
							indataset,
							outpl,
							inDID,
							inBDID,
							typestr,
							FakeIDField,
							newdids,
							newbdids,
							olddids,
							oldbdids,
							tmsid,
							rmsid)
						export tmsids := project(outpl, transform({outpl,boolean isdeepdive},self.isdeepdive := false,self := left));
						AutokeyB2.mac_get_payload_ids(
							ids,
							inkeyname,
							indataset,
							outpl,
							inDID,
							inBDID,
							typestr,
							FakeIDField,
							newdids,
							newbdids,
							olddids,
							oldbdids,
							tmsid,
							rmsid)
						shared bdids_mixed :=
							project(newbdids, transform({newbdids,boolean isdeepdive}, self.isDeepDive := true, self := left)) +
							project(oldbdids, transform({oldbdids,boolean isdeepdive}, self.isDeepDive := false, self := left));
						// Export the BDIDs
						export bdids := bdids_mixed(if(not in_parms.nodeepdive,true,isdeepdive = false));
						AutokeyB2.mac_get_payload_ids(
							ids,
							inkeyname,
							indataset,
							outpl,
							inDID,
							inBDID,
							typestr,
							FakeIDField,
							newdids,
							newbdids,
							olddids,
							oldbdids,
							tmsid,
							rmsid)
						shared dids_mixed :=
							project(newdids, transform({newdids,boolean isdeepdive}, self.isDeepDive := true, self := left)) +
							project(olddids, transform({olddids,boolean isdeepdive}, self.isDeepDive := false, self := left));
						// Export the DIDs
						export dids := dids_mixed(if(not in_parms.nodeepdive,true,isdeepdive = false));
					end;
				end;
		endmacro;
		