Import data_services,doxie;
r:=RECORD,maxlength(60000)
  unsigned1	digit1;
  unsigned1	digit2;
  unsigned1	digit3;
  unsigned1	digit4;
  unsigned1	digit5;
  unsigned1	digit6;
  unsigned1	digit7;
  unsigned1	digit8;
  unsigned1	digit9;
  unsigned1	digit10;
  unsigned1	digit11;
  unsigned1	digit12;
  unsigned2 entity_type_id;
  unsigned2 entity_sub_type_id;
  unsigned8 record_id;
  unsigned8 uid;
 END;
d	:=dataset([],r);

EXPORT Key_IPRange(string Platform) :=	Index(d,{digit1, digit2, digit3, digit4, digit5, digit6, digit7, digit8, digit9, digit10, digit11, digit12, entity_type_id,entity_sub_type_id},{d},
																				data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																				+Platform	+ '::'+ doxie.Version_SuperKey +'::iprange');
