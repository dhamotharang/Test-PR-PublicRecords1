#OPTION('multiplePersistInstances',FALSE);
import business_header;                                               

export Zoom_As_Business_Header := fZoom_As_Business_Header(files().base.BusinessHeader)
	: PERSIST(persistnames.asbusinessheader);
