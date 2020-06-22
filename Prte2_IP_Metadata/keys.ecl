import doxie,mdr;

EXPORT Keys := module

export Key_IP_4 := index(files.IP_4,{beg_octet1, end_octet1, beg_octet2, end_octet2, beg_octets34, end_octets34},
    {files.IP_4},Constants.KeyName_IP_4 + doxie.Version_SuperKey);

export Key_IP_6 := index(files.IP_6,{beg_hextet1},
    {files.IP_6},Constants.KeyName_IP_6 + doxie.Version_SuperKey);


end;