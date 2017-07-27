export Support
 :=
  module
	export	boolean		fIntegerInRange(integer4 pValue, integer4 pLowLimit, integer4 pHighLimit)
							:=	pValue <= pHighLimit and pValue >= pLowLimit;
  end
 ;
