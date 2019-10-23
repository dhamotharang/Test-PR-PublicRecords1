iteration         := '@iteration@';
pversion          := '@version@';
PreClusterCount   := '1234567';
PostClusterCount  := '213456';
MatchesPerformed  := '77849594';
myset             := [100,80,40,30,20,10,1];

#workunit('name','WorkMan.test_att ' + pversion + ' ' + iteration);

output(iteration        ,named('iteration'       ));
output(pversion         ,named('pversion'        ));
output(PreClusterCount  ,named('PreClusterCount' ));
output(PostClusterCount ,named('PostClusterCount'));
output(myset[(unsigned)iteration] ,named('MatchesPerformed'));

run on father files cdw