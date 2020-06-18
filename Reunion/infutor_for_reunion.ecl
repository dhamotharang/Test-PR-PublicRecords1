IMPORT Infutor;

infutor_best := DISTRIBUTE(Infutor.file_infutor_best,HASH(did));  //708,358,966
dAdults:=DISTRIBUTE(reunion.adults,HASH(did));

dJoined(unsigned1 mode):=JOIN(infutor_best,dAdults,LEFT.did=RIGHT.did,TRANSFORM(RECORDOF(infutor_best),SELF:=LEFT;),LOCAL)
  :PERSIST('~thor::persist::mylife::infutor::' + reunion.Constants.sMode(mode), EXPIRE(10), REFRESH(FALSE)); //456,848,781

EXPORT infutor_for_reunion(unsigned1 mode):=dJoined(mode);
