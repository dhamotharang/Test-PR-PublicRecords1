IMPORT ut, doxie, _Control,data_services,PRTE2_Header,PRTE2_Watchdog;
export Key_Prep_Watchdog_marketing(boolean exclude_Equifax) := FUNCTION

		//compare to glb data and set flags
		watchdog.Layout_best_flags flags(watchdog.layout_best L, watchdog.Layout_Best R) := transform
		 self.glb_name := if(datalib.leadmatch(l.fname,r.fname)=0 or 
							datalib.preferredfirst(l.fname)!=datalib.preferredfirst(r.fname),'N','Y');
		 self.glb_address := if(l.prim_range!=r.prim_range or l.prim_name!=r.prim_name or
								~ut.NNEQ(l.sec_range,r.sec_range) or
								 l.zip!=r.zip,'N','Y'); 
		 self.glb_ssn := if(l.ssn!=r.ssn or 
							((integer)(r.ssn[1..5])=0 and l.ssn[6..9]!=r.ssn[6..9]),'N','Y');
		 self.glb_dob := if(datalib.leadmatch((string)l.dob,(string)r.dob)=0,'N','Y');
		 self.glb_phone := if(l.phone!=r.phone,'N','Y');
		 self := r;
		end;

		glb := watchdog.File_Best;
		markt := if (exclude_Equifax,Watchdog.File_Best_marketing_nonEquifax, watchdog.File_Best_marketing);

		_t1 := join(glb,markt,left.did=right.did,flags(left,right),local);
        #IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
        t1 := join(PRTE2_Watchdog.Files.file_best ,
                      PRTE2_Watchdog.Files.file_best,
                      left.did=right.did,flags(left,right),local);
        #ELSE
		ut.mac_suppress_by_phonetype(_t1,phone,st,t1,true,did);
        #END

		noneq := if (exclude_Equifax,'_noneq','');

		RETURN INDEX(t1
								,{t1}
								,data_services.Data_Location.Watchdog_Best
									+ 'thor_data400::key::watchdog_marketing'+noneq+'.did_'+doxie.Version_SuperKey);

END;
