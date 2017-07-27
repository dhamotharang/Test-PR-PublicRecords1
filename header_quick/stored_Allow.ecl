boolean allow_headerquick_val := thorlib.getenv('AllowHeaderQuick','1')='1' : STORED('AllowHeaderQuick');

//** for package file
//<Environment id=' AllowHeaderQuick' val='1'/>  for allow
//<Environment id=' AllowHeaderQuick' val='0'/> for not allow.

export stored_Allow := allow_headerquick_val;