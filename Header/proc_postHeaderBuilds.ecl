﻿import header,ut,PersonLinkingADL2V3,header_slimsort,Roxiekeybuild,Text_FragV1,Doxie,data_services,misc,_control,Std,PromoteSupers;

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

		SHARED fn:=nothor(fileservices.SuperFileContents(Filename_Header,1)[1].name);
		SHARED sub:=stringlib.stringfind(fn,((STRING8)Std.Date.Today())[1..2],1);

		// ******************************************************************************************** //

		#stored ('buildname', 'PersonHeader'   ); 
		#stored ('version'  , header.version_build); 
		#stored ('emailList', 'gabriel.marcan@lexisnexisrisk.com'    ); 

		thor1:='thor400_44';
		thor2:='thor400_66';

		bld_Transunion_LN    := Header.transunion_did
		: success(sequential(output('TU/LT completed'),header.msg('TU/LT completed',elist_owners).good))
		;
		bld_Transunion_Ptrak := Header.build_tucs_did
		: success(sequential(output('TS/TN completed'),header.msg('TS/TN completed',elist_owners).good))
		;
		build_slimsorts      := header_slimsort.Proc_Make_Name_xxx(thor1, thor2)
		: success(sequential(output('XADL1keys completed'),header.msg('XADL1keys completed',elist_owners).good))
		;
		step:='Yogurt:'+Header.version_build+' XADL keys and externals base files';
		#WORKUNIT('name', step);
		cmpltd:=step+' completed';
		failed:=step+' failed';
		export XADLkeys := sequential(
                                         header.LogBuild('Started :'+step)
                                        ,if(Header.version_build<>fn[sub..sub+7],fail('Header base does not match version'))
                                        // ,nothor(Header.Proc_Copy_From_Alpha.Copy)
                                        ,bld_Transunion_LN
                                        ,bld_Transunion_Ptrak
                                        ,notify('Build_Relatives','*')
                                        ,build_slimsorts
                                        ,nothor(Header.Proc_Copy_From_Alpha.CopyOthers)
                                        ,header.LogBuild('Completed :'+step)
                                        )
                                        :success(header.msg(cmpltd,elist_owners).good)
                                        ,failure(header.msg(failed,elist_owners).bad)
                                        ;

		// ******************************************************************************************** //
		
		#stored ('buildname', 'PersonHeader'   ); 
		#stored ('version'  , header.version_build); 
		#stored ('emailList', 'gabriel.marcan@lexisnexisrisk.com'    ); 

		step:='Yogurt:'+Header.version_build+' Relative and HHID base files';
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
                                            header.LogBuild('Started :'+step)
                                            ,if(Header.version_build<>fn[sub..],fail('Header base does not match version'))
                                            ,bld_relatives
                                            ,parallel(make_hhid	,make_fcra_hhid)
                                            ,notify('Build_Header_Keys','*')
                                            ,bld_relative_title
                                            ,header.LogBuild('Completed :'+step)
                                            )
                                            :success(header.msg(cmpltd,elist_owners).good)
                                            ,failure(header.msg(failed,elist_owners).bad)
                                            ;

		// ******************************************************************************************** //
		
		#stored ('buildname', 'PersonHeader'   ); 
		#stored ('version'  , header.version_build); 
		#stored ('emailList', 'gabriel.marcan@lexisnexisrisk.com'    );
		#stored ('build_operator', _control.MyInfo.EmailAddressNotify );

		step:='Yogurt:'+Header.version_build+' Header, slimsorts, and relative Keys';
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
                                            header.LogBuild('Started :'+step)
                                            ,if(Header.version_build<>fn[sub..sub+7],fail('Header base does not match version'))
                                            ,Doxie.Proc_Doxie_Keys_All()
                                            // ,output(verify_keys('PersonHeaderKeys'),named('PersonHeaderKeys'))
                                            // ,output(verify_keys('RelativeKeys'),named('RelativeKeys'))
                                            // ,output(verify_keys('PersonSlimsortKeys'),named('PersonSlimsortKeys'))
                                            ,notify('Finalize_Header_build','*')
                                            ,Header.Proc_Copy_To_Alpha(header.version_build)
                                            ,if(isQuarterly, misc.header_hash_split, output('Hash files are not created in this build'))
                                            ,header.LogBuild('Completed :'+step)
                                            )
                                            :success(header.msg(cmpltd,elist_build_in_qa).good)
                                            ,failure(header.msg(failed,elist_owners).bad)
                                            ;

		// ******************************************************************************************** //
		
		#stored ('buildname', 'PersonHeader'   ); 
		#stored ('version'  , header.version_build); 
		#stored ('emailList', 'gabriel.marcan@lexisnexisrisk.com'    ); 

		step:=Header.version_build+' Move header_raw and source keys to prod';
		#WORKUNIT('name', step);
		cmpltd:=step+' completed';
		failed:=step+' failed';
		wl:=nothor(WorkunitServices.WorkunitList('',jobname:='y*quick*'))(state in ['blocked','running','wait']);
		export finalize := sequential(
                                            header.LogBuild('Started :'+step)
                                            ,if(Header.version_build<>fn[sub..sub+7],fail('Header base does not match version'))
                                            ,if(exists(wl),fail('QUICK HEADER is running'))
                                            ,nothor(Header.move_header_raw_to_prod())
                                            ,Header.Proc_Copy_From_Alpha.MoveToQA
                                            // ,output(Verify_XADL1_base_files,named('XADLfiles'),all)
                                            ,header.Proc_Accept_SRC_toQA()
                                            // ,output(verify_keys('SourceKeys'),named('SourceKeys'))
                                            ,notify('Build_FCRA_Header','*')
                                            ,notify('build_property_full','*')
                                            ,header.LogBuild('Completed :'+step)
                                            )
                                            :success(header.msg(cmpltd,elist_owners).good)
                                            ,failure(header.msg(failed,elist_owners).bad)
                                            ;


		// ******************************************************************************************** //
		
		#stored ('buildname', 'PersonHeader'   ); 
		#stored ('version'  , header.version_build); 
		#stored ('emailList', 'gabriel.marcan@lexisnexisrisk.com'    ); 

		step:='Yogurt:'+Header.version_build+' FCRA Header and keys';
		#WORKUNIT('name', step);
		cmpltd:=step+' completed';
		failed:=step+' failed';
		export FCRAheader := sequential(
                                        header.LogBuild('Started :'+step)
                                        ,if(Header.version_build<>fn[sub..sub+7],fail('Header base does not match version'))
                                        ,Doxie.Proc_FCRA_Doxie_keys_All()
                                        // ,output(verify_keys('FCRA_PersonHeaderKeys',true),named('FCRA_PersonHeaderKeys'))
                                        ,notify('Build_Header_boolean','*')
                                        ,header.LogBuild('Completed :'+step)
                                        )
                                        :success(header.msg(cmpltd,elist_fcra).good)
                                        ,failure(header.msg(failed,elist_owners).bad)
                                        ;


		// ******************************************************************************************** //
		
		#stored ('buildname', 'PersonHeader'   ); 
		#stored ('version'  , header.version_build); 
		#stored ('emailList', 'gabriel.marcan@lexisnexisrisk.com'    ); 


		step:='Yogurt:'+Header.version_build+' PowerSearch Keys';
		#WORKUNIT('name', step);
		cmpltd:=step+' completed';
		failed:=step+' failed';
		export booleanSrch := sequential(
                                            header.LogBuild('Started :'+step)
                                            ,if(Header.version_build<>fn[sub..sub+7],fail('Header base does not match version'))
                                            ,Text_FragV1.Build_PowerSearch_Keys(Header.version_build)
                                            // ,output(verify_keys('PowerSearchKeys',,true),named('PowerSearchKeys'))
                                            ,header.LogBuild('Completed :'+step)
                                            )
                                            :success(header.msg(cmpltd,elist_owners).good)
                                            ,failure(header.msg(failed,elist_owners).bad)
                                            ;

end;