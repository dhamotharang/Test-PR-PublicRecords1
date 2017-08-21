pversion	:= '20160315';
pUseProd	:= false;   
pDelta		:= false;
#workunit('name', 'Composite ' + pversion);
#stored('did_add_force','thor')
#OPTION('multiplePersistInstances',FALSE);
Bair_composite.Build_All(pversion,pUseProd,pDelta);

