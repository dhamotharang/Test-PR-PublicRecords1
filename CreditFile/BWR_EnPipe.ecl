/*    IN::CREDIT   */
// vbx2indic creditfile indicativefile tradefile pubrecsfile errorfile
//vbx2indic vbxfile indicfile tradefile pubrecfile 
// + inqrecfile addressfile aliasfile emplfile errors
//vbx2indic vbxfile indicfile tradefile pubrecfile inqrecfile 
//addressfile aliasfile emplfile errors
d := dataset('',{ string1 s },
PIPE('vbx2indic ' + thorlib.l2p('dev_in::credit_file_20030825', false) + ' ' 
                  + thorlib.l2p('dev_in::cred_per', true) + ' '
                  + thorlib.l2p('dev_in::trad_per', true) + ' '
                  + thorlib.l2p('dev_in::pubrec_per', true) + ' '
                  + thorlib.l2p('dev_in::inqrec_per', true) + ' '
                  + thorlib.l2p('dev_in::address_per', true) + ' '
                  + thorlib.l2p('dev_in::alias_per', true) + ' '
                  + thorlib.l2p('dev_in::empl_per', true) + ' '
                  + thorlib.l2p('dev_in::spare_per', true) + ' '
                  + thorlib.l2p('dev_in::log_pipe_per', true)
                  ));

output(d,,'stdout',overwrite);