import crim_common,ut;

df := dataset(ut.foreign_prod + 'thor_data400::in::court_crim_activity_20120727'/* + crim_common.Version_Development*/,layout_accurint_Activity_in,flat);

layout_activity into(df L) := transform
  self.conviction_override_date 			:= if((integer4)l.event_date=0,
																					l.process_date,
																					l.event_date);
	self.conviction_override_date_type	:= if(self.conviction_override_date = '',
																					'',
																					'E');
	self := L;
end;

export AllActivities := project(df,into(LEFT))(vendor in ['02','03','1B']); //LN Crim Counties not yet replaced by Hygenics