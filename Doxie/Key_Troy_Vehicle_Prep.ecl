import vehlic;
v := vehlic.File_Vehicles;

doxie.keytype_troy_vehicle make_tv(v le,unsigned4 cnt) := transform
  self.did := (unsigned8)MAP( cnt=1 => le.own_1_did,
                   cnt=2 and le.own_2_did<>le.own_1_did => le.own_2_did,
                   cnt=3 and le.reg_1_did <> le.own_2_did and
                             le.reg_1_did <> le.own_1_did => le.reg_1_did,
                   cnt=4 and le.reg_2_did <> le.own_2_did and
						     le.reg_2_did <> le.reg_1_did and
                             le.reg_2_did <> le.own_1_did => le.reg_2_did, '' );
  self.year_make := (unsigned2)le.year_make;
  self := le;
  end;

p1 := normalize(v,4,make_tv(left,counter))(did<>0);

export Key_Troy_Vehicle_Prep := index(p1,{p1},'~thor_data400::key::troy_vehicle' + thorlib.WUID()) ;