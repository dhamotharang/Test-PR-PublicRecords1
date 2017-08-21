IMPORT wk_ut,doxie,doxie_build,STD,mdr,doxie,header_quick,data_services,PromoteSupers;
EXPORT fn_block_records := MODULE

	export block_list_filename := data_services.Data_location.prefix('person_header')+'thor400_data::reference::header::block_records';
	export layout_block_rid := record
	
		string20		add_wuid := (string)workunit;
		string40		add_user := wk_ut.get_WUInfo((string)workunit).WUInfo()[1].owner;
    string50    ticket   := '';
		
		header.Layout_Header_v2;
	
	end;
	export current_block_list := dataset(block_list_filename,layout_block_rid,thor);
	export add_dataset (string50 _ticket, dataset({unsigned8 did, unsigned8 rid}) recs_to_add) := function
 
 
      blank_head := dataset([], header.Layout_Header_v2);
      k1_name        := '~thor_data400::key::pre_file_header_building::qa';
      k1_name_father := '~thor_data400::key::pre_file_header_building::father';
      pre_file_header_building := doxie_build.fn_file_header_building(blank_head)(Header.Blocked_data_new());
      key_pre_file_header_building := index(pre_file_header_building,{pre_file_header_building.did},{pre_file_header_building},
                                       k1_name);
      key_pre_file_header_building_father := index(pre_file_header_building,{pre_file_header_building.did},{pre_file_header_building},
                                       k1_name_father);
      
      filter_from1 := key_pre_file_header_building;
      filter_from2 := key_pre_file_header_building_father;
                         
      layout_block_rid create_block_reference(recs_to_add L, filter_from1 R) := transform

								SELF.add_wuid := (string)workunit;
								SELF.add_user := global(wk_ut.get_WUInfo((string)workunit).WUInfo()[1].owner);
								SELF.ticket := _ticket;
								SELF := R;
		
      end;
      
      new_blocked_records1 := join(recs_to_add,filter_from1, keyed(LEFT.did=RIGHT.did) AND LEFT.rid=RIGHT.rid,
                   create_block_reference(LEFT,RIGHT),few);
      new_blocked_records2 := join(recs_to_add,filter_from2, keyed(LEFT.did=RIGHT.did) AND LEFT.rid=RIGHT.rid,
                   create_block_reference(LEFT,RIGHT),few);
                   
   	  previous_block_file:= dataset(block_list_filename,layout_block_rid,thor);
      new_block_file     := dedup(sort(previous_block_file + new_blocked_records1+new_blocked_records2,src,rid,add_wuid),src,rid);
      
      PromoteSupers.Mac_SF_BuildProcess(new_block_file,block_list_filename,bld_block_file,2,,true,pVersion:=WORKUNIT);
      added_record_count := count(new_block_file)-count(previous_block_file);
      return sequential(
                        output(choosen(new_block_file,1000,1))
                        ,bld_block_file
                        ,STD.System.Log.addWorkunitInformation('Records have been added to the suppression list')
            );
 end;
	export add(string50   _ticket, unsigned8 _did, set of unsigned8 _rids, boolean pFastHeader = false ) := function

      found_rids_count := if (~pFastHeader, 
                            count(doxie.Key_Header    (s_did=_did AND rid in _rids)),
                            count(header_quick.key_DID(  did=_did AND rid in _rids))
                          );
                          
      check_records := if(found_rids_count <> count(_rids),fail('NOT ALL RIDS FOUND: check file version or QuickHeader flag'));
			   check_ticket  := if(trim(_ticket) = ''              ,fail('Ticket cannot be blank'));
						
      blank_head := dataset([], header.Layout_Header_v2);
      k1_name := '~thor_data400::key::pre_file_header_building::qa';
      pre_file_header_building := doxie_build.fn_file_header_building(blank_head)(Header.Blocked_data_new());
      key_pre_file_header_building := index(pre_file_header_building,{pre_file_header_building.did},{pre_file_header_building},
                                       k1_name);



			filter_from := if (~pFastHeader,
                          key_pre_file_header_building,
                          dataset(data_services.Data_location.prefix('default')+'thor_data400::base::quick_header', header.Layout_Header, thor)
                          
                         );
			
			layout_block_rid create_block_reference(filter_from L) := transform

								SELF.add_wuid := (string)workunit;
								SELF.add_user := global(wk_ut.get_WUInfo((string)workunit).WUInfo()[1].owner);
								SELF.ticket := _ticket;
								SELF := L;
		
			end;

			new_blocked_records:= project(filter_from(did= _did,rid in _rids),create_block_reference(LEFT));
			previous_log       := dataset(block_list_filename,layout_block_rid,thor);
      new_block_file     := dedup(sort(previous_log + new_blocked_records,src,rid,add_wuid),src,rid);
      
      PromoteSupers.Mac_SF_BuildProcess(new_block_file,block_list_filename,bld_block_file,2,,true,pVersion:=WORKUNIT);

			return sequential(
                         check_records
												,check_ticket
                        ,output(filter_from,named('builidng_'),extend)
                        ,output(choosen(new_block_file,1000,1))
                        ,bld_block_file
												,STD.System.Log.addWorkunitInformation('Records have been added to the suppression list')
			);

	
	end;
	export filter(_header) := functionmacro
	
					filtered := join( distribute(_header															

,hash32(did,phone,ssn,dob,title,fname,mname,lname,name_suffix,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip))

											,distribute(Header.fn_block_records.current_block_list
,hash32(did,phone,ssn,dob,title,fname,mname,lname,name_suffix,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip))
											,
											        LEFT.did				= RIGHT.did 
											  //AND LEFT.rid 				= RIGHT.rid 			// This changes for transunion - hence we are not using it for the match
											  //AND LEFT.src 				= RIGHT.src 			// removed in case the same combination appears in another source
											  //AND LEFT.vendor_id	= RIGHT.vendor_id // This is irrelevant for the complaint
										
											  //AND LEFT.phone 			= RIGHT.phone
												AND LEFT.ssn 				= RIGHT.ssn 
												AND LEFT.dob 				= RIGHT.dob
												
											    AND LEFT.title 			= RIGHT.title
											    AND LEFT.fname 			= RIGHT.fname
												AND LEFT.mname 			= RIGHT.mname
												AND LEFT.lname 			= RIGHT.lname
												AND LEFT.name_suffix= RIGHT.name_suffix
												
												
												AND LEFT.prim_range = RIGHT.prim_range
												AND LEFT.predir 		= RIGHT.predir
												AND LEFT.prim_name 	= RIGHT.prim_name
												AND LEFT.suffix 		= RIGHT.suffix
												AND LEFT.postdir 		= RIGHT.postdir
											  //AND LEFT.unit_desig = RIGHT.unit_desig
											  //AND LEFT.sec_range 	= RIGHT.sec_range
											  //AND LEFT.city_name	= RIGHT.city_name
											    AND LEFT.st 				= RIGHT.st
												AND LEFT.zip 				= RIGHT.zip
												
											 ,TRANSFORM(LEFT)
											 ,LEFT ONLY,local,FEW,LOOKUP);
					
					return when(
					filtered
					,assert(count(Header.fn_block_records.current_block_list)-count(filtered)<=count(_header),'Not all RIDs were filtered!'))
					;
	
	endmacro;

END;