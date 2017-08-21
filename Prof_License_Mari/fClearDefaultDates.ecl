import ut;

export fClearDefaultDates(dataset(recordof(Prof_License_Mari.layouts.base)) int0)
	:=
function

recordof(int0) xformDefaultDates(recordof(int0) le) := transform
set_default_date := ['00000000','00010101','17530101','0   0000','00101'];
			self.BIRTH_DTE					:= if(le.BIRTH_DTE in set_default_date,'',le.BIRTH_DTE);
			self.CURR_ISSUE_DTE			:= if(le.CURR_ISSUE_DTE in set_default_date,'',le.CURR_ISSUE_DTE);
			self.ORIG_ISSUE_DTE			:= if(le.ORIG_ISSUE_DTE in set_default_date,'',le.ORIG_ISSUE_DTE);
			self.EXPIRE_DTE					:= if(le.EXPIRE_DTE in set_default_date ,'',le.EXPIRE_DTE);
			self.RENEWAL_DTE				:= if(le.RENEWAL_DTE in set_default_date,'',le.RENEWAL_DTE);
      self.INST_BEG_DTE				:= if(le.INST_BEG_DTE in set_default_date,'',le.INST_BEG_DTE);
			self.VIOL_DTE						:= if(le.VIOL_DTE in set_default_date,'',le.VIOL_DTE);
			self.VIOL_EFF_DTE				:= if(le.VIOL_EFF_DTE in set_default_date,'',le.VIOL_EFF_DTE);
			self.ACTION_STATUS_DTE	:= if(le.ACTION_STATUS_DTE in set_default_date,'',le.ACTION_STATUS_DTE);
			self.SCHL_ATTEND_DTE_1	:= if(le.SCHL_ATTEND_DTE_1 in set_default_date,'',le.SCHL_ATTEND_DTE_1);
			self.SCHL_ATTEND_DTE_2	:= if(le.SCHL_ATTEND_DTE_2 in set_default_date,'',le.SCHL_ATTEND_DTE_2);
			self.SCHL_ATTEND_DTE_3	:= if(le.SCHL_ATTEND_DTE_3 in set_default_date,'',le.SCHL_ATTEND_DTE_3);
			self.STATUS_EFFECT_DTE	:= if(le.STATUS_EFFECT_DTE in set_default_date,'',le.STATUS_EFFECT_DTE);
			self.START_DTE					:= if(le.START_DTE in set_default_date,'',le.START_DTE);
			self  := le;
END;
fixDefaultDates := project(int0,xformDefaultDates(left));

return fixDefaultDates;

end;
