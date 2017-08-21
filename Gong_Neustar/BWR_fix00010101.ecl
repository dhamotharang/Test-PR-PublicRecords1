m := gong_neustar.File_Master;

mok := m(dt_first_seen<>'00010101');
m1 := m(dt_first_seen='00010101');

m2 := PROJECT(m1, transform(recordof(m1),
						self.dt_first_seen := left.filedate[1..8];
						self := left;));

mstr := mok  + m2;
lfn := gong_Neustar.Constants.lfnMaster + 'fix00010101::' + workunit;

SEQUENTIAL(
		OUTPUT(mstr,,lfn,COMPRESSED,OVERWRITE),
		gong_Neustar.Promotions.Master(lfn)
);
	
