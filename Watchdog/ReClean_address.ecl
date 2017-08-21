import header,infutor,infutor_narc,AID,ut;

export ReClean_address
	:=
		module
					shared h_did:=dedup(header.file_headers,did,all,local);
					tu0:= distribute(
							  project(Header.File_TN_did,transform({header.Layout_header},self.dob:=0,self:=left))
							+ header.File_TUCS_did
							+ header.File_transunion_did
							,hash(did));
					tu:=join(tu0,h_did,left.did=right.did,local);
					sup := header.filename_header;
					h:=if(ver('header',sup,header.file_headers).same
								,output('Header version previously AID Cleaned')
								,sequential(output('Header version will be AID Cleaned')
														, ver('header',sup,header.file_headers + tu).reclean
														, ver('header',sup,header.file_headers).update	)
								);
					export header_ := h;

					sup := '~thor_data400::base::infutor';
					i0  := infutor.infutor_into_watchdog;
					i1:=join(i0,h_did,left.did=right.did,local);
					i:=if(ver('infutor',sup,i1).same
								,output('Infutor version previously AID Cleaned')
								,sequential(output('Infutor version will be AID Cleaned')
														, ver('infutor',sup,infutor.infutor_into_watchdog).reclean
														, ver('infutor',sup,infutor.infutor_into_watchdog).update	)
								);
					export infutor_ := i;

        	sup := '~thor_data400::base::infutor_narc::qa';
					i0  := infutor_narc.infutor_narc_into_watchdog;
					i1:=join(i0,h_did,left.did=right.did,local);
					i:=if(ver('infutor_narc',sup,i1).same
								,output('Infutor_narc version previously AID Cleaned')
								,sequential(output('Infutor_narc version will be AID Cleaned')
														, ver('infutor_narc',sup,infutor_narc.infutor_narc_into_watchdog).reclean
														, ver('infutor_narc',sup,infutor_narc.infutor_narc_into_watchdog).update	)
								);
					export infutor_narc := i;				
					
		end;