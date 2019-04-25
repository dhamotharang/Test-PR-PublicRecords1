import _Control;

export copy(

   string pSourceName                                                    = ''
                // ,string pDestinationName       = ''
                ,string pDestinationGroup           = 'hthor__dev_eclagent'
                ,string pRemoteURL                                                       = 'http://10.241.3.242:8010/FileSpray'

) :=
function

                return fileservices.RemotePull(pRemoteURL,pSourceName,pDestinationGroup,pSourceName,,,true,true,true);

end;


copy(scoringqa::out::nonfcra::leadintegrity_batch_generic_msn1106_0_v4_20141207_1)


// STD.File.Copy('~scoringqa::out::nonfcra::leadintegrity_batch_generic_msn1106_0_v4_20141207_1','hthor__dev_eclagent',
                            // '~scoringqa::out::nonfcra::leadintegrity_batch_generic_msn1106_0_v4_20141207_1','10.241.3.238:7070');

