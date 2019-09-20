IMPORT PRTE2_Header,infutor,PromoteSupers,Watchdog;
EXPORT proc_build_base(string filedate) := function

        head:=PRTE2_Header.file_header_base;
        h_as_i := project(head,transform({infutor.infutor_header()},
        
        SELF.valid_dob:='',     SELF.hhid:=0,           SELF.county_name:='',
        SELF.listed_name:='',   SELF.listed_phone:='',  SELF.dod:=0,
        SELF.death_code:='',    SELF.lookup_did:=0,   
				SELF.global_sid := 0,   SELF.record_sid := 0,
				SELF:=LEFT                  ));

        #IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
        i_as_h := infutor.infutor_best(,h_as_i);
        #ELSE
        i_as_h := head;
        #END
        pre_head_roll := sort(distribute(head,hash32( did,title, name_suffix)),did,-title, -name_suffix,local);

        {head} tRollHead(head L, head R) := Transform
        
                SELF.title                 :=max(L.title,R.title);
                SELF.name_suffix           :=max(L.name_suffix,R.name_suffix);
                SELF                       := L;
        end;
        
        head_rolled := rollup(pre_head_roll,tRollHead(LEFT,RIGHT),did,local);
        hbest := join(distribute(i_as_h     ,hash32(did)),
                      distribute(head_rolled,hash32(did)), LEFT.did=RIGHT.did,transform(
        
                    Watchdog.Layout_Best,SELF:=LEFT,
                    SELF:=RIGHT
                    
                    ),local,keep(1));

       
        PromoteSupers.Mac_SF_BuildProcess(hbest,PRTE2_Watchdog.constants.prefix_base,build_base,2,,true,pVersion:=filedate);
        return build_base;
end;