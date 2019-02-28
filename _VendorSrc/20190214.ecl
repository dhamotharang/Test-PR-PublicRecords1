pversion := '20190217';
filedate:='20190217';
pUseProd:=true;
     
// #workunit('name', 'Vendor Source Build ' + pversion);
// _VendorSrc2.Build_All(pversion,true);

_VendorSrc2.Build_Base(pversion,pUseProd);
// _VendorSrc2.Build_Base(pversion,pUseProd).vendorsrc_all;
// _VendorSrc2.Files(pUseProd).base.qa;
// _VendorSrc2.UpdateBase(pversion, pUseProd).VendorSrc_Base;
// _VendorSrc2.Files(filedate,pUseProd).CollegeLocator_input;
