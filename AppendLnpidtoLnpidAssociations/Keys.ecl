EXPORT Keys := MODULE
  import $;

  prefix := '~';

  LnpidToLnpidAssocFile := DATASET ([],$.Layouts.LnpidToLnpidAssocRec);

  EXPORT LnpidToLnpidAssocKey := INDEX(LnpidToLnpidAssocFile,
                             {PERSON_LNPID},{LnpidToLnpidAssocFile},
                              prefix + 'thor::key::healthcareprovider::qa::lnpid::to::lnpid::association');
END;