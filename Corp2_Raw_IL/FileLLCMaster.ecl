import corp2;
//********************************************************************
//FileLLCMaster -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.LLCMasterLayoutIn LLCTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform
	self.ll_record_ind_42001          		:= corp2.t2u(l.payload[1..1]);
	self.ll_file_nbr_42001          			:= corp2.t2u(l.payload[2..9]);
	self.ll_agent_code_42001        			:= corp2.t2u(l.payload[10..10]);
	self.ll_agent_name_42001			 				:= corp2.t2u(l.payload[11..40]);
	self.ll_agent_street_42001      			:= corp2.t2u(l.payload[41..70]);
	self.ll_agent_city_42001        			:= corp2.t2u(l.payload[71..88]);
	self.ll_agent_zip_42001         			:= corp2.t2u(l.payload[89..97]);
	self.ll_agent_cnty_code_42001      		:= corp2.t2u(l.payload[98..100]);
	self.ll_agent_chg_date_42001       		:= corp2.t2u(l.payload[101..108]);
	self.ll_llc_name_42001          			:= corp2.t2u(l.payload[109..228]);  
	self.ll_purpose_code_42001        		:= corp2.t2u(l.payload[229..234]);
	self.ll_status_code_42001         		:= corp2.t2u(l.payload[235..236]);
	self.ll_status_date_42001         		:= corp2.t2u(l.payload[237..244]);
	self.ll_organized_date_42001       		:= corp2.t2u(l.payload[245..252]);
	self.ll_dissolution_date_42001        := corp2.t2u(l.payload[253..260]);
	self.ll_management_type_42001       	:= corp2.t2u(l.payload[261..261]);
	self.ll_fein_42001             				:= corp2.t2u(l.payload[262..270]);
	self.ll_juris_organized_42001         := corp2.t2u(l.payload[271..272]);
	self.ll_records_off_street_42001      := corp2.t2u(l.payload[273..302]);
	self.ll_records_off_city_42001      	:= corp2.t2u(l.payload[303..320]);
	self.ll_records_off_zip_42001       	:= corp2.t2u(l.payload[321..329]);
	self.ll_records_off_juris_42001     	:= corp2.t2u(l.payload[330..331]);
	self.ll_assumed_ind_42001       			:= corp2.t2u(l.payload[332..332]);
	self.ll_old_ind_42001           			:= corp2.t2u(l.payload[333..333]);
	self.ll_provisions_ind_42001    			:= corp2.t2u(l.payload[334..334]);
	self.ll_cr_ar_mail_date_42001       	:= corp2.t2u(l.payload[335..342]);
	self.ll_cr_ar_file_date_42001       	:= corp2.t2u(l.payload[343..350]);
	self.ll_cr_ar_deliq_date_42001      	:= corp2.t2u(l.payload[351..358]);
	self.ll_cr_ar_paid_amt_42001        	:= corp2.t2u(l.payload[359..362]);
	self.ll_cr_ar_year_due_42001        	:= corp2.t2u(l.payload[363..366]);
	self.ll_pv_ar_mail_date_42001       	:= corp2.t2u(l.payload[367..374]);
	self.ll_pv_ar_file_date_42001       	:= corp2.t2u(l.payload[375..382]);
	self.ll_pv_ar_deliq_date_42001      	:= corp2.t2u(l.payload[383..390]);
	self.ll_pv_ar_paid_amt_42001        	:= corp2.t2u(l.payload[391..394]);
	self.ll_pv_ar_year_due_42001        	:= corp2.t2u(l.payload[395..398]);
	self.ll_opt_ind_42001               	:= corp2.t2u(l.payload[399..399]);
end;

export FileLLCMaster(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInLLC) := project(pInLLC(corp2.t2u(payload[1..1])='M'),LLCTransform(LEFT));