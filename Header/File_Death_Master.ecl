import ut;
/*Uses super file.  To add a new file:
SEQUENTIAL(
FileServices.StartSuperFileTransaction(),
FileServices.ClearSuperFile('~thor_data400::Base::Death_Master'),
FileServices.AddSuperFile('~thor_data400::Base::Death_Master','~thor_data400::in::death_master_20040203'),
FileServices.FinishSuperFileTransaction()
);
*/
d := dataset('~thor_data400::Base::Death_Master',header.layout_death_master,flat);

layout_death_master clean(d le) := transform
  self.dod8 := le.dod8[5..8]+le.dod8[1..4];
  self.dob8 := le.dob8[5..8]+le.dob8[1..4];
  self.fname := if ( le.mname='' and ut.word(le.fname,2)<>'',ut.word(le.fname,1),le.fname);
  self.mname := if ( le.mname='' and ut.word(le.fname,2)<>'',ut.word(le.fname,2),le.mname);
  self.lname := MAP ( 
                   stringlib.stringfind(le.lname,' JR',1) <>0 => le.lname[1..stringlib.stringfind(le.lname,' JR',1)],
                   stringlib.stringfind(le.lname,' SR',1) <>0 => le.lname[1..stringlib.stringfind(le.lname,' SR',1)],
                   stringlib.stringfind(le.lname,' I',1) <>0 => le.lname[1..stringlib.stringfind(le.lname,' I',1)],
                   stringlib.stringfind(le.lname,' II',1) <>0 => le.lname[1..stringlib.stringfind(le.lname,' II',1)],
                   le.lname );
  self.name_suffix := MAP ( 
                   le.name_suffix<>'' => le.name_suffix,
                   stringlib.stringfind(le.lname,' JR',1) <>0 => 'JR',
                   stringlib.stringfind(le.lname,' SR',1) <>0 => 'SR',
                   stringlib.stringfind(le.lname,' I',1) <>0 => 'I',
                   stringlib.stringfind(le.lname,' II',1) <>0 => 'II',
                   le.name_suffix );
  self := le;
  end;

export File_Death_Master := project(d,clean(left));