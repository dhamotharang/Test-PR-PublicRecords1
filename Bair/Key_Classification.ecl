import Data_Services;

r := RECORD
  string50 ori;
  unsigned1 mode;
  unsigned4 ucr_group;
  string255 crime;
  string100 agencytype;
  string25 last_update;
  unsigned8 __internal_fpos__;
END;

d:=dataset([],r);

EXPORT Key_Classification(string v = 'qa') := 
													index(d,{ori,mode},{d},data_services.Data_location.Prefix('BAIR')+
																						'thor_data400::key::bair::classification::' + v + '::ori');
