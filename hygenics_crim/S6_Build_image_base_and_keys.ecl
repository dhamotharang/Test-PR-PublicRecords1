import Hygenics_images, Hygenics_images_v2;
/////////////////////////////////////////////////////////////////////////////
//run the build
////////////////////////////////////////////////////////////////////////////
#OPTION('multiplePersistInstances',FALSE);
filedate := '20180110';

			sequential(Hygenics_images.proc_build_img_base(filedate);
			Hygenics_images.proc_build_keys(filedate);
			Hygenics_images.proc_build_all(filedate);
			Hygenics_images_v2.Proc_Build_IMG_Base(filedate);
			Hygenics_images_v2.Proc_Build_Keys(filedate);
			Hygenics_images_v2.Proc_Build_All(filedate);
			Hygenics_crim.Check_Upload_Date(filedate));