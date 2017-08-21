import Bair_BatchImporter;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Orbit Update');

//as a service
doMyService := FUNCTION
	OUTPUT('Service for: ' + 'EVENTNAME=' + EVENTNAME) : global;
	version := EVENTEXTRA('returnTo') : global;
	act := Bair.Orbit_update.SetOrbitForPrepBatch(version,Bair_BatchImporter.filenames().lInputTemplateManifest+'::'+version,'built');	
	return act;
END;
     
doMyService : WHEN('Update_Orbit_For_BatchFiles');