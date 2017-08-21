#stored('did_add_force', 'thor');
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Cortera Build');

version := '';

SEQUENTIAL(
	Cortera.Spray(version),
	Cortera.BuildData(version),
	Cortera.BuildKeys(version)
);
