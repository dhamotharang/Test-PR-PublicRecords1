import data_services,BusReg;

EXPORT in_BusReg :=BusReg.Files(,false).input.Sprayed;
//EXPORT in_BusReg:= dataset(data_services.foreign_prod + 'thor_data400::in::busreg::20170710::data',layout_in_BusReg,thor);
