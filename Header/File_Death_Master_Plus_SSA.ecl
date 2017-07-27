import Data_Services,ut;
d := dataset(Data_Services.Data_location.prefix('Death')+'~thor_data400::Base::Death_Master_Plus_SSA',header.layout_death_master_plus,flat);

layout_death_master_plus clean(d le) := transform
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

export File_Death_Master_Plus_SSA := project(d,clean(left));