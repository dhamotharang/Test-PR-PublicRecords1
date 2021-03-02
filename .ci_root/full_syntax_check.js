#!node

let arg = process.argv.slice(2);
let per = (arg[0]) ? parseFloat(arg[0]) : 1;

const cp = require('child_process');
const rline = require('readline');
const fs = require('fs');
const fetch = require('node-fetch');
const xjs = require('xml-js');

let hpccpath = '';
let file = 'query_list.txt';
let workpath = '..';

let server_url = 'http://uspr-dopsservices.risk.regn.net/demodopsservice.asmx';
let server_req = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:lex="http://lexisnexis.com/"><soapenv:Header/><soapenv:Body><lex:GetQueryList><lex:location>B</lex:location><lex:environment></lex:environment><lex:cluster></lex:cluster></lex:GetQueryList></soapenv:Body></soapenv:Envelope>';

let exceptions = new Set();

// utility functions
// ----------------------------------------------
let checkObject = function(obj) {
  return typeof obj === 'object' && obj !== null;
};

let findFirstKey = function(obj, key) {
  let out = null;

  if (checkObject(obj))
  {
    let karr = Object.keys(obj);
    if (karr.find(kk => kk == key)) out = obj[key];
    else {
      for (const kk of karr) {
        let tmp = findFirstKey(obj[kk], key);
        if (tmp) { out = tmp; break; }
      }
    }
  }

  return out;
};

let getDateString = function () {
	let d = new Date();
	return d.toISOString();
};
// ----------------------------------------------

// Service Fetching
// ----------------------------------------------
let soapCall = async function(url, request_txt, timeout = 8000) {
	let opt = { 
		method: 'post', 
		body: request_txt, 
		headers: { 'Content-Type': 'text/xml' }, 
	};
	let result = {
		status_ok: false, 
		status: { val: 0, text: 'soapcall error' }, 
		response: '', 
	};

	console.log('Sending Request to: ' + url);

	try {
		let response = await fetch(url, opt);
		let rtxt = await response.text();
		
		console.log('Soapcall response');

		// assemble result
		result = {
		  status_ok: response.ok, 
		  status: { val: response.status, text: response.statusText }, 
		  response: rtxt, 
		};

		if (!result.status_ok) {
		  console.log('Error: Request Failed');
		}
	}
	catch (error) {
		result.status.text = error;
		console.log('Error: Request Failed');
	}

	return result;
}

let dedupServices = function(list) {
	let out = [];
	let last = '';
	
	for (let item of list) {
		if (item.toLowerCase() != last.toLowerCase()) out.push(item);
		last = item;
	}
	return out;
}

let getServices = async function(filter = 1) {
	let out = [];
	console.log('Fetching Services List...');
	
	let res = await soapCall(server_url, server_req);
	if (res.status_ok) {
		let obj = xjs.xml2js(res.response, { compact: true, trim: true });
		let tmp = findFirstKey(obj, 'dquery');
		let arr = (tmp && Array.isArray(tmp)) ? tmp : [];
		
		console.log('Services Response OK: ' + arr.length);
		arr.forEach((item) => out.push(item.queryname._text));
	}
	else console.log('Services Request Failed');
	
	// optionally filter a random subset
	if (filter < 1) out = out.filter(() => Math.random() < filter);
	
	return dedupServices(out);
}

let getExceptions = function() {
	const fname = 'query_exceptions.json';
	try {
		let txt = fs.readFileSync(fname, { encoding: 'utf8' });
		let obj = JSON.parse(txt);
		
		for (let item of obj.nofastsyntax) {
			let tmp = item.toLowerCase();
			exceptions.add(tmp);
		}
		console.log('Loaded Fast Syntax Exceptions: ' + exceptions.size);
	}
	catch (error) {
		console.log('Unable to read: ' + fname);
	}
}
// ------------------------------------------


// match attribute name to (case-correct) file path
let findPath = function(str) {
	let arr = str.split('.');
	let pp = workpath;
	let find = (str, dir) => {
		let tmp = str.toLowerCase();
		let ret = null;
		
		for (let item of dir) {
			if (item.toLowerCase() == tmp) { ret = item; break; }
		}
		return ret;
	};
	
	// add ECL suffix to final file name
	if (arr.length == 0) return null;
	else arr[arr.length - 1] += '.ecl';
	
	for (let item of arr) {
		let dir = [];
		try { dir = fs.readdirSync(pp); } catch (error) {}
		
		let name = find(item, dir);
		if (name) pp = pp + '/' + name;
		else return null;
	}
	return pp;
}

// perform syntax check
let syntax_check = function(path, use_fast = true) {
	let args = [
		'-syntax', 
		'--nostdinc', 
		'-I', 
		workpath, 
		'-legacy', 
		path
	];
	let out = { ok: false, status: 0, stdout: '', stderr: '' };
	
	// optionally use fastsyntax
	if (use_fast) args.splice(1, 0, '--fastsyntax');
	
	try {
		let tmp = cp.execFileSync(hpccpath + 'eclcc', args, { stdio: [] });
		out.ok = true;
		if (tmp) out.stdout = tmp.toString().trim();
	}
	catch (error) {
		out.status = error.status;
		if (error.stdout) out.stdout = error.stdout.toString().trim();
		if (error.stderr) out.stderr = error.stderr.toString().trim(); 
		
		// only mark a fail if there are actual error messages as eclcc's return code cannot always be trusted
		if (!out.stderr) out.ok = true;
	}
	
	return out;
};

// main function
let main = async function() {
	let lines = await getServices(per);
	let errs = [];
	let len = lines.length;
	let num = 0;
	let total = 0;
	let pass = 0;
	let total_time = 0;
	let worst = { name: '', time: 0 };
	let dStart = Date.now();
	
	// make sure any exceptions are loaded prior to syntax check
	getExceptions();
	
	console.log('Starting Syntax Check at: ' + getDateString());
	console.log('Checking ' + len + ' Queries...');
	console.log('----------------------------------------------------------');
	console.log('');
	
	for (let item of lines) {
		let path = findPath(item);
		let fast = !(exceptions.has(item.toLowerCase()));
		
		// record percent done
		num++;
		let prog = Math.round((num/len) * 100);
		let pstr = (prog + '%').padStart(4, ' ');
		
		// ignore files that don't exist
		if (!path) {
			console.log(pstr + '  []      ' + '   0.0s  ' + item);
			continue;
		}
		else total++;
		
		let t0 = process.hrtime();
		let res = syntax_check(path, fast);
		let tdd = process.hrtime(t0);
		let tdelt = (tdd[0] * 1000000000 + tdd[1]) / 1000000000;
		let time = (tdelt.toFixed(1) + 's').padStart(7, ' ');
		let fast_msg = (fast) ? '' : ' [nofast]';
		
		if (res.ok) {
			console.log(pstr + '  [OK]    ' + time + '  ' + item + fast_msg);
			pass++;
		}
		else {
			errs.push({ query: item, res: res });
			console.log(pstr + '  [ERROR] ' + time + '  ' + item + fast_msg);
		}
		
		// calculate worst and average time
		total_time += tdelt;
		if (tdelt > worst.time) worst = { name: item, time: tdelt };
	}
	
	// print out error details
	if (errs.length > 0) {
		console.log('\n\nVerification ERRORS:');
		console.log('----------------------------------------------------------\n');
		
		for (let item of errs) {
			console.log('[[ ' + item.query + ' ]]');
			console.log('----------------------------------------------------------');
			console.log(item.res.stderr);
			console.log('----------------------------------------------------------');
			console.log('');
		}
		console.log('');
	}
	
	let dEnd = Date.now();
	let dsecs = Math.round((dEnd - dStart) / 1000);
	let dhrs = Math.floor(dsecs / 3600); dsecs -= (dhrs * 3600);
	let dmins = Math.floor(dsecs / 60); dsecs -= (dmins * 60);
	console.log('\nScript Finished at: ' + getDateString());
	console.log('Elapsed Time: ' + dhrs + ' hrs, ' + dmins + ' mins, ' + dsecs + ' secs');
	
	if (total > 0) {
		let avg = total_time / total;
		console.log('\nAvg Query Time: ' + avg.toFixed(1) + 's');
		console.log('Max Query Time: ' + worst.time.toFixed(1) + 's  [' + worst.name + ']');
	}
	
	console.log('\n----------------------------------------------------------\nFinal Results: (' + pass + '/' + total + ') Passed');
	
	// missing queries
	if (total < len) {
		console.log('Missing Queries: ' + (len - total));
	}
	
	// throw an error so the task fails if errors were detected
	if (pass < total) {
		console.log('Failed Queries: ' + (total - pass));
		return false;
	}
	else return true;
}

// run the main function
console.log('Running Verification Check:');
main().then((ok) => { 
	if (ok) console.log('Verification PASSED');
	else console.log('Verification FAILED');

	process.exit((ok) ? 0 : 2);
});
