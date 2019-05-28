import _Control;
export Spray_Telcordia(string filedate) := 
function							
tpm := fileservices.SprayVariable(_Control.IPAddress.bctlpedata11,
													   '/data/thor_back5/local_data/tpmdata/sources/'+ filedate +'/TPM.DAT',
														111 /*max rec size*/, /*separator*/,	/*end of rec terminator*/,	/*quotations included*/,  'thor400_44' /*cluster*/,'~thor400::in::telcordia::tmp' /*filename on Thor*/,,,,true /*overwrite*/,true /*replicate*/,false /*compress*/);
									 
ocn := fileservices.SprayVariable(_Control.IPAddress.bctlpedata11,
													'/data/thor_back5/local_data/tpmdata/sources/'+ filedate +'/OCN.DAT',
													43 /*max rec size*/, /*separator*/,/*end of rec terminator*/,/*quotations included*/,'thor400_44' /*cluster*/, '~thor400::in::telcordia::ocn' /*filename on Thor*/,,,,true /*overwrite*/, true /*replicate*/,	false /*compress*/);									 
									 
plname := fileservices.SprayVariable(_Control.IPAddress.bctlpedata11,
														'/data/thor_back5/local_data/tpmdata/sources/'+ filedate +'/PLNAME.DAT',
														65 /*max rec size*/, /*separator*/, /*end of rec terminator*/, /*quotations included*/,'thor400_44'/*cluster*/,'~thor400::in::telcordia::plname'/*filename on Thor*/,,,,true /*overwrite*/,true /*replicate*/,false /*compress*/);
									 
return sequential(tpm, ocn, plname);
end;