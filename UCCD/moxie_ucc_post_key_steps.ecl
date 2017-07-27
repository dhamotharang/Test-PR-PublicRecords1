#workunit('name', 'UCC post keys');
import UCCD;

string16 wuid := '' : stored('wuid'); 

#stored('wuid','w20050714')

//export moxie_ucc_post_key_steps := 

sequential(
UCCD.moxie_ucc_collateral_keys,

UCCD.moxie_ucc_debtor_keys,

UCCD.moxie_ucc_event_keys,

UCCD.moxie_ucc_secured_keys,

UCCD.moxie_ucc_summary_keys): failure(FileServices.sendemail('wma@seisint.com','UCC Key Build Failure',failmessage));







