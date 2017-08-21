import STD, _control;

lfn := '~thor::spokeo::out::201701';
ip := _control.IPAddress.bctlpedata12;
//destdir := '/data/temp/spokeo/';
destdir := '/tmp/spokeo/';

EXPORT Despray_File := STD.File.DeSpray(lfn, ip, destdir+'spokeo_output_201701.csv');
