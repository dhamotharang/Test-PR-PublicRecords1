IMPORT dx_dma;
EXPORT	file_suppressionTPS_delta	:=
MODULE

	EXPORT	Base			:=	dataset(dx_dma.names.base,dx_dma.layouts.building,flat, opt);
    EXPORT  father 			:=	dataset(dx_dma.names.base_father,dx_dma.layouts.building,flat, opt);
    EXPORT  grandfather 			:=	dataset(dx_dma.names.base_grandfather,dx_dma.layouts.building,flat, opt);
	EXPORT  base_new(string filedate) := dataset(dx_dma.names.base+ '_' +filedate,dx_dma.layouts.building,flat);
END;
