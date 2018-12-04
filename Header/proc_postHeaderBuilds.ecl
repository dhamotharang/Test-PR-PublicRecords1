import header,ut,PersonLinkingADL2V3,header_slimsort,Roxiekeybuild,Text_FragV1,Doxie,data_services,misc,_control,Std,PromoteSupers,InsuranceHeader_xLink;

export proc_postHeaderBuilds := module

		
		shared elist_owners 				:=   'gabriel.marcan@lexisnexisrisk.com'
											    +',jose.bello@lexisnexisrisk.com'
                                                ;

		shared elist_build_in_qa            :=  elist_owners
                                                + ',Aleida.Lima@lexisnexisrisk.com'
                                                + ',manish.shah@lexisnexisrisk.com'
                                                + ',Cody.Fouts@lexisnexisrisk.com'
                                                ;

        SHARED elist_fcra                   :=  elist_owners
                                                + ',Sudhir.Kasavajjala@lexisnexisrisk.com'
                                                + ',Wenhong.Ma@lexisnexisrisk.com'
                                                ;

		SHARED fn:=nothor(fileservices.SuperFileContents(header.Filename_Header,1)[1].name);
		SHARED sub:=stringlib.stringfind(fn,((STRING8)Std.Date.Today())[1..2],1);
    EXPORT getVname (string superfile, string v_end = ':') := FUNCTION

        FileName:=fileservices.GetSuperFileSubName(superfile,1);
        v_strt  := stringlib.stringfind(FileName,'20',1);
        v_endd	:= stringlib.stringfind(FileName[v_strt..],v_end,1);
        v_name  := FileName[v_strt..v_strt+if(v_endd<1,length(FileName),v_endd)-2];

        RETURN v_name;

    END;
    
    KeySuperFile := if(_Control.mod_xADLversion.QA_version, doxie.version_superkey, 'built');
    seg_key_name:=InsuranceHeader_xLink.KeyPrefix+ 'key::insuranceheader_segmentation::did_ind_'+KeySuperFile;
    
    SHARED checkLinkingVersion(string build_version):= if (
    
           getVname(InsuranceHeader_xLink.Key_InsuranceHeader_ADDRESS().KeyName)<>build_version OR
           getVname(InsuranceHeader_xLink.Key_InsuranceHeader_DLN().KeyName)<>build_version OR
           getVname(InsuranceHeader_xLink.Key_InsuranceHeader_DOB().KeyName)<>build_version OR
           getVname(InsuranceHeader_xLink.Key_InsuranceHeader_LFZ().KeyName)<>build_version OR
           getVname(InsuranceHeader_xLink.Key_InsuranceHeader_NAME().KeyName)<>build_version OR
           getVname(InsuranceHeader_xLink.Key_InsuranceHeader_PH().KeyName)<>build_version OR
           getVname(InsuranceHeader_xLink.Key_InsuranceHeader_RELATIVE().KeyName)<>build_version OR
           getVname(InsuranceHeader_xLink.Key_InsuranceHeader_SSN().KeyName)<>build_version OR
           getVname(InsuranceHeader_xLink.Key_InsuranceHeader_SSN4().KeyName)<>build_version OR
           getVname(InsuranceHeader_xLink.Key_InsuranceHeader_ZIP_PR().KeyName)<>build_version OR
           getVname(InsuranceHeader_xLink.Key_InsuranceHeader_PH().KeyName)<>build_version OR
           getVname(seg_key_name)<>build_version
       
        ,fail('Header linking keys does not match version'));

		// ******************************************************************************************** //

		#stored ('buildname', 'PersonHeader'   ); 
		#stored ('version'  , header.version_build); 
		
		thor1:='thor400_44';
		thor2:='thor400_36';

		bld_Transunion_LN    := Header.transunion_did
		: success(sequential(output('TU/LT completed'),header.msg('TU/LT completed',elist_owners).good))
		;
		bld_Transunion_Ptrak := Header.build_tucs_did
		: success(sequential(output('TS/TN completed'),header.msg('TS/TN completed',elist_owners).good))
		;
		build_slimsorts      := header_slimsort.Proc_Make_Name_xxx(thor1, thor2)
		: success(sequential(output('XADL1keys completed'),header.msg('XADL1keys completed',elist_owners).good))
		;
		// step:='Yogurt:'+Header.version_build+' XADL keys and externals base files';
		step:=Header.version_build+' XADL keys and externals base files';
		#WORKUNIT('name', step);
		cmpltd:=step+' completed';
		failed:=step+' failed';
		export XADLkeys := sequential(
                                         header.LogBuild.single('Started :'+step)
                                        ,if(Header.version_build<>fn[sub..sub+7],fail('Header base does not match version'))
                                        ,nothor(Header.Proc_Copy_From_Alpha.Copy)
                                        ,checkLinkingVersion(header.version_build)
                                        ,bld_Transunion_LN
                                        ,bld_Transunion_Ptrak
                                        ,build_slimsorts
                                        ,nothor(Header.Proc_Copy_From_Alpha.CopyOthers)
                                        ,Header.Proc_Copy_RemoteLinkingKeys_From_Alpha(header.version_build)
                                        ,header.LogBuild.single('Completed :'+step)
                                        )
                                        :success(header.msg(cmpltd,elist_owners).good)
                                        ,failure(header.msg(failed,elist_owners).bad)
                                        ;

		// ******************************************************************************************** //
		
		#stored ('buildname', 'PersonHeader'   ); 
		#stored ('version'  , header.version_build); 
		
		// step:='Yogurt:'+Header.version_build+' Relative and HHID base files';
		step:=Header.version_build+' Relative and HHID base files';
		#WORKUNIT('name', step);
		cmpltd:=step+' completed';
		failed:=step+' failed';

		sel:=[
		118120464
		,1067439253
		,2550118476, 2484243127 												//Bug: 140323
		,1733604568, 1807428055, 1733604568, 1731726281 //Bug: 197240
		];
				
		holder1 := header.relatives.relatives1(~(person1 in sel and person2 in sel))
							: success(header.msg('Relative completed',elist_owners).good)
		;
		rel_title := header.file_relative_title.build_file 
						  : success(header.msg('Relative Title completed',elist_owners).good);
		PromoteSupers.MAC_SF_BuildProcess(holder1,'~thor_data400::BASE::Relatives',bld_relatives,2,,true,pVersion:=Header.version_build);
        PromoteSupers.MAC_SF_BuildProcess(rel_title,'~thor_data400::base::relative_title',bld_relative_title,2,,true,pVersion:=Header.version_build);
		PromoteSupers.MAC_SF_BuildProcess(header.HHID_Table_Final,'~thor_data400::BASE::HHID',make_hhid,2,,true,pVersion:=Header.version_build);
		PromoteSupers.MAC_SF_BuildProcess(header.FCRA_HHID_Table_Final,'~thor_data400::BASE::FCRA_HHID',make_fcra_hhid,2,,true,pVersion:=Header.version_build);
		export relatives := sequential(
                                            header.LogBuild.single('Started :'+step)
                                            ,if(Header.version_build<>fn[sub..],fail('Header base does not match version'))
                                            ,checkLinkingVersion(header.version_build)
                                            ,parallel(make_hhid	,make_fcra_hhid)
                                            ,header.LogBuild.single('Completed :'+step)
                                            )
                                            :success(header.msg(cmpltd,elist_owners).good)
                                            ,failure(header.msg(failed,elist_owners).bad)
                                            ;

		// ******************************************************************************************** //
		
		#stored ('buildname', 'PersonHeader'   ); 
		#stored ('version'  , header.version_build); 
		#stored ('build_operator', _control.MyInfo.EmailAddressNotify );

		// step:='Yogurt:'+Header.version_build+' Header, slimsorts, and relative Keys';
		step:=Header.version_build+' Header, slimsorts, and relative Keys';
		#WORKUNIT('name', step);
		
		cmpltd
			:=
			step
			+ ' are ready to move to CERT.\n\n'
			+ '************* PENDING SCORING REPLY TO THIS EMAIL ************\n'
			+ '************* PENDING SCORING REPLY TO THIS EMAIL ************\n'
			+ '************* PENDING SCORING REPLY TO THIS EMAIL ************\n'
			+ 'completed'
			;
		failed:=step+' failed';
		isQuarterly := Header.version_build[5..6] in ['03','06','09','12'];
		export headerKeys := sequential(
                                            header.LogBuild.single('Started :'+step)
                                            ,if(Header.version_build<>fn[sub..sub+7],fail('Header base does not match version'))
                                            ,checkLinkingVersion(header.version_build)
                                            ,Doxie.Proc_Doxie_Keys_All()
                                            ,Header.Proc_Copy_To_Alpha(header.version_build)
                                            ,if(isQuarterly, misc.header_hash_split, output('Hash files are not created in this build'))
                                            ,header.LogBuild.single('Completed :'+step)
                                            )
                                            :success(header.msg(cmpltd,elist_build_in_qa).good)
                                            ,failure(header.msg(failed,elist_owners).bad)
                                            ;

		// ******************************************************************************************** //
		
		#stored ('buildname', 'PersonHeader'   ); 
		#stored ('version'  , header.version_build); 
		
		step:=Header.version_build+' Move header_raw and source keys to prod';
		#WORKUNIT('name', step);
		cmpltd:=step+' completed';
		failed:=step+' failed';
		wl:=nothor(WorkunitServices.WorkunitList('',jobname:='y*quick*'))(state in ['blocked','running','wait']);
		export finalize := sequential(
                                            header.LogBuild.single('Started :'+step)
                                            ,if(Header.version_build<>fn[sub..sub+7],fail('Header base does not match version'))
                                            ,if(exists(wl),fail('QUICK HEADER is running'))
                                            ,checkLinkingVersion(header.version_build)
                                            ,nothor(Header.move_header_raw_to_prod())
                                            ,Header.Proc_Copy_From_Alpha.MoveToQA
                                            ,header.Proc_Accept_SRC_toQA()
                                            ,notify('build_property_full','*')
                                            ,header.LogBuild.single('Completed :'+step)
                                            )
                                            :success(header.msg(cmpltd,elist_owners).good)
                                            ,failure(header.msg(failed,elist_owners).bad)
                                            ;


		// ******************************************************************************************** //
		
		#stored ('buildname', 'PersonHeader'   ); 
		#stored ('version'  , header.version_build); 
		
		// step:='Yogurt:'+Header.version_build+' FCRA Header and keys';
		step:=Header.version_build+' FCRA Header and keys';
		#WORKUNIT('name', step);
		cmpltd:=step+' completed';
		failed:=step+' failed';
		export FCRAheader := sequential(
                                        header.LogBuild.single('Started :'+step)
                                        ,if(Header.version_build<>fn[sub..sub+7],fail('Header base does not match version'))
                                        ,checkLinkingVersion(header.version_build)
                                        ,Doxie.Proc_FCRA_Doxie_keys_All(,,header.version_build)
                                        ,header.LogBuild.single('Completed :'+step)
                                        )
                                        :success(header.msg(cmpltd,elist_fcra).good)
                                        ,failure(header.msg(failed,elist_owners).bad)
                                        ;


		// ******************************************************************************************** //
		
		#stored ('buildname', 'PersonHeader'   ); 
		#stored ('version'  , header.version_build); 
		
		// step:='Yogurt:'+Header.version_build+' PowerSearch Keys';
		step:=Header.version_build+' PowerSearch Keys';
		#WORKUNIT('name', step);
		cmpltd:=step+' completed';
		failed:=step+' failed';
		export booleanSrch := sequential(
                                            header.LogBuild.single('Started :'+step)
                                            ,if(Header.version_build<>fn[sub..sub+7],fail('Header base does not match version'))
                                            ,checkLinkingVersion(header.version_build)
                                            ,Text_FragV1.Build_PowerSearch_Keys(Header.version_build)
                                            ,header.LogBuild.single('Completed :'+step)
                                            )
                                            :success(header.msg(cmpltd,elist_owners).good)
                                            ,failure(header.msg(failed,elist_owners).bad)
                                            ;

end;