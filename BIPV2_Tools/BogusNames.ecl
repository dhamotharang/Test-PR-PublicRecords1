EXPORT BogusNames :=
module

  name_obscenities := [
     'NIGGER'
    ,'CUNT'
    ,'WANKER'
    ,'BASTARD'
    ,'FUCKER'
    ,'MOTHERFUCKER'
    ,'FUCK'
    ,'DICKHEAD'
    ,'COCK'
    ,'PUSSY'
    ,'TWAT'
    ,'BOLLOCKS'
    ,'BITCH'
    ,'SHIT'
    ,'PISS'
    ,'BULLSHIT'
    ,'ARSEHOLE'
    ,'ASSHOLE'
    ,'ASS'
    ,'BUGGER'
    ,'CRAP'
    ,'DAMN'
    ,'SLUT'
    ,'FAGGOT'
    ,'WHORE'
    ,'HOE'
  ];
  export BogusNames(string pName_Field) := trim(pName_Field) in name_obscenities;

end;