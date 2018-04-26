IMPORT PRTE,PRTE2_Header,Std;
rl:= relationship.layout_output.titled;

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);

payload := PRTE2_Header.file_relatives;
dKeyHeader__relatives3 := project(payload,transform(rl,

        self.did1:=LEFT.person2;    self.did2:=LEFT.person1;                 self.title:=LEFT.rtitle;   
        self.cohabit_cnt:=1;        self.coapt_cnt:=1;                       self.copobox_cnt:=1;       
        self.cossn_cnt:=1;          self.copolicy_cnt:=1;                    self.coclaim_cnt:=1;       
        self.coproperty_cnt:=1;     self.bcoproperty_cnt:=1;                 self.coforeclosure_cnt:=1; 
        self.bcoforeclosure_cnt:=1; self.colien_cnt:=1;                      self.bcolien_cnt:=1;       
        self.cobankruptcy_cnt:=1;   self.bcobankruptcy_cnt:=1;               self.covehicle_cnt:=1;     
        self.coexperian_cnt:=1;     self.cotransunion_cnt:=1;                self.coenclarity_cnt:=1;   
        self.coecrash_cnt:=1;       self.bcoecrash_cnt:=1;                   self.cowatercraft_cnt:=1;  
        self.coaircraft_cnt:=1;     self.comarriagedivorce_cnt:=1;           self.coucc_cnt:=1;         
        self.total_score:=27;       self.rel_dt_last_seen:=Std.Date.Today(); self.isanylnamematch:=true;

        self := LEFT;
        SELF := [];
));
export file_relative := dedup(sort(dKeyHeader__relatives3,record),except title, all)(did1>0,did2>0,did1<>did2);
#ELSE
export file_relative :=dataset('~thor_data400::base::insuranceheader::qa::relatives_v3',rl,flat);
#END