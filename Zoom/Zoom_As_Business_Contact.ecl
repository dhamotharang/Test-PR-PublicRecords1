#OPTION('multiplePersistInstances',FALSE);
export Zoom_As_Business_Contact := fZoom_As_Business_Contact(files().base.BusinessHeader)
	: PERSIST(persistnames.asbusinesscontact);
