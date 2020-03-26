import ut, header_services, doxie,_Control,header,NID,data_services,PRTE2_Header,PRTE2_Watchdog;

EXPORT Key_Prep_Watchdog_nonglb (boolean exclude_EQ = true ) := FUNCTION
				//compare to glb data and set flags
				watchdog.Layout_best_flags flags(watchdog.layout_best L, watchdog.Layout_Best R) := transform
				 self.glb_name := if(datalib.leadmatch(l.fname,r.fname)=0 or 
														 NID.PreferredFirstVersionedStr(l.fname, NID.version)!=NID.PreferredFirstVersionedStr(r.fname, NID.version),'N','Y');
				 self.glb_address := if(l.prim_range!=r.prim_range or l.prim_name!=r.prim_name or
										~ut.NNEQ(l.sec_range,r.sec_range) or
										 l.zip!=r.zip,'N','Y'); 
				 self.glb_ssn := if(l.ssn!=r.ssn or 
									((integer)(r.ssn[1..5])=0 and l.ssn[6..9]!=r.ssn[6..9]),'N','Y');
				 self.glb_dob := if(datalib.leadmatch((string)l.dob,(string)r.dob)=0,'N','Y');
				 self.glb_phone := if(l.phone!=r.phone,'N','Y');
				 self := r;
				end;

				string_rec := record
					watchdog.Layout_Best;
					string1 		glb_name := 'Y';
					string1 		glb_address := 'Y';
					string1 		glb_dob := 'Y';
					string1 		glb_ssn := 'Y';
					string1 		glb_phone := 'Y';
					unsigned8 filepos := 0;
				end;

				glb := watchdog.File_Best;
				non_glb0 := if(exclude_EQ,watchdog.File_Best_nonglb_nonEquiFax,watchdog.File_Best_nonglb);
				non_glb := non_glb0;

				set_Flags := join(glb,non_glb,left.did=right.did,flags(left,right),local);

				wdog := watchdog.prep_build.prep(set_flags);

				candidates := distribute(wdog(trim(fname)='' or trim(lname)=''),hash(did));
				not_candidates := wdog(~(trim(fname)='' or trim(lname)=''));
				
				non_eq := if(exclude_EQ,'_noneq','');
				glb_pst        := distribute(dataset('~thor400_84::out::watchdog_filtered_header_nonglb'+non_eq,header.layout_header,flat),hash(did));
				
				header.layout_header t1(glb_pst le, candidates ri) := transform
				 self := le;
				end;

				j1 := join(glb_pst,candidates
							,left.did=right.did
							,t1(left,right)
							,local);

				//only fix those that need fixing
				bestFirstLast	:=	watchdog.fn_BestFirstLastName(j1);

				watchdog.Layout_best_flags tr(candidates l,bestFirstLast r) := transform
					self.fname	:=	if(l.fname='',r.fname,l.fname);
					self.lname	:=	if(l.lname='',r.lname,l.lname);
					self        := l;
				end;

				fb0:=join(candidates,bestFirstLast
							,left.did=right.did
							,tr(left,right)
							,left outer
							,local);

				concat := fb0+not_candidates;

				//only fix those that need fixing
				candidates1 := distribute(concat(trim(ssn)=''),hash(did));
				not_candidates1 := concat(~(trim(ssn)=''));

				j2 := join(glb_pst,candidates1
							,left.did=right.did
							,t1(left,right)
							,local);

				_bestSSN	:=	watchdog.fn_best_ssn(j2).concat_them;

				watchdog.Layout_best_flags tr0(candidates1 l,_bestSSN r) := transform
					self.ssn	:=	if(l.ssn='',r.ssn,l.ssn);
					self        :=	l;
				end;

				fb00:=join(candidates1,_bestSSN
							,left.did=right.did
							,tr0(left,right)
							,left outer
							,local);

				_fb := fb00+not_candidates1;
    
                #IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
                fb := project(PRTE2_Watchdog.files.file_best,{string_rec OR {_fb}});
                #ELSE
				ut.mac_suppress_by_phonetype(_fb,phone,st,fb,true,did);
                #END

				return index(fb,{fb},data_services.Data_Location.Watchdog_Best + 'thor_data400::key::watchdog_nonglb'+non_eq+'.did_'+doxie.Version_SuperKey);
END;