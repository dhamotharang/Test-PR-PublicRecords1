import dx_dma;
export	file_suppressionTPS_delta	:=
module

	export	Base			:=	dataset(dx_dma.names.base,dx_dma.layouts.building,flat, opt);
    export  father 			:=	dataset(dx_dma.names.base_father,dx_dma.layouts.building,flat, opt);
	export  base_new(string filedate) := dataset(dx_dma.names.base+ '_' +filedate,dx_dma.layouts.building,flat);
end;
