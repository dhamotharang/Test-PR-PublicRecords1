#OPTION('multiplePersistInstances',FALSE);
import business_header,ut,zoom;                                               

export Zoom_As_Business_Linking := Zoom.fZoom_As_Business_Linking(Zoom.Files().base.qa): PERSIST(zoom.persistnames.asbusinesslinking);