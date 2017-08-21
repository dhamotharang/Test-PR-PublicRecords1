import STD, Corp2;

/* SD corpData has some bad addresses,all address parts are in single field\fho_address1 .Below trasform only target those and fix them 
   EX:W20160707-144036
*/
Corp2_Raw_AR.Layouts.CorpDataLayoutIn CorpTransform(Corp2_Raw_AR.Layouts.CorpDataLayoutIn l) := transform

	 self.fho_city					:= stringlib.splitwords(Corp2_Raw_AR.Functions.FixAddress(l.fho_address1),'|',false)[2];
	 self.fho_state					:= stringlib.splitwords(Corp2_Raw_AR.Functions.FixAddress(l.fho_address1),'|',false)[3];
	 self.fho_address1			:= if(trim(self.fho_city)<>'' and trim(self.fho_state) <>'',stringlib.splitwords(Corp2_Raw_AR.Functions.FixAddress(l.fho_address1),'|',false)[1],l.fho_address1);	 
	 self.fho_zip						:= stringlib.splitwords(Corp2_Raw_AR.Functions.FixAddress(l.fho_address1),'|',false)[4];
	 self										:= l;
	 
end;

export File_In_CorpData(dataset(Corp2_Raw_AR.Layouts.CorpDataLayoutIn) pInCorpData) := project(pInCorpdata(corp2.t2u(fho_city)='X'),CorpTransform(LEFT)) + pInCorpdata(corp2.t2u(fho_city)<>'X');

