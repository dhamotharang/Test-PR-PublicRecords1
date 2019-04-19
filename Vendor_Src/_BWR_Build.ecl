pversion := '20190418';                                                 
pUseProd := TRUE;           
                                         
SourceIP:='bctlpedata12.risk.regn.net';                                 
Directory:='/data/temp/bellojd/VladPetrokas/vendor_src/data/';            
LogicalName:= 'thor_data400::in::vendor_src*';                           
  
#workunit('name', 'Vendor Source Build ' + pversion);                    
Vendor_Src.Build_All(pversion,LogicalName,SourceIP,Directory,pUseProd);  



