import data_services, Suppress, Doxie, RoxieKeyBuild,_Control, AVM_V2, header, data_Services;
EXPORT reDID(string filedate, boolean runondev = false ) := module

	export ReDID_Wrapper(filetype
											,environment
											,baselayout
											,didfield
											,sortfield
											,usedatalandfiles = 'false'
											,getretval
											,replacerecords = 'true') := macro
		
		#uniquename(origbasefilename)
		%origbasefilename% := '~thor_data400::base::new_suppression_file';
		
		#uniquename(basefilename)
		%basefilename% := if (_Control.ThisEnvironment.Name = 'Prod_Thor'
														,%origbasefilename%
														,if (usedatalandfiles
																,%origbasefilename%
																,regexreplace('~',%origbasefilename%,data_services.foreign_prod))
																);
													
														
		// add filename
		#uniquename(recordwithvirtual)
		%recordwithvirtual% := record
			baselayout;
			string255  OriginalFileName{virtual(LogicalFileName)};
		end;

	
		#uniquename(l_dataset)
		%l_dataset% := dataset(%basefilename%,%recordwithvirtual%,THOR,opt);
										
		
		
		
		#uniquename(recordwithphysical)
		%recordwithphysical% := record
			baselayout;
			unsigned6 olddid := 0;
			unsigned6 newdid := 0;
			boolean ischanged := false;
			string255  OriginalFileName;
		end;
	
		#uniquename(withfilename)
		%recordwithphysical% %withfilename%(%l_dataset% L) := transform
			self.olddid := (unsigned6)l.didfield;
			self := L;
		end;

		#uniquename(dwithfilename_full)
		%dwithfilename_full% := project(%l_dataset%, %withfilename%(left));
		
		#uniquename(dwithfilename)
		#uniquename(dwithfilename_nondid)
		%dwithfilename% := %dwithfilename_full%(linking_type = 'DID');
		
		%dwithfilename_nondid% := %dwithfilename_full%(linking_type <> 'DID');
		
		#uniquename(redidretval)
		header.Mac_ReDID(%dwithfilename%,didfield,%redidretval%);
		
		#uniquename(persistfile) // to capture what changed
		%persistfile% := %redidretval% : persist('~persist::suppress::'+filetype+'_'+environment+'::redid', expire(100));
		
		#uniquename(replacexform) // replace records
		%recordwithphysical% %replacexform%(%dwithfilename% l, %persistfile% r) := transform
			//self.didfield := if ((string)r.didfield <> '',  r.didfield, l.didfield);
			self := l;
		end;

		#uniquename(dreplaced)
		%dreplaced% := join(
													%dwithfilename%
													,%persistfile%
													,left.olddid = right.olddid and left.sortfield = right.sortfield
													,%replacexform%(left,right)
													,left only
													,lookup
													);
		
		#uniquename(fulldataset) // replace records with did change for all non-flag files
		%fulldataset% := dedup(sort(distribute(if (~replacerecords
														,%dwithfilename% 
														,%dreplaced%) + %persistfile% + %dwithfilename_nondid%), didfield,local), record,local) : independent;
		
		#uniquename(mvretval)
		RoxieKeybuild.Mac_SK_Move_V3(
								%origbasefilename% //keyname
								,'D'
								,%mvretval%
								,filedate
								,2
								,true);
		
		// revert back to original layout
		
		#uniquename(converttooriginal)
		baselayout %converttooriginal%(%fulldataset% l) := transform
			self := l;
		end;
		
		#uniquename(tooriginal) 
		%tooriginal% := dedup(sort(project(%fulldataset%,%converttooriginal%(left)),sortfield, local),record, local);
		
		#uniquename(mvretvalwithfilename)
		RoxieKeybuild.Mac_SK_Move_V3(
								%origbasefilename% + '_withfilename' //keyname
								,'D'
								,%mvretvalwithfilename%
								,filedate
								,2);
		
		getretval := if ( ~fileservices.fileexists
																			(%origbasefilename%+'_'+filedate),
															sequential
																(
																	output(count(%dwithfilename_full%),named(filetype+'_old_count'))
																	,sequential(
																				output(%tooriginal%,,%origbasefilename%+'_'+filedate,overwrite)
																				,output(%fulldataset%,,%origbasefilename%+'_withfilename'+'_'+filedate,overwrite)
																			)
																	,%mvretval%
																	,%mvretvalwithfilename%
																	,output(count(%fulldataset%),named(filetype+'_new_count'))
																	),
															output(%origbasefilename%+'_'+filedate + ' exists, no action taken')
															);
		
		
	endmacro;
	
	export roxieip := if (_Control.ThisEnvironment.Name = 'Prod_Thor',
														_Control.RoxieEnv.prodvip,		
														_Control.RoxieEnv.staging_neutral_roxieIP);
	
	export isNewHeader := if (_Control.ThisEnvironment.Name = 'Prod_Thor' or runondev,
															Header.IsNewProdHeaderVersion('suppress',,roxieip),
															false);
	
	export postprocess := function
			return sequential(
												header.PostDID_HeaderVer_Update('suppress',,roxieip),
												fileservices.RemoveOwnedSubfiles('~thor_data400::key::rid_did2_qa_forsuppress', true)
													);
	end;

	export getnew() := function
	
		ReDID_Wrapper('suppress','fcra',Suppress.Layout_New_Suppression,Linking_ID,Linking_type,,suppressredid,false);
		
		return	if (isNewHeader,
							sequential
								(
								if (~fileservices.superfileexists('~thor_data400::key::rid_did2_qa_forsuppress'),
										fileservices.createsuperfile('~thor_data400::key::rid_did2_qa_forsuppress'))
								,if (fileservices.superfileexists('~thor_data400::key::rid_did2_qa'),
									if (fileservices.getsuperfilesubname('~thor_data400::key::rid_did2_qa_forsuppress',1) = fileservices.getsuperfilesubname('~thor_data400::key::rid_did2_qa',1)
										,output('~thor_data400::key::rid_did2_qa_forsuppress is current')
										,fileservices.addsuperfile('~thor_data400::key::rid_did2_qa_forsuppress','~thor_data400::key::rid_did2_qa',,true)
											)
										)
										,suppressredid
										,postprocess
									),
								output('No re-did')
						);
 
	end;
 
end;