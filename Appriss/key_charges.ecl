
import doxie, Data_Services;


ds := dataset([],Layout_Key_charges);

export key_charges := index(ds , {booking_sid,charge_seq},{ds}, 
				Data_Services.Data_location.Prefix('Appriss') + 'thor_200::key::appriss::' + doxie.Version_SuperKey + '::charges_id');
