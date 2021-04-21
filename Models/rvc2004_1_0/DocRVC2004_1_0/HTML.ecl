<html><head><title>Shellpoint Custom Model (neverpaid segment)</title></head><body>
<h1>Shellpoint Custom Model (neverpaid segment)(RVC2004_1_0)</h1><p>
<h2>Whole Model Information</h2>
This is a single scorecard model.</p>
<p>This model uses reason method AscendingNonZeroWithInquiry.</p>
LUCI made the following notes while compiling the .CSV: <ul>
<li>Line: 62, Severity: WARNING, Message: RC [C12] used with multiple Inds</li><li>Line: 62, Severity: WARNING, Message: RC [Z01] used with multiple Inds</li><li>Line: 62, Severity: WARNING, Message: RC [Z03] used with multiple Inds</li>
</ul>
</body></html>
<h2>Exceptions</h2>There are also exception conditions in which the scorecards are bypassed, defined as follows:
<ul><li><b>RV5_Attr_200 - </b>
If <code>(real) ssndeceased = 1 or (real) subjectdeceased = 1</code> is true then the score is set to 200
 and a reason code of  is set.</li><li><b>RV5_Attr_222 - </b>
If <code>(real) confirmationsubjectfound = -998 or (real) confirmationsubjectfound < 1</code> is true then the score is set to 222
 and a reason code of  is set.</li></ul>
<h2>ScoreCard - SCORECARD_model6</h2>
This scorecard is a linear model.
<ul><li>The weights for each variable are computed as defined below</li><li>Combined_score is then calculated by adding the individual weights together</li>
<li>Raw_point is then calculated by adding the Combined_score to the Constant -6.20383556354911</li>
<li>The score is then processed according to the formula (700 + 20 * ((Raw_point - 0 - LN(0.049227)) / LN(2))).</li>
<li>The value is then rounded to the nearest integer.</li>
<li>If the value is less than 501 it is set to 501.</li>
<li>If the value is greater than 900 it is set to 900.</li>

<h3>Independant Variables</h3>
<p><b>ChargeOffAmount</b> is defined in 6 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.375117906627449</td><td>Z01</td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.375117906627449</td><td></td></tr><tr><td>-999999999</td><td>8546.265</td><td>0.375117906627449</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.375117906627449</td><td></td></tr><tr><td>8546.265</td><td>18436.145</td><td>0.309244208292874</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.375117906627449</td><td>Z04</td></tr><tr><td>18436.145</td><td>34264.93</td><td>-0.0976038497040409</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.375117906627449</td><td>Z04</td></tr><tr><td>34264.93</td><td>HIGH</td><td>-0.285617568483362</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.375117906627449</td><td>Z04</td></tr>
</table></p>
<p><b>CollateralStatus</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.506249019049611</td><td>Z01</td></tr><tr><td>Secured</td><td>Secured</td><td>0.506249019049611</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.506249019049611</td><td></td></tr><tr><td>Unsecured</td><td>Unsecured</td><td>-0.505505156657995</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.506249019049611</td><td>Z03</td></tr><tr><td></td><td>HIGH</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.506249019049611</td><td>Z03</td></tr>
</table></p>
<p><b>LoanType</b> is defined in 7 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.437226314256582</td><td>Z01</td></tr><tr><td>CFD</td><td>CFD</td><td>-0.783823199084631</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.437226314256582</td><td>Z03</td></tr><tr><td>HE</td><td>HE</td><td>0.437226314256582</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.437226314256582</td><td></td></tr><tr><td>HI</td><td>HI</td><td>0.0808731487276667</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.437226314256582</td><td>Z03</td></tr><tr><td>MHCH</td><td>MHCH</td><td>-0.213208434163752</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.437226314256582</td><td>Z03</td></tr><tr><td>MHLH</td><td>MHLH</td><td>-0.48149235638988</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.437226314256582</td><td>Z03</td></tr><tr><td></td><td>HIGH</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.437226314256582</td><td>Z03</td></tr>
</table></p>
<p><b>OutOfStatuteIndicator</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.400744957361021</td><td>Z01</td></tr><tr><td>N</td><td>N</td><td>0.400744957361021</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.400744957361021</td><td></td></tr><tr><td>Y</td><td>Y</td><td>-0.399632991058556</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.400744957361021</td><td>Z03</td></tr><tr><td></td><td>HIGH</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.400744957361021</td><td>Z03</td></tr>
</table></p>
<p><b>addrcurrentphoneservice</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.17581248093876</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.17581248093876</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>-0.176496997665736</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.17581248093876</td><td>L78</td></tr><tr><td>0.5</td><td>HIGH</td><td>0.17581248093876</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.17581248093876</td><td></td></tr>
</table></p>
<p><b>addrinputmatchindex</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.109644071572997</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.109644071572997</td><td>C12</td></tr><tr><td>-999999999</td><td>1.5</td><td>-0.348450615891214</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.109644071572997</td><td>F01</td></tr><tr><td>1.5</td><td>HIGH</td><td>0.109644071572997</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.109644071572997</td><td></td></tr>
</table></p>
<p><b>addrinputsubjectowned</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.25984141212094</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.25984141212094</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>-0.126883825848919</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.25984141212094</td><td>A44</td></tr><tr><td>0.5</td><td>HIGH</td><td>0.25984141212094</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.25984141212094</td><td></td></tr>
</table></p>
<p><b>addrprevioussubjectowned</b> is defined in 1 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-999999999</td><td>HIGH</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.393204356454376</td><td>C12</td></tr>
</table></p>
<p><b>addrprevioustimeoldest</b> is defined in 5 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.227389143242477</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.227389143242477</td><td>C12</td></tr><tr><td>-999999999</td><td>205.5</td><td>-0.178058014191334</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.227389143242477</td><td>C13</td></tr><tr><td>205.5</td><td>353.5</td><td>0.180458239359927</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.227389143242477</td><td>C13</td></tr><tr><td>353.5</td><td>HIGH</td><td>0.227389143242477</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.227389143242477</td><td></td></tr>
</table></p>
<p><b>dayssince_OpenDate</b> is defined in 5 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.518838613059721</td><td>Z01</td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.518838613059721</td><td></td></tr><tr><td>-999999999</td><td>4785.5</td><td>0.518838613059721</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.518838613059721</td><td></td></tr><tr><td>4785.5</td><td>7697.5</td><td>-0.15284397845779</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.518838613059721</td><td>Z05</td></tr><tr><td>7697.5</td><td>HIGH</td><td>-0.27403651626685</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.518838613059721</td><td>Z05</td></tr>
</table></p>
<p><b>dayssince_ReceivedDate</b> is defined in 7 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>1.84983879208409</td><td>Z01</td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>1.84983879208409</td><td></td></tr><tr><td>-999999999</td><td>309</td><td>1.84983879208409</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>1.84983879208409</td><td></td></tr><tr><td>309</td><td>1358.5</td><td>0.933891056825015</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>1.84983879208409</td><td>Z02</td></tr><tr><td>1358.5</td><td>2314</td><td>0.147011498338894</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>1.84983879208409</td><td>Z02</td></tr><tr><td>2314</td><td>3731</td><td>0.0658874265823452</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>1.84983879208409</td><td>Z02</td></tr><tr><td>3731</td><td>HIGH</td><td>-0.846610037669496</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>1.84983879208409</td><td>Z02</td></tr>
</table></p>
<p><b>sourcecredheadertimeoldest</b> is defined in 5 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.393416528917569</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.393416528917569</td><td>C12</td></tr><tr><td>-999999999</td><td>345.5</td><td>-0.275087108555596</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.393416528917569</td><td>C20</td></tr><tr><td>345.5</td><td>423.5</td><td>0.0295111082163462</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.393416528917569</td><td>C20</td></tr><tr><td>423.5</td><td>HIGH</td><td>0.393416528917569</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.393416528917569</td><td></td></tr>
</table></p>

</ul>
