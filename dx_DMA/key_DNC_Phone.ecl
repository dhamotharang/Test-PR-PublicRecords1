Import	dx_dma;
EXPORT	key_DNC_Phone	:=	index(  {dx_dma.layouts.delta_keyfield},
                                    {dx_dma.layouts.delta_payload},
                                    dx_dma.names.key_DNC
                                    );